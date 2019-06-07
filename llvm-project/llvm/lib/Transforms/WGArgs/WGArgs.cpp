#define APP "RSCD"

#include <iostream>
#include <sstream>
#include <fstream>
#include <string>

#include "llvm/Pass.h"
#include "llvm/IR/User.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FormatVariadic.h"

using namespace llvm;

namespace {

  struct WGArgs : public ModulePass {
    static char ID;
    WGArgs() : ModulePass(ID) {}    

    struct WGArg
    {
      int kernel;           // kernel id
      int wgcnt;            // number of wg args in this kernel
      int acnt;             // number of args in this kernel
      Instruction *ska[10]; // the related clSetKernelArg
    };

    bool findKernel(int k[], int tmp, int kcnt)
    {
      for(int i = 0; i < kcnt; i++)
      {
        if(tmp == k[i]) // find
        {
          return true;
        }
      }
      return false;
    }
    int findPid(Function *func, std::string sp, int *value)
    {
      for(Function::iterator bb = func->begin(), e = func->end(); bb!=e; bb++)  // basic blocks
      { 
        for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++) // instructions
        {
          std::string si = formatv("{0}", *i).str();                     
          if(si.find(sp) != std::string::npos)
          {
            Instruction *inst = dyn_cast<Instruction>(i);
            if(inst->getOpcode() == Instruction:: GetElementPtr)  // GEP instruction
            {
              //errs() << "inst: " << *inst << '\n';
              for(User *U: inst->users())
              {
                if(Instruction *Inst = dyn_cast<Instruction>(U))
                {
                  if(Inst->getOpcode() == Instruction::Store)
                  {
                    //errs() << "Inst: " << *Inst << '\n';
                    Value *op0 = Inst->getOperand(0);
                    *value = (dyn_cast<ConstantInt>(op0))->getSExtValue();
                  }
                }
              }
              Value *op2 = inst->getOperand(2); // op2 refers to the index
              //errs() << "value: " << *op2 << '\n';
              ConstantInt *ci = dyn_cast<ConstantInt>(op2);
              return ci->getSExtValue();  // find the index
            }
          }
        }
      }
      return -1;  // cannot find
    }
    int compute(std::string otor, int op1, int op2)
    {
      if(otor == "mul")
      {
        return op1*op2;
      }
      else if(otor == "div")
      {
        return op1/op2;
      }
      else if(otor == "add")
      {
        return op1+op2;
      }
      else if(otor == "sub")
      {
        return op1-op2;
      }
      else if(otor == "lshr")
      {
        return op1>>op2;
      }
      else  // otor == "shl"
      {
        return op1<<op2;
      }
    }
    // find gep recursively -> test whether the variable is related to n_work_items
    Instruction* findGEP(Instruction *inst, int cnt)  
    {
      for(Use &U: inst->operands())
      {
        Value *v = U.get();
        if(Instruction *i = dyn_cast<Instruction>(v))
        {
          //errs() << "inst: " << *i << '\n';
          if(cnt > 5)
          {
            return NULL;
          }
          else if(i->getOpcode() == Instruction::GetElementPtr)
          {
            return i;
          }
          else  // continue to find gep
          {
            return findGEP(i, cnt+1);
          }
        }
        else
        {
          return NULL;
        }
      }
      return NULL;
    }
    // get the result of the value and another constant
    int computeConstant(Instruction *inst, int value, std::string otor)
    {
      Value *op0 = inst->getOperand(0);
      Value *op1 = inst->getOperand(1);
      // if op0 is a constant
      if(isa<Constant>(op0)) 
      {
        ConstantInt *c = dyn_cast<ConstantInt>(op0);
        return compute(otor, c->getSExtValue(), value);
      }
      // if op1 is a constant
      else if(isa<Constant>(op1))
      {
        ConstantInt *c = dyn_cast<ConstantInt>(op1);
        return compute(otor, value, c->getSExtValue());
      }
      // op0 and op1 are not constant 
      // -> exsit another variable except for "n_work_groups" and "n_work_items"
      else  
      {
        return -1;
      }
    }
    // from the gep of "n_work_items", to the original inst
    int GEPBack(Instruction *gep, Instruction *inst, int value)
    {
      // find the original inst
      if(gep->isIdenticalTo(inst))
      {
        return value;
      }
      // have not find -> continue
      else 
      {
        // find where the gep is used in
        for(User *U: gep->users())
        {         
          Instruction *i = dyn_cast<Instruction>(U);  //errs() << *U << '\n';
          switch(i->getOpcode())
          {
            // need to compute
            case Instruction::Mul:
              return computeConstant(i, value, "mul");
            case Instruction::UDiv:
            case Instruction::SDiv:
              return computeConstant(i, value, "div");
            case Instruction::Add:
              return computeConstant(i, value, "add");
            case Instruction::Sub:
              return computeConstant(i, value, "sub");
            case Instruction::LShr:
              return computeConstant(i, value, "lshr");
            case Instruction::Shl:
              return computeConstant(i, value, "shl");
            default:
              return GEPBack(i, inst, value);
          }         
        }
        return -1;
      }
    }
    // compute the value of one operand (of the inst related to "n_work_groups")
    int computeOperand(Value *operand, int wi, int wipid)
    {
      // if this value is a constant
      if(isa<Constant>(operand))
      {
        ConstantInt *c = dyn_cast<ConstantInt>(operand);
        return c->getSExtValue();
      }
      // if is not a constant
      // -> this value can be related to "n_work_items"
      else
      {
        Instruction *inst = dyn_cast<Instruction>(operand);
        if(Instruction *gep = dyn_cast<Instruction>(findGEP(inst, 0)))
        {
          std::string sgep = formatv("{0}", *gep).str();
          if(sgep.find("%struct.Params") != std::string::npos) // if contains ".."
          {
            Value *op2 = gep->getOperand(2); // op2 refers to the index
            ConstantInt *ci = dyn_cast<ConstantInt>(op2);
            // if the index matches "n_work_items"
            if(ci->getSExtValue() == wipid) 
            {
              //errs() << "find the gep: " << *gep << "\n";
              return GEPBack(gep, inst, wi);
            }
          }
        }
        else  // not a constant, and cannot find gep
        {
          return -1;
        }
        return wi;
      }
    }
    // compute
    int computeValue(Instruction *inst, Instruction *op, std::string otor, int value, int wi, int wipid)
    {
      Value *op0 = inst->getOperand(0); //errs() << "op0: " << *op0 << '\n';
      Value *op1 = inst->getOperand(1); //errs() << "op1: " << *op1 << '\n';      
      if(Instruction *i0 = dyn_cast<Instruction>(op0))  // op0 is inst
      {
        // if op0 is related to "n_work_groups"
        if(i0->isIdenticalTo(op))
        {
          int operand = computeOperand(op1, wi, wipid); // compute op1
          return compute(otor, value, operand);
        }
        // if op0 is not related to "n_work_groups"
        // -> op1 must be related to "n_work_groups"
        else 
        {
          int operand = computeOperand(op0, wi, wipid); // compute op0
          return compute(otor, operand, value);
        }
      }
      // if op1 is related to "n_work_groups"
      else 
      {
        int operand = computeOperand(op0, wi, wipid); // compute op0
        return compute(otor, operand, value);
      }
    }

    bool runOnModule(Module &M) override {

      // 1. we need x and y[..] from NumKernel.out
      // x: number of kernels; 
      // y[i]: number of args for each kernel
      int x;  
      int y[10]; 
      std::string app = APP;
      std::string file = "/root/Work/llvm/apps/" + app + "/NumKernel.out";
      std::ifstream fin(file);
      char line[20];
      fin.getline(line, sizeof(line));
      std::stringstream ssx(line);
      ssx >> x;
      int i = 0;
      while(fin.getline(line, sizeof(line)))
      {
        std::stringstream ss(line);
        ss >> y[i++];
      }

      // 2. we need kernel pairs and Y/N from MemAcc.out
      // tmpk1, tmpk2: id of kernel pairs
      // cond: Y/N about KKC
      // and store to k[..]: all kernels in kernel pairs that are not KKC
      int k[10];
      int tmpk1, tmpk2;
      std::string cond;
      file = "/root/Work/llvm/apps/" + app + "/MemAcc.out";
      std::ifstream fin2(file);
      char line2[20];
      int kcnt = 0;
      bool kkc = false;
      while(fin2.getline(line2, sizeof(line2)))
      {
        std::stringstream ss(line2);
        ss >> tmpk1;
        ss >> tmpk2;
        ss >> cond; //errs() << cond << '\n';
        // if not KKC -> can be MPS
        if(cond == "N") 
        {
          // have not stored in k
          if(!findKernel(k, tmpk1, kcnt)) 
          {
            k[kcnt++] = tmpk1;
          }
          // have not stored in k
          if(!findKernel(k, tmpk2, kcnt)) 
          {
            k[kcnt++] = tmpk2;
          }
        }
        // if is KKC -> cannot be MPS
        else 
        {
          // the first pair
          if(!kkc) 
          {
            errs() << "\t\tYes (";
            errs() << "between kernel" << tmpk1+1 << " and kernel" << tmpk2+1;
            kkc =  true;
          }
          // not the first pair
          else 
          {
            errs() << ", between kernel" << tmpk1+1 << " and kernel" << tmpk2+1;
          }
        }
      }
      // is KKC
      if(kkc)
      {
        errs() << ")\n";
        errs() << "1\n";
      }
      // is not KKC
      else 
      {
        errs() << "\t\tNo\n";
        errs() << "0\n";
      }
      // no kernel in kernel pairs that are not KKC -> cannot be KKC
      if(kcnt == 0)
      {
        errs() << -1 << '\n';
        return false;
      } 
      // else: 
      errs() << kcnt << '\n';
      for(int i = 0; i < kcnt; i++)
      {
        errs() << k[i] << '\n';
      }

      // 3. we need to return __ kernel's __ arg = __
      // wgcnt: number of wg args
      // wgarg[..][0]: kernel id
      // wgarg[..][1]: arg id
      // wgarg[..][2]: value
      int wgcnt = 0;
      int wgarg[10][3];
      
      // begin...
      // 1. find pid = ?
      int wgpid = -1;   // index of "n_work_groups" in struct params
      int wipid = -1;   // index of "n_work_items" in struct params
      int wgvalue = -1; // value of "n_work_groups"
      int wivalue = -1; // value of "n_work_items"
      for(Module::iterator f = M.begin(), f2 = M.end(); f!=f2; f++) // functions
      { 
        if(f->getName() == "main")
        {
          for(Function::iterator bb = f->begin(), e = f->end(); bb!=e; bb++)  // basic blocks
          { 
            for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++) // instructions
            {
              Instruction *inst = dyn_cast<Instruction>(i);
              if(inst->getOpcode() == Instruction::Call)
              {               
                CallInst *cinst = dyn_cast<CallInst>(inst); //errs() << "call: " << *inst << '\n';
                Function *func = cinst->getCalledFunction();  // get the called function
                FunctionType *ty = func->getFunctionType();
                int acnt = ty->getNumParams();  // num of args
                for(int i = 0; i < acnt; i++)
                {
                  Value *arg = cinst->getArgOperand(i); // test for each arg
                  std::string sarg = formatv("{0}", *arg).str();
                  if(sarg.find("%struct.Params") != std::string::npos) // if contains ".."
                  {
                    //errs() << "Function: " << func->getName() << '\n';
                    wipid = findPid(func, "%n_work_items", &wivalue);   // find pid and value of "n_work_items"
                    wgpid = findPid(func, "%n_work_groups", &wgvalue);  // find pid and value of "n_work_groups"                
                    //errs() << "wg: " << wgpid << ", " << wgvalue << '\n';
                    //errs() << "wi: " << wipid << ", " << wivalue << '\n';
                    break;
                  }
                }                   
              }
            }
          }
        }        
      }
      if(wgpid == -1) // no arg
      {
        errs() << 0 << '\n';
        return false;
      }
      
      // 2. find potential clSetKernelArg inst
      WGArg wgArg[10];
      for(int i = 0; i < kcnt; i++)
      {
        wgArg[i].kernel = i;
        wgArg[i].acnt   = 0;  // number of args
        wgArg[i].wgcnt  = 0;  // number of wg args
      }
      int instcnt = -1;
      int xcnt    = 0;
      int cur     = y[0];
      for(Module::iterator f = M.begin(), f2 = M.end(); f!=f2; f++) // functions
      { 
        for(Function::iterator bb = f->begin(), e = f->end(); bb!=e; bb++)  // basic blocks
        { 
          for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++) // instructions
          {
            std::string si = formatv("{0}",*i).str();
            if(si.find("clSetKernelArg") != std::string::npos)  // find "clSetKernelArg"
            {
              instcnt++;
              wgArg[xcnt].acnt++;
              Instruction *Inst = dyn_cast<Instruction>(i);
              // find all args the "clSetKernelArg" inst uses
              int opcnt = 0;
              for(Use &U: Inst->operands())
              {
                Value *v = U.get();
                opcnt++;
                // we need the 4th arg not using "cl_mem"
                if(opcnt == 4 && formatv("{0}",*v).str().find("cl_mem") == std::string::npos)  
                {                                                               
                  // change to next kernel
                  if(instcnt >= cur) 
                  {
                    xcnt++;
                    cur += y[xcnt]; // next kernel's location boundary
                  }
                  // if this kernel is in k[..]
                  if(findKernel(k, xcnt, kcnt)) 
                  {                    
                    wgArg[xcnt].ska[wgArg[xcnt].wgcnt] = Inst;  //errs() << "find: " << *Inst << '\n';
                    wgArg[xcnt].wgcnt++;
                  }
                }
              }
            }
          }
        }
      }
      /*
      for(int i = 0; i < kcnt; i++)
      {
        errs() << wgArg[i].kernel << ": ";
        errs() << wgArg[i].wgcnt << "\n";
        for(int j = 0; j < wgArg[i].wgcnt; j++)
        {
          errs() << *wgArg[i].ska[j] << '\n';
        }
      }
      */
      // 3. find insts according to step 1 (gep, index), and test according to step 2 (suitable arg)
      for(Module::iterator f = M.begin(), f2 = M.end(); f!=f2; f++) // functions
      { 
        if(f->getName() == "main")
        {
          for(Function::iterator bb = f->begin(), e = f->end(); bb!=e; bb++)  // basic blocks
          { 
            for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++) // instructions
            {
              Instruction *inst = dyn_cast<Instruction>(i);
              std::string sinst = formatv("{0}", *inst).str();
              if(sinst.find("%struct.Params") != std::string::npos) // if contains ".."
              {
                if(inst->getOpcode() == Instruction::GetElementPtr)
                {
                  Value *op2 = inst->getOperand(2); // op2 refers to the index
                  ConstantInt *ci = dyn_cast<ConstantInt>(op2);
                  // if the index matches "n_work_groups"
                  if(ci->getSExtValue() == wgpid)
                  {                   
                    Instruction *inst2 = inst;  //errs() << "find: " << *inst << '\n';        
                    int value = 1;
                    bool stop = false;
                    while(!stop)
                    {
                      for(User *U: inst2->users())  // inst2 is used in ?
                      {                       
                        Instruction *Inst = dyn_cast<Instruction>(U); //errs() << *U << '\n';
                        switch(Inst->getOpcode())
                        {
                          case Instruction::Invoke: // clSetKErnelArg
                            for(int i = 0; i < kcnt; i++)
                            {
                              for(int j = 0; j < wgArg[i].wgcnt; j++)
                              {
                                if(Inst->isIdenticalTo(wgArg[i].ska[j]))  // the same inst
                                {
                                  //errs() << "yes\n";
                                  wgarg[wgcnt][0] = wgArg[i].kernel;
                                  wgarg[wgcnt][1] = wgArg[i].acnt;
                                  wgarg[wgcnt][2] = value;  //errs() << "value: " << value << '\n';                                 
                                  wgcnt++;
                                }
                              }
                            }
                            stop = true;
                            break;
                          case Instruction::Call: 
                          case Instruction::Store:                           
                            stop = true;  //errs() << "value: " << value << '\n';
                            break;
                          // continue
                          case Instruction::Mul:
                            value = computeValue(Inst, inst2, "mul", value, wivalue, wipid);
                            inst2 = Inst;
                            break;
                          case Instruction::UDiv:
                            value = computeValue(Inst, inst2, "div", value, wivalue, wipid);
                            inst2 = Inst;
                            break;
                          case Instruction::Add:
                            value = computeValue(Inst, inst2, "add", value, wivalue, wipid);
                            inst2 = Inst;
                            break;
                          case Instruction::Sub:
                            value = computeValue(Inst, inst2, "sub", value, wivalue, wipid);
                            inst2 = Inst;
                            break;
                          default:
                            inst2 = Inst;
                            break;
                        }
                      }
                    }                                       
                  }
                }
              }
            }
          }
        }       
      }      
      //errs() << wgcnt << '\n';
      for(int i = 0; i < wgcnt; i++)
      {
        // invalid result
        if(wgarg[i][2] < 0)
        {
          continue;
        }
        errs() << wgarg[i][0] << ' ';
        errs() << wgarg[i][1] << ' ';
        errs() << wgarg[i][2] << '\n';
      }
      return false;
    }
  };
}  // end of anonymous namespace

char WGArgs::ID = 0;
static RegisterPass<WGArgs> X("wgargs", "do on clSetKernelArg's arguments of host code",
                             false /* Only looks at CFG */,
                             false /* Analysis Pass */);

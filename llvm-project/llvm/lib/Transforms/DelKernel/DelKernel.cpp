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
#include "llvm/Analysis/CFG.h"

using namespace llvm;

namespace {

  struct DelKernel : public ModulePass {
    static char ID;
    DelKernel() : ModulePass(ID) {}    

    struct BBList
    {
      BasicBlock *bb;     // bb
      std::string name;   // name of bb
      bool keep;          // delete or not
    };
    
    struct KList
    {
      int kid;            // kernel id
      int bbcnt;          // number of bb
      BBList bbList[40];  // bbList
    };

    int findKernel(KList kList[], int kcnt, int k)
    {
      for(int i = 0; i < kcnt; i++)
      {
        if(k == kList[i].kid)
        {
          return i;
        }
      }
      return -1;
    }
    // match the kernel-arg, and return its value
    int match(int wgarg[10][3], int wganum, int k, int a)
    {
      for(int i = 0; i < wganum; i++)
      {
        if(k == wgarg[i][0] && a == wgarg[i][1])
        {
          return wgarg[i][2];
        }
      }
      return -1;
    }

    int findBB(KList kList[], int pos, BasicBlock *ibb)
    {
      for(int i = 0; i < kList[pos].bbcnt; i++)
      {
        if(ibb == kList[pos].bbList[i].bb)
        {
          return i;
        }
      }
      return -1;
    }
    
    int computeValue(Instruction *inst, int op1, int op2)
    {
      switch(inst->getOpcode())
      {
        case Instruction::LShr:
          return op1>>op2;
        case Instruction::Shl:
          return op1<<op2;
        case Instruction::Add:
          return op1+op2;
        case Instruction::Sub:
          return op1-op2;
        case Instruction::Mul:
          return op1*op2;
        case Instruction::UDiv:
        case Instruction::SDiv:
          return op1/op2;
        case Instruction::ICmp:
        {
          ICmpInst *icmp = dyn_cast<ICmpInst>(inst);
          switch(icmp->getPredicate())
          {
            case CmpInst::Predicate::ICMP_EQ:   // equal
              return op1==op2 ? 1:0; 
            case CmpInst::Predicate::ICMP_NE:   // not equal
              return op1!=op2 ? 1:0;
            case CmpInst::Predicate::ICMP_UGT:  // unsigned greater than
            case CmpInst::Predicate::ICMP_SGT:  // signed greater than
              return op1>op2 ? 1:0;
            case CmpInst::Predicate::ICMP_UGE:  // unsigned greater or equal
            case CmpInst::Predicate::ICMP_SGE:  // signed greater or equal
              return op1>=op2 ? 1:0;
            case CmpInst::Predicate::ICMP_ULT:  // unsigned less than
            case CmpInst::Predicate::ICMP_SLT:  // signed less than
              return op1<op2 ? 1:0;
            case CmpInst::Predicate::ICMP_ULE:  // unsigned less or equal
            case CmpInst::Predicate::ICMP_SLE:  // signed less or equal
              return op1<=op2 ? 1:0;
            default:
              return -100;  // do not consider FCmpInst
          }
        }
        default:
          return -100;
      }
    }
    // recursively find the bb's terminator, and compute the value
    int findTerminator(BasicBlock *bb, Instruction *inst, std::string vname, int value)
    {
      //errs() << "inst: " << *inst << '\n';  //errs() << "value: " << value << '\n';
      if(inst == bb->getTerminator())  // end
      {
        //errs() << "terminator\n";
        return value;
      }
      else if(inst->getParent() != bb) // out of this bb
      {
        //errs() << "out of bb\n";
        return -100;
      }
      else if(inst->getOpcode() == Instruction::Store)
      {
        //errs() << "meet store\n";
        return -100;
      }
      else if(value == -100)
      {
        return -100;
      }
      else
      {
        // computing part
        switch(inst->getOpcode())
        {
          case Instruction::ICmp:
          case Instruction::LShr:
          case Instruction::Add:
          case Instruction::Sub:
          case Instruction::Mul:
          case Instruction::UDiv:
          case Instruction::SDiv:
          {
            Value *op0 = inst->getOperand(0);
            Value *op1 = inst->getOperand(1);
            std::string sop0 = formatv("{0}", *op0).str();
            std::string sop1 = formatv("{0}", *op1).str();
            // op0 is constant, op1 uses the value
            if(isa<Constant>(op0) && sop1.find(vname) != std::string::npos) 
            {
              ConstantInt *c0 = dyn_cast<ConstantInt>(op0);
              value = computeValue(inst, c0->getSExtValue(), value);
            }
            // op1 is constant, op0 uses the value
            else if(isa<Constant>(op1) && sop0.find(vname) != std::string::npos)
            {
              ConstantInt *c1 = dyn_cast<ConstantInt>(op1);
              value = computeValue(inst, value, c1->getSExtValue());
            }
            else
            {
              value = -100;
            }
            break;
          }       
        }        
        int ucnt = inst->getNumUses();  // get the number of users
        int res[10];
        int cnt = 0;
        for(User *U: inst->users())
        {
          Instruction *i = dyn_cast<Instruction>(U);
          res[cnt++] = findTerminator(bb, i, inst->getName(), value); // do for each users
        }
        // if inst has 2 users or more
        if(inst->hasNUsesOrMore(2))
        {
          for(int i = 0; i < ucnt; i++)
          {
            if(res[i] != -100)  // only one will reach the terminator i think
            {
              return res[i];
            }
          }
        }
        // if inst has 1 user (usually)
        else if(inst->hasOneUse())
        {
          return res[0];
        }
        else
        {
          return -100;
        }
        return -100;
      }
    }

    bool findPreds(BasicBlock *pbb, BasicBlock *bb, int level)
    { 
      if(level > 2)
      {
        return false;
      }
      // 2.2.1. is itself
      if(pbb == bb)
      {
        return true;
      }
      bool ret = false;
      for(succ_iterator s = succ_begin(bb), e = succ_end(bb); s!=e; s++)  // for all successors
      {
        BasicBlock *sbb = dyn_cast<BasicBlock>(*s);
        ret = ret | findPreds(pbb, sbb, level+1);
      }
      // 2.2.2. is its successor
      // 2.2.3. is its successor's successor
      return ret;
    }

    void handleBB(BasicBlock *tbb, BasicBlock *pbb, KList kList[], int pos)
    {
      // 1. testbb should be Y now
      int bbpos = findBB(kList, pos, tbb);  // find testbb's position
      if(kList[pos].bbList[bbpos].keep)     // find testbb's situation
      {
        // 2.1. testbb has only one predecessor
        if(tbb->hasNPredecessors(1))
        {         
          kList[pos].bbList[bbpos].keep = false;  //errs() << "delete: " << tbb->getName() << '\n';         
          for(succ_iterator s = succ_begin(tbb), e = succ_end(tbb); s!=e; s++)
          {
            BasicBlock *dest = dyn_cast <BasicBlock>(*s);
            handleBB(dest, tbb, kList, pos);
          }
        }
        // 2.2. testbb has two predecessors
        else 
        {
          for(pred_iterator p = pred_begin(tbb), e = pred_end(tbb); p!=e; p++)
          {           
            BasicBlock *prebb = dyn_cast<BasicBlock>(*p); //errs() << "preds: " << **p << '\n';errs() << "preds: " << prebb->getName() << '\n';          
            if(prebb != pbb)  // find the another predecessor
            {
              // test for the another predecessor: we can handle 3-nested loops (branches)
              if(findPreds(prebb, tbb, 0))
              {             
                kList[pos].bbList[bbpos].keep = false;  //errs() << "delete: " << tbb->getName() << '\n';              
                for(succ_iterator s = succ_begin(tbb), e = succ_end(tbb); s!=e; s++)
                {
                  BasicBlock *dest = dyn_cast <BasicBlock>(*s);
                  handleBB(dest, tbb, kList, pos);
                }
              }
            }
          }
        }
      }
    }
    
    bool runOnModule(Module &M) override {

      // 1. we need kcnt and k[..] from WGArgs.out
      // kcnt: number of kernels to consider (kernels in kernel pairs that are not KKC)
      // k[..]: kernels to consider
      // and store to kList[..]
      int kcnt = 0;
      KList kList[10];
      // 2. we need __ kernel's __ arg = __ from WGArgs.out
      // wgacnt: number of wg args
      // wgarg[..][0]: kernel id
      // wgarg[..][1]: arg id
      // wgarg[..][2]: value
      int wgacnt = 0;
      int wgarg[10][3];
      bool arg;

      std::string app = APP;
      std::string file = "/root/Work/llvm/apps/" + app + "/WGArgs.out";
      std::ifstream fin(file);
      char line[20];
      fin.getline(line, sizeof(line));  // first line: no use
      fin.getline(line, sizeof(line));  // second line: no use
      fin.getline(line, sizeof(line));
      std::stringstream ssk(line);
      ssk >> kcnt;  // the number of kernels
      int i = 0;
      while(i < kcnt)
      {
        fin.getline(line, sizeof(line));
        std::stringstream ss(line);
        ss >> kList[i++].kid;
      }

      while(fin.getline(line, sizeof(line)))
      {
        std::stringstream sswg(line);
        sswg >> wgarg[wgacnt][0];
        sswg >> wgarg[wgacnt][1];
        sswg >> wgarg[wgacnt][2];
        wgacnt++;
      }
      if(wgacnt > 0)
      {
        arg = true;
      }
      else
      {
        arg = false;
      }

      int k = -1;
      for(Module::iterator f = M.begin(), f2 = M.end(); f!=f2; f++) // functions
      { 
        if(f->getCallingConv() == 76)
        {
          k++;
          int pos = findKernel(kList, kcnt, k);
          // if k is in kList: find its position
          if(pos != -1) 
          {
            kList[pos].bbcnt = 0;
            for(Function::iterator bb = f->begin(), e = f->end(); bb!=e; bb++)  // basic blocks
            {
              BasicBlock *bbtmp = dyn_cast<BasicBlock>(bb); //errs() << bbtmp->getName() << '\n';            
              kList[pos].bbList[kList[pos].bbcnt].bb = bbtmp;
              kList[pos].bbList[kList[pos].bbcnt].name = bbtmp->getName();
              kList[pos].bbList[kList[pos].bbcnt].keep = true;
              kList[pos].bbcnt++;
            }
          }
        }
      }
/*
      for(int i = 0; i < kcnt; i++)
      {
        errs() << "kid: " << kList[i].kid << '\n';
        for(int j = 0; j < kList[i].bbcnt; j++)
        {
          errs() << "bb: " << kList[i].bbList[j].name << '\n';
        } 
      }
*/
      // if there are args be consider
      if(arg)
      {
        int k = -1;
        for(Module::iterator f = M.begin(), f2 = M.end(); f!=f2; f++) // functions
        { 
          if(f->getCallingConv() == 76)
          {
            k++;
            int acnt = -1;
            for(Function::arg_iterator a = f->arg_begin(), e = f->arg_end(); a != e; a++)
            {
              acnt++;
              // if (k, acnt) is in wgarg: get its value
              int value = match(wgarg, wgacnt, k, acnt);
              if(value != -1) 
              {
                // and find the position of k
                int pos = findKernel(kList, kcnt, k);   //errs() << a->getName() << '\n';            
                for(Function::iterator bb = f->begin(), e = f->end(); bb!=e; bb++)  // all basic blocks
                {
                  for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++) // all instructions
                  {
                    std::string si = formatv("{0}",*i).str();
                    if(si.find(a->getName()) != std::string::npos)  // find the related instructions
                    {                  
                      Instruction *inst = dyn_cast<Instruction>(i); //errs() << "inst: " << *i << '\n';
                      BasicBlock *ibb = inst->getParent();
                      // find the position of its parent bb
                      int bbpos = findBB(kList, pos, ibb); 
                      // this inst needs to be considered only when its situation now is "true"
                      if(kList[pos].bbList[bbpos].keep) 
                      {
                        int res = findTerminator(ibb, inst, a->getName(), value); //errs() << "parent bb: " << kList[pos].bbList[bbpos].name << '\n';//errs() << "result value: " << res << '\n';                      
                        // valid result
                        if(res != -100)
                        {
                          Instruction *last_inst = ibb->getTerminator();
                          if(BranchInst *br_inst = dyn_cast<BranchInst>(last_inst))
                          {
                            // this inst needs to be considered only when it leads to a definite branch
                            // it should be a conditional branch
                            if(br_inst->isConditional())
                            {
                              BasicBlock *dest; //errs() << "br: " << *br_inst << '\n';                             
                              if(res == 1)
                              {
                                dest = br_inst->getSuccessor(1);
                              }
                              else if(res == 0)
                              {
                                dest = br_inst->getSuccessor(0);
                              }
                              //errs() << "handle: " << dest->getName() << '\n';
                              handleBB(dest, ibb, kList, pos);
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
        }
      }
      for(int i = 0; i < kcnt; i++)
      { //errs() << i << '\n';       
        int y = 0;
        int n = 0;
        for(int j = 0; j < kList[i].bbcnt; j++)
        { //errs() << "bb: " << kList[i].bbList[j].name << ":\t";         
          if(kList[i].bbList[j].keep)
          {           
            y++;  //errs() << "y\n";
          }
          else
          {           
            n++;  //errs() << "n\n";
          }
        }
        // if we delete more than half of the bbs
        if(n > y)
        {
          errs() << "\t\tYes\n";
          errs() << "1\n";
          return false;
        }
      }
      errs() << "\t\tNo\n";
      errs() << "0\n";
      return false;
    }
  };
}  // end of anonymous namespace

char DelKernel::ID = 0;
static RegisterPass<DelKernel> X("delkernel", "find multi-pass scheme",
                             false /* Only looks at CFG */,
                             false /* Analysis Pass */);

#define APP "PS_2"

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

  struct MPS : public ModulePass {
    static char ID;
    MPS() : ModulePass(ID) {}    

    struct BBList
    {
      BasicBlock *bb;
      std::string name;
      bool keep;
    };
    
    struct KList
    {
      int kid;  // not all kernels need to test
      int bbcnt;
      BBList bbList[40];
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
          //errs() << icmp->getPredicate() << '\n';
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
          }
        }
      }
    }
    // recursively find the bb's terminator, and compute the value
    int findTerminator(BasicBlock *bb, Instruction *inst, std::string vname, int value)
    {
      //errs() << "inst: " << *inst << '\n';
      //errs() << "value: " << value << '\n';
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
          {
            Value *op0 = inst->getOperand(0);
            Value *op1 = inst->getOperand(1);
            std::string sop0 = formatv("{0}", *op0).str();
            std::string sop1 = formatv("{0}", *op1).str();
            if(isa<Constant>(op0) && sop1.find(vname) != -1) // op0 is constant, op1 uses the value
            {
              ConstantInt *c0 = dyn_cast<ConstantInt>(op0);
              value = computeValue(inst, c0->getSExtValue(), value);
            }
            else if(isa<Constant>(op1) && sop0.find(vname) != -1)  // op1 is constant, op0 uses the value
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
        int ucnt = inst->getNumUses();  // the number of users
        int res[10];
        int cnt = 0;
        for(User *U: inst->users())
        {
          Instruction *i = dyn_cast<Instruction>(U);
          res[cnt++] = findTerminator(bb, i, inst->getName(), value); // do for each users
        }
        if(inst->hasNUsesOrMore(2)) // if inst has 2 users or more
        {
          for(int i = 0; i < ucnt; i++)
          {
            if(res[i] != -100)  // only one will reach the terminator i think
            {
              return res[i];
            }
          }
        }
        else  // if inst has 1 user (usually)
        {
          return res[0];
        }
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
      //Instruction *last_inst = bb->getTerminator();
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
          //errs() << "delete: " << tbb->getName() << '\n';
          kList[pos].bbList[bbpos].keep = false;          
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
            //errs() << "preds: " << **p << '\n';
            BasicBlock *prebb = dyn_cast<BasicBlock>(*p);
            //errs() << "preds: " << prebb->getName() << '\n';
            if(prebb != pbb)  // find the another predecessor
            {
              // test for the another predecessor: we can handle 3-nested loops (branches)
              if(findPreds(prebb, tbb, 0))
              {
                //errs() << "delete: " << tbb->getName() << '\n';
                kList[pos].bbList[bbpos].keep = false;               
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

      // 1. we need kcnt and k[..] from WGArgs (host)
      int kcnt = 0;
      KList kList[10];
      // 2. we need __ kernel's __ arg = __ from WGArgs (host)
      int wgacnt = 0;
      int wgarg[10][3];
      bool arg;

      std::string app = APP;
      std::string file = "/root/Work/llvm/apps/" + app + "/WGArgs.out";
      std::ifstream fin(file);
      char line[20];
      fin.getline(line, sizeof(line));  // first line: no use
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
      fin.getline(line, sizeof(line));  // the number of wg args
      std::stringstream ssa(line);
      ssa >> wgacnt;
      i = 0;
      while(fin.getline(line, sizeof(line)))
      {
        std::stringstream sswg(line);
        sswg >> wgarg[i][0];
        sswg >> wgarg[i][1];
        sswg >> wgarg[i][2];
        i++;
      }
      if(wgacnt > 0)
      {
        //errs() << "true\n";
        arg = true;
      }
      else
      {
        //errs() << "false\n";
        arg = false;
      }

      int k = -1;
      for(Module::iterator f = M.begin(), f2 = M.end(); f!=f2; f++) // functions
      { 
        if(f->getCallingConv() == 76)
        {
          k++;
          int pos = findKernel(kList, kcnt, k);
          if(pos != -1) // need to test this kernel
          {
            kList[pos].bbcnt = 0;
            for(Function::iterator bb = f->begin(), e = f->end(); bb!=e; bb++)  // basic blocks
            {
              BasicBlock *bbtmp = dyn_cast<BasicBlock>(bb);
              //errs() << bbtmp->getName() << '\n';
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
              int value = match(wgarg, wgacnt, k, acnt);
              if(value != -1) // kernel-arg need to be considered
              {
                int pos = findKernel(kList, kcnt, k); // find the pos of this kernel in kList
                //errs() << a->getName() << '\n';
                for(Function::iterator bb = f->begin(), e = f->end(); bb!=e; bb++)  // all basic blocks
                {
                  for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++) // all instructions
                  {
                    std::string si = formatv("{0}",*i).str();
                    size_t idx = si.find(a->getName()); // find the related instructions
                    if(idx != -1)
                    {
                      //errs() << "inst: " << *i << '\n';
                      Instruction *inst = dyn_cast<Instruction>(i);
                      BasicBlock *ibb = inst->getParent();
                      int bbpos = findBB(kList, pos, ibb);  // find its parrent bb's situation
                      if(kList[pos].bbList[bbpos].keep) // this inst is need to considered only when its situation now is yes
                      {
                        //errs() << "parent bb: " << kList[pos].bbList[bbpos].name << '\n';
                        int res = findTerminator(ibb, inst, a->getName(), value);
                        //errs() << "result value: " << res << '\n';
                        if(res != -100)
                        {
                          Instruction *last_inst = ibb->getTerminator();
                          if(BranchInst *br_inst = dyn_cast<BranchInst>(last_inst))
                          {
                            if(br_inst->isConditional())  // conditional
                            {
                              BasicBlock *dest;
                              //errs() << "br: " << *br_inst << '\n';
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
      {
        errs() << i << '\n';
        int y = 0;
        int n = 0;
        for(int j = 0; j < kList[i].bbcnt; j++)
        {
          errs() << "bb: " << kList[i].bbList[j].name << ":\t";
          if(kList[i].bbList[j].keep)
          {
            errs() << "y\n";
            y++;
          }
          else
          {
            errs() << "n\n";
            n++;
          }
        }
        if(n > y) // delete more than half
        {
          errs() << "\t\tYes\n";
          return false;
        }
      }
      errs() << "\t\tNo\n";
      return false;
    }
  };
}  // end of anonymous namespace

char MPS::ID = 0;
static RegisterPass<MPS> X("mps", "find multi-pass scheme",
                             false /* Only looks at CFG */,
                             false /* Analysis Pass */);

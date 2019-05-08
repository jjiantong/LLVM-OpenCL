#define APP "PS_2"

#include <iostream>
#include <sstream>
#include <fstream>
#include <string>

#include "llvm/Pass.h"
#include "llvm/IR/User.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FormatVariadic.h"

using namespace llvm;

namespace {

  struct KKC : public ModulePass {
    static char ID;
    KKC() : ModulePass(ID) {}

    struct AccessP
    {
      Instruction *index;
      int flag; // 0: no; 1: if branches; 2: for loops 
      Instruction *cmp; // condition of 1 
      Instruction *bound; // bound of 2
    };

    struct KKCP
    {
      bool isKKC;
      int kernel1;
      int arg1;
      int kernel2;
      int arg2;
      int icnt1;
      int icnt2;
      AccessP ap1[16];
      AccessP ap2[16];
    };

    int matchOut(int cand[][4], int k, int a, int ccnt) // upper kernel
    {
      for(int i = 0; i < ccnt; i++)
      {
        if(cand[i][0] == k && cand[i][1] == a)
        {
          return i;
        }
      }
      return -1;
    }

    int matchIn(int cand[][4], int k, int a, int ccnt)  // lower kernel
    {
      for(int i = 0; i < ccnt; i++)
      {
        if(cand[i][2] == k && cand[i][3] == a)
        {
          return i;
        }
      }
      return -1;
    }

    bool isLoop(KKCP kkc[], BasicBlock *bb, int pos, int icnt, bool isProducer)
    {
      //errs() << "isloop:\n";
      bool ret = false;
      if(Instruction *last_inst = bb->getTerminator())
      {
        if(BranchInst *br_inst = dyn_cast<BranchInst>(last_inst))
        {
          if(br_inst->isConditional())  // should be a conditional branch
          {
            BasicBlock *dest0 = br_inst->getSuccessor(0); // two successors
            BasicBlock *dest1 = br_inst->getSuccessor(1);
            if((dest0 == bb)||(dest1 == bb))  // one should be the current bb
            {
              //errs() << "is a loop\n";
              Value *v = br_inst->getOperand(0);
              Instruction *cmpi = dyn_cast<Instruction>(v);
              //errs() << "cmp: " << *cmpi << '\n';
              if(isProducer)
              {
                kkc[pos].ap1[icnt].bound = cmpi;
              }
              else
              {
                kkc[pos].ap2[icnt].bound = cmpi;
              }
              ret = true;
            }
            //else
              //errs() << "conditional branch, but not loop.\n";
          }
          //else
            //errs() << "unconditional branch\n";
        }
        //else
          //errs() << "not branch\n";
      }
      return ret;
    }

    bool isBr(KKCP kkc[], BasicBlock *bb, int pos, int icnt, bool isProducer)
    {
      //errs() << "isbr:\n";
      bool ret = false;
      if(bb->hasNPredecessors(1)) // should have only one predecessor
      {
        BasicBlock *prebb = bb->getUniquePredecessor();
        if(Instruction *last_inst = prebb->getTerminator())
        {
          if(BranchInst *br_inst = dyn_cast<BranchInst>(last_inst))
          {
            if(br_inst->isConditional())  // should be a conditional branch
            {
              Value *v = br_inst->getOperand(0);
              Instruction *cmpi = dyn_cast<Instruction>(v);
              //errs() << "cmp: " << *cmpi << '\n';
              if(isProducer)
              {
                kkc[pos].ap1[icnt].cmp = cmpi;
              }
              else
              {
                kkc[pos].ap2[icnt].cmp = cmpi;
              }
              ret = true;
            }
            //else
              //errs() << "unconditional branch\n";
          }
          //else
            //errs() << "not branch\n";
        }
      }
      //else
        //errs() << "has more than 1 prebb\n";
      return ret;
    }

    void findAP1(KKCP kkc[], int pos, GetElementPtrInst *inst)
    {
      kkc[pos].icnt1++;  // number of instructions      
      //errs() << "inst: " << *inst << '\n'; 
      Instruction *idx = dyn_cast<Instruction>(inst->getOperand(1));
      kkc[pos].ap1[kkc[pos].icnt1].index = idx; // store the instruction about index
      //errs() << "index: " << *idx << '\n';
      BasicBlock *bb = inst->getParent(); // find its location
      if(isLoop(kkc, bb, pos, kkc[pos].icnt1, true))  // if is a loop
      {
        kkc[pos].ap1[kkc[pos].icnt1].flag = 2;
      }                    
      else if(isBr(kkc, bb, pos, kkc[pos].icnt1, true)) // if is a branch
      {
        kkc[pos].ap1[kkc[pos].icnt1].flag = 1;
      }
      else  // if no
      {
        kkc[pos].ap1[kkc[pos].icnt1].flag = 0;
      }
    }

    void findAP2(KKCP kkc[], int pos, GetElementPtrInst *inst)
    {
      kkc[pos].icnt2++;  // number of instructions
      //errs() << "inst: " << *inst << '\n';  
      Instruction *idx = dyn_cast<Instruction>(inst->getOperand(1));
      kkc[pos].ap2[kkc[pos].icnt2].index = idx; // store the instruction about index
      //errs() << "index: " << *idx << '\n';  
      BasicBlock *bb = inst->getParent(); // find its location
      if(isLoop(kkc, bb, pos, kkc[pos].icnt2, false)) // if is a loop
      {
        kkc[pos].ap2[kkc[pos].icnt2].flag = 2;
      }                    
      else if(isBr(kkc, bb, pos, kkc[pos].icnt2, false)) // if is a branch
      {
        kkc[pos].ap2[kkc[pos].icnt2].flag = 1;
      }
      else  // if no
      {
        kkc[pos].ap2[kkc[pos].icnt2].flag = 0;
      }
    }

    bool sameValues(Instruction *i1, Instruction *i2)
    {
      if(i1->isSameOperationAs(i2, 0)) // should be the same operation
      {
        if(i1->getOpcode() == Instruction::Call) // is call instruction
        {
          //errs() << "find:" << *i1 << "!!!AND!!!" << *i2 << '\n';
          //Function *f1 = i1->getParent()->getParent();
          //Function *f2 = i2->getParent()->getParent();
          //errs() << "belong to: " << f1->getName() << " and " << f2->getName() << '\n';
          CallInst *cinst1 = dyn_cast<CallInst>(i1);
          CallInst *cinst2 = dyn_cast<CallInst>(i2); 
          StringRef func1  = cinst1->getCalledFunction()->getName();
          StringRef func2  = cinst2->getCalledFunction()->getName();
          Value *para1     = cinst1->getArgOperand(0);
          Value *para2     = cinst2->getArgOperand(0);
          if(func1 == func2)  // should be same: e.g., get_local_id
          {
            if(para1 == para2)  // should be same: 0, 1, or 2
            {
              return true;
            }
            else
            {
              return false;
            }
          }
          else
          {
            return false;
          }
        }

        else
        {
          //errs() << "find:" << *i1 << "!!!AND!!!" << *i2 << '\n';
          int ocnt = i1->getNumOperands();
          Value *v1[ocnt];
          Value *v2[ocnt];
          bool isSame[ocnt];
          for(int i = 0; i < ocnt; i++)
          {
            v1[i] = i1->getOperand(i);
            v2[i] = i2->getOperand(i);
            if(isa<Constant>(v1[i]) && isa<Constant>(v2[i]))  // both constants
            {
              //errs() << "both" << *v1[i] << " and " << *v2[i] << " are constants\n";
              std::string sv1 = formatv("{0}", *v1[i]).str(); 
              std::string sv2 = formatv("{0}", *v2[i]).str();
              if(sv1 == sv2)
              {
                //errs() << "and they are the same\n";
                isSame[i] = true;
              } 
              else
              {
                //errs() <<"but they are not equal\n";
                isSame[i] = false;
              }
            }
            else if((!isa<Constant>(v1[i])) && (!isa<Constant>(v2[i]))) // both not
            {
              Instruction *inst1 = dyn_cast<Instruction>(v1[i]);
              Instruction *inst2 = dyn_cast<Instruction>(v2[i]);
              if(inst1 && inst2)
              {
                isSame[i] = sameValues(inst1, inst2);
              }
              else
              {
                //!!!!!!!!!!!!
                //errs() << "they are not instruction: " << *v1[i] << "!!!AND!!!" << *v2[i] << '\n';               
                std::string sv1 = formatv("{0}", *v1[i]).str(); 
                std::string sv2 = formatv("{0}", *v2[i]).str();  
                /*
                Function *f1 = v1[i]->getParent()->getParent();
                Function *f2 = v2[i]->getParent()->getParent();
                int acnt  = -1;
                int apos1 = -1;
                int apos2 = -1;
                for(Function::arg_iterator a = f1->arg_begin(), e = f1->arg_end(); a != e; a++) // all args for f1
                {
                  acnt++;
                  std::string sa = formatv("{0}", *a).str();  // to string
                  if(sv1 == sa)
                  {
                    apos1 = acnt;
                    errs() << "it is the " << acnt+1 << "arg\n";
                  }
                }
                acnt = -1;
                for(Function::arg_iterator a = f2->arg_begin(), e = f2->arg_end(); a != e; a++) // all args for f2
                {
                  acnt++;
                  std::string sa = formatv("{0}", *a).str();  // to string
                  if(sv2 == sa)
                  {
                    apos2 = acnt;
                    errs() << "it is the " << acnt+1 << "arg\n";
                  }
                }
                */
                if(sv1 == sv2)
                {
                  // !!!!!!!!!!!!!!
                  // should: determine its num in arg list, and go back to host to further judge
                  //errs() << "and they are the same\n";
                  isSame[i] = true;
                } 
                else
                {
                  //errs() <<"but they are not equal\n";
                  isSame[i] = false;
                }
              }
            }
            else
            {
              isSame[i] = false;
            }
          }
          bool ret = isSame[0];
          for(int i = 1; i < ocnt; i++)
          {
            ret = ret && isSame[i];
          }
          return ret;
        }
      }
      else  // not the same operation
      {
        return false;
      }
    }

    bool runOnModule(Module &M) override {

      // we need ccnt and cand[..] from InOut (host)
      int cand[10][4];
      std::string app = APP;
      std::string file = "/root/Work/llvm/apps/" + app + "/InOut.out";
      std::ifstream fin(file);
      char line[20];
      int ccnt = 0;
      while(fin.getline(line, sizeof(line)))
      {
        std::stringstream ss(line);
        ss >> cand[ccnt][0];
        ss >> cand[ccnt][1];
        ss >> cand[ccnt][2];
        ss >> cand[ccnt][3];
        ccnt++;
      }
      /*
      int ccnt = 4;
      int cand[10][4] = { {0,1,1,0},
                          {1,1,2,0},
                          {1,2,2,2},
                          {2,1,3,0}};
      /*
      int ccnt = 3;
      int cand[10][4] = { {0,0,2,1},
                          {0,3,1,1},
                          {1,0,2,0}};
      */
      /*
      int ccnt = 1;
      int cand[10][4] = { {0,2,1,7}};
      */
      /*
      //test for br
      int ccnt = 1;
      int cand[10][4] = { {0,0,1,0}};
      */
      KKCP kkc[10];
      for(int i = 0; i < ccnt; i++)
      {
        kkc[i].kernel1 = cand[i][0];  // store to kkc
        kkc[i].arg1    = cand[i][1];
        kkc[i].kernel2 = cand[i][2];
        kkc[i].arg2    = cand[i][3];
        kkc[i].icnt1   = -1;
        kkc[i].icnt2   = -1;
      }
      int kcnt  = -1;
      for(Module::iterator f = M.begin(), f2 = M.end(); f!=f2; f++) // all functions
      {        
        if(f->getCallingConv() == 76) // __kernel: 76
        {
          kcnt++; //number of kernel
          //errs() << "Function name: " << f->getName() << '\n';
          //FunctionType *ty = f->getFunctionType();
          //errs() << "numparams: " << ty->getNumParams() << '\n';          
          int acnt = -1;
          for(Function::arg_iterator a = f->arg_begin(), e = f->arg_end(); a != e; a++) // all args of the function
          {
            acnt++; //number of arg
            int pos1 = matchOut(cand, kcnt, acnt, ccnt);  // for the producer kernel
            int pos2 = matchIn(cand, kcnt, acnt, ccnt);   // for the consumer kernel
            if(pos1 != -1)  // if (kcnt,acnt) is in cand: find this arg
            {
              //errs() << "producer: " << *a << '\n';
              std::string sa = formatv("{0}",*a).str(); // Argument(?) to string
              for(Function::iterator bb = f->begin(), e = f->end(); bb!=e; bb++)  // all basic blocks
              {
                for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++) // all instructions
                {
                  std::string si = formatv("{0}",*i).str();
                  size_t idx = si.find(sa); // find all related instructions: gep instructions
                  if(idx != -1)
                  {
                    if(GetElementPtrInst *gep = dyn_cast<GetElementPtrInst>(i))
                    {
                      findAP1(kkc, pos1, gep);
                    }            
                  }
                }
              }
              kkc[pos1].icnt1++;             
            }
                      
            else if(pos2 != -1)  // if (kcnt,acnt) is in cand: find this arg
            {
              //errs() << "consumer: " << *a << '\n';
              std::string sa = formatv("{0}",*a).str(); // Argument(?) to string
              for(Function::iterator bb = f->begin(), e = f->end(); bb!=e; bb++)  // all basic blocks
              {
                for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++) // all instructions
                {
                  std::string si = formatv("{0}",*i).str();
                  size_t idx = si.find(sa); // find all related instructions: gep instructions
                  if(idx != -1)
                  {
                    if(GetElementPtrInst *gep = dyn_cast<GetElementPtrInst>(i))
                    {
                      findAP2(kkc, pos2, gep);
                    }                   
                  }
                }
              }
              kkc[pos2].icnt2++;             
            }           
          }       
        }       
      }

      for(int pos = 0; pos < ccnt; pos++)
      {
        kkc[pos].isKKC = true;  // initializtion
        if(kkc[pos].icnt1 == kkc[pos].icnt2)  // num of instructions should be equal
        {
          int icnt = kkc[pos].icnt1;
          for(int i = 0; i < icnt; i++) // for each pair of instructions
          {
            if(kkc[pos].ap1[i].flag == kkc[pos].ap2[i].flag)  // should be the same pattern: no branch loop
            {
              int flag = kkc[pos].ap1[i].flag;
              // 1 match the index
              Instruction *inst1 = kkc[pos].ap1[i].index;
              Instruction *inst2 = kkc[pos].ap2[i].index;
              if(sameValues(inst1, inst2)) // have same index
              {
                if(flag == 1) // further for branch
                {
                  // 2 match the cmp
                  Instruction *cmp1 = kkc[pos].ap1[i].cmp;
                  Instruction *cmp2 = kkc[pos].ap2[i].cmp;
                  if(!sameValues(cmp1, cmp2))  // do not have the same condition
                  {
                    kkc[pos].isKKC = false;
                  }
                  /*
                  else
                  {
                    errs() << "!!!!!!!same condition!!!!!!!!!!!\n";
                  }
                  */
                }
                else if(flag == 2)  // further for loop
                {
                  // 3 match for loop
                  Instruction *cmp1 = kkc[pos].ap1[i].bound;
                  Instruction *cmp2 = kkc[pos].ap2[i].bound;
                  if(!sameValues(cmp1, cmp2))  // do not have the same condition
                  {
                    kkc[pos].isKKC = false;
                  }
                }
              }
              else
              {
                kkc[pos].isKKC = false;
              }
            }
            else  // not the same pattern
            {
              //errs() << *kkc[pos].ap1[i].index << " and " << *kkc[pos].ap2[i].index << " are not the same pattern!\n";
              //errs() << "flags: " << kkc[pos].ap1[i].flag << " and " << kkc[pos].ap2[i].flag << '\n';
              kkc[pos].isKKC = false;
              break;  // break the loop and turn to next pos
            }
          }
        }
        else  // num of instruction: not equal
        {
          //errs() << "different num of instructions!\n";
          kkc[pos].isKKC = false;
        }
      }

      // filter again
      for(int tpos = 0; tpos < ccnt; tpos++)
      {
        if(kkc[tpos].isKKC) // test for pos of (isKKC = true)
        {
          int tkernel1 = kkc[tpos].kernel1;
          int tkernel2 = kkc[tpos].kernel2;
          for(int fpos = 0; fpos < ccnt; fpos++)  // go through pos of (isKKC = false)
          {
            if(!kkc[fpos].isKKC)
            {
              int fkernel1 = kkc[fpos].kernel1;
              int fkernel2 = kkc[fpos].kernel2;
              if(tkernel1 <= fkernel1 && tkernel2 >= fkernel2)  // subset is false!
              {
                kkc[tpos].isKKC = false;
              }
            }
          }
        }
      }
      /*
      for(int i = 0; i < ccnt; i++)
      {
        errs() << "producer: " << kkc[i].kernel1 << ", " << kkc[i].arg1 << ":\n";
        for(int j = 0; j < kkc[i].icnt1; j++)
        {
          errs() << j << ": " << *kkc[i].ap1[j].index << '\n';
          errs() << kkc[i].ap1[j].flag << '\n';         
          if(kkc[i].ap1[j].flag == 1) // branch
          {
            errs() << "cmp: " << *kkc[i].ap1[j].cmp << '\n';
          }        
        }
        errs() << "consumer: " << kkc[i].kernel2 << ", " << kkc[i].arg2 << ":\n";
        for(int j = 0; j < kkc[i].icnt2; j++)
        {
          errs() << j << ": " << *kkc[i].ap2[j].index << '\n';
          errs() << kkc[i].ap2[j].flag << '\n';          
          if(kkc[i].ap2[j].flag == 1) // branch
          {
            errs() << "cmp: " << *kkc[i].ap2[j].cmp << '\n';
          }
        }
        errs() << "Result: ";
        if(kkc[i].isKKC)
          errs() << "true!!!!\n";
        else
          errs() << "false!!!!\n";
      }
      */
      /*
      bool res = false;
      int kres[10][2];
      int cnt = 0;
      for(int i = 0; i < ccnt; i++)
      {
        if(kkc[i].isKKC)
        {
          res = true;
          kres[cnt][0] = kkc[i].kernel1 + 1;
          kres[cnt][1] = kkc[i].kernel2 + 1;
          cnt++;
        }
      }
      if(res)
      {
        errs() << "\t\tYes (";
        for(int i = 0; i < cnt; i++)
        {
          errs() << " between kernel" << kres[i][0] << " and kernel" << kres[i][1] << ", ";
        }
        errs() << ")\n";
      }
      else
      {
        errs() << "\t\tNo\n";
      }
      */
      for(int i = 0; i < ccnt; i++)
      {
        errs() << kkc[i].kernel1 << ' ' << kkc[i].kernel2 << ' ';
        if(kkc[i].isKKC)
        {
          errs() << "Y\n";
        }
        else
        {
          errs() << "N\n";
        }
      }
      return false;
    }
  }; // end of struct Hello
}  // end of anonymous namespace

char KKC::ID = 0;
static RegisterPass<KKC> X("kkc", "find kernel-to-kernel communication",
                             false /* Only looks at CFG */,
                             false /* Analysis Pass */);

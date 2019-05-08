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
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FormatVariadic.h"

using namespace llvm;

namespace {

  struct SameBuffer : public ModulePass {
    static char ID;
    SameBuffer() : ModulePass(ID) {}    
    
    struct SuitInst
    {
      int iy[5];
      Instruction* i[5];
    };

    bool haveSameInst(SuitInst suitInst[], int x, int y[], int z[]) 
    {
      int flag = 0;
      int same = 0;
      for(int i1 = 0; i1 < x-1; i1++) // 0 ~ x-2
      {
        for(int j1 = 0; j1 < z[i1]; j1++) // every instruction
        {
          for(int i2 = i1+1; i2 < x; i2++) // the next ~ x-1
          {
            for(int j2 = 0; j2 < z[i2]; j2++) // every instruction
            {
              if(suitInst[i1].i[j1]->isIdenticalTo(suitInst[i2].i[j2]))
              {
                errs() << i1 << " " << suitInst[i1].iy[j1] << " "; 
                errs() << i2 << " " << suitInst[i2].iy[j2] << '\n';
                flag = 1;
                same = 1;
                break;
              }
            }
            if(flag) 
            {
              flag = 0; // break and break: to judge next instruction
              break;
            }
          }
        }
      }    
      if(same)  return true;
      else      return false;
    }
      
    bool runOnModule(Module &M) override {

      // we need x and y[..] from NumKernels (kernel)
      // x: #kernels; y[i]: #args for each kernel
      /*
      int x = 4;
      int y[4];
      y[0] = 3; y[1] = 4; y[2] = 4; y[3] = 3;   
      int z[4];
      SuitInst suitInst[4];      
      int x = 3;
      int y[3];
      y[0] = 4; y[1] = 3; y[2] = 2;
      int z[3];
      SuitInst suitInst[3];
      int x = 2;
      int y[2];
      y[0] = 3; y[1] = 8;
      int z[2];
      SuitInst suitInst[2];
      */
      int x;  // # kernels
      int y[10];  // # args for each kernel
      std::string app = APP;
      std::string file = "/root/Work/llvm/apps/" + app + "/NumKernels.out";
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
      int z[10];  // # suitable args (cl_mem) for each kernel
      SuitInst suitInst[10];

      int instcnt = -1;
      int ycnt    = -1;
      int zcnt    = -1;
      int xcnt    = 0;
      int cur     = y[0];
      for(Module::iterator f = M.begin(), f2 = M.end(); f!=f2; f++) // functions
      { 
        for(Function::iterator bb = f->begin(), e = f->end(); bb!=e; bb++)  // basic blocks
        { 
          for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++) // instructions
          { 
            std::string si = formatv("{0}",*i).str();
            size_t idx = si.find("clSetKernelArg"); 
            if(idx != -1) // find "clSetKernelArg"
            { 
              //errs() << *i << '\n';
              instcnt++;
              ycnt++;
              Instruction *Inst = dyn_cast<Instruction>(i);
              int opcnt = 0;
              for(Use &U: Inst->operands()) // find all instructions used by "clSetKernelArg"
              {
                Value *v = U.get();
                opcnt++;
                if(opcnt == 4 && formatv("{0}",*v).str().find("cl_mem") != -1)  // find what values the instruction uses
                {                                                               // we need the 4th arg with "cl_mem"
                  Instruction *arg4 = dyn_cast<Instruction>(v);                  
                  //errs() << "find : " << *arg4 << '\n';  // find instruction
                  if(instcnt < cur) // the same kernel
                  {
                    zcnt++; // actual cnt +1
                    //errs() << xcnt << ", " << ycnt << " ---- " << zcnt << '\n';
                  }
                  else  // change to next kernel
                  {
                    xcnt++;               // next kernel
                    ycnt = instcnt - cur; // real position
                    z[xcnt-1] = zcnt+1;   // record kernel's actually cnt
                    zcnt = 0;             // start cnting next kernel
                    cur += y[xcnt];       // next kernel's location boundary
                    //errs() << xcnt << ", " << ycnt << " ---- " << zcnt << '\n';
                  }
                  suitInst[xcnt].iy[zcnt] = ycnt; // real position
                  suitInst[xcnt].i[zcnt]  = arg4; // and instruction
                }            
              }
            }
          }
        }
      }
      z[xcnt] = zcnt+1; // record the last kernel's actually cnt

      bool same = haveSameInst(suitInst, x, y, z);
      int cnt = 0;
      while((!same) && cnt<5) // until find same instruction
      {
        for(int i = 0; i < x; i++)  // every kernel
        {
          for(int j = 0; j < z[i]; j++) // every instruction
          {
            Instruction *inst = dyn_cast<Instruction>(suitInst[i].i[j]);  // fetch from suitInst
            if(inst->getOpcode() == Instruction::BitCast  // for bitcast
              || inst->getOpcode() == Instruction::Load)  // or load instruction
            {
              Value *v = inst->getOperand(0);
              inst = dyn_cast<Instruction>(v);
              suitInst[i].i[j] = inst;
            }
          }
        }
        same = haveSameInst(suitInst, x, y, z);
        cnt ++;
      }

      return false;
    }
  };
}  // end of anonymous namespace

char SameBuffer::ID = 0;
static RegisterPass<SameBuffer> X("samebuffer", "do on clSetKernelArg's arguments of host code",
                             false /* Only looks at CFG */,
                             false /* Analysis Pass */);

#include <string>

#include "llvm/Pass.h"
#include "llvm/IR/User.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instruction.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FormatVariadic.h"

using namespace llvm;

namespace {

  struct NumKernels : public ModulePass {
    static char ID;
    NumKernels() : ModulePass(ID) {}

    bool runOnModule(Module &M) override {

      int kcnt = 0;
      int acnt[4];
      for(Module::iterator f = M.begin(), f2 = M.end(); f!=f2; f++) // all functions
      {        
        if(f->getCallingConv() == 76) // __kernel: 76
        {
          // get the number of args for each kernel
          acnt[kcnt++] = f->getFunctionType()->getNumParams();
        }
      }
      errs() << kcnt << '\n';
      if(kcnt > 1)  // if multi-kernels
      {
        for(int i = 0; i < kcnt; i++)
        {
          errs() << acnt[i] << '\n';
        }
      }     
      return false;
    }
  }; // end of struct Hello
}  // end of anonymous namespace

char NumKernels::ID = 0;
static RegisterPass<NumKernels> X("numkernels", "count the number of kernels and args",
                             false /* Only looks at CFG */,
                             false /* Analysis Pass */);

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

using namespace llvm;

namespace {

  struct MPS : public ModulePass {
    static char ID;
    MPS() : ModulePass(ID) {}    

    bool runOnModule(Module &M) override {

      // 1. we need kcnt and k[..] from WGArgs (host)
      int kcnt = 0;
      int k[10];
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
        ss >> k[i++];
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
      /*
      for(int i = 0; i < kcnt; i++)
      {
        errs() << k[i] << '\t';
      }
      errs() << '\n';
      for(int i = 0; i < wgacnt; i++)
      {
        errs() << wgarg[i][0] << ", " << wgarg[i][1] << ", " << wgarg[i][2] << '\n';
      }
      */
      for(Module::iterator f = M.begin(), f2 = M.end(); f!=f2; f++) // functions
      { 
        for(Function::iterator bb = f->begin(), e = f->end(); bb!=e; bb++)  // basic blocks
        { 
          for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++) // instructions
          {
            
          }
        }
      }

      return false;
    }
  };
}  // end of anonymous namespace

char MPS::ID = 0;
static RegisterPass<MPS> X("mps", "find multi-pass scheme",
                             false /* Only looks at CFG */,
                             false /* Analysis Pass */);

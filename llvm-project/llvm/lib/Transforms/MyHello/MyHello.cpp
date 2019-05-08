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

  struct MyHello : public ModulePass {
    static char ID;
    MyHello() : ModulePass(ID) {}

    bool runOnModule(Module &M) override {

      outs() << "Hello ";
      outs() << M.getName() << '\n';

      for(Module::iterator f = M.begin(), f2 = M.end(); f!=f2; f++) // all functions
      {
        if(f->getCallingConv() == 76) // __kernel: 76
        {
          outs() << "Function name: " << f->getName() << '\n';
          //FunctionType *ty = f->getFunctionType();
          //outs() << "numparams: " << ty->getNumParams() << '\n';
          
          //for(Function::arg_iterator a = f->arg_begin(), e = f->arg_end(); a != e; a++) // all args of the function
          //{           
            //outs() << *a << '\n';               // %8* data
            //outs() << a->getName() << '\n';     // data
            //outs() << a->getValueID() << '\n';  // 17
            //outs() << a->getType()->getTypeID() << '\n';
            //std::string sa = formatv("{0}",*a).str(); // Argument(?) to string
                       
            for(Function::iterator bb = f->begin(), e = f->end(); bb!=e; bb++)  // all basic blocks
            {
              for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++) // all instructions
              {
                std::string si = formatv("{0}",*i).str();
                size_t idx = si.find("%arrayidx14 ="); // find the related instructions
                if(idx != -1)
                {
                  Instruction *inst = dyn_cast<Instruction>(i);               
                  outs() << "inst: " << *inst << '\n';  
                  outs() << i->getName() << '\n';     
                  outs() << i->getValueID() << '\n';  
                  outs() << i->getType()->getTypeID() << '\n'; 
                  for(Use &U: inst->operands())
                  {
                    Value *v = U.get();
                    
                    if(GlobalValue *gv = dyn_cast<GlobalValue>(v))
                    {
                      outs() << *gv << '\n';
                      outs() << gv->getName() << '\n';
                      outs() << gv->getValueID() << '\n';
                      outs() << gv->getType()->getTypeID() << '\n';
                    }
                    else
                    {
                      outs() << *v << ": no\n";
                    }
                  }            
                }
              //}
            }                        
          }       
        } 
      }

      return false;
    }
  }; // end of struct Hello
}  // end of anonymous namespace

char MyHello::ID = 0;
static RegisterPass<MyHello> X("myhello", "Hello World Pass",
                             false /* Only looks at CFG */,
                             false /* Analysis Pass */);

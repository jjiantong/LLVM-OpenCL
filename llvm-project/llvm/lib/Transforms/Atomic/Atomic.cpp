#include <string>

#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FormatVariadic.h"

using namespace llvm;

namespace {
  
  struct Atomic : public ModulePass {
    static char ID; // Pass identification, replacement for typeid
    Atomic() : ModulePass(ID) {}

	bool runOnModule(Module &M) override {
    	
		int cnt = 0;		
		for(Module::iterator f=M.begin(), f2=M.end(); f!=f2; f++)	// all functions
		{
			for(Function::iterator bb=f->begin(), e=f->end(); bb!=e; bb++)	// all basic blocks
			{
				for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++)	// All instructions
				{
					if(CallInst *cinst = dyn_cast<CallInst>(i))
					{
						if(cinst->getCalledFunction()->getName().find("atomic") != std::string::npos)	// get the function called
						{
							cnt++;
						}
					}
				}
			}			
		}
		if(cnt)
		{
			errs() << "\t\tYes (" << cnt << " AOs)\n";
		}			
		else
		{
			errs() << "\t\tNo\n";
		}			
    	return false;
    }
  };
}

char Atomic::ID = 0;
static RegisterPass<Atomic> X("atomic", "find atomic operations");

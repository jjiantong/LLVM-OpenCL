#include <string>

#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FormatVariadic.h"

using namespace llvm;

namespace {
  
  struct Atomic : public ModulePass {
    static char ID; // Pass identification, replacement for typeid
    Atomic() : ModulePass(ID) {}

	bool runOnModule(Module &M) override {
    	
		//errs() << "Module name: " << M.getName() << '\n';			
		int cnt = 0;
		for(Module::iterator f=M.begin(), f2=M.end(); f!=f2; f++)	// All functions
		{
			//errs() << "Function name:" << f->getName() << '\n';
			for(Function::iterator bb=f->begin(), e=f->end(); bb!=e; bb++)	// All basic blocks
			{
				for(BasicBlock::iterator i = bb->begin(), i2 = bb->end(); i!=i2; i++)	// All instructions
				{
					//errs() << formatv("{0}",*i) <<"\n";
					std::string si = formatv("{0}",*i).str();	// Instruction to string
					size_t idx = si.find("atomic");
					if(idx != -1)
					{
						cnt++;
					}
				}
			}			
		}
		if(cnt)
			errs() << "\t\tYes (" << cnt << " AOs)\n";
		else
			errs() << "\t\tNo\n";

    	return false;
    }
  };
}

char Atomic::ID = 0;
static RegisterPass<Atomic> X("atomic", "find atomic operations");

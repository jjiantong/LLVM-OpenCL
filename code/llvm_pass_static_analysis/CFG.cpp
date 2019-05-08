#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <iostream>
#include <string>
#include <map>
#include <typeinfo>

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IRReader/IRReader.h"
#include <bits/stl_map.h>
#include "llvm/Support/CFG.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Support/GraphWriter.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
//#include "llvm/ADT/SmallVector.h"
#include "llvm/IR/InstrTypes.h"
#include <queue>

#if 0
  #define __DEBUG__(x) x
#else
  #define __DEBUG__(x)
#endif

using namespace llvm;

        #define LOAD_OR_STORE_IS_COALESCLED      1
		#define LOAD_OR_STORE_IS_NOT_COALESCLED  0
		#define INST_IS_NOT_LOAD_STORE           99
		
		#define LS_ADDR_SPACE_LOCAL           3
		#define LS_ADDR_SPACE_GLOBAL          1
	
	    #define MEM_TRANS_WIDTH               64 //64 bytes.
		
		
		// Referenced From http://llvm.org/doxygen/Instruction_8cpp_source.html

		
namespace
{
	struct FPGA_Model : public FunctionPass
	{
			static char ID; // Pass identification, replacement for typeid
			FPGA_Model() : FunctionPass(ID) {}

///////////////////////////////Input/////////////////////////////////////			
		float SIMD            = 1.0;
		float CU              = 1.0;
		float banks           = 2.0;
		float Mem_trans_width = 64;  //64 types.
		float WI              = 1024.0; //32.0*1024.0*1024.0; //2048.0*2048.0;	
        float MTP             = 0.66;		
		////////FPGA resource utilization for computing potential metrics//////
		

		//input loop counter from GPU profiler, loop_unroll from input...
#if 1
	    int Loops_counter_input[3]   = {32768, 128, 8};//{128, 8, 8}; //SM: {2048,1} //NSM: {2048, 1};
		int Loops_unroll_input[3]  = {1, 8, 8}; //1
#else
	    int Loops_counter_input[4]   = {32768, 8, 128, 8};//{128, 8, 8}; //SM: {2048,1} //NSM: {2048, 1};
		int Loops_unroll_input[4]  = {1, 1, 1, 1}; //1
#endif
///////////////////////////////Input/////////////////////////////////////	
			
		#define FP_ADD   7
		#define FP_SQRT  28
		#define FP_MULT  5
		#define FP_DIV   14
		
		#define INT_ADD  1
		#define INT_MULT 3
		#define INT_DIV  32
		
		#define CALL_LAT    1
		#define LOCAL_LOAD  7
		#define LOCAL_STORE 7
		#define GET_ELE_PTR 1
		#define PHI_NODE    1
	    #define SEL_NODE    1
	    #define INSN_NUM_MAX 200
	    #define ALLOCA_NODE 1
		
        std::vector<std::pair<int,int> > adj[INSN_NUM_MAX];
		std::map<Instruction *, unsigned> value_index_in_adj; // not only insn, but also parameter.
		unsigned adj_index = 1;
		
		//one comment: can we get the #pragme from OpenCL file...
        std::map<Loop*, int> Loops_counter, Loops_unroll;
	
		std::map<std::string, unsigned> statistics;
 
        float function_mem_insts = 0;
		
		//input data collectors
		std::map<BasicBlock *, float> mem_insts;
		std::map<BasicBlock *, float> mem_bytes;
		std::map<BasicBlock *, float> mem_burst;
		std::map<BasicBlock *, float> bb_critical_path;
		std::map<BasicBlock *, float> bb_accumulate_trip_counter;
		
		Instruction *bb_loop_coscelsced_index;
		
		float mem_byte_sum_tmp, mem_burst_sum_tmp, mem_insn_sum_tmp;
		
		unsigned insn_bytes(Type *type)
		{
			switch(type->getTypeID())
			{

				case Type::VoidTyID:
					return sizeof(nullptr);

				case Type::HalfTyID:
					break;

				case Type::FloatTyID:
					return 4;

				case Type::DoubleTyID:
					return 8;

				case Type::X86_FP80TyID:
					break;

				case Type::FP128TyID:
					break;

				case Type::PPC_FP128TyID:
					break;

				case Type::LabelTyID:
					break;

				case Type::MetadataTyID:
					break;

				case Type::X86_MMXTyID:
					break;

				case Type::IntegerTyID:
					return 4;

				case Type::FunctionTyID:
					break;

				case Type::StructTyID:
					break;

				case Type::ArrayTyID:
					return type->getArrayNumElements() *
						insn_bytes(type->getArrayElementType());

				case Type::PointerTyID:
					return insn_bytes(type->getPointerElementType());

				case Type::VectorTyID:
					break;

				case Type::NumTypeIDs:
					break;

				//default:
				//	break;
			} // switch

			return 0;
		}

	
		std::map<std::string, CallInst *> opencl_functions;
		
		unsigned inst_addr_linear_to_thread(Instruction *index_inst)
		{   
		    //errs()<<index_inst->getOpcode()<<"\n";
			
			if( CallInst *call_inst = dyn_cast<CallInst>(index_inst) )
			{
             //call_inst
			    //errs()<<"found the thread.......\n";
				
				Function *Callee = call_inst->getCalledFunction();
                StringRef FnName = Callee->getName();
                Value *parameter_0;
				parameter_0      = call_inst->getArgOperand(0);
                if (FnName == "get_local_id")
                {
				  unsigned Imm = (dyn_cast<ConstantInt>(parameter_0))->getZExtValue(); //0; //	
				  if (Imm == 0)//std::map<std::string, CallInst *> opencl_functions; 	
				  {
				    return LOAD_OR_STORE_IS_COALESCLED;
				  }
				}						
                else if (FnName == "get_global_id")
                {
				  unsigned Imm = (dyn_cast<ConstantInt>(parameter_0))->getZExtValue();	//0; //
				  if (Imm == 0)//std::map<std::string, CallInst *> opencl_functions; 	
				  {
				    return LOAD_OR_STORE_IS_COALESCLED;
				  }
				}
                 return LOAD_OR_STORE_IS_NOT_COALESCLED;					  
			}
			else if ((index_inst->getOpcode()) == Instruction::Add)
			{  
		
				unsigned op_0_flag, op_1_flag;
                //always has two operands....
				Value *op_0 = index_inst->getOperand(0);
				Value *op_1 = index_inst->getOperand(1);
				if ( Instruction *op_0_inst = dyn_cast<Instruction>(op_0) )
					op_0_flag = inst_addr_linear_to_thread(op_0_inst);
				else
					op_0_flag = LOAD_OR_STORE_IS_NOT_COALESCLED;
				
				if ( Instruction *op_1_inst = dyn_cast<Instruction>(op_1) )
					op_1_flag = inst_addr_linear_to_thread(op_1_inst);
				else
					op_1_flag = LOAD_OR_STORE_IS_NOT_COALESCLED;
				
                 //  errs()<< op_0_flag <<" "<< op_1_flag <<"  \n";

				return op_0_flag | op_1_flag; //only one operand is thread id, just engouh
			}
			else
			{  
				return LOAD_OR_STORE_IS_NOT_COALESCLED;
			}
			return LOAD_OR_STORE_IS_COALESCLED;
		}
		

		bool ls_insn_is_local(Instruction *inst)
		{
		  //Value *op_in_test;	
		  unsigned ls_is_local = 0;
		  
	///////////////////1////////inst///////////
		  //if inst is a Load instruction	
		  if (LoadInst *load_inst = dyn_cast<LoadInst>(inst)) 	//if (isa<LoadInst>(inst))
		  {
          	 //op_in_test  = load_inst->getPointerOperand();	
             ls_is_local = (LS_ADDR_SPACE_LOCAL == load_inst->getPointerAddressSpace() );			  
          }			 
		  //if inst is a Store instruction	
		  else if (StoreInst *store_inst = dyn_cast<StoreInst>(inst))
		  {	  
          	 //op_in_test = store_inst->getPointerOperand();		
             ls_is_local = (LS_ADDR_SPACE_LOCAL == store_inst->getPointerAddressSpace() );
		  }	 
          else 
			 errs()<<"ERROR: not load/store insn is tested for coalescing. \n";// return INST_IS_NOT_LOAD_STORE;
		  
		  return ls_is_local;
		}
		  
		unsigned coalescled_with_thread(Instruction *inst)
		{
		  Value *op_in_test;	
		  unsigned ls_is_local = 0;
		  
	///////////////////1////////inst///////////
		  //if inst is a Load instruction	
		  if (LoadInst *load_inst = dyn_cast<LoadInst>(inst)) 	//if (isa<LoadInst>(inst))
		  {
          	 op_in_test  = load_inst->getPointerOperand();	
             ls_is_local = (LS_ADDR_SPACE_LOCAL == load_inst->getPointerAddressSpace() );			  
          }			 
		  //if inst is a Store instruction	
		  else if (StoreInst *store_inst = dyn_cast<StoreInst>(inst))
		  {	  
          	 op_in_test = store_inst->getPointerOperand();		
             ls_is_local = (LS_ADDR_SPACE_LOCAL == store_inst->getPointerAddressSpace() );
		  }	 
          else 
			errs()<<"WARNING. Not load/store insn in function coalescled_with_thread\n";
          //return INST_IS_NOT_LOAD_STORE;
		  
		  //according optimization guide, if the LS accesses the local memory, then no coalescing happens.
		  if (ls_is_local == 1)
			  return LOAD_OR_STORE_IS_NOT_COALESCLED;
          
           // errs()<<"before the GEP test......\n";

	///////////////////2//////op_in_test/ is load/store ////////////
	       Instruction *index_inst;
		  //test whether op_in_test is a GEP, should be GEP.....
          if (GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(op_in_test)) 
		  {
			int num_of_indices = GEP->getNumIndices();  
            //assume it is not coalesced if with multiple indies; It is not right...
            if (num_of_indices != 1)
				return LOAD_OR_STORE_IS_NOT_COALESCLED; 
			else 
			{   //this is index for the load instruction....
				User::op_iterator II = GEP->idx_begin(); // idx_end
				index_inst = dyn_cast<Instruction>(*II);
			}
		  }
		  
          //if ()
           // errs()<<"before the inst_addr_linear_to_thread test......\n";

    ////////////////3///////index_inst/////////////////      
	       unsigned inst_is_coaleasced;
		   inst_is_coaleasced = inst_addr_linear_to_thread(index_inst); //true; //
		  
          return inst_is_coaleasced;
          //do the job to determine whether Load/Store is 		  
	    }  


		bool test_bb_is_loop(BasicBlock *itb)
		{
               //judge whether the basic block itb is a loop or not...
				if ( TerminatorInst *last_insn = itb->getTerminator() )
				{
					if ( BranchInst *br_insn = dyn_cast<BranchInst>(last_insn) )
					{
						if ( br_insn->isConditional() )
						{
							BasicBlock * dest_block_0 = br_insn->getSuccessor(0); 
							BasicBlock * dest_block_1 = br_insn->getSuccessor(1); 
							if ( (dest_block_0 == itb) || (dest_block_1 == itb) )
							{
					             return true;//errs()<<"it is the normal BB, it is a loop. \n";
								//test whether the load/store is easy to unroll...
							}
							else
					             return false; //errs()<<"it is the normal BB, it is a not loop. \n";
								
						}
						else
					       return false; //errs()<<"it is the normal BB, it is un-conditional br. \n";
						
					}
					else 
					  return false; //errs()<<"it is the normal BB, but not br. \n";
				}
				else
					return false; //errs()<<"it is not normal BB, ending with non-terminator insn. \n";

			
		}
		
		
		bool test_bb_is_loop_coalesced (BasicBlock *itb)
		{
          //judge whether the basic block itb is a loop or not...
          TerminatorInst *last_insn    = itb->getTerminator();
          BranchInst *br_insn          = dyn_cast<BranchInst>(last_insn);
          //go to the cmp isntruction.
          CmpInst *CI                  = dyn_cast<CmpInst>(br_insn->getCondition());
			 
			 //one of cmp ops is increasing with 1....and the other one is a constant....
          Value *CmpOp0                = CI->getOperand(0);
          Value *CmpOp1                = CI->getOperand(1);
          //CmpInst::Predicate Predicate = CI->getPredicate();
		  
          //test whether two operands are instructions.
	      Instruction *inc_insn;
		  bool inc_inst_found = false;
		  if (Instruction *op_0 = dyn_cast<Instruction>(CmpOp0))
		  {
             BasicBlock *bb_op_0   = op_0->getParent();
			 if (bb_op_0 == itb)
			 {
			   //errs()<<"it is potential instruction with increasing by 1. \n";	 
			   inc_inst_found      = true; 
			   inc_insn            = op_0;
			 }
		  }
	      
		  if (Instruction *op_1 = dyn_cast<Instruction>(CmpOp1))
		  {
             BasicBlock *bb_op_1    = op_1->getParent();
			 if (bb_op_1 == itb)
			 { 
			   inc_insn             = op_1;		       
			   if (inc_inst_found == true) 	 
			     errs()<<"WARNING!!!!two instructions of cmp_inst belong to this bb,not normal.. \n"; 
			 }
		  }
          
          //already focus on the increasing insn: inc_insn. 		  
          if ( (inc_insn->getOpcode() == Instruction::Add) || (inc_insn->getOpcode() == Instruction::Sub) )	
          {
             Value *Opnd0           = inc_insn->getOperand(0);
             Value *Opnd1           = inc_insn->getOperand(1);  
			 Instruction *opnd_0    = dyn_cast<Instruction>(Opnd0);
			 Instruction *opnd_1    = dyn_cast<Instruction>(Opnd1);
			 ConstantInt *conInt_0  = dyn_cast<ConstantInt>(Opnd0);
			 ConstantInt *conInt_1  = dyn_cast<ConstantInt>(Opnd1);
			 
			 Instruction *inc_insn_phi; 
			 ConstantInt *conInt_inc;
			 
			 if ( (opnd_0 != NULL) && (conInt_1 != NULL) ) 
			 {
				inc_insn_phi        =  opnd_0;
				conInt_inc          =  conInt_1;
			 }
			 else if ( (opnd_1 != NULL) && (conInt_0 != NULL) )
			 {
				inc_insn_phi        =  opnd_1;
				conInt_inc          =  conInt_0;
			 }
			 else
			 {   
		         errs()<<"Debugging: it is not phi insn + Constant .. \n"; 
				 return false;
			 }
				   
		    //test the inc_insn_phi.....
		     BasicBlock *bb_insn_phi   = inc_insn_phi->getParent();
		     if (bb_insn_phi == itb)
		     {
		       //errs()<<"it is potential instruction with increasing by 1. \n";	 
		       if ( !( isa<PHINode>(inc_insn_phi) ) )
		  	  {
		  		  errs()<<"Debugging: inc_insn is not PHI....\n"; 
		  		  return false;
		  	  }
		     }
				 
		  	
		  	int64_t constant_value       = conInt_inc->getSExtValue();
            if (constant_value == 1)
		  	 {
				bb_loop_coscelsced_index = inc_insn_phi; 
				//store the phi insn, test whether it is used to index the load/store insn. 
		  		return true; 
		  	 }
             else
		  	  {   
		  		  errs()<<"Constant is not equal to 1...\n"; 
		  		  return false;
		  	  }
				 
		  }		
          else 
            return false; // if it is not add/sub, it is not possible for unrolling to do well.
		}
	
	
		unsigned nested_loop_depth_for_basicblock(LoopInfo LI, BasicBlock *itb)
		{
						
				//test whether the bb belong to Loop.
				int counter_depth = 0;
                 const Loop *L = LI.getLoopFor(itb);
                 if (L) {
                   ++counter_depth;
                   while (const Loop *Parent = L->getParentLoop())
				   {
					   ++counter_depth;
                       L = Parent;
				   }
                   errs()<<"BB is belonging to Loop:"<<counter_depth<<"\n"; 
                 }
				 else 
					errs()<<"BB is not belonging to Loop."<<"\n"; 		
                return counter_depth;				
		}
		
		bool test_insn_benefit_from_ul (Instruction *inst, Instruction *inst_test)
		{
           Value *gep_in_test;	

		   if (LoadInst *load_inst = dyn_cast<LoadInst>(inst))
		   {	  
          	 gep_in_test = load_inst->getPointerOperand();		
		   }	 
           else if (StoreInst *store_inst = dyn_cast<StoreInst>(inst))
		   {	  
          	 gep_in_test = store_inst->getPointerOperand();		
		   }
           else
		   {   errs()<<"inst not ls_insn in test_insn_benefit_from_ul.\n";
			   return false;
		   }
		  //according optimization guide, if the LS accesses the local memory, then no coalescing happens.
		  
	///////////////////2//////gep_in_test/ is load/store ////////////
	       Instruction *index_inst;
		  //test whether gep_in_test is a GEP, should be GEP.....
          if (GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(gep_in_test)) 
		  {
			//int num_of_indices = GEP->getNumIndices();  
            //assume it is not coalesced if with multiple indies; It is not right...
            //this is index for the load instruction....
			User::op_iterator II, IE, ID;
             for ( II = GEP->idx_begin(), IE = GEP->idx_end(); II != IE; ++II)
				 ID = II;
             //User::op_iterator II = GEP->idx_end(); 
            index_inst = dyn_cast<Instruction>(*ID); //last offset instruction
			if (index_inst == inst_test)
			{	
				return true;
			}	
			else if ( (index_inst->getOpcode() == Instruction::Add) || (index_inst->getOpcode() == Instruction::Sub) )	//index_inst == NULL 
            {
             Value *Opnd0           = index_inst->getOperand(0);
             Value *Opnd1           = index_inst->getOperand(1);  
			 if (Instruction *opnd_0    = dyn_cast<Instruction>(Opnd0))
			 {
				 if (opnd_0 == inst_test)
					 return true;
			 }
			 if ( Instruction *opnd_1    = dyn_cast<Instruction>(Opnd1) )
			 {
                 if ( opnd_1 == inst_test ) 
			         return true;
			 }
			  
            //  errs() << (ID == IE) <<"index is null............................\n";
			} 
			//else 
			  //errs()<<"index is not null.............................\n";	
		  }	
		   return false;
  		}
      

		void compute_critical_path_getelementptr (Instruction *inst, unsigned latency)
		{
		    unsigned insn_tmp_index = 0;	
          //add inst to value_index_in_adj first. It is a new instruction in BB. 
            value_index_in_adj[inst] = adj_index;	
			insn_tmp_index           = adj_index;
			
			//connect the latency edge of inst: adj_index+INSN_NUM_MAX/2. 
           adj[insn_tmp_index].push_back(std::make_pair(insn_tmp_index+INSN_NUM_MAX/2, latency)); //INT_ADD
			adj_index++;
            __DEBUG__(errs()<<insn_tmp_index<<" to "<<insn_tmp_index+INSN_NUM_MAX/2<< "GET Latency:"<< latency << "\n";)
	   
           GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(inst); 
		  //int num_of_indices = GEP->getNumIndices();  
			
            //assume it is not coalesced if with multiple indies; It is not right...
          for (User::op_iterator II = GEP->idx_begin(), IE = GEP->idx_end(); II != IE; ++II)
		    {
			  //  Instruction* index_inst = dyn_cast<Instruction>(*II);		   
              if ( Instruction *insn_in_test = dyn_cast<Instruction>(*II) )
			   {
				   if ( (insn_in_test->getParent()) == (inst->getParent()) ) //oprand and inst in same bb.
				   { //find the insn_in_test's index in value_index_in_adj, then add the dependence....
					 std::map<Instruction *,unsigned>::iterator it;
					 if (it == value_index_in_adj.end())
                       errs()<<"Try to find the instruction in this block, but not found:Add. \n";
                    unsigned Op_index = value_index_in_adj[insn_in_test];
					 
					 //connect the real dependcy between Op and inst......................................
				     adj[Op_index+INSN_NUM_MAX/2].push_back(std::make_pair(insn_tmp_index, 0));
					 
					 __DEBUG__(errs()<<Op_index+INSN_NUM_MAX/2<<" to "<<insn_tmp_index<< " Connect Latency: 0" << "\n";)
				   }
				   else
				   { 
		            //1, create new adj (adj_index) for Op, connect Op to adj[0].
                    //adj[0].push_back(std::make_pair(adj_index, 0)); //adj_index
				     //2, connect adj_index to insn_tmp_index, 
				     //adj[adj_index].push_back(std::make_pair(insn_tmp_index, 0));
				     //adj_index++;
					 
					 //clean implementation. Directly connect to 0 if input is from other BB or parameter.
					 adj[0].push_back(std::make_pair(insn_tmp_index, 0));
                     __DEBUG__(errs()<<"begin: 0"<<" to "<<insn_tmp_index<< " parallel Latency: 0" << "\n";)
				   }
			   }
			   else 
			   {   
					 //clean implementation. Directly connect to 0 if input is from other BB or parameter.
					 adj[0].push_back(std::make_pair(insn_tmp_index, 0));
					 __DEBUG__(errs()<<"begin: 0"<<" to "<<insn_tmp_index<< "Not insn paralle Latency: 0" << "\n";)
			   }
			       
			}
	    }
		
		
		void compute_critical_path (Instruction *inst, unsigned latency)
		{
		   unsigned insn_tmp_index = 0;	
          //add inst to value_index_in_adj first. It is a new instruction in BB. 
            value_index_in_adj[inst] = adj_index;	
			insn_tmp_index           = adj_index;
			
			//connect the latency edge of inst: adj_index+INSN_NUM_MAX/2. 
           adj[insn_tmp_index].push_back(std::make_pair(insn_tmp_index+INSN_NUM_MAX/2, latency)); //INT_ADD
			adj_index++;
            __DEBUG__(errs()<<insn_tmp_index<<" to "<<insn_tmp_index+INSN_NUM_MAX/2<< " Latency:"<< latency << "\n";)
			
           for (unsigned op = 0, E = inst->getNumOperands(); op != E; ++op) 
			{
              Value *Op = inst->getOperand(op); //add it to adj/value_index_in_adj  
			   
              if ( Instruction *insn_in_test = dyn_cast<Instruction>(Op) )
			   {
				   if ( (insn_in_test->getParent()) == (inst->getParent()) ) //oprand and inst in same bb.
				   { //find the insn_in_test's index in value_index_in_adj, then add the dependence....
					 std::map<Instruction *,unsigned>::iterator it;
					 if (it == value_index_in_adj.end())
                       errs()<<"Try to find the instruction in this block, but not found:Add. \n" << "\n";	
                    unsigned Op_index = value_index_in_adj[insn_in_test];
					 
					 //connect the real dependcy between Op and inst......................................
				     adj[Op_index+INSN_NUM_MAX/2].push_back(std::make_pair(insn_tmp_index, 0));
                     __DEBUG__(errs()<<Op_index+INSN_NUM_MAX/2<<" to "<<insn_tmp_index<< " Connect Latency: 0" << "\n";)

				   }
				   else
				   { 
		            //1, create new adj (adj_index) for Op, connect Op to adj[0].
                    //adj[0].push_back(std::make_pair(adj_index, 0)); //adj_index
				     //2, connect adj_index to insn_tmp_index, 
				     //adj[adj_index].push_back(std::make_pair(insn_tmp_index, 0));
				     //adj_index++;
					 
					 //clean implementation. Directly connect to 0 if input is from other BB or parameter.
					 adj[0].push_back(std::make_pair(insn_tmp_index, 0));
                     __DEBUG__(errs()<<"begin: 0"<<" to "<<insn_tmp_index<< " parallel Latency: 0" << "\n";)

				   }
			   }
			   else 
			   {   
					 //clean implementation. Directly connect to 0 if input is from other BB or parameter.
					 adj[0].push_back(std::make_pair(insn_tmp_index, 0));
                     __DEBUG__(errs()<<"begin: 0"<<" to "<<insn_tmp_index<< "Not insn paralle Latency: 0" << "\n";)


			   }
			       
			}
	    }
		
		void update(Instruction *inst, float ul, bool bb_loop_coalesced)
		{
			switch(inst->getOpcode())
			{
				// Terminators
				case Instruction::Ret:	break;  //do nothing.
				case Instruction::Br:
				case Instruction::Switch:
				case Instruction::IndirectBr:
				    //errs()<<"load easy for burst and simd: ";
					++statistics["branches"];
					break;
				case Instruction::Invoke:      errs()<<"WARNING: in Invoke. \n";	    break;
				case Instruction::Resume:      errs()<<"WARNING: in Resume. \n";	    break;
				case Instruction::Unreachable: errs()<<"WARNING: in Unreachable. \n";	break;

				// Standard binary operators
				case Instruction::Add:
				case Instruction::Sub:
                    compute_critical_path (inst, INT_ADD); //update adj, value_index_in_adj, adj_index
					++statistics["iops"];
					break;
				case Instruction::FAdd:
				case Instruction::FSub:
                    compute_critical_path (inst, FP_ADD); //update adj, value_index_in_adj, adj_index				
					++statistics["flops"];
					break;
				case Instruction::Mul:
                    compute_critical_path (inst, INT_MULT);	//update adj, value_index_in_adj, adj_index				
					++statistics["iops"];
					break;
				case Instruction::FMul:
                    compute_critical_path (inst, FP_MULT);	//update adj, value_index_in_adj, adj_index				
					++statistics["flops"];
					break;
				case Instruction::UDiv:
				case Instruction::SDiv:
				case Instruction::URem:
				case Instruction::SRem:				
                    compute_critical_path (inst, INT_DIV);	//update adj, value_index_in_adj, adj_index				
					++statistics["iops"];
					break;
				case Instruction::FDiv:
				case Instruction::FRem:
                    compute_critical_path (inst, FP_DIV);	//update adj, value_index_in_adj, adj_index				
					++statistics["flops"];
					break;

				// Logical operators
				case Instruction::Shl:
				case Instruction::LShr:
				case Instruction::AShr:
				case Instruction::And:
				case Instruction::Or:
				case Instruction::Xor:
                    compute_critical_path (inst, INT_ADD);	//update adj, value_index_in_adj, adj_index						
					++statistics["iops"];	break;

				// Memory instructions
				case Instruction::Alloca:
				{
				   /////////////////////////////////////////////////////////////
                   value_index_in_adj[inst] = adj_index;	
			       //connect the latency edge of inst: adj_index+INSN_NUM_MAX/2. 
                   adj[adj_index].push_back(std::make_pair(adj_index+INSN_NUM_MAX/2, ALLOCA_NODE)); 
				   adj[0].push_back(std::make_pair(adj_index, 0));
                   adj_index++;
				   
				   // errs()<<"In Alloca, it is not normal. \n";
					statistics["allocas"]++;
					AllocaInst * i=cast<AllocaInst>(inst);
					statistics["alloca bytes"] += insn_bytes(i->getType());
					break;
				}
                //mem_byte_sum_tmp  = 0.0;
				//mem_burst_sum_tmp = 0.0;
				//mem_insn_sum_tmp  = 0.0;
				case Instruction::Load: //f, bb_loop_coalesced
				{   
				   compute_critical_path (inst, LOCAL_LOAD);	//update adj, value_index_in_adj, adj_index	
				   
					Value* value= inst->getOperand(0);
					if (ls_insn_is_local(inst) == true)// local load if (true)//
					{
						//belong to the critical path computation...
						//compute_critical_path (inst, LOCAL_LOAD);	//update adj, value_index_in_adj, adj_index		
					}
					else
					{
				      unsigned load_bytes        = insn_bytes(value->getType());
   				      float mem_insn_tmp         = 1.0;
					  float mem_byte_tmp         = (float)load_bytes;
					  float mem_burst_tmp        = 1.0;

					  unsigned load_is_coalesced = coalescled_with_thread(inst); //LOAD_OR_STORE_IS_COALESCLED
					  
                      statistics["load_store"]++;
					  statistics["load_store_bytes"]+= load_bytes;					  
					  
					  //UL and SIMD do not apply to the load/store insn at the same time...
					  
					  //LOOP UNROLLING: bb_loop_coalesced, bb_loop_coscelsced_index (phi instrrution for testing ls insn).
					  if ( (bb_loop_coalesced == true) && (test_insn_benefit_from_ul(inst, bb_loop_coscelsced_index) == true) ) //
					  {
                          mem_insn_tmp     = ceil( ((float)load_bytes * ul)/ Mem_trans_width);
						  mem_byte_tmp     = (float)load_bytes * ul;
					  }
					  else // it is not coalesced....
					  {
                          mem_insn_tmp     = ul;
						  mem_byte_tmp     = (float)load_bytes * ul;
					  }						  
					  //errs()<<"load easy for burst and simd: "<<load_is_coalesced<<"\n";
					  
					  //BURST + SIMD: coalescled_with_thread... SIMD
					  if (load_is_coalesced == LOAD_OR_STORE_IS_COALESCLED)
					  {
                         mem_insn_tmp      *= ceil( ((float)load_bytes * SIMD)/ Mem_trans_width);
						 mem_byte_tmp      *= SIMD;	//always *SIMD
						 mem_burst_tmp      = floor( Mem_trans_width/((float)load_bytes * SIMD));
					  }
					  else
					  {
                         mem_insn_tmp      *= SIMD;
						 mem_byte_tmp      *= SIMD;	//always *SIMD
						 mem_burst_tmp      = 1.0;						 
					  }

                         mem_insn_sum_tmp  += mem_insn_tmp/mem_burst_tmp;//mem_insn_sum_tmp  += mem_insn_tmp;						  
                         mem_byte_sum_tmp  += mem_byte_tmp;
                         mem_burst_sum_tmp += mem_burst_tmp;//mem_burst_sum_tmp += mem_burst_tmp;					  
					  
					}
					//int addrspace_llvm;
					//LoadInst *load_inst = dyn_cast<LoadInst>(inst);
					//errs()<<load_inst->getPointerAddressSpace();
					//errs()<<"Load:"<<coalescled_with_thread(inst)<<"\n";

					break;
				}

				case Instruction::Store:
				{
					compute_critical_path (inst, LOCAL_STORE);
					
				    Value* value = inst->getOperand(0);
					
					if (ls_insn_is_local(inst) == true)// local store
					{
						 //compute_critical_path (inst, LOCAL_STORE);	//update adj, value_index_in_adj, adj_index		
						//belong to the critical path computation...
					}
					else
					{
                      unsigned load_bytes        = insn_bytes(value->getType());
					  unsigned load_is_coalesced = coalescled_with_thread(inst); //LOAD_OR_STORE_IS_COALESCLED
					  
                      statistics["load_store"]++;
					  statistics["load_store_bytes"]  += load_bytes;
					  
					  float mem_insn_tmp         = 1.0;
					  float mem_byte_tmp         = (float)load_bytes;
					  float mem_burst_tmp        = 1.0;
					  
					  //UL and SIMD do not apply to the load/store insn at the same time...
					  
					  //LOOP UNROLLING: bb_loop_coalesced, bb_loop_coscelsced_index (phi instrrution for testing ls insn).
					  if ( (bb_loop_coalesced == true) && (test_insn_benefit_from_ul(inst, bb_loop_coscelsced_index) == true) ) //
					  {
                          mem_insn_tmp     = ceil( ((float)load_bytes * ul)/ Mem_trans_width);
						  mem_byte_tmp     = (float)load_bytes * ul;
					  }
					  else // it is not coalesced....
					  {
                          mem_insn_tmp     = ul;
						  mem_byte_tmp     = (float)load_bytes * ul;
					  }						  
					  
					  //BURST + SIMD: coalescled_with_thread... SIMD
					  if (load_is_coalesced == LOAD_OR_STORE_IS_COALESCLED)
					  {
                         mem_insn_tmp      *= ceil( ((float)load_bytes * SIMD)/ Mem_trans_width);
						 mem_byte_tmp      *= SIMD;	//always *SIMD
						 
						 mem_burst_tmp      = floor( Mem_trans_width/((float)load_bytes * SIMD));
					  }
					  else
					  {
                         mem_insn_tmp      *= SIMD;
						 mem_byte_tmp      *= SIMD;	//always *SIMD
						 mem_burst_tmp      = 1.0;						 
						  
					  }
                         mem_insn_sum_tmp  += mem_insn_tmp/mem_burst_tmp;//mem_insn_sum_tmp  += mem_insn_tmp;						  
                         mem_byte_sum_tmp  += mem_byte_tmp;
                         mem_burst_sum_tmp += mem_burst_tmp;//mem_burst_sum_tmp += mem_burst_tmp;						  
					}
					break;
				}
				
				case Instruction::GetElementPtr:
				   /////////////////////////////////////////////////////////////
				   /////////////////////////////////////////////////////////////
				   compute_critical_path_getelementptr(inst, GET_ELE_PTR);
				   /////////////////////////////////////////////////////////////
				   /////////////////////////////////////////////////////////////				
					break;
				case Instruction::Fence:
					break;
				case Instruction::AtomicCmpXchg:
					break;
				case Instruction::AtomicRMW:
					break;

				// Convert instructions
				case Instruction::Trunc:	errs()<<"In Select, it is not normal. \n";  break;
				case Instruction::ZExt:	    errs()<<"In Select, it is not normal. \n";  break;
				case Instruction::SExt:	    errs()<<"In Select, it is not normal. \n";  break;
				case Instruction::FPToUI:	errs()<<"In FPToUI, it is not normal. \n";  break;
				case Instruction::FPToSI:	errs()<<"In FPToSI, it is not normal. \n";  break;
				case Instruction::UIToFP:	errs()<<"In UIToFP, it is not normal. \n";  break;
				case Instruction::SIToFP:	errs()<<"In SIToFP, it is not normal. \n";  break;
				case Instruction::FPTrunc:	errs()<<"In FPTrunc, it is not normal. \n";  break;
				case Instruction::FPExt:	errs()<<"In FPExt, it is not normal. \n";  break;
				case Instruction::PtrToInt:	errs()<<"In PtrToInt, it is not normal. \n";  break;
				case Instruction::IntToPtr:	errs()<<"In IntToPtr, it is not normal. \n";  break;
				case Instruction::BitCast:	
				            compute_critical_path (inst, SEL_NODE);  //update adj, value_index_in_adj, adj_index	
							//errs()<<"In BitCast, it is not normal. \n";  
							break;
				
				
				case Instruction::AddrSpaceCast: errs()<<"In AddrSpaceCast, it is not normal. \n";  break;

				// Other Instructions
				case Instruction::ICmp:
				    compute_critical_path (inst, INT_ADD);	//update adj, value_index_in_adj, adj_index	
					statistics["iops"]++;
					break;
				case Instruction::FCmp:
				    compute_critical_path (inst, INT_ADD);	//update adj, value_index_in_adj, adj_index					
					statistics["flops"]++;
					break;
				case Instruction::PHI:
				   /////////////////////////////////////////////////////////////
				   /////////////////////////////////////////////////////////////
                  // unsigned insn_tmp_index = 0;	 
                   //add inst to value_index_in_adj first. It is a new instruction in BB. 
                   value_index_in_adj[inst] = adj_index;	
			       //insn_tmp_index           = adj_index;
			
			       //connect the latency edge of inst: adj_index+INSN_NUM_MAX/2. 
                   adj[adj_index].push_back(std::make_pair(adj_index+INSN_NUM_MAX/2, PHI_NODE)); 
                   					__DEBUG__( errs()<<adj_index<<" to "<<adj_index+INSN_NUM_MAX/2<< " PHI Latency: 1" << "\n";)
									 
				   adj[0].push_back(std::make_pair(adj_index, 0));
				                        __DEBUG__(errs()<<"begin: 0"<<" to "<<adj_index<< " pHI Latency: 0" << "\n";)
                   adj_index++;
				  /* if (PHINode *PN = dyn_cast<PHINode>(inst)) 
				   {
                     for (unsigned i = 0, e = PN->getNumIncomingValues(); i != e; ++i) 
					 {
                       Value *IncValue = PN->getIncomingValue(i);
                       // Allow self-referencing phi-nodes.
                       if (Instruction *insn_for_phi = cast<Instruction>(IncValue))
					   { 
				          if (insn_for_phi->getParent() != inst->getParent()) 
						  {
							  
						  }  
					   }
					 }	   
				   } */
				   /////////////////////////////////////////////////////////////
				   /////////////////////////////////////////////////////////////
					break;
				case Instruction::Call:
				{ //call insn always has only one cycle latency here. Only analyze the case with one function. 
				  adj[0].push_back(std::make_pair(adj_index, 0));	
                  value_index_in_adj[inst] = adj_index;		
				  
                  adj[adj_index].push_back(std::make_pair(adj_index+INSN_NUM_MAX/2, CALL_LAT)); //INT_ADD
				       __DEBUG__(errs()<<adj_index<<" to "<<adj_index+INSN_NUM_MAX/2<< " Call Latency: 1" << "\n";)
				     __DEBUG__( errs()<<"begin: 0"<<" to "<<adj_index<< " Call Latency: 0" << "\n";)
			      adj_index++;				
				  /*
				   if ( CallInst *call_inst = dyn_cast<CallInst>(inst) ) //always true since it is call function..
				    { //call_inst
					  Function *Callee = call_inst->getCalledFunction();
                      StringRef FnName = Callee->getName();
                      Value *parameter_0;
					  parameter_0 = call_inst->getArgOperand(0);
                      if (FnName == "get_local_id")
                      {
                         //ConstantInt *Size = dyn_cast<ConstantInt>(parameter_0);
                        //const uint64_t Imm = Size->getValue().getLimitedValue();
					    unsigned Imm = (dyn_cast<ConstantInt>(parameter_0))->getZExtValue(); //0; //	
					    if (Imm == 0)//std::map<std::string, CallInst *> opencl_functions; 	
					    {
					      opencl_functions["get_local_id"] = call_inst;	
						  errs()<<"get_local_id"<<"\n";
					    }
					  }						
                      else if (FnName == "get_global_id")
                      {
					    unsigned Imm = (dyn_cast<ConstantInt>(parameter_0))->getZExtValue();	//0; //
					    if (Imm == 0)//std::map<std::string, CallInst *> opencl_functions; 	
					    {
                          opencl_functions["get_global_id"] = call_inst;	
                          errs()<<"get_global_id"<<"\n";
					    }
					  }		
                    }					  
				  */	
					break;
				}	
				case Instruction::Select: //errs()<<"In Select, it is not normal. \n";
                    compute_critical_path (inst, SEL_NODE);  //update adj, value_index_in_adj, adj_index	
					statistics["iops"]++;
					break;
				case Instruction::UserOp1: errs()<<"In UserOp1, it is not normal. \n";
					break;
				case Instruction::UserOp2: errs()<<"In UserOp2, it is not normal. \n";
					break;
				case Instruction::VAArg: errs()<<"In VAArg, it is not normal. \n";
					break;
				case Instruction::ExtractElement: errs()<<"In ExtractElement, it is not normal. \n";
					break;
				case Instruction::InsertElement: errs()<<"In InsertElement, it is not normal. \n";
					break;
				case Instruction::ShuffleVector: errs()<<"In ShuffleVector, it is not normal. \n";
					break;
				case Instruction::ExtractValue: errs()<<"In ExtractValue, it is not normal. \n";
					break;
				case Instruction::InsertValue: errs()<<"In InsertValue, it is not normal. \n";
					break;
				case Instruction::LandingPad: errs()<<"In LandingPad, it is not normal. \n";
					break;
				default:
					puts("Unhandled Instruction");
					exit(0);
			}
		}

		
       virtual void getAnalysisUsage(AnalysisUsage &AU) const {
          AU.setPreservesCFG();
          AU.addRequired<LoopInfo>();
          //   AU.addRequired<BasicBlock>();	
          AU.addPreserved<LoopInfo>();
       }

  int solveCP(int N,std::vector<std::pair<int,int> > *adj)
  {
	int *F=new int[N<<1];
	int *deg=new int[N<<1];
	
	for (int i=0;i<(N<<1);++i)
		F[i]=deg[i]=0;
	
	std::stack<int> stack;
	stack.push(0);
	
	for (int i=0;i<(N<<1);++i)
	for (std::vector<std::pair<int,int> >::iterator it=adj[i].begin();it!=adj[i].end();++it)
		++deg[it->first];
	
	while (!stack.empty())
	{
		int u=stack.top();
		stack.pop();
		for (std::vector<std::pair<int,int> >::iterator it=adj[u].begin();it!=adj[u].end();++it)
		{
			int v=it->first,w=it->second;
			F[v]=std::max(F[v],F[u]+w);
			if (!(--deg[v]))	stack.push(v);
		}
	}
	int ret=0;
	for (int i=0;i<(N<<1);++i)
	if (ret<F[i])	ret=F[i];
	return ret;
}

/*
		float SIMD  = 1.0;
		float CU    = 1.0;
		float banks = 2.0;
		float Mem_trans_width = 64; //64 types.
		//input loop counter from GPU profiler, loop_unroll from input...
		int Loops_counter_input[2] = {32, 1};
		int Loops_unroll_input[2]  = {1, 1};
		float WI                   = 2048.0*2048.0;
		
		bb_critical_path
		Loops_counter, Loops_unroll
*/		
        float comput_cycles_in_loop(Loop* L)
        {   
          //push the child loop to the loop_queue.
          std::vector<Loop*> subLoops = L->getSubLoops();
		  int subLoop_num             = subLoops.size();
		  float tmp_sum               = 0;
		  float tmp_max_cycle         = 0.0;
		  //handle the case without loop....
		  if ( subLoops.empty() )
		  { 
            //the majority part of computation cycles comes from loop part...	  
			tmp_sum += (WI/CU)*((float)Loops_counter[L]/(float)Loops_unroll[L]);
			
            for (Loop::block_iterator BI = L->block_begin(), BE = L->block_end(); BI != BE; ++BI) 
            {
              BasicBlock *BB = *BI;
			  tmp_sum       += bb_critical_path[BB];
			}
			return tmp_sum;
		   }

		  //1: handle the case with BB which is not belonging to child loops....
          for (Loop::block_iterator BI = L->block_begin(), BE = L->block_end(); BI != BE; ++BI) 
          {
			bool bb_in_loop_flag = false;  
            BasicBlock *BB       = *BI;
			for (int j = 0; j < subLoop_num; j++)
			{
				Loop* sub_loop = subLoops.at(j); 
				if (sub_loop->contains(BB))
				{
					bb_in_loop_flag = true;
					break;
				}
			}
		    
			//BB is not belonging to inner loop in "L"
			if(bb_in_loop_flag == false) 
			{  
		        float bb_cycles = (WI/CU) + bb_critical_path[BB]-1.0;
				tmp_sum        += bb_cycles;
				if (bb_cycles > tmp_max_cycle )
				  tmp_max_cycle = bb_cycles;
			}
		    //BB is belonging to inner loop in "L"
          }	      
		  
			//2, handling the child loops into the total computation cycles of L.
          for (int j = 0; j < subLoop_num; j++)
          {
            Loop* sub_loop                = subLoops.at(j); 
            float comp_cycles_in_sub_loop = comput_cycles_in_loop(sub_loop);
			
                tmp_sum                  += comp_cycles_in_sub_loop;
			
            if (comp_cycles_in_sub_loop > tmp_max_cycle)
			{
				tmp_max_cycle             = comp_cycles_in_sub_loop;
			}
          }
          
		  //the majority part of computation cycles comes from loop part...	
          tmp_sum  += tmp_max_cycle*Loops_counter[L]/Loops_unroll[L]; 
		  
          return tmp_sum;
		}
				
        float memory_cycles(LoopInfo* LI, BasicBlock *itb)
        {
          float inst_num_tmp;
		  
		  if (mem_insts[itb] != 0)
		  {			
            float trip_counter_for_bb = 1.0; 
			Loop *loop_parent     = LI->getLoopFor(itb);
			while (loop_parent != NULL) //if itb is not belonging to any loop, then itb is NULL
			{
				//trip counter for the loop.
                trip_counter_for_bb *= (Loops_counter[loop_parent]/Loops_unroll[loop_parent]);
                loop_parent = loop_parent->getParentLoop(); 	
            //    errs()<<"trip_counter_for_bb"<< trip_counter_for_bb <<"\n"; 				
			}

			//Eq.14 in the paper....	
             inst_num_tmp = (mem_insts[itb])*                          ///mem_burst[itb] avery mem insts for each work item
			                 WI *                                      // number of work items.
						     trip_counter_for_bb;		              //trip counter
		  }
          else
           	 inst_num_tmp = 0.0;
		 
		    function_mem_insts += inst_num_tmp;
			
			return inst_num_tmp;
			
		}

        float compute_loop_trip_counter(LoopInfo* LI, BasicBlock *itb)
        {
          //float inst_num_tmp;
		  
		
            float trip_counter_for_bb = 1.0; 
			Loop *loop_parent     = LI->getLoopFor(itb);
			while (loop_parent != NULL) //if itb is not belonging to any loop, then itb is NULL
			{
				//trip counter for the loop.
                trip_counter_for_bb *= (Loops_counter[loop_parent]/Loops_unroll[loop_parent]);
                loop_parent = loop_parent->getParentLoop(); 	
                //errs()<<"trip_counter_for_bb"<< trip_counter_for_bb <<"\n"; 				
			}

		
			return trip_counter_for_bb;
			
		}

		
		//determine the loop_counter and loop_ul for each loop of the OpenCl program.
	bool set_loop_counter_ul(LoopInfo* LI) //using queue to implement BFS. 
		{
		  std::queue<Loop *> loop_queue;
		  int global_loop_index = 0;
		  
	// 0: search the outermost level loop for the using the way BFS. 
	// Enqueue their child loop into loop_queue.
          for (LoopInfo::iterator i = LI->begin(), e = LI->end(); i != e; ++i) 
		  {
            Loop *L = *i;
			//log the counter and UL for each loop....
			Loops_counter[L]  = Loops_counter_input[global_loop_index ];
			Loops_unroll[L]   = Loops_unroll_input[global_loop_index++];
			
			//push the child loop to the loop_queue.
			std::vector<Loop*> subLoops = L->getSubLoops();
            for (unsigned ii=0; ii<subLoops.size(); ii++)
			{   
		        Loop* sub_loop = subLoops.at(ii); 
				loop_queue.push(sub_loop);
			}
		  }		
		  
	//  work on the queue loop_queue until it is empty...
          while (!loop_queue.empty())
			{ 
		      // pop the front loop in the loop_queue...
			  Loop* loop_test = loop_queue.front();
			  loop_queue.pop();
			  
			  //log the counter and UL for each loop....
			  Loops_counter[loop_test]    = Loops_counter_input[global_loop_index ];
			  Loops_unroll[loop_test]     = Loops_unroll_input[global_loop_index++];
			  
			  //push the child loop to the loop_queue.
			  std::vector<Loop*> subLoops = loop_test->getSubLoops();
              for (unsigned ii=0; ii<subLoops.size(); ii++)
			  {   
		         Loop* sub_loop = subLoops.at(ii); 
				 loop_queue.push(sub_loop);
			  }
			}

		  
		  return true;
		}
		
		
		virtual bool runOnFunction(Function &F)
		{
          errs()<<"#######################\n";
          errs()<<"Function: "<<F.getName()<<"\n";
          //ViewGraph<Function>(F, "cfg" + F.getName());
          F.viewCFG();
		  
          LoopInfo &LI = getAnalysis<LoopInfo>();		  
          LoopInfo* LI_pointer;
		  LI_pointer = &LI;
          //int loopCounter = 0;

		  //take the consideration of SIMD.......
		  WI    =  WI/SIMD;
		  
		  //set the trip counter and UL factor for each loop.....
		  bool set_flag = set_loop_counter_ul(LI_pointer);
          if (set_flag == false)
		  {
			 errs()<<"expected (input) and measured number of loop is different "<<"\n"; 
		  }
		  
/*        
          for (LoopInfo::iterator i = LI.begin(), e = LI.end(); i != e; ++i) 
		  {
            Loop *L = *i;
            int bbCounter = 0;  int instCounter = 0;
            loopCounter++;

			  //bbCounter+=1; //BasicBlock::iterator
			  //for ( auto ii = bb->begin(); ii != bb->end(); ++ii)
			    //instCounter++;

			std::vector<Loop*> subLoops = L->getSubLoops();
			
			//BasicBlock *test_bb = subLoops[0]->block_begin();
			//if (test_bb->getParent() == subLoops[0])
            //   errs() << "one slot of Loop info for ";				
			
            errs() << "Loop:";
            errs() << loopCounter;
            errs() << ": inner loop number = ";
            errs() << subLoops.size();
            errs() << "\n";
          }			
*/		  
			//opencl_functions
/*			
		  unsigned ul_factor[8];
          ul_factor[0] = 1;
          ul_factor[1] = 1;
          ul_factor[2] = 1;
          ul_factor[3] = 1;
          ul_factor[4] = 1; //loop exists.
          ul_factor[5] = 1;
          ul_factor[6] = 1;
          ul_factor[7] = 1;
*/		  
 		  int bb_inc = 0;
		  float total_mem_unit_num = 0.0;
		  
          for (auto itb=F.begin();itb!=F.end();++itb) //loop over each basicblock...
          { 
				statistics.clear();
				errs()<<"-----------------------\n";
				errs()<<"Basic Block: "<<itb->getName()<<" has "<<itb->size()<<" instructions\n";
				
				unsigned UL   = 1;
				//for computing critical path latency. 
	            adj_index = 1;
				for (int i=0;i<INSN_NUM_MAX;++i)
		         adj[i].clear();

				//test whether itb is a loop...
				bool bb_is_loop         = test_bb_is_loop(itb); 
				
				bool bb_loop_coalesced  = false;
				if (bb_is_loop == true)
				{
                  //always get the Loop since iti is a loop
                  Loop *bb_parent     = LI.getLoopFor(itb); //Loop* bb_parent     = itb->getParent();
                  UL                  = Loops_unroll[bb_parent];
				  
				  //it is for unroll.... 
				   bb_loop_coalesced  = test_bb_is_loop_coalesced(itb);
				}
			   
				//if (bb_loop_coalesced == true)
				//	errs()<<"The basic block can benefit from unrolling....^_^ \n";
			
			    mem_byte_sum_tmp  = 0.0;
				mem_burst_sum_tmp = 0.0;
				mem_insn_sum_tmp  = 0.0;

				
				//errs()<<"before update every instruction \n";
				//updating the instructions in each basic block.....
				for (auto iti=itb->begin();iti!=itb->end();++iti)
				{	
					//update(iti, ul_factor[bb_inc], bb_loop_coalesced);
					update(iti, UL, bb_loop_coalesced);
				}	
				//errs()<<"after update every instruction \n";
/*				 
				if (mem_insn_sum_tmp == 0.0)
				{
			      mem_byte_sum_tmp  = 0.0;
				  mem_burst_sum_tmp = 0.0;
				  mem_insn_sum_tmp  = 0.0;
				}
				else
                {
			      mem_byte_sum_tmp  = mem_byte_sum_tmp/mem_insn_sum_tmp;
				  mem_burst_sum_tmp = mem_burst_sum_tmp/((float)statistics["load_store"]);  //
				}
*/				 
				unsigned critical_path_len = solveCP(INSN_NUM_MAX/2,adj); 

				
				float loop_trip_counter = compute_loop_trip_counter( LI_pointer, itb);
				bb_accumulate_trip_counter[itb]   = loop_trip_counter;
                
				mem_insts[itb]        = mem_insn_sum_tmp;
		        mem_bytes[itb]        = mem_byte_sum_tmp;
		        mem_burst[itb]        = mem_burst_sum_tmp;
				bb_critical_path[itb] = (float)critical_path_len;
				//add the memory instructions of this basic block to the total counter (function_mem_insts)....
				float bb_mem_insts      = memory_cycles( LI_pointer, itb);//after updating mem_insts...
				
				total_mem_unit_num  += (float)statistics["load_store"];
				
				errs()<<"critical path= "<<critical_path_len<<" cycles.\n";
				errs()<<"load_store:"<< statistics["load_store"] <<"  ";
				errs()<<"insns:"<< mem_insn_sum_tmp<<" bytes:" << mem_byte_sum_tmp<<" burst:" << mem_burst_sum_tmp<<"\n";
				errs()<<"Mem insns of this basic block:" << bb_mem_insts << "\n"<<"\n";
				
				 bb_inc++;				
				//show the statistics result...
				//for (std::map<std::string,unsigned>::iterator it=statistics.begin();it!=statistics.end();++it)
				//	errs()<<"    "<<it->first.c_str()<<": "<<it->second<<"\n";
           }
		   
		   //errs()<<"Total Mem insns:" << function_mem_insts << "\n";
		   errs()<<"Total Mem cycles:" << function_mem_insts/MTP << "\n";
		   
		   
		  float function_computation_cycles = 0.0; 
		  //compute the computation cycles for the input kernel....
		  //if the input OpenCL kernel does not have the loop, then all execute in parallel.
		  // it rarely happens.
	    if (LI.empty())
	    {   
	           float critical_path_max = 0;
	   	  for (auto itb=F.begin();itb!=F.end();++itb) //loop over each basicblock...
               { 
	   	    if (bb_critical_path[itb] > critical_path_max)
	             critical_path_max = bb_critical_path[itb];
	   	  }
	   	  
                function_computation_cycles = (WI/CU) + critical_path_max -1.0;			 
	    }
	    else//if there is loop in the 
	    {
	      float loop_cycles = 0.0;  
          for (LoopInfo::iterator i = LI.begin(), e = LI.end(); i != e; ++i) 
	      {
               Loop *L = *i;	
               float comp_tmp = comput_cycles_in_loop(L);
               if (comp_tmp > loop_cycles)
                 loop_cycles = comp_tmp;				  
	      }
		          function_computation_cycles = loop_cycles;	
	    } 
		
         errs()<<"Total computation cycles:" << function_computation_cycles << "\n";

/////////////////////////B_mem///////////////////////////////////////////////////////////////	
//bb_accumulate_trip_counter mem_insts mem_bytes
        float total_mem_bytes = 0.0;
		float total_mem_insts = 0.0;
		for (auto itb=F.begin();itb!=F.end();++itb) //loop over each basicblock...
        {
          total_mem_insts += bb_accumulate_trip_counter[itb] * mem_insts[itb];
		  total_mem_bytes += bb_accumulate_trip_counter[itb] * mem_bytes[itb];
          // errs()<<"CMP:" << total_mem_insts*Mem_trans_width << "  " << total_mem_bytes << "\n";
        }		
		float b_mem =  1.0 - (total_mem_bytes/(total_mem_insts*Mem_trans_width));
         errs()<<"Metric B_mem:" << b_mem << "\n";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		  

		 
/////////////////////////B_balance///////////////////////////////////////////////////////////////		 
	     //computing the loop counter for each loop....
        float max_loop_counter,  second_max_loop_counter;
		  
        auto bb_index = F.begin();
		
		 max_loop_counter = bb_accumulate_trip_counter[bb_index];
		 bb_index++;
		 if (bb_accumulate_trip_counter[bb_index] > max_loop_counter)
		 {
			 second_max_loop_counter = max_loop_counter;
			 max_loop_counter        = bb_accumulate_trip_counter[bb_index];
		 }
		 else
		 {
			 second_max_loop_counter = bb_accumulate_trip_counter[bb_index];
			// max_loop_counter        = max_loop_counter;			 
		 }
		  
		  bb_index++; //now bb_index is the third basic block....
		 //check for the maxi 
         for (; bb_index!=F.end(); ++bb_index) //loop over each basicblock...
          {
			  if (bb_accumulate_trip_counter[bb_index] > max_loop_counter)
			  {
			      second_max_loop_counter = max_loop_counter;
			      max_loop_counter        = bb_accumulate_trip_counter[bb_index];
			  }
			  else if (bb_accumulate_trip_counter[bb_index] > second_max_loop_counter)
			  {
			    second_max_loop_counter   = bb_accumulate_trip_counter[bb_index];
			    // max_loop_counter       = max_loop_counter;			 
			  }
		  }
 		  float b_balance = (max_loop_counter - second_max_loop_counter)/max_loop_counter;
         errs()<<"Metric B_balance:" << b_balance << "\n";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		  
		  

/////////////////////////B_itpp///////////////////////////////////////////////////////////////
         //bb_critical_path   total_mem_unit_num
		 float B_itpp = 0.0;
		 float accommodation_thread_num = 0.0;
		for (auto itb=F.begin();itb!=F.end();++itb) //loop over each basicblock...
        {
          accommodation_thread_num += bb_critical_path[itb];
        }		
		accommodation_thread_num += total_mem_unit_num * (float)LOCAL_LOAD; 
        
		if (accommodation_thread_num > WI)
		  B_itpp = (accommodation_thread_num-WI)/accommodation_thread_num;
	    else
		  B_itpp = 0.0;	
        errs()<<"Metric B_itpp:" << B_itpp << "\n";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////			  
	   	return false;
		}
	};
}

char FPGA_Model::ID = 0;
static RegisterPass<FPGA_Model> X("cfg_4", "CFG Pass");
		  
/*
          LoopInfo &LI = getAnalysis<LoopInfo>();
          int loopCounter = 0;
          errs() << F.getName() + "\n";
          for (LoopInfo::iterator i = LI.begin(), e = LI.end(); i != e; ++i) 
		  {
            Loop *L = *i;
            int bbCounter = 0;  int instCounter = 0;
            loopCounter++;
            for(Loop::block_iterator bb = L->block_begin(); bb != L->block_end(); ++bb)
			{ 
			  BasicBlock *C = *bb;
			  bbCounter+=1;
			  
			  //errs()<<C->getName();
			  
			  for(auto ii = C->begin(); ii!=C->end(); ++ii){
			 	instCounter++;
			 }
			  //bbCounter+=1; //BasicBlock::iterator
			  //for ( auto ii = bb->begin(); ii != bb->end(); ++ii)
			    //instCounter++;
            }
            errs() << "Loop ";
            errs() << loopCounter;
            errs() << ": #BBs = ";
            errs() << bbCounter;
            errs() << ": #Insts = ";
            errs() << instCounter;
            errs() << "\n";
          }
*/

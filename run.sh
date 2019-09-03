#!/bin/bash

ls apps/ && read -p "Please choose an application: " app
[ "$app" == "RSCD" ] && name=baseline_2 || name=baseline

# rebuild for the specific application
echo -e "\n--------Rebuilding--------"
clang -Dcl_clang_storage_class_specifiers -isystem llvm-project/libclc/generic/include -include clc/clc.h -x cl -emit-llvm -S apps/$app/$name.cl -o apps/$app/$name.ll || exit	# compile OpenCL kernel (.cl)
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/IsSameBuff/IsSameBuff.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/IsRdWr/IsRdWr.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/IsSameMAP/IsSameMAP.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/IsSequential/IsSequential.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/VarBuffInHost/VarBuffInHost.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/VarBuffInKernel/VarBuffInKernel.cpp	
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/ExecModel/ExecModel.cpp	
cd /root/Work/llvm/llvm-project/build
make > /dev/null && echo -e "Succeed." || exit

echo -e "\n--------Analysing--------\n"
cd /root/Work/llvm/apps/$app
# test for pattern AO
echo "Pattern AO:"
opt -load /root/Work/llvm/llvm-project/build/lib/LLVMHasAO.so -hasao $name.ll 1>/dev/null 2>HasAO.out || exit
sed -n 1p HasAO.out			# get the first line: output
ao=$(sed -n 2p HasAO.out)	# get the second line: $ao

# test for pattern KKC
# R1. numofkernels: get the number of kernels and args
opt -load /root/Work/llvm/llvm-project/build/lib/LLVMNumOfKernels.so -numofkernels $name.ll 1>/dev/null 2>NumOfKernels.out || exit
_kernel=$(head -1 NumOfKernels.out)	# get the first line

if [ $_kernel -eq 1 ]; then	# only one kernel -> no MPS or KKC
	echo -e "Pattern KKC:\n\t\tNo\nPattern MPS:\n\t\tNo"
	mps=0
	kkc=0
else						# more than two kernels	
	clang -w -emit-llvm -c main.cpp -o main.bc && llvm-dis main.bc || exit	# compile the host code (.cpp)
	echo -e "Pattern KKC:"

	# R2. issamebuff: find kernel pairs that access the same buffer object
	opt -load /root/Work/llvm/llvm-project/build/lib/LLVMIsSameBuff.so -issamebuff main.ll 1>/dev/null 2>IsSameBuff.out || exit

	# R2. isrdwr: find kernel pairs that satisfy "output->input"
	opt -load /root/Work/llvm/llvm-project/build/lib/LLVMIsRdWr.so -isrdwr $name.ll 1>/dev/null 2>IsRdWr.out || exit

	# R3. issamemap: find kernel pairs that access the buffer object following the same memory access pattern (MAP)
	opt -load /root/Work/llvm/llvm-project/build/lib/LLVMIsSameMAP.so -issamemap $name.ll 1>/dev/null 2>IsSameMAP.out || exit

	sed -n 1p IsSameMAP.out			# get the first line: output
	kkc=$(sed -n 2p IsSameMAP.out)	# get the second line: $kkc

	# test for pattern MPS
	echo -e "Pattern MPS:"
	# R4. issequential: find kernel pairs that execute sequentially
	opt -load /root/Work/llvm/llvm-project/build/lib/LLVMIsSequential.so -issequential $name.ll 1>/dev/null 2>IsSequential.out || exit

	_R4Triplets=$(head -1 IsSequential.out)	# get the first line

	if [ $_R4Triplets -eq 0 ]; then			# no sequential kernels -> no MPS
		echo -e "\t\tNo"
		mps=0
	else
		# R5. VarBuffInHost: get args related to n_work_groups and compute their current values with n_work_groups = 1 
		opt -load /root/Work/llvm/llvm-project/build/lib/LLVMVarBuffInHost.so -varbuffinhost main.ll 1>/dev/null 2>VarBuffInHost.out || exit
		# R5. VarBuffInKernel: find apps that exist pattern MPS
		opt -load /root/Work/llvm/llvm-project/build/lib/LLVMVarBuffInKernel.so -varbuffinkernel $name.ll 1>/dev/null 2>VarBuffInKernel.out || exit
		sed -n 1p VarBuffInKernel.out			# get the first line: output
		mps=$(sed -n 2p VarBuffInKernel.out)	# get the second line: $mps
	fi
fi

# determine the most suitable execution model
echo "Execution model:"
[ $ao -eq 0 -a $mps -eq 0 -a $kkc -eq 0 ] && echo "1" >ExecModel.in
[ $ao -eq 0 -a $mps -eq 0 -a $kkc -eq 1 ] && echo "3" >ExecModel.in
[ $ao -eq 0 -a $mps -eq 1 -a $kkc -eq 0 ] && echo "2" >ExecModel.in
[ $ao -eq 0 -a $mps -eq 1 -a $kkc -eq 1 ] && echo "4" >ExecModel.in
[ $ao -eq 1 -a $mps -eq 0 -a $kkc -eq 0 ] && echo "2" >ExecModel.in
[ $ao -eq 1 -a $mps -eq 0 -a $kkc -eq 1 ] && echo "4" >ExecModel.in
[ $ao -eq 1 -a $mps -eq 1 -a $kkc -eq 0 ] && echo "2" >ExecModel.in
[ $ao -eq 1 -a $mps -eq 1 -a $kkc -eq 1 ] && echo "4" >ExecModel.in
opt -load /root/Work/llvm/llvm-project/build/lib/LLVMExecModel.so -execmodel $name.ll 1>/dev/null || exit
echo -e "\n---------The End---------\n"

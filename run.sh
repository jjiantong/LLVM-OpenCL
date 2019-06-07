#!/bin/bash

ls apps/ && read -p "Please choose an application: " app
[ "$app" == "RSCD" ] && name=baseline_2 || name=baseline

# rebuild for the specific application
echo -e "\n--------Rebuilding--------"
clang -Dcl_clang_storage_class_specifiers -isystem llvm-project/libclc/generic/include -include clc/clc.h -x cl -emit-llvm -S apps/$app/$name.cl -o apps/$app/$name.ll || exit	# compile OpenCL kernel (.cl)
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/SameBuf/SameBuf.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/InOut/InOut.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/MemAcc/MemAcc.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/WGArgs/WGArgs.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/DelKernel/DelKernel.cpp	
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/ExecModel/ExecModel.cpp	
cd /root/Work/llvm/llvm-project/build
make > /dev/null && echo -e "Succeed." || exit

echo -e "\n--------Analysing--------\n"
cd /root/Work/llvm/apps/$app
# test for pattern AO
echo "Pattern AO:"
opt -load /root/Work/llvm/llvm-project/build/lib/LLVMFindAO.so -findao $name.ll 1>/dev/null 2>FindAO.out || exit
sed -n 1p FindAO.out		# get the first line: output
ao=$(sed -n 2p FindAO.out)	# get the second line: $ao

# test for pattern KKC
# 1. numkernel: get the number of kernels and args
opt -load /root/Work/llvm/llvm-project/build/lib/LLVMNumKernel.so -numkernel $name.ll 1>/dev/null 2>NumKernel.out || exit
kernel_num=$(head -1 NumKernel.out)	# get the first line

if [ $kernel_num -eq 1 ]; then		# only one kernel, then it has no KKC or MPS
	echo -e "Pattern KKC:\n\t\tNo\nPattern MPS:\n\t\tNo"
	mps=0
	kkc=0
else					# more than two kernels	
	clang -w -emit-llvm -c main.cpp -o main.bc && llvm-dis main.bc || exit	# compile the host code (.cpp)
	echo -e "Pattern KKC:"

	# 2. samebuf: find arg pairs that use the same buffer
	opt -load /root/Work/llvm/llvm-project/build/lib/LLVMSameBuf.so -samebuf main.ll 1>/dev/null 2>SameBuf.out || exit

	# 3. inout: find arg pairs that satisfy "output->input"
	opt -load /root/Work/llvm/llvm-project/build/lib/LLVMInOut.so -inout $name.ll 1>/dev/null 2>InOut.out || exit

	# 4. MemAcc: find kernel pairs that exist pattern KKC
	opt -load /root/Work/llvm/llvm-project/build/lib/LLVMMemAcc.so -memacc $name.ll 1>/dev/null 2>MemAcc.out || exit

	# test for pattern MPS
	# 1. WGarg: get args related to n_work_groups and compute their current values with n_work_groups = 1 
	opt -load /root/Work/llvm/llvm-project/build/lib/LLVMWGArgs.so -wgargs main.ll 1>/dev/null 2>WGArgs.out || exit
	sed -n 1p WGArgs.out		# get the first line: output
	kkc=$(sed -n 2p WGArgs.out)	# get the second line: $kkc
	kcnt=$(sed -n 3p WGArgs.out)	# get the third line: $kcnt
	echo "Pattern MPS:"
	if [ $kcnt -eq -1 ]; then	# no kernel to consider
		echo -e "\t\tNo"
		mps=0
	else	
		# 2. DelKernel: find apps that exist pattern MPS
		opt -load /root/Work/llvm/llvm-project/build/lib/LLVMDelKernel.so -delkernel $name.ll 1>/dev/null 2>DelKernel.out || exit
		sed -n 1p DelKernel.out			# get the first line: output
		mps=$(sed -n 2p DelKernel.out)	# get the second line: $ao		
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

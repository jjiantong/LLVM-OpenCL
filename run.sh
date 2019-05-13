#!/bin/bash

ls apps/ && read -p "Please choose an application: " app
[ "$app" == "RSCD" ] && name=baseline_2 || name=baseline
cd apps/$app

# rebuild for the specific application
echo -e "\n--------Rebuilding--------"
clang -Dcl_clang_storage_class_specifiers -isystem /root/Work/llvm/libclc/generic/include -include clc/clc.h -x cl -emit-llvm -S $name.cl -o $name.ll || exit	# compile OpenCL kernel (.cl)
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/SameBuffer/SameBuffer.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/InOut/InOut.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/KKC/KKC.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/WGArgs/WGArgs.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/MPS/MPS.cpp	
cd /root/Work/llvm/llvm-project/build
make > /dev/null && echo -e "Succeed." || exit

echo -e "\n--------Analysing--------\n"
cd /root/Work/llvm/apps/$app
# test for pattern AO
echo "Pattern AO:"
opt -load /root/Work/llvm/llvm-project/build/lib/LLVMAtomic.so -atomic $name.ll 1>/dev/null 2>Atomic.out || exit
sed -n 1p Atomic.out		# get the first line: output
ao=$(sed -n 2p Atomic.out)	# get the second line: $ao

# test for pattern KKC
# 1. numkernels: get the number of kernels and args
opt -load /root/Work/llvm/llvm-project/build/lib/LLVMNumKernels.so -numkernels $name.ll 1>/dev/null 2>NumKernels.out || exit
kernel_num=$(head -1 NumKernels.out)	# get the first line

if [ $kernel_num -eq 1 ]; then		# only one kernel, then it has no KKC or MPS
	echo -e "Pattern KKC:\n\t\tNo\nPattern MPS:\n\t\tNo"
	mps=0
	kkc=0
else					# more than two kernels	
	clang -w -emit-llvm -c main.cpp -o main.bc && llvm-dis main.bc || exit	# compile the host code (.cpp)
	echo -e "Pattern KKC:"

	# 2. samebuffer: find arg pairs that use the same buffer
	opt -load /root/Work/llvm/llvm-project/build/lib/LLVMSameBuffer.so -samebuffer main.ll 1>/dev/null 2>SameBuffer.out || exit

	# 3. inout: find arg pairs that satisfy "output->input"
	opt -load /root/Work/llvm/llvm-project/build/lib/LLVMInOut.so -inout $name.ll 1>/dev/null 2>InOut.out || exit

	# 4. KKC: find kernel pairs that exist pattern KKC
	opt -load /root/Work/llvm/llvm-project/build/lib/LLVMKKC.so -kkc $name.ll 1>/dev/null 2>KKC.out || exit

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
		# 2. MPS: find apps that exist pattern MPS
		opt -load /root/Work/llvm/llvm-project/build/lib/LLVMMPS.so -mps $name.ll 1>/dev/null 2>MPS.out || exit
		sed -n 1p MPS.out		# get the first line: output
		mps=$(sed -n 2p MPS.out)	# get the second line: $ao		
	fi
fi

# determine the most suitable execution model
echo "Execution model:"
[ $ao -eq 0 -a $mps -eq 0 -a $kkc -eq 0 ] && echo -e "\t\tNDR"
[ $ao -eq 0 -a $mps -eq 0 -a $kkc -eq 1 ] && echo -e "\t\tNDR+C"
[ $ao -eq 0 -a $mps -eq 1 -a $kkc -eq 0 ] && echo -e "\t\tSWI"
[ $ao -eq 0 -a $mps -eq 1 -a $kkc -eq 1 ] && echo -e "\t\tSWI+C"
[ $ao -eq 1 -a $mps -eq 0 -a $kkc -eq 0 ] && echo -e "\t\tSWI"
[ $ao -eq 1 -a $mps -eq 0 -a $kkc -eq 1 ] && echo -e "\t\tSWI+C"
[ $ao -eq 1 -a $mps -eq 1 -a $kkc -eq 0 ] && echo -e "\t\tSWI"
[ $ao -eq 1 -a $mps -eq 1 -a $kkc -eq 1 ] && echo -e "\t\tSWI+C"
echo -e "\n---------The End---------\n"

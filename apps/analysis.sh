#!/bin/bash

app=$1

# rebuild for specific applications
echo -e "\n------Rebuilding------"
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/SameBuffer/SameBuffer.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/InOut/InOut.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/KKC/KKC.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/WGArgs/WGArgs.cpp
sed -i "1c #define APP \"$app\"" /root/Work/llvm/llvm-project/llvm/lib/Transforms/MPS/MPS.cpp
cd /root/Work/llvm/llvm-project/build
make > /dev/null

# change directory 
echo -e "\n------Analysing------"
cd /root/Work/llvm/apps/$app
echo -e "\nApplication:\n\t\t$app"

# test for AO
echo "Pattern AO:"
opt -load ../../llvm-project/build/lib/LLVMAtomic.so -atomic baseline_2.ll >/dev/null

# test for KKC
# step 1: numkernels -> get the number of kernels and args (from host)
echo "Pattern KKC:"
opt -load ../../llvm-project/build/lib/LLVMNumKernels.so -numkernels baseline_2.ll 1>/dev/null 2>NumKernels.out
kernel_num=$(head -1 NumKernels.out)	# get the first line
# only one kernel, then it has no KKC or MPS
if [ $kernel_num -eq 1 ]
	then
		echo -e "\t\tNo\nPattern MPS:\n\t\tNo"
	else
		# step 2: samebuffer -> test for args on host code
		opt -load ../../llvm-project/build/lib/LLVMSameBuffer.so -samebuffer main.ll 1>/dev/null 2>SameBuffer.out

		# step 3: inout -> find load/store on OpenCL kernels
		opt -load ../../llvm-project/build/lib/LLVMInOut.so -inout baseline_2.ll 1>/dev/null 2>InOut.out

		# step 4: KKC
		opt -load ../../llvm-project/build/lib/LLVMKKC.so -kkc baseline_2.ll 1>/dev/null 2>KKC.out

		# test for MPS
		# step 1: WG arg -> get args related to n_work_groups and their current values with n_work_groups = 1 (from host) 
		opt -load ../../llvm-project/build/lib/LLVMWGArgs.so -wgargs main.ll 1>/dev/null 2>WGArgs.out

		# step 2: analyse the results from host
		sed -n 1p WGArgs.out	# get the first line
		wgcnt=$(sed -n 2p WGArgs.out)	# get the second line
		echo "Pattern MPS:"
		if [ $wgcnt -eq -1 ]
			then
				echo -e "\t\tNo"
		fi
		
		# step 3: MPS -> test the args (from host)
		opt -load ../../llvm-project/build/lib/LLVMMPS.so -mps baseline_2.ll >/dev/null
fi

echo -e "\n------The End------"

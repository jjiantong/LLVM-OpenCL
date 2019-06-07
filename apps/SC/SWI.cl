#define _OPENCL_COMPILER_
#define SIZE 65536

#include "support/common.h"

// OpenCL kernel ------------------------------------------------------------------------------------------
__kernel void StreamCompaction_kernel(int size, int value, __global int *input ) {

	int pos = 0;
	int reg[SIZE];

	for(int i = 0; i < SIZE; i++)
		reg[i] = input[i];

	for(int my = 0; my < size; my++) {
        if(reg[my] != value) {
            reg[pos] = reg[my];
            pos++;
        }
    }

	for(int i = 0; i < SIZE; i++)
		input[i] = reg[i];
}

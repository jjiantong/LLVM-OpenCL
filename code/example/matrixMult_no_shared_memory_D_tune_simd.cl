// Defines BLOCK_SIZE
#include "matrixMult.h"

// This is the definition of a kernel. Notice a few attributes provided to it:
// The reqd_work_group_size specifies the exact dimensions of the work group. This
// allows the compiler to optimize the hardware for this case. In particular, it scales the
// sizes of barriers and optimizes the loop structure to be able to simultaneously run several
// work groups of the specified size.
// The num_vector_lanes attribute suggests and a vectorization method to be used when creating the
// hardware circuit for this kernel. In particular, it states that each thread should perform the work
// of eight threads thus widening the datapath in the kernel. To make the this flow easy to use, this
// setting does not affect how the kernel is invoked from the host. That is, the host still specifies
// the workgroup size to be (BLOCK_SIZE, BLOCK_SIZE, 1) and the hardware circuit reduces it internally
// to a workgroup size that is an 4th of the size.

__kernel 
__attribute((reqd_work_group_size(BLOCK_SIZE,BLOCK_SIZE,1)))
__attribute((num_vector_lanes(NUM_SIMD)))
__attribute((num_compute_units(NUM_CU)))
void matrixMult( // Input and output matrices
                 __global float *restrict C,
                 __global float *restrict A,
                 __global float *restrict B, 
                 // Widths of matrices.
                 int A_width, int B_width)
{

    // Global ID index
    int global_x = get_global_id(0);
    int global_y = get_global_id(1);

    // Global ID size
    int global_size_x = get_global_size(0);
    int global_size_y = get_global_size(1);
	
	__global float * a = A + global_y*2048; //A_width
	__global float * b = B;
	float value = 0;
	
    #pragma unroll UNROLL_FACTOR
	for(int j = 0; j<2048; j++) //A_width
	{
		value += a[j]*b[j*B_width+global_x];
	}

    // Store result in matrix C
    C[global_y * 2048 + global_x] = value;//A_width
}

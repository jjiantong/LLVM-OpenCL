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
//__attribute((num_vector_lanes(4)))
void matrixMult( // Input and output matrices
                 __global float *restrict C,
                 __global float *A,
                 __global float *B, 
                 // Widths of matrices.
                 int A_width, int B_width)
{
    // Local storage for parts of input matrices A and B
    __local float A_local[BLOCK_SIZE][BLOCK_SIZE];
    __local float B_local[BLOCK_SIZE][BLOCK_SIZE];

    // Block index
    int block_x = get_group_id(0);
    int block_y = get_group_id(1);

    // Local ID index
    int local_x = get_local_id(0);
    int local_y = get_local_id(1);

    // Compute loop bounds
    int a_start = A_width * BLOCK_SIZE * block_y;
    int a_end   = a_start + A_width - 1;
    int b_start = BLOCK_SIZE * block_x;

    float running_sum = 0.0f;

    // Compute the matrix multiplication result for a given block.
    for (int a = a_start, b = b_start; a <= a_end; a += BLOCK_SIZE, b += (BLOCK_SIZE * B_width))
    {

        // Load the matrices to local memory. Notice that we are performing
        // index swapping here to have faster access to data. The compiler can do this automatically,          
        // but we include a manual version of this optimization for illustration purposes.
        A_local[local_y][local_x] = A[a + A_width * local_y + local_x];
        B_local[local_x][local_y] = B[b + B_width * local_y + local_x];
	
        // Synchronize to ensure the entire workgroup has completed the memory transfer before
        // proceeding to perform multiplication and addition.
        barrier(CLK_LOCAL_MEM_FENCE);

        #pragma unroll
        for (int k = 0; k < BLOCK_SIZE; ++k)
        {
            running_sum += A_local[local_y][k] * B_local[local_x][k];
        }

        // Wait for the workgroup to finish computation. If we do not, it is possible
        // that some work items compute their inner product and proceed to the loop entry before 
        // other work items in the same workgroup have a chance to read data from local memory.
        // This would cause a race condition; hence the presence of a barrier.
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    // Store result in matrix C
    C[get_global_id(1) * get_global_size(0) + get_global_id(0)] = running_sum;
}

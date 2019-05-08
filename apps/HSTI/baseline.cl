#define _OPENCL_COMPILER_

#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
#pragma OPENCL EXTENSION cl_khr_global_int32_extended_atomics : enable

#include "support/common.h"
#include "support/partitioner.h"

// OpenCL kernel ------------------------------------------------------------------------------------------
__kernel 
void Histogram_kernel(int size, int bins, int n_tasks, float alpha, __global unsigned int *data,
    __global unsigned int *histo, __local unsigned int *l_histo ) {
    
    Partitioner p = partitioner_create(n_tasks, alpha);
    
    // Block and thread index
    const int bx = get_group_id(0);
    const int tx = get_local_id(0);
    const int bD = get_local_size(0);
    const int gD = get_num_groups(0);

    // Sub-histograms initialization
    for(int pos = tx; pos < bins; pos += bD) {
        l_histo[pos] = 0;
    }

    barrier(CLK_LOCAL_MEM_FENCE); // Intra-block synchronization

    // Main loop
    for(int i = gpu_first(&p); gpu_more(&p); i = gpu_next(&p)) {
    
        // Global memory read
        unsigned int d = data[i * bD + tx];

// Atomic vote in shared memory
        atomic_add(&l_histo[((d * bins) >> 12)], 1);
    }

    barrier(CLK_LOCAL_MEM_FENCE); // Intra-block synchronization

    // Merge per-block histograms and write to global memory
    for(int pos = tx; pos < bins; pos += bD) {
// Atomic addition in global memory
        atomic_add(histo + pos, l_histo[pos]);
    }
}

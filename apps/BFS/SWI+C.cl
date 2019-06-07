#define _OPENCL_COMPILER_

#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
#pragma OPENCL EXTENSION cl_khr_global_int32_extended_atomics : enable

#include "support/common.h"

	channel unsigned int chan;

// OpenCL kernel ------------------------------------------------------------------------------------------
__kernel  
void BFS_in(__global int * restrict q1, __global int *n_t) {

    int n_t_local = n_t[0];

	for(int base = 0; base < n_t_local; base++) 

		write_channel_intel(chan, q1[base]);
}

__kernel  
void BFS_0(__global Node * restrict graph_nodes_av, __global Edge * restrict graph_edges_av, __global int * restrict cost,
    __global int * restrict color, __global int * restrict q2, __global int *n_t,
    __global int *tail, __global int *iter) {

    int iter_local = iter[0];
    int n_t_local = n_t[0];
	int tail_bin = 0;

	for(int base = 0; base < n_t_local; base++) {
		int pid = read_channel_intel(chan);
		cost[pid] = iter_local;

        Node cur_node;
        cur_node.x = graph_nodes_av[pid].x;
        cur_node.y = graph_nodes_av[pid].y;
        for(int i = cur_node.x; i < cur_node.y + cur_node.x; i++) {
            int id        = graph_edges_av[i].x;
            if(color[id] < BLACK) { 
				color[id] = BLACK;    
                q2[tail_bin] = id;
				tail_bin++;
            }
        }
    }

	tail[0] = tail_bin;
	iter[0]++;

}



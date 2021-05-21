#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stddef.h>
#include <limits.h>

__global__ void f_kernel(int* __restrict__ a, int* __restrict__ b, int *d_flag){
        int tid = blockIdx.x*blockDim.x+threadIdx.x;
        int flag = 1;
        *a = 1;
	*b = 1;
        if(threadIdx.x == 0)
             *d_flag = 0;
}
int f(int* __restrict__ a, int* __restrict__ b)
{
  int *d_flag;
  int flag = 1;
  cudaMalloc((void**)&d_flag, sizeof(int));
  cudaMemcpy(d_flag, a, sizeof(int), cudaMemcpyHostToDevice);
  f_kernel<<<1,1>>>(a,b,d_flag);
  cudaMemcpy(&flag, d_flag, sizeof(int), cudaMemcpyDeviceToHost);
}

int main(void)
{
  int a = 5;
  printf("%d\n", f(&a, &a));
  return f(&a, &a);
}
        
 
//编译通过; gcc:5;nvcc: 77；

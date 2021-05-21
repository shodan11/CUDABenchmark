#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>

struct a
{
  unsigned int bitfield : 3;
};

__device__ void test(int tid, int z, int *d_flag)
{
  if ( tid == 0) {
    if (z != 3)
      *d_flag = 0;
  }
}

__global__ void foo_kernel(int *d_flag)
{
  int tid = blockIdx.x * blockDim.x + threadIdx.x;
  struct a b;
  b.bitfield = 131;

  test(tid, b.bitfield, d_flag);
}

void foo()
{
  int *d_flag;
  int flag = 1;
  cudaMalloc((void**)&d_flag, sizeof(int));
  cudaMemcpy((void *)d_flag, (const void *)&flag, sizeof(int), cudaMemcpyHostToDevice);
  foo_kernel<<<1,1>>>(d_flag);
  cudaMemcpy(&flag, d_flag, sizeof(int), cudaMemcpyDeviceToHost);

  if (flag == 0) {
    printf("aborting\n");
    abort();
  }
}

int main()
{
  foo();
  //printf("%d\n", foo());
  //exit (0);
}
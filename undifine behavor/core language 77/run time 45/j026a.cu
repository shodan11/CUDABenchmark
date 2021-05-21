#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>

__global__ void f_kernel(int *y)
{
  int tid = blockIdx.x * blockDim.x + threadIdx.x;
  
}
int f(int z){
  int y;
  int *dev_y;
  cudaMalloc((void**)&dev_y, sizeof(int));
  f_kernel<<<1,1>>>(dev_y);
  cudaMemcpy(&z, dev_y, sizeof(int), cudaMemcpyDeviceToHost);
}

int main(void)
{
  int (*z)(double) = (int (*)(double))&f;
  //return z(5);
  printf("%d\n", z(5));
}



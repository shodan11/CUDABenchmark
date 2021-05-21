#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
int foo();

__global__ void foo_kernel(int x, int *y)
{
  
}

int main(void)
{
  int y;
  int *dev_y;
  cudaMalloc((void**)&dev_y, sizeof(int));
  foo_kernel<<<1,1>>>(5,dev_y);
  cudaMemcpy(&y,dev_y, sizeof(int), cudaMemcpyDeviceToHost);
  printf("%d\n",y);
  cudaFree(dev_y);
  
}
//0


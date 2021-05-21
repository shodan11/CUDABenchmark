#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>

__global__ void fun(int *y){
     int x = 0;
     *y = 1/x;
     printf("%d\n", 1/x);
     
             
}

int main(void)
{
  int y;
  int *dev_y;
  cudaMalloc((void**)&dev_y, sizeof(int));
  fun<<<1,1>>>(dev_y);
  cudaMemcpy(&y, dev_y, sizeof(int), cudaMemcpyDeviceToHost);
  
  cudaFree(dev_y);
 // printf("%d\n", y);
  return y;
  
}

//编译通过 1；

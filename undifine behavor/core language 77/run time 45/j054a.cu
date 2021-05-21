#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stddef.h>
#include <limits.h>

__global__ void fun(int *y){
      long long *p = malloc(sizeof(long long));

      *p = 5;

      *p = *(short*)p;
      
      printf("%d\n", *(short*)p);
     
             
}

int main(void)
{
  int y;
  int *dev_y;
  cudaMalloc((void**)&dev_y, sizeof(int));
  fun<<<1,1>>>(dev_y);
  cudaMemcpy(&y, dev_y, sizeof(int), cudaMemcpyDeviceToHost);
  
  cudaFree(dev_y);
  return 0;
  
}

//编译通过; gcc:5;nvcc: error: a value of type "void *" cannot be used to initialize an entity of type "long long *";

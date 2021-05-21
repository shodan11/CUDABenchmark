#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stddef.h>
#include <limits.h>


__global__ void fun(int *z){     
     int x = 5;
     int y = 5;
     int * __restrict__ p = &x;
     int * __restrict__ q = &y;
printf("%d\n", *p);
     p = q;
printf("%d\n", *p);
      *z = *p;     
      printf("%d\n", *z);    
      //return 0;            
}

int main(void)
{
  int z;
  int *dev_z;
  cudaMalloc((void**)&dev_z, sizeof(int));
  fun<<<1,1>>>(dev_z);
  cudaMemcpy(&z, dev_z, sizeof(int), cudaMemcpyDeviceToHost);
  
  cudaFree(dev_z);
  return 0;
  
}

//编译通过; gcc:5;nvcc: 5；

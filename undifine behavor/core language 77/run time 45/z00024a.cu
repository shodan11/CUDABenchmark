#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stddef.h>
#include <limits.h>
#include <string.h>


__global__ void fun(int *z){  
        int x = 0;
        (int)(&x) & -7;
        *z = (int)(&x) & -7;
        printf("%d\n", (int)(&x) & -7);
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

//编译通过；gcc:4;clang:4;nvcc:0;Unspecified value or behavior.C11 sec. 5.1.2.2.3:1;

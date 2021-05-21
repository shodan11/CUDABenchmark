#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>

#include <stddef.h>
#include <limits.h>
#include <string.h>


__global__ void fun(int *z){ 
        char a[5] = {1, 2, 3, 4, 5};
        printf("%d\n", *(int*)(&a[4]));
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

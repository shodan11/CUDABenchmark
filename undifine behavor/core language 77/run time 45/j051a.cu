#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stddef.h>

__global__ void fun(int *y){
     int s = -1;

      1 << s;
      *y = 1<<s;
      printf("%d\n", 1<<s);
      
     
             
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

//编译通过; gcc:-2147483648;nvcc:0;

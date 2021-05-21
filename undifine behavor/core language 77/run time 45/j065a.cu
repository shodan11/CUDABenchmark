#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stddef.h>
#include <limits.h>

__global__ void fun(int *y){
      volatile int x = 5;
	*(int*)&x;
        *y = *(int*)&x;
        printf("%d\n", *y);
      //return 0;
             
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

//编译通过; gcc:5;nvcc: 5;clang: 编译的时候出现警告：expression result unused [-wunused-value] *(int*)&x;

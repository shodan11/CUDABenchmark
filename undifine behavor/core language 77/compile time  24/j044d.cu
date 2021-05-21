#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>

struct str {int *x;};

__global__ void fun(int *y){
     int x = 5;
     int *p = &x;
     (union str)p;
     //printf("%p\n", *y);
             
}

int main(void)
{
  int y;
  int *dev_y;
  cudaMalloc((void**)&dev_y, sizeof(int));
  fun<<<1,1>>>(dev_y);
  cudaMemcpy(&y, dev_y, sizeof(int), cudaMemcpyDeviceToHost); 
  cudaFree(dev_y);  
}

//编译错误类型：j044d.cu(12): error: tag kind of union is incompatible with declaration of class "str"


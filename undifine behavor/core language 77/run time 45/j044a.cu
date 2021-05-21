#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>

__global__ void fun(double *y){
     int x = 5;
     int *p = &x;
     *y = (double)p;
     printf("%d\n", y);
             
}

int main(void)
{
  double y;
  double *dev_y;
  cudaMalloc((void**)&dev_y, sizeof(double));
  fun<<<1,1>>>(dev_y);
  cudaMemcpy(&y, dev_y, sizeof(double), cudaMemcpyDeviceToHost); 
  cudaFree(dev_y);  
}

//编译错误类型：044a.cu(10): error: invalid type conversion

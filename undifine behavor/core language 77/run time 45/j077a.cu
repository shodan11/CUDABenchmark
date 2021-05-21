#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stddef.h>
#include <limits.h>
#include <stdalign.h>

__global__ void f_kernel(int *d_flag){
        int tid = blockIdx.x*blockDim.x+threadIdx.x;
        int flag = 1;

        if(threadIdx.x == 0)
             *d_flag = 0;
}
  int f(int a[static 5]){
  
  int *d_flag;
  int flag = 1;
  cudaMalloc((void**)&d_flag, sizeof(int));
  cudaMemcpy(d_flag,0,sizeof(int), cudaMemcpyHostToDevice);
  f_kernel<<<1,1>>>(d_flag);
  cudaMemcpy(&flag, d_flag, sizeof(int), cudaMemcpyDeviceToHost);
}

int main(void)
{
  int a[2];
  //printf("%d\n", f(a));
  return f(a);
}
        
 
//编译错误;nvcc:(17): error: expected an expression;把static去掉就没问题；

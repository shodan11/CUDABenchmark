#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>

__global__ void fun(int *y){
     int a[4][5] = {0};
      a[1][7];
      //*y = a[1][7];
      printf("%d\n", a[1][7]);
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

//编译通过 gcc:0;nvcc:0  这个编译器编译的时候有警告超出数组的范围；

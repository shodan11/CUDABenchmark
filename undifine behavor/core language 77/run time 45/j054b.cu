#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stddef.h>
#include <limits.h>

__global__ void fun(int *y){
      struct big_type {
      int arr[32];
};
      union u {
      struct s1 { char c; struct big_type bt1; } sub1;
      struct s2 { long long x; struct big_type bt2; } sub2;
} obj;
      obj.sub2.bt2 = obj.sub1.bt1;
      printf("%d\n", obj.sub2.bt2);
      printf("%d\n", obj.sub1.bt1);
     
             
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

//编译通过; nvcc: 0 0;gcc:1526236216   2147483637;

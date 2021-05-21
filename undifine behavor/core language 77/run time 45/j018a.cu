#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <math.h>

__global__ void fun(float x, float y, float *z)
//_gloable_void fun(float x, float y, float *z)
//一行代码三处低级错误；
{

  *z = pow(x, y) ;
 
}

int main(void)
{
  float z;
  float *dev_z;
  cudaMalloc((void**)&dev_z, sizeof(float));
  fun<<<1,1>>>(10.0, 39.0, dev_z);
  cudaMemcpy(&z, dev_z, sizeof(float), cudaMemcpyDeviceToHost);
  printf("%f\n", z);//printf（"%f\n", z）;括号的错误
  cudaFree(dev_z);
  return 0;
  
}

//输出结果为inf;

#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>

__gloabl__ void f(int *z)
{

}

int main(void)
{
  int z;
  int *dev_z;
  cudaMalloc((void**)&dev_z, sizeof(int));
  fun<<<1,1>>>(dev_z);
  cudaMemcpy(&z, dev_z, sizeof(int), cudaMemcpyDeviceToHost)；
  cudaFree(dev_z);
  return f();
  
}



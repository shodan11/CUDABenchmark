#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stddef.h>
#include <limits.h>
#include <string.h>


__global__ void fun(int *z){  
        char a[5] = "abc";
	      char* p = realloc(a, 5);
	      p[0];
        *z = p[0];
        printf("%d\n", *z);
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

//编译未通过；(11): error: a value of type "void *" cannot be used to initialize an entity of type "char *";

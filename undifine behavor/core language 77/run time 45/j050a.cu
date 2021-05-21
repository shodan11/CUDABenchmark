#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <math.h>
#include <limits.h>
#include <stddef.h>

__global__ void fun(int *y){
     if (sizeof(ptrdiff_t) == sizeof(int)) {
            unsigned char *ptr0 = malloc(((unsigned)INT_MAX) + 1);

            unsigned char *ptr1 = ptr0 + (unsigned)INT_MAX + 1;

            ptr1 - ptr0;
            *y = ptr1 - ptr0;
            printf("%ld\n", *y);
            }
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

//j050a.cu(12): error: a value of type "void *" cannot be used to initialize an entity of type "unsigned char *"

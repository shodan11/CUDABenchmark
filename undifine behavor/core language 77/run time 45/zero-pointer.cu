#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stddef.h>
#include <limits.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct test_struct {
  void *               r;
  int                  y;
  double               x;
  long                 z;
  char                 str[348];
  struct test_struct * next;
  struct test_struct * prev;

} test_struct;

__global__ void fun(int *z){  
  void *        voidp   = NULL;
  char          zeroes[sizeof(test_struct)];

  memset(zeroes, 0, sizeof(zeroes));

  const void *s1 = &voidp;
  const void *s2 = zeroes;
  size_t n = sizeof(voidp);
  const unsigned char *us1 = (const unsigned char *) s1;
  const unsigned char *us2 = (const unsigned char *) s2;
  int k;
  while (n-- != 0) {
        if (*us1 != *us2) {
               if(*us1 < *us2){k = -1;}
               else k = 1;
              
        }
        printf("%d\n", k);
        us1++;
        us2++;
  }
    printf("%d\n", 100); 
  //return 100;
      // printf("%d\n", (int)(&x) & -7);
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

//编译通过；

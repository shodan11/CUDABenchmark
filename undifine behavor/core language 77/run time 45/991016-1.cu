#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stddef.h>
#include <limits.h>
typedef int T0;
typedef long T1;
typedef long long T2;


__global__ void doit(int sel, int n, void *p, int *y){
  
  T0 * const p0 = p;
  T1 * const p1 = p;
  T2 * const p2 = p;
  switch (sel)
    {
    case 0:
      do 
    *p0 += *p0;
      while (--n);
      return *p0 == 0;

    case 1:
      do 
   *p1 += *p1;
      while (--n);
      return *p1 == 0;

    case 2:
      do 
    *p2 += *p2;
      while (--n);
      return *p2 == 0;

    default:
      abort ();
    }
*y = p;

}



int main()
{
  int y;
  int *dev_y;
  cudaMalloc((void**)&dev_y, sizeof(int));
  doit<<<1,1>>>(dev_y);
  cudaMemcpy(&y, dev_y, sizeof(int), cudaMemcpyDeviceToHost);
  T0 v0; T1 v1; T2 v2;

  v0 = 1; doit(0, 5, &v0);
  printf("%d\n", v0);
  v1 = 1; doit(1, 5, &v1);
  printf("%d\n", v1);
  v2 = 1; doit(2, 5, &v2);
  printf("%d\n", v2);
  //cudaFree(dev_y);
  //return 0;
  
}

//编译未通过; gcc:32;nvcc: ；

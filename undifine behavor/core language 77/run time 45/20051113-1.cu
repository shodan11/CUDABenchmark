#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>
#include <stddef.h>
#include <limits.h>
extern void *memset(void *, int, size_t);
typedef struct
{
  short a;  
  unsigned short b;
  unsigned short c;
  unsigned long long Count;
  long long Count2;
} __attribute__((packed)) Struct1;

typedef struct
{
  short a;
  unsigned short b;
  unsigned short c;
  unsigned long long d;
  long long e;
  long long f;
} __attribute__((packed)) Struct2;

typedef union
{
  Struct1 a;
  Struct2 b;
} Union;

typedef struct
{
  int Count;
  Union List[];
} __attribute__((packed)) Struct3;
unsigned long long Sum (Struct3 *instrs) __attribute__((noinline));

__global__ void Sum_kernel (Struct3 *instrs,unsigned long long count,unsigned long long *y)
{
  int tid = blockIdx.x * blockDim.x + threadIdx.x;
  unsigned long long Count = 0;
  int i;
  for (i = 0; i < instrs->Count; i++) {
    count += instrs->List[i].a.Count;
    *y = count;
  }
}
unsigned long long Sum(Struct3 *instrs)
{
  unsigned long long *y;
  int flag = 1;
  cudaMalloc((void**)&y, sizeof(unsigned long long));
  cudaMemcpy((void *)y, (const void *)&flag, sizeof(unsigned long long), cudaMemcpyHostToDevice);
  Sum_kernel<<<1,1>>>(instrs, y);
  cudaMemcpy(&flag, y, sizeof(unsigned long long), cudaMemcpyDeviceToHost);

}


int main()
{
  Struct3 *p = malloc (sizeof (int) + 3 * sizeof(Union));
  memset(p, 0, sizeof(int) + 3*sizeof(Union));
  p->Count = 3;
  p->List[0].a.Count = 555;
  p->List[1].a.Count = 999;
  p->List[2].a.Count = 0x101010101ULL;
  p->List[0].a.Count2 = 555;
  p->List[1].a.Count2 = 999;
  p->List[2].a.Count2 = 0x101010101LL;
  if (Sum(p) != 555 + 999 + 0x101010101ULL)
    abort(); 
}



//nvcc: allowing all exceptions is incompatible with previous function "memset"
///usr/local/cuda-7.0/bin/..//include/common_functions.h(72): here
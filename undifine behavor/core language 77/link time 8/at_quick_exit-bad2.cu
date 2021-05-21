#include <stdlib.h>                                                                                                                                                                                                                                                                                                                                                            #include <stdlib.h>
#include <iostream>

__global__ void foo_kernel(int *d_flag)
{
	int tid = blockIdx.x*blockDim.x+threadIdx.x;
	int flag = 1;
	quick_exit(0);
	
}

void foo(void)
{
	int *d_flag;
	int flag = 1;
	cudaMalloc((void**)&d_flag, sizeof(int));
    cudaMemcpy((void *)d_flag, (const void *)&flag, sizeof(int), cudaMemcpyHostToDevice);
    foo_kernel<<<1,1>>>(d_flag);
    cudaMemcpy(&flag, d_flag, sizeof(int), cudaMemcpyDeviceToHost);
}

int main() {
  atexit(foo);
  exit(0);
}
#include <stdlib.h>
#include <iostream>

__global__ void test() {}



__global__ void foo_kernel(int *d_flag)
{
	int tid = blockIdx.x*blockDim.x+threadIdx.x;
	int flag = 1;
	
}

void foo()
{
	int *d_flag;
	int flag = 1;
	at_quick_exit(test);
	cudaMalloc((void**)&d_flag, sizeof(int));
    cudaMemcpy((void *)d_flag, (const void *)&flag, sizeof(int), cudaMemcpyHostToDevice);
    foo_kernel<<<1,10>>>(d_flag);
    cudaMemcpy(&flag, d_flag, sizeof(int), cudaMemcpyDeviceToHost);
}

int main() {
  at_quick_exit(foo);
  quick_exit(0);
}

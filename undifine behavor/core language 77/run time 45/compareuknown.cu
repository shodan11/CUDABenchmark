#include <stdlib.h>
#include <iostream>
#include "device_launch_parameters.h"
#include "cuda_runtime.h"
#include <stdio.h>


__global__ void test(int *z) 
{
	char x, y;
	if (x==y)
	{
		*z=0;
	}
	printf("%d\n", *z);	
} 

int main(void)
{
	int z;
	int *dev_z;
	cudaMalloc((void**)&dev_z, sizeof(int));
	test<<<1,1>>>(dev_z);
	cudaMemcpy(&z, dev_z, sizeof(int), cudaMemcpyHostToDevice);
	printf("%d\n",z);
	cudaFree(dev_z);
	return 0;
}                                                                                   
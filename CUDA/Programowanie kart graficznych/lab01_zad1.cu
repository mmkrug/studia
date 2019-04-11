#include <stdio.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <ctime>
#include <math.h>


#define  N   		10000000
#define  BLOCK_SIZE	1024

float 	   hArray[N];
float     *dArray;
int 	   blocks;


clock_t start_cpu, end_cpu;
double total_cpu;

clock_t start_gpu, end_gpu;
clock_t start_gpu_prolog, end_gpu_prolog;
clock_t start_gpu_epilog, end_gpu_epilog;
clock_t start_gpu_operacje, end_gpu_operacje;
double total_gpu;
double total_gpu_prolog;
double total_gpu_epilog;
double total_gpu_operacje;

void prologue(void) {
	cudaMemset(hArray, 0, sizeof(hArray));
	for (int i = 0; i < N; i++) {
		hArray[i] = i + 1;
	}
	cudaMalloc((void**)&dArray, sizeof(hArray));
	cudaMemcpy(dArray, hArray, sizeof(hArray), cudaMemcpyHostToDevice);
}

void epilogue(void) {
	cudaMemcpy(hArray, dArray, sizeof(hArray), cudaMemcpyDeviceToHost);
	cudaFree(dArray);
}




// Kernel
__global__ void pow3(float *A) {
	int x = blockDim.x * blockIdx.x + threadIdx.x;

	if (x < N)
		A[x] = A[x] * A[x] * A[x] + A[x] * A[x] + A[x];
}


void pow3cpu(float *A) {

	for (int x = 0; x < N; x++) {
		A[x] = A[x] * A[x] * A[x] + A[x] * A[x] + A[x];
	}

}





int main(int argc, char** argv)
{
	int	 devCnt;

	cudaGetDeviceCount(&devCnt);
	if (devCnt == 0) {
		perror("No CUDA devices available -- exiting.");
		return 1;
	}



	// CPU benchmark
	
	start_cpu = clock();
	{
		// CPU operacje
		for (int i = 0; i < N; i++) {
			hArray[i] = i + 1;
		}

		pow3cpu(hArray);
	}
	end_cpu = clock();
	total_cpu = (double)1000 * (end_cpu - start_cpu) / CLOCKS_PER_SEC;
	// koniec CPU



	// GPU benchmark
	start_gpu = clock();
	{
		// prolog
		start_gpu_prolog = clock();
		{
			prologue();
		}
		end_gpu_prolog = clock();
		// operacje na gpu
		start_gpu_operacje = clock();
		{
			blocks = N / BLOCK_SIZE;
			if (N % BLOCK_SIZE)
				blocks++;
			pow3 << <blocks, BLOCK_SIZE >> > (dArray);
			cudaThreadSynchronize();
		}
		end_gpu_operacje = clock();

		// epilog
		start_gpu_epilog = clock();
		{
			epilogue();
		}
		end_gpu_epilog = clock();

	}
	end_gpu = clock();


	total_gpu = (double)1000 * (end_gpu - start_gpu) / CLOCKS_PER_SEC;
	total_gpu_prolog = (double)1000 * (end_gpu_prolog - start_gpu_prolog) / CLOCKS_PER_SEC;
	total_gpu_operacje = (double)1000 * (end_gpu_operacje - start_gpu_operacje) / CLOCKS_PER_SEC;
	total_gpu_epilog = (double)1000 * (end_gpu_epilog - start_gpu_epilog) / CLOCKS_PER_SEC;


	printf("  Lab 1. Zad 1. Wektor\n\n");

	printf("  N:            %d \n", N);
	printf("  BLOCK SIZE:   %d \n", BLOCK_SIZE);
	printf("  Czas CPU:     %f [ms]\n", total_cpu);
	printf("  Czas GPU:     %f [ms]\n", total_gpu);
	printf("  GPU prolog:   %f [ms]\n", total_gpu_prolog);
	printf("  GPU operacje: %f [ms]\n", total_gpu_operacje);
	printf("  GPU epilog:   %f [ms]\n", total_gpu_epilog);



	return 0;
}

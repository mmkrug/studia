#include "EasyBMP.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
using namespace std;

#define	BLOCK_SIZE 32

int picWidth, picHeight;
BMP Input, Output;

struct Matrix {
	int width;
	int height;
	int *elementsRed;
	int *elementsGreen;
	int *elementsBlue;
};

__global__ void BmpToGrayKernel(const Matrix, Matrix);

void alokujMacierz(Matrix &M)
{
	M.width=picWidth;
	M.height=picHeight;
	M.elementsRed=(int*)malloc(M.width*M.height*sizeof(int));
	M.elementsGreen=(int*)malloc(M.width*M.height*sizeof(int));
	M.elementsBlue=(int*)malloc(M.width*M.height*sizeof(int));
}

void ConvertBmpToMatrix(BMP &Input, Matrix &M)
{
	for (int j=0; j<M.height; j++)
		for (int i=0; i<M.width; i++)
		{
			M.elementsRed[j*M.width+i]=Input(i,j)->Red;
			M.elementsGreen[j*M.width+i]=Input(i,j)->Green;
			M.elementsBlue[j*M.width+i]=Input(i,j)->Blue;
		}
}

void ConvertMatrixToBmp(BMP &Output, Matrix &M)
{
	for (int j=0; j<M.height; j++)
		for (int i=0; i<M.width; i++)
		{
			Output(i,j)->Red=(ebmpBYTE)M.elementsRed[j*M.width+i];
			Output(i,j)->Green=(ebmpBYTE)M.elementsGreen[j*M.width+i];
			Output(i,j)->Blue=(ebmpBYTE)M.elementsBlue[j*M.width+i];
		}
}

void zwolnijMacierz(Matrix &M)
{
	free(M.elementsRed);
	free(M.elementsGreen);
	free(M.elementsBlue);
}

void BmpToGrayGpu(const Matrix &A, Matrix &C)
{
	//kopiuje macierz Input do globalnej pamieci urzadzenia

	Matrix dA;
	dA.width=A.width;
	dA.height=A.height;
	size_t size=A.width*A.height*sizeof(int);
   	cudaMalloc((void**)&dA.elementsRed, size);
	cudaMemcpy(dA.elementsRed, A.elementsRed, size, cudaMemcpyHostToDevice);
	cudaMalloc((void**)&dA.elementsGreen, size);
	cudaMemcpy(dA.elementsGreen, A.elementsGreen, size, cudaMemcpyHostToDevice);
	cudaMalloc((void**)&dA.elementsBlue, size);
	cudaMemcpy(dA.elementsBlue, A.elementsBlue, size, cudaMemcpyHostToDevice);

	//przydzielam macierz Output w globalnej pamieci urzadzenia

	Matrix dC;
	dC.width=C.width;
	dC.height=C.height;
	size=C.width*C.height*sizeof(int);
	cudaMalloc((void**)&dC.elementsRed, size);
	cudaMemcpy(dC.elementsRed, C.elementsRed, size, cudaMemcpyHostToDevice);
	cudaMalloc((void**)&dC.elementsGreen, size);
	cudaMemcpy(dC.elementsGreen, C.elementsGreen, size, cudaMemcpyHostToDevice);
	cudaMalloc((void**)&dC.elementsBlue, size);
	cudaMemcpy(dC.elementsBlue, C.elementsBlue, size, cudaMemcpyHostToDevice);
   	
	//preparuje srodowisko i wywoluje kernel

	dim3 dimBlock(BLOCK_SIZE, BLOCK_SIZE);
	dim3 dimGrid(A.height / dimBlock.x + 1, A.width / dimBlock.y + 1);
	
	BmpToGrayKernel<<<dimGrid, dimBlock>>>(dA, dC);
	cudaThreadSynchronize();
	
	//odbieram obliczona macierz C z pamieci globalnej urzadzenia

	cudaMemcpy(C.elementsRed, dC.elementsRed, size, cudaMemcpyDeviceToHost);
	cudaMemcpy(C.elementsGreen, dC.elementsGreen, size, cudaMemcpyDeviceToHost);
	cudaMemcpy(C.elementsBlue, dC.elementsBlue, size, cudaMemcpyDeviceToHost);

	//zwalniam pamiec

	cudaFree(dA.elementsRed);
	cudaFree(dA.elementsGreen);
	cudaFree(dA.elementsBlue);
	cudaFree(dC.elementsRed);
	cudaFree(dC.elementsGreen);
	cudaFree(dC.elementsBlue);
}

// Kernel
__global__ void BmpToGrayKernel(Matrix A, Matrix C) {
	//kazdy watek oblicza jeden element macierzy C
	//akumulujac wynik w zmienej cvalue

	int j=blockIdx.y*blockDim.y+threadIdx.y; //row
	int i=blockIdx.x*blockDim.x+threadIdx.x; //col

	if (i==0 || j==0)
		return;

	if (i>=(A.height-1)||j>=(A.width-1))
		return;
	C.elementsRed[i*C.width+j]=0.2126*A.elementsRed[i*A.width+j] + 0.7152*A.elementsGreen[i*A.width+j]+0.0722*A.elementsBlue[i*A.width+j];
	C.elementsGreen[i*C.width+j]=0.2126*A.elementsRed[i*A.width+j] + 0.7152*A.elementsGreen[i*A.width+j]+0.0722*A.elementsBlue[i*A.width+j];
	C.elementsBlue[i*C.width+j]=0.2126*A.elementsRed[i*A.width+j] + 0.7152*A.elementsGreen[i*A.width+j]+0.0722*A.elementsBlue[i*A.width+j];
}

int main(int argc, char** argv)
{
	BMP Input, Output;
	double czas=0;
    	Input.ReadFromFile("in.bmp");
    	picWidth = Input.TellWidth();
	picHeight = Input.TellHeight();
	Output.SetSize( Input.TellWidth() , Input.TellHeight() );
	Output.SetBitDepth(24);

    int	 devCnt;
    cudaGetDeviceCount(&devCnt);
    if(devCnt == 0) {
		perror("No CUDA devices available -- exiting.");
		return 1;
    }

	Matrix A, C;

	alokujMacierz(A);
	alokujMacierz(C);
	ConvertBmpToMatrix(Input, A);

	clock_t begin=clock(), end;

	BmpToGrayGpu(A, C);

	end=clock();
	czas=(double)(end-begin)/CLOCKS_PER_SEC;
	printf("Czas obliczen na GPU = %.9f sekund\n", czas);

	ConvertMatrixToBmp(Output, C);
	zwolnijMacierz(A);
	zwolnijMacierz(C);
	
	Output.WriteToFile("in2.bmp");
    return 0;
}

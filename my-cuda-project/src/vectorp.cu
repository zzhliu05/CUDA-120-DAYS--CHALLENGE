#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>


__global__ void vectorAdd(float *A,float *B,float *C,int N){
    int idx=blockIdx.x*blockDim.x+threadIdx.x;
    if(idx<N){
        C[idx]=A[idx]+B[idx];
    }
}
int main(){
    int l=10000000;
    int size=l*sizeof(float);
    float *A,*B,*C;
    float *d_A,*d_B,*d_C;
    A=(float*)malloc(size);
    B=(float*)malloc(size);
    C=(float*)malloc(size);
    cudaMalloc(&d_A,size);
    cudaMalloc(&d_B,size);
    cudaMalloc(&d_C,size);
    for(int i=0;i<l;i++){
        A[i]=i;
        B[i]=2*i;
    }
    cudaMemcpy(d_A,A,size,cudaMemcpyHostToDevice);
    cudaMemcpy(d_B,B,size,cudaMemcpyHostToDevice);
    int threadsPerBlock=256;
    int blocksPerGrid=(l+threadsPerBlock-1)/threadsPerBlock;
    vectorAdd<<<blocksPerGrid,threadsPerBlock>>>(d_A,d_B,d_C,l);
    cudaMemcpy(C,d_C,size,cudaMemcpyDeviceToHost);
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    free(A);
    free(B);
    free(C);
    return 0;
}

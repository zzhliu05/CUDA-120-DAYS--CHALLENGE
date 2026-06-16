#include <stdio.h>
#include <cuda_runtime.h>


__global__ void matrixMul(float *A,float *B,float *C,int n){
    int idx=blockIdx.x*blockDim.x+threadIdx.x;
    __shared__ float tileA[16][16];
    __shared__ float tileB[16][16];
    int blocky=blockIdx.x/(n/16);
    int blockx=blockIdx.x%(n/16);
    int thready=threadIdx.x/16;
    int threadx=threadIdx.x%16;
    int row=blocky*16+thready;
    int col=blockx*16+threadx;
    if(idx<n*n){
        for(int i=0;i<n/16;i++){
            int acol=blockx*16+i*16+threadx;
            int brow=blocky*16+i*16+thready;
            tileA[thready][threadx]=A[row*n+acol];
            tileB[thready][threadx]=B[brow*n+col];
            __syncthreads();
            for (int j=0;j<16;j++){
                C[idx]+=tileA[thready][j]*tileB[j][threadx];
            }
            __syncthreads();
        }
    }
}


int main(){
    int n=1024;
    int size=n*n*sizeof(float);
    float *A,*B,*C;
    float *d_A,*d_B,*d_C;
    A=(float*)malloc(size);
    B=(float*)malloc(size);
    C=(float*)malloc(size);
    cudaMalloc(&d_A,size);
    cudaMalloc(&d_B,size);
    cudaMalloc(&d_C,size);
    int blocksize=16*16;
    int blockPerGrid=(n*n+blocksize-1)/blocksize;
    int threadsPerBlock=256;
    for(int i=0;i<n*n;i++){
        A[i]=1.0f;
        B[i]=1.0f;
    }
    cudaMemcpy(d_A,A,size,cudaMemcpyHostToDevice);
    cudaMemcpy(d_B,B,size,cudaMemcpyHostToDevice);
    matrixMul<<<blockPerGrid,threadsPerBlock>>>(d_A,d_B,d_C,n);
    cudaMemcpy(C,d_C,size,cudaMemcpyDeviceToHost); 
    printf("C[0][0]=%f\n",C[0]);
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    free(A);
    free(B);
    free(C);
    return 0;
}

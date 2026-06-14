#include <stdio.h>
#include <cuda_runtime.h>

__global__ void hellofromGPU()
{
    if (threadIdx.x == 0){
        printf("Hello from GPU!\n");
    }
}

int main(){
    hellofromGPU<<<1,1>>>();

    cudaDeviceSynchronize();
    printf("Hello from CPU!\n");
    
    return 0;
}
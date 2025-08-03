#include <stdio.h>
#include <cuda_runtime.h>

__global__ void add_threads(int* s, const int n) {
    *s = threadIdx.x + n * blockIdx.x;
}

int main() {
    int hSum = 0;
    int* dSum;
    CudaMalloc(&dSum, sizeof(int));
    const int n = 8;
    add_threads<<<1, n>>>(&dSum, n);

    cudaError_t err = cudaDeviceSynchronize();
    if (err != cudaSuccess) {
        printf("CUDA error: %s\n", cudaGetErrorString(err));
    }

    CudaMemcpy(&hSum, dSum);
    CudaFree(dSum);

    printf("sum is %d\n", hSum);
}

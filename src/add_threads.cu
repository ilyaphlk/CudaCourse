#include <stdio.h>
#include <cuda_runtime.h>

__global__ void add_threads(int* s) {
    *s = threadIdx.x + blockIdx.x;
}

int main() {
    int sum = 0;
    add_threads<<<2, 2>>>(&sum);

    cudaError_t err = cudaDeviceSynchronize();
    if (err != cudaSuccess) {
        printf("CUDA error: %s\n", cudaGetErrorString(err));
    }

    printf("sum is %d\n", sum);
}

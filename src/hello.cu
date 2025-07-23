#include <cstdio>
#include <cuda_runtime.h>

__global__ void hello() {
    printf("hello, world!\n", threadIdx.x);
}

int main() {
    hello<<<1, 1>>>();

    cudaError_t err = cudaDeviceSynchronize();
    if (err != cudaSuccess) {
        printf("CUDA error: %s\n", cudaGetErrorString(err));
    }

    return 0;
}


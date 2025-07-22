#include <cstdio>
#include <cuda_runtime.h>
#include <cuda_device_runtime_api.h>

__global__ void hello() {
    printf("hello, world!\n");
}

int main() {
    hello<<<1, 1>>>();

    cudaError_t err = cudaDeviceSynchronize();
    if (err != cudaSuccess) {
        printf("CUDA error: %s\n", cudaGetErrorString(err));
    }

    return 0;
}


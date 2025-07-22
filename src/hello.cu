#include <cstdio>
#include <cuda_device_runtime_api.h>

__global__ void hello() {
    printf("hello, world!\n");
}

int main() {
    hello<<<1, 1>>>();

    cudaDeviceSynchronize();

    return 0;
}


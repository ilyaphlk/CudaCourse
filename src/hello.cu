#include <cstdio>
#include <cuda_runtime.h>

__global__ void hello(char* buffer) {
    sprintf(buffer, "hello, world! thread number %d\n", threadIdx.x);
}

int main() {
    char* d_buffer;
    cudaMalloc(&d_buffer, 256);

    hello<<<1, 1>>>(d_buffer);

    cudaError_t err = cudaDeviceSynchronize();
    if (err != cudaSuccess) {
        printf("CUDA error: %s\n", cudaGetErrorString(err));
    }

    char h_buffer[256];
    cudaMemcpy(h_buffer, d_buffer, 256, cudaMemcpyDeviceToHost);
    printf("%s", h_buffer);

    cudaFree(d_buffer);

    return 0;
}


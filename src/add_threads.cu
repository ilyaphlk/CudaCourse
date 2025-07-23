#include <stdio.h>
#include <cuda_runtime.h>

__global__ void add_threads(int* s, const int n) {
    //*s = threadIdx.x + n * blockIdx.x;
    *s = n;
}

int main() {
    int sum = 0;
    const int n = 8;
    add_threads<<<n, n>>>(&sum, n);

    cudaError_t err = cudaDeviceSynchronize();
    if (err != cudaSuccess) {
        printf("CUDA error: %s\n", cudaGetErrorString(err));
    }

    printf("sum is %d\n", sum);
}

#include <stdio.h>
#include <cuda_runtime.h>

__device__ void write_string(char* buffer, const char* message) {
    int i = 0;
    while (message[i] != '\0') {
        buffer[i] = message[i];
        ++i;
    }
    buffer[i] = '\0';
}

__global__ void hello(char* buffer) {
    write_string(buffer, "hello, world!\n");
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

    FILE *f = fopen("output.txt", "w");
    fprintf(f, "%s\n", h_buffer);
    fclose(f);

    cudaFree(d_buffer);

    return 0;
}


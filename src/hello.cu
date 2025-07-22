#include <cstdio>

__global__ void hello() {
    printf("hello, world!\n");
}

int main() {
    hello<<<1, 1>>>();

    cudaDeviceSynchronize();

    return 0;
}


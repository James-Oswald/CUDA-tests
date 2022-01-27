
#include<cstdio>
#include<iostream>
#include<vector>

#define vectorSize 10

__global__ void sum(const double* in1, const double* in2, double* output){
    printf("Thread: %d\n", threadIdx.x);
    output[threadIdx.x] = in1[threadIdx.x] + in2[threadIdx.x];
}

int main(){
    int rt, dv;
    cudaError_t c2 = cudaDriverGetVersion(&dv);
    cudaError_t c1 = cudaRuntimeGetVersion(&rt);
    std::cout<<"CUDA RT:"<<c1<<":"<<rt<<"\nCUDA Dv:"<<c2<<":"<<dv<<std::endl;
    int inSize = vectorSize*sizeof(double);
    std::vector<double> ins, result;
    result.resize(vectorSize);
    for(int i = 0; i < vectorSize; i++)
        ins.push_back(i);
    double* din1, *din2, *dout;
    cudaMalloc((void**)&din1, inSize);
    cudaMalloc((void**)&din2, inSize);
    cudaMalloc((void**)&dout, inSize);
    cudaMemcpy((void*)din1, (void*)ins.data(), inSize, cudaMemcpyHostToDevice);
    cudaMemcpy((void*)din2, (void*)ins.data(), inSize, cudaMemcpyHostToDevice);
    sum<<<1, 30>>>(din1, din2, dout);
    cudaError_t cudaerr = cudaDeviceSynchronize();
    if (cudaerr != cudaSuccess)
        printf("kernel launch failed with error \"%s\".\n", cudaGetErrorString(cudaerr));
    cudaMemcpy((void*)result.data(), dout, inSize, cudaMemcpyDeviceToHost);
    cudaFree(din1); cudaFree(din2); cudaFree(dout);
    for(double elm : result)
        std::cout<<elm<<std::endl;
    return 0;
}
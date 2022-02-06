#include<cstdio>
#include<iostream>
#include<vector>

#define vectorSize 10

__global__ void add(const double* in1, const double* in2, double* output){
    output[threadIdx.x] = in1[threadIdx.x] + in2[threadIdx.x];
}

int main(){
    std::vector<double> ins = {1, 1, 1, 1, 1};
    int inSize = ins.size()*sizeof(double);
    std::vector<double> result;
    result.resize(ins.size());
    double *din1, *din2, *dout;
    cudaMalloc((void**)&din1, inSize);
    cudaMalloc((void**)&din2, inSize);
    cudaMalloc((void**)&dout, inSize);
    cudaMemcpy((void*)din1, (void*)ins.data(), inSize, cudaMemcpyHostToDevice);
    cudaMemcpy((void*)din2, (void*)ins.data(), inSize, cudaMemcpyHostToDevice);
    add<<<1, ins.size()>>>(din1, din2, dout);
    cudaDeviceSynchronize();
    cudaMemcpy((void*)result.data(), dout, inSize, cudaMemcpyDeviceToHost);
    cudaFree(din1); cudaFree(din2); cudaFree(dout);
    for(double elm : result)
        std::cout<<elm<<std::endl;
    return 0;
}
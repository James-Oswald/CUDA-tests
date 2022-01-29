
#include<iostream>
#include <thrust/copy.h>
#include<thrust/device_vector.h>

__global__ void add(const double* in1, const double* in2, double* output){
    output[threadIdx.x] = in1[threadIdx.x] + in2[threadIdx.x];
}

int main(){
    std::vector<double> data = {10, 20, 30, 40};
    thrust::device_vector<double> in1(data.begin(), data.end());
    thrust::device_vector<double> in2(data.begin(), data.end());
    thrust::device_vector<double> out(data.size());
    add<<<1, data.size()>>>(in1.data().get(), in2.data().get(), out.data().get());
    std::vector<double> res(out.size());
    thrust::copy(out.begin(), out.end(), res.begin());
    for(int i = 0; i < 4; i++)
        std::cout<<res[i]<<std::endl;
}
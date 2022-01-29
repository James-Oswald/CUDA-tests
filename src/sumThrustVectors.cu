
#include<iostream>
#include<thrust/device_vector.h>

__global__ void sumRow(double* vecStart, double* vec2Start){
    vecStart[blockIdx.x] = vecStart[blockIdx.x] + vec2Start[blockIdx.x];
}

double sum(const std::vector<double>& vec){
    thrust::device_vector<double> dv(vec.begin(), vec.end());
    while(dv.size() > 1){
        bool odd = dv.size() % 2 == 1;
        double* dvloc = dv.data().get();
        sumRow<<<dv.size()/2, 1>>>(dvloc, dvloc+(dv.size()/2+(odd?1:0)));
        cudaDeviceSynchronize();
        dv.resize(dv.size()/2+(odd?1:0));
    }
    return dv[0];
}

int main(){
    std::vector<double> data = {.5, .5, .5, .5, .9};
    std::cout<<sum(data)<<std::endl;
}
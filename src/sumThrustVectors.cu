
#include<iostream>
#include<thrust/device_vector.h>

__global__ void sumRow(double* vecStart, double* vec2Start){
    vecStart[blockIdx.x] = vecStart[blockIdx.x] + vec2Start[blockIdx.x];
}

double sum(const std::vector<double>& vec){
    thrust::device_vector<double> dv(vec.begin(), vec.end());
    while(dv.size() > 1){
        int newSize = dv.size()/2+(dv.size() % 2 == 1);
        double* dvloc = dv.data().get();
        sumRow<<<dv.size()/2, 1>>>(dvloc, dvloc+newSize);
        cudaDeviceSynchronize();
        dv.resize(newSize);
    }
    return dv[0];
}

int main(){
    std::vector<double> data;
    for(int i = 0; i < 100; i++)
        data.push_back(0.5);
    std::cout<<sum(data)<<std::endl;
}
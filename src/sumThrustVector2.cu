
#include<cstdio>
#include<cassert>
#include<iostream>
#include<thrust/device_vector.h>

__global__ void sum(double* data, int size){
    assert(size <= gridDim.x);
    if(size == 1) 
        return;
    int half = size / 2;
    int newSize = half + (size % 2 == 1);    
    if(blockIdx.x >= half) 
        return;
    data[blockIdx.x] = data[blockIdx.x] + data[blockIdx.x + newSize];
    if(blockIdx.x == 0){
        for(int i = 0; i < size; i++)
            printf("%02f ", data[i]);
        printf("\n%d | %d\n", size, newSize);
        sum<<<newSize,1>>>(data, newSize);
    }
}

int main(){
    std::vector<double> data;
    for(int i = 0; i < 100; i++)
        data.push_back(0.5);
    thrust::device_vector<double> dv(data.begin(), data.end());
    sum<<<dv.size(),1>>>(dv.data().get(), dv.size());
    std::cout<<dv[0]<<std::endl;
}


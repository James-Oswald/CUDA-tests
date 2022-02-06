
#include<cstdlib>

int main(){
    volatile char* i = (char*)calloc(sizeof(char), 4000000000);
    free((void*)i);
    return 0;
}
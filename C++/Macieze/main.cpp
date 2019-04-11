#include<iostream>
#include<cstdlib>
#include<time.h>
using namespace std;
float k;

float losuj(){
    srand(time(NULL));
    for(int i=0;i<10;i++){
        k=rand();
    }
    return k;
}

int main (){

    k=losuj();

    cout<<k<<endl;
    return 0;
}

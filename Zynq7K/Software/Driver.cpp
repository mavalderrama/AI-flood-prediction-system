#include "ANN.h"

using namespace std;
void testFunc();

int main()
{
    testFunc();    
    return 0;
}

void testFunc(){
    unsigned int inputs[3] = {3880851945,3880851945,3880851945};
    ANN test;
    unsigned int result;
    for(unsigned int i = 0; i < 300000000;i++){
         if(i % 2 == 0){
            unsigned int inputs2[3] = {0,0,0};
            test.setInputs(inputs2);
        }
        else 
            test.setInputs(inputs);  
        result = test.startOP();
        //cout << "ANN result: " << result << endl;
    }
    cout << "Program Terminated" << endl;
    //delete(test);
}

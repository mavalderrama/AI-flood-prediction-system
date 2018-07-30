
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include <time.h>
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <iostream>
#include "xtopann_hw.h"

#define LAYERS  1
#define NEURONS 3
#define OUTPUTS 1
#define INPUT_BASE_ADDR 0x05000000
#define OUTPUT_BASE_ADDR 0x07000000
#define DEV_MEM	"/dev/mem"
#define UIO_SIZE "/sys/class/uio/uio0/maps/map0/size"

class ANN
{
    public:

	unsigned *IP_Ctrl;
	unsigned Page_Size;
	void *base_address;
	unsigned int uio_size;
	unsigned int* Inputs;
	unsigned int* Output;
	unsigned int* layerWeigth;
	unsigned int* layerBias;
	unsigned int* outputWeigth;
	unsigned int* outputBias;
	unsigned int* input_hw;
	unsigned int* output_hw;


    ANN();

	~ANN();

    int getAddr();

	int mapPorts();

	int loadWeigths(unsigned int layerWeigthT[LAYERS][NEURONS][NEURONS],unsigned int layerBiasT[LAYERS][NEURONS],unsigned int outputWeigthT[OUTPUTS][NEURONS],unsigned int outputBiasT[OUTPUTS]);

	int initPL();

	int setInputs(unsigned int NInputs[3]);

	unsigned int startOP();

	unsigned int * assignToPhysical(unsigned long address,unsigned int size);
};
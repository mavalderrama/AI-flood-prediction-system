#include "ANN.h"
using namespace std;

ANN::ANN()
{

    unsigned int hiddenLayerWeigth[1][3][3] = {{{3880851945,3780071,22903153},{3489502838,4287104000,37389472},{594025369,4214627,4272006871}}};
    unsigned int hiddenLayerBias[1][3] = {{265083664,515825161,3914842383}};
    unsigned int outputLayerWeigth[1][3] = {{4282607805,4270857062,17722516}};
    unsigned int outputLayerBias[1] = {4293928919};

    if(getAddr() != 0)
        cout << "[ERROR]: The memory cannot be maped using UIO" << endl;
    if(mapPorts() != 0)
        cout << "[ERROR]: Invalid offsets file" << endl;
    if(loadWeigths(hiddenLayerWeigth,hiddenLayerBias,outputLayerWeigth,outputLayerBias) != 0)
       cout << "[ERROR]: Invalid weigth file" << endl;
    if(initPL() != 0)
        cout << "[ERROR]: The IP Accelerator is not ready" << endl;
    input_hw = assignToPhysical(XTOPANN_AXILITES_ADDR_INPUTS_V_DATA,sizeof(unsigned int)*3);
    output_hw = assignToPhysical(XTOPANN_AXILITES_ADDR_RESULT_V_DATA,sizeof(unsigned int));
}

ANN::~ANN()
{
    munmap(base_address,uio_size);
}

int ANN::getAddr()
{
    unsigned Page_Offset;
    unsigned Page_Addr;
    Page_Size = sysconf(_SC_PAGESIZE);
    int fd = open (DEV_MEM, O_RDWR | O_SYNC);
    if (fd < 1) {
        printf("Error al abrir /dev/mem\n");
        return -1;
    }
    int uio_fd;
    FILE *size_fp;
    uio_fd = open("/dev/uio0", O_RDWR);
    if(uio_fd == NULL)
    {
        printf("ERROR uio_fd = %d\n",uio_fd);
        return 1;
    }
    size_fp = fopen(UIO_SIZE,"r");
    fscanf(size_fp, "0x%x\n", &uio_size);
    base_address = mmap(NULL, uio_size,PROT_READ | PROT_WRITE,MAP_SHARED, uio_fd, 0);
    
    IP_Ctrl = ((unsigned *) (base_address));
    fclose(size_fp);
    return 0;
}

int ANN::mapPorts()
{
    //Inputs          = (unsigned int *)(base_address + XTOPANN_AXILITES_ADDR_INPUTS_V_BASE);
	//Output          = (unsigned int *)(base_address + XTOPANN_AXILITES_ADDR_RESULT_V_BASE);
	layerWeigth     = (unsigned int *)(base_address + XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_BASE);
	layerBias       = (unsigned int *)(base_address + XTOPANN_AXILITES_ADDR_BIAS_V_BASE);
	outputWeigth    = (unsigned int *)(base_address + XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_BASE);
	outputBias      = (unsigned int *)(base_address + XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_BASE);
    return 0;
}

int ANN::loadWeigths(unsigned int layerWeigthT[LAYERS][NEURONS][NEURONS],unsigned int layerBiasT[LAYERS][NEURONS],unsigned int outputWeigthT[OUTPUTS][NEURONS],unsigned int outputBiasT[OUTPUTS])
{
    unsigned int *cpyLayerWeigth     = layerWeigth;
    unsigned int *cpyLayerBias       = layerBias;
    unsigned int *cpyOutputWeigth    = outputWeigth;
    unsigned int *cpyOutputBias      = outputBias;

    for(int i = 0; i < LAYERS; i++)
    {
        for(int j = 0; j < NEURONS; j++)
        {
            for(int k = 0; k < NEURONS; k++)
            {
                cpyLayerWeigth += i*100 + j*10 + k;
                *cpyLayerWeigth = layerWeigthT[i][j][k];
            }
            cpyLayerBias += i*10 + j;
            *cpyLayerBias = layerBiasT[i][j];
        }
    }

    for(int i = 0; i < OUTPUTS; i++)
    {
        for(int j = 0; j < NEURONS; j++)
        {
            cpyOutputWeigth += i*10 + j;
           *cpyOutputWeigth = outputWeigthT[i][j];
        }
        cpyOutputBias++;
        *cpyOutputBias = outputBiasT[i];
    }
    return 0;
}

int ANN::initPL()
{
    unsigned int *ipAccelControl = (unsigned int*)base_address;
    if(*ipAccelControl <= 6)
        return 0;
    else
        return 1;
}

int ANN::setInputs(unsigned int NInputs[NEURONS])
{
    memcpy(input_hw,NInputs,sizeof(unsigned int)*NEURONS);
    return 0;
}

unsigned int ANN::startOP()
{
    unsigned int *ipAccelControl = (unsigned int*)base_address;
    *ipAccelControl = 1;
    unsigned int check = 100;
    //cout << "check " << check << endl;
    while(check >= 6){
        check = *ipAccelControl;
        //cout << "check " << check << endl;
    }
    //return *Output;
    return *output_hw;
}

unsigned int * ANN::assignToPhysical(unsigned long address,unsigned int size){
	int devmem = open("/dev/mem", O_RDWR | O_SYNC);
	off_t PageOffset = (off_t) address % getpagesize();
	off_t PageAddress = (off_t) (address - PageOffset);
	return (unsigned int *) mmap(0, size*sizeof(unsigned int), PROT_READ|PROT_WRITE, MAP_SHARED, devmem, PageAddress);
}
//#include <ap_fixed.h>
//#include "dataset.h"
#define numBits 32
#define numBitsInt 8
#define AFWIDTH (1 << numBits)
#define AFWIDTH2 (1 << numBits-1)
#define LAYERS 1
#define NEURONS 3
#define OUTPUTS 1
#define numBitsCoe 16
#define COEWIDTH (1 << numBitsCoe)
#define EPOCHS 10000
#define DATASET_SIZE 2592
#define DATASET_INPUTS 3
//typedef ap_fixed<numBits,numBitsInt,AP_RND_CONV> fix;
typedef float fix;
#include "coe3.h"
//#include <math.h>       /* sqrt */

void TOPANN(fix inputs[3],fix layerWeigth[LAYERS][NEURONS][NEURONS],fix bias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS],fix result[2]);
void ANN(fix inputs[6],fix layerWeigth[LAYERS][NEURONS][NEURONS],fix bias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS],fix layerResult[LAYERS][NEURONS]);
fix resultNeuron(fix inputs[10],fix weigths[10],fix bias,char control);
void initWeigths(fix hiddenLayerWeigth[LAYERS][NEURONS][NEURONS],fix hiddenLayerBias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS]);
void TANN(fix layerWeigth[LAYERS][NEURONS][NEURONS],fix bias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS]);
void initWeigths(fix hiddenLayerWeigth[LAYERS][NEURONS][NEURONS],fix hiddenLayerBias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS]);

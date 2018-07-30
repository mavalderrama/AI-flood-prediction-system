#include "hardware.h"
#include <iostream>
#include <fstream>
#include <time.h>       /* time */
#include <stdio.h>      /* printf, scanf, puts, NULL */
#include <stdlib.h>     /* srand, rand */
#include <math.h>

using namespace std;

void ANNS(fix inputs[DATASET_INPUTS],fix layerWeigth[LAYERS][NEURONS][NEURONS],fix bias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS],fix layerResult[LAYERS+1][NEURONS]);
fix resultNeuronS(fix inputs[6],fix weigths[10],fix bias,char control);
int main()
{
	fix inputs[3] = {0.658936,0.000000,0.017043};
	fix hiddenLayerWeigth[1][3][3] = {{{-24.5375,0.226716,1.3511},{-47.7326,-0.46607,2.20049},{35.1926,0.249236,-1.34845}}};
	fix hiddenLayerBias[1][3] = {{15.7007,30.5674,-22.531}};
	fix outputLayerWeigth[1][3] = {{-0.736537,-1.43619,1.05509}};
	fix outputLayerBias[1] = {-0.059801};
	fix result[2] = {100,100};
	fix layerResult[LAYERS+1][NEURONS];
	fix sinputs[NEURONS];
	for(int i = 0; i < 300000000;i++)
	{
		for(int i = 0; i < NEURONS; i++){
			sinputs[i] = inputs[i];
		}
		ANNS(sinputs,hiddenLayerWeigth,hiddenLayerBias,outputLayerWeigth,outputLayerBias,layerResult);
	}
	cout << "Program Terminated" << endl;
}

void ANNS(fix inputs[DATASET_INPUTS],fix layerWeigth[LAYERS][NEURONS][NEURONS],fix bias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS],fix layerResult[LAYERS+1][NEURONS])
{
	layerLoop: for(int layerIndex = 0; layerIndex < LAYERS;layerIndex++)
	{
		neuronLoop: for(int neuronIndex = 0; neuronIndex < NEURONS;neuronIndex++)
		{
			if(layerIndex == 0)
			{
				layerResult[layerIndex][neuronIndex] = resultNeuronS(inputs,layerWeigth[0][neuronIndex],bias[0][neuronIndex],0);
			}
			else
			{
				layerResult[layerIndex][neuronIndex] = resultNeuronS(layerResult[layerIndex],layerWeigth[layerIndex][neuronIndex],bias[layerIndex][neuronIndex],0);
			}
		}
	}
	outputLoop: for(int outputIndex = 0;outputIndex < OUTPUTS;outputIndex++)
	{
		//LAYERS value indicates is the output value from last layer followed by the outputIndex that indicates which neuron is
		layerResult[LAYERS][outputIndex] = resultNeuronS(layerResult[LAYERS-1],outputLayerWeigth[outputIndex],outputLayerBias[outputIndex],0);
	}
}

fix resultNeuronS(fix inputs[6],fix weigths[10],fix bias,char control)
{
	fix temp = 0.0;
	resultNeuronLoop:for(int i = 0;i < NEURONS;i++)
	{
		temp += weigths[i]*inputs[i];
	}
	temp += bias;
	if(temp >= 5.0)
		return 1.0;
	else
	{
		if(temp <= -5.0)
		{
			if(control == 0)
				return -1.0;
			if(control == 1)
				return 0.0;
		}
		else
		{
			if(control == 0)
			{
				return coeTanSig[(int)((temp+5)*(409))];
			}
			//if(control == 1)
				//return coeLogSig[(int)((temp+5)*(6553))];
		}
	}
	return 0;
}

void initWeigths(fix hiddenLayerWeigth[LAYERS][NEURONS][NEURONS],fix hiddenLayerBias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS])
{
	srand (time(NULL));
	fix temp;
	for(int layerIndex = 0; layerIndex < LAYERS;layerIndex++)
	{
		neuronLoop: for(int neuronIndex = 0; neuronIndex < NEURONS;neuronIndex++)
		{
			neuronInputLoop: for(int neuronInputIndex = 0; neuronInputIndex < NEURONS;neuronInputIndex++)
			{
				hiddenLayerWeigth[layerIndex][neuronIndex][neuronInputIndex] = (rand()%1000)/1000.0 - 0.5;
			}
		}
	}

	for(int layerIndex = 0; layerIndex < LAYERS;layerIndex++)
	{
		neuronLoopBias: for(int neuronIndex = 0; neuronIndex < NEURONS;neuronIndex++)
		{
			hiddenLayerBias[layerIndex][neuronIndex] = (rand()%1000)/1000.0 - 0.5;
		}
	}

	for(int neuronIndex = 0; neuronIndex < OUTPUTS; neuronIndex++)
	{
		outputLoopWeigths: for(int inputIndex = 0; inputIndex < NEURONS; inputIndex++)
		{
			outputLayerWeigth[neuronIndex][inputIndex] = (rand()%1000)/1000.0 - 0.5;
		}
	}

	for(int neuronIndex = 0; neuronIndex < OUTPUTS; neuronIndex++)
	{
		outputLayerBias[neuronIndex] = (rand()%1000)/1000.0 - 0.5;
	}
}

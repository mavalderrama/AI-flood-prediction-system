#include "hardware.h"

using namespace std;

void ANNS(fix inputs[DATASET_INPUTS],fix layerWeigth[LAYERS][NEURONS][NEURONS],fix bias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS],fix layerResult[LAYERS+1][NEURONS]);
fix resultNeuronS(fix inputs[6],fix weigths[10],fix bias,char control);

int main()
{
	fix inputs[3] = inputsDataset[34];
	fix hiddenLayerWeigth[1][3][3] = {{{8.0000,0.1635,0.1382},{1.0584,-2.6705,-4.2706},{1.0878,-0.7956,1.5774}}};
	fix hiddenLayerBias[1][3] = {{-4.6488,1.7857,1.7727}};
	fix outputLayerWeigth[1][3] = {{2.8549,0.2973,-0.7400}};
	fix outputLayerBias[1] = {0.4229};
	fix trainTarget[100];
	fix annOutput[OUTPUTS];
	fix result[1] = 100;
	fix layerResult[LAYERS+1][NEURONS];
	ofstream myfile;
	myfile.open("annEval.txt");
	for(int i = 0; i < DATASET_SIZE;i++)
	{
		TEST_HARDWARE(inputsDataset[i],hiddenLayerWeigth,hiddenLayerBias,outputLayerWeigth,outputLayerBias,trainTarget,result,2); // Case default: Start program in execution mode
		myfile << result[0] << endl;
	}
	myfile.close();
	return 0;
}

void ANNS(fix inputs[DATASET_INPUTS],fix layerWeigth[LAYERS][NEURONS][NEURONS],fix bias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS],fix layerResult[LAYERS+1][NEURONS])
{
	layerLoop: for(int layerIndex = 0; layerIndex < LAYERS;layerIndex++)
	{
		neuronLoop: for(int neuronIndex = 0; neuronIndex < NEURONS;neuronIndex++)
		{
			if(layerIndex == 0)
			{
				layerResult[layerIndex][neuronIndex] = resultNeuron(inputs,layerWeigth[0][neuronIndex],bias[0][neuronIndex],0);
			}
			else
			{
				layerResult[layerIndex][neuronIndex] = resultNeuron(layerResult[layerIndex],layerWeigth[layerIndex][neuronIndex],bias[layerIndex][neuronIndex],0);
			}
		}
	}
	outputLoop: for(int outputIndex = 0;outputIndex < OUTPUTS;outputIndex++)
	{
		layerResult[LAYERS][outputIndex] = resultNeuron(layerResult[LAYERS-1],outputLayerWeigth[outputIndex],outputLayerBias[outputIndex],0);
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

#include "hardware.h"
using namespace std;

void TEST_HARDWARE(fix inputs[3],fix layerWeigth[LAYERS][NEURONS][NEURONS],fix bias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS],fix *trainTarget,	fix annOut[OUTPUTS],char control)
{
	fix layerResult[LAYERS+1][NEURONS];
	if(control == 1)
		TANN(layerWeigth,bias,outputLayerWeigth,outputLayerBias);
	else
	{
		ANN(inputs,layerWeigth,bias,outputLayerWeigth,outputLayerBias,layerResult);
		annOut[0] = layerResult[1][0];
	}

}

void ANN(fix inputs[3],fix layerWeigth[LAYERS][NEURONS][NEURONS],fix bias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS],fix layerResult[LAYERS+1][NEURONS])
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

void TANN(fix layerWeigth[LAYERS][NEURONS][NEURONS],fix bias[LAYERS][NEURONS],fix outputLayerWeigth[OUTPUTS][NEURONS],fix outputLayerBias[OUTPUTS])
{
	fix delta = 0;
	fix temp;
	const fix LEARNINGRATE = 0.25;
	const fix ALPHA = 0.0001;
	fix layerResult[LAYERS+1][NEURONS];
	fix inputs[DATASET_INPUTS];
	float Cumtemp = 0;
	for(int epoch = 0;epoch < EPOCHS;epoch++)
	{
		float Cumulative_Error = 0.0;
		for(int datasetSize = 0; datasetSize < DATASET_SIZE; datasetSize++)
		{
			for(int datasetInputs = 0;datasetInputs < DATASET_INPUTS; datasetInputs++)
				inputs[datasetInputs] = inputsDataset[datasetSize][datasetInputs];
			//This function propagates the dataset across the network. It returns layerResult vector
			ANN(inputs,layerWeigth,bias,outputLayerWeigth,outputLayerBias,layerResult);
			//cout << "dataSIndex = " << datasetSize << endl;
			if(epoch == EPOCHS-1)
			  cout << "Propagation Result = " << layerResult[LAYERS][OUTPUTS-1] << endl;
			Cumtemp = (float)(targets[datasetSize][0] - layerResult[LAYERS][OUTPUTS-1]);
			//cout << "target - ANNOut = "<< Cumtemp << endl;
			Cumulative_Error += 0.5*pow(Cumtemp,2);
			//cout << "cumError = "<< Cumulative_Error << endl;
			//This Calculates the Delta for the output neuron
			delta = (targets[datasetSize][0] - layerResult[LAYERS][OUTPUTS-1]) * ((fix)1.0 - (layerResult[LAYERS][OUTPUTS-1] * layerResult[LAYERS][OUTPUTS-1]));
			//cout << "delta = " << delta << endl;

			//this updates the bias of the output neurons
			//cout << "update bias" << endl;
			if(datasetSize == 0)
			{
				outputLayerBias[0] += /*ALPHA * prevOutputBias[0] +*/ LEARNINGRATE * delta;
			}
			else
			{
				outputLayerBias[0] += /*ALPHA * prevOutputBias[1] +*/ LEARNINGRATE * delta;
			}



			//This updates the weights in the hidden layer based in the inputs
			for(int neuronIndex = 0; neuronIndex < NEURONS;neuronIndex++)
			{
				//This updates the biases for the hidden layer
				if(datasetSize == 0)
				{
					bias[0][neuronIndex] += /*ALPHA * prevBias[0][neuronIndex][0] +*/ (LEARNINGRATE) * (delta) * (outputLayerWeigth[0][neuronIndex]) * ((fix)1.0 - (layerResult[0][neuronIndex] * layerResult[0][neuronIndex]));
				}
				else
				{
					bias[0][neuronIndex] += /*ALPHA * prevBias[0][neuronIndex][1] +*/ (LEARNINGRATE) * (delta) * (outputLayerWeigth[0][neuronIndex]) * ((fix)1.0 - (layerResult[0][neuronIndex] * layerResult[0][neuronIndex]));
				}

				for(int inputIndex = 0;inputIndex < NEURONS; inputIndex++)
				{
					if(datasetSize == 0)
					{
						layerWeigth[0][neuronIndex][inputIndex] += /*ALPHA * prevLayerWeigth[0][neuronIndex][inputIndex][0] +*/ (LEARNINGRATE) * (delta) * (outputLayerWeigth[0][neuronIndex]) * ((fix)1.0 - (layerResult[0][neuronIndex] * layerResult[0][neuronIndex])) * inputs[inputIndex];
					}
					else
					{
						layerWeigth[0][neuronIndex][inputIndex] += /*ALPHA * prevLayerWeigth[0][neuronIndex][inputIndex][1] +*/ (LEARNINGRATE) * (delta) * (outputLayerWeigth[0][neuronIndex]) * ((fix)1.0 - (layerResult[0][neuronIndex] * layerResult[0][neuronIndex])) * inputs[inputIndex];
					}
				}
			}
			//This updates the weights of the output neuron based on the output of the hidden layer neurons
			for(int neuronIndex = 0; neuronIndex < OUTPUTS;neuronIndex++)
			{
					for(int inputIndex = 0;inputIndex < NEURONS; inputIndex++)
					{
							if(datasetSize == 0)
							{
									outputLayerWeigth[neuronIndex][inputIndex] += /*ALPHA * outputLayerWeigth[neuronIndex][inputIndex] +*/ LEARNINGRATE * delta * layerResult[0][inputIndex];
							}
							else
							{
									outputLayerWeigth[neuronIndex][inputIndex] += /*ALPHA * prevOutputWeigth[neuronIndex][inputIndex][1] +*/ LEARNINGRATE * delta * layerResult[0][inputIndex];
							}
					}
			}


		}
		float temp5 = Cumulative_Error/DATASET_SIZE;
		cout << "ERROR = " << temp5 << endl;
		if(epoch > 0)
			if(temp5 <= 0.020)
			{
				cout << "ERROR = " << temp5 << endl;
				cout << "EPOCHA = " << epoch << endl;
				break;
			}
	}

	//Print Weigths in a file for download
	ofstream myfile;
	myfile.open("TrainWeigths.h");
	myfile << "fix hiddenLayerWeigth[" << LAYERS << "][" << NEURONS << "][" << NEURONS << "] = {";
	layerLoop: for(int layerIndex = 0; layerIndex < LAYERS;layerIndex++)
	{
		myfile << "{";
		neuronLoop: for(int neuronIndex = 0; neuronIndex < NEURONS;neuronIndex++)
		{
			myfile << "{";
			neuronInputLoop: for(int neuronInputIndex = 0; neuronInputIndex < NEURONS;neuronInputIndex++)
			{
				if(neuronInputIndex < NEURONS - 1)
					myfile << layerWeigth[layerIndex][neuronIndex][neuronInputIndex] << ",";
				else
					myfile << layerWeigth[layerIndex][neuronIndex][neuronInputIndex];
			}
			if(neuronIndex < NEURONS - 1)
				myfile << "},";
			else
				myfile << "}";
		}
		if(layerIndex < LAYERS - 1)
			myfile << "},";
		else
			myfile << "}";
	}
	myfile << "};" << endl;

	myfile << "fix hiddenLayerBias[" << LAYERS << "][" << NEURONS << "] = {";
	layerLoopBias: for(int layerIndex = 0; layerIndex < LAYERS;layerIndex++)
	{
		myfile << "{";
		neuronLoopBias: for(int neuronIndex = 0; neuronIndex < NEURONS;neuronIndex++)
		{
			if(neuronIndex < NEURONS - 1)
				myfile << bias[layerIndex][neuronIndex] << ",";
			else
				myfile << bias[layerIndex][neuronIndex];
		}
		if(layerIndex < LAYERS - 1)
			myfile << "},";
		else
			myfile << "}";
	}
	myfile << "};" << endl;

	myfile << "fix outputLayerWeigth[" << OUTPUTS << "][" << NEURONS << "] = {";
	outputLoopNeurons: for(int neuronIndex = 0; neuronIndex < OUTPUTS; neuronIndex++)
	{
		myfile << "{";
		outputLoopWeigths: for(int inputIndex = 0; inputIndex < NEURONS; inputIndex++)
		{
			if(inputIndex < NEURONS - 1)
				myfile << outputLayerWeigth[neuronIndex][inputIndex] << ",";
			else
				myfile << outputLayerWeigth[neuronIndex][inputIndex];
		}
		if(neuronIndex < OUTPUTS - 1)
			myfile << "},";
		else
			myfile << "}";
	}
	myfile << "};" << endl;

	myfile << "fix outputLayerBias[" << OUTPUTS << "] = {";
	outputLoopNeuronsBias: for(int neuronIndex = 0; neuronIndex < OUTPUTS; neuronIndex++)
	{
		if(neuronIndex < OUTPUTS - 1)
			myfile << outputLayerBias[neuronIndex] << ",";
		else
			myfile << outputLayerBias[neuronIndex];
	}
	myfile << "};" << endl;
	myfile.close();
}

fix resultNeuron(fix inputs[6],fix weigths[10],fix bias,char control)
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
}



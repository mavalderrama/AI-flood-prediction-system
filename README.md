# Edge Computing Artificial Neural Network 
This implementation of an IoT Edge Computing System can predict a flood and dinamically reconfigure its hardware based on the data load

# VIVADO HLS Hardware ANN IP Core

Hardware implementation of a fully conected Artificial Neural Network using Xilinx Vivado HLS
Available at Vivado/HLS

## Features
- Input Layers:
	- Reconfigurable N number of inputs
- Hidden Neurons & Layers:
	- Reconfigurable N number of Layers
	- Reconfigurable N number of Neurons
- Ouput Layers:
	- Reconfigurable N number of outputs
- Training:
	- Load and download weights
	- Hardware feed forward back progragation method
- Activation Function:
	- Sigmoid
- Buses
	- AXI Full for data I/O
	- AXI Lite for management and configuration

# Artificial Neural Network (Software implementation)

## Features
Same features as HW counterpart but slower
Available at Zynq7K/Software
  
# Petalinux on ZYNQ7000

Fork of ARM Linux for ZYNQ7000 devices
This version was compiled to work with an Artificial Neural Network Accelerator implemented in the ZYNQ7000 FPGA hw portion

## Features
- Compiled with an Ubuntu 16 LTS File System
- The Device Tree Source includes UIO (User Inputs Outputs) and a gigabit Ethernet drivers Zynq7K/Device Tree Source
- Boot files available on Zynq7K/Petalinux Boot Files



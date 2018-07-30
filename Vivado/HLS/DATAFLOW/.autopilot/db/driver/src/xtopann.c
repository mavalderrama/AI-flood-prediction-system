// ==============================================================
// File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2017.4
// Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
// 
// ==============================================================

/***************************** Include Files *********************************/
#include "xtopann.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XTopann_CfgInitialize(XTopann *InstancePtr, XTopann_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Axilites_BaseAddress = ConfigPtr->Axilites_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XTopann_Start(XTopann *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTopann_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_AP_CTRL) & 0x80;
    XTopann_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_AP_CTRL, Data | 0x01);
}

u32 XTopann_IsDone(XTopann *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTopann_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XTopann_IsIdle(XTopann *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTopann_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XTopann_IsReady(XTopann *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTopann_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XTopann_EnableAutoRestart(XTopann *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTopann_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_AP_CTRL, 0x80);
}

void XTopann_DisableAutoRestart(XTopann *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTopann_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_AP_CTRL, 0);
}

void XTopann_Set_inputs_V(XTopann *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTopann_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_INPUTS_V_DATA, Data);
}

u32 XTopann_Get_inputs_V(XTopann *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTopann_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_INPUTS_V_DATA);
    return Data;
}

void XTopann_Set_result_V(XTopann *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTopann_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_RESULT_V_DATA, Data);
}

u32 XTopann_Get_result_V(XTopann *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTopann_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_RESULT_V_DATA);
    return Data;
}

u32 XTopann_Get_layerWeigth_V_BaseAddress(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_BASE);
}

u32 XTopann_Get_layerWeigth_V_HighAddress(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_HIGH);
}

u32 XTopann_Get_layerWeigth_V_TotalBytes(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_HIGH - XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_BASE + 1);
}

u32 XTopann_Get_layerWeigth_V_BitWidth(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTOPANN_AXILITES_WIDTH_LAYERWEIGTH_V;
}

u32 XTopann_Get_layerWeigth_V_Depth(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTOPANN_AXILITES_DEPTH_LAYERWEIGTH_V;
}

u32 XTopann_Write_layerWeigth_V_Words(XTopann *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_HIGH - XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XTopann_Read_layerWeigth_V_Words(XTopann *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_HIGH - XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_BASE + (offset + i)*4);
    }
    return length;
}

u32 XTopann_Write_layerWeigth_V_Bytes(XTopann *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_HIGH - XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XTopann_Read_layerWeigth_V_Bytes(XTopann *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_HIGH - XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_LAYERWEIGTH_V_BASE + offset + i);
    }
    return length;
}

u32 XTopann_Get_bias_V_BaseAddress(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_BIAS_V_BASE);
}

u32 XTopann_Get_bias_V_HighAddress(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_BIAS_V_HIGH);
}

u32 XTopann_Get_bias_V_TotalBytes(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XTOPANN_AXILITES_ADDR_BIAS_V_HIGH - XTOPANN_AXILITES_ADDR_BIAS_V_BASE + 1);
}

u32 XTopann_Get_bias_V_BitWidth(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTOPANN_AXILITES_WIDTH_BIAS_V;
}

u32 XTopann_Get_bias_V_Depth(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTOPANN_AXILITES_DEPTH_BIAS_V;
}

u32 XTopann_Write_bias_V_Words(XTopann *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XTOPANN_AXILITES_ADDR_BIAS_V_HIGH - XTOPANN_AXILITES_ADDR_BIAS_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_BIAS_V_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XTopann_Read_bias_V_Words(XTopann *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XTOPANN_AXILITES_ADDR_BIAS_V_HIGH - XTOPANN_AXILITES_ADDR_BIAS_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_BIAS_V_BASE + (offset + i)*4);
    }
    return length;
}

u32 XTopann_Write_bias_V_Bytes(XTopann *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XTOPANN_AXILITES_ADDR_BIAS_V_HIGH - XTOPANN_AXILITES_ADDR_BIAS_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_BIAS_V_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XTopann_Read_bias_V_Bytes(XTopann *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XTOPANN_AXILITES_ADDR_BIAS_V_HIGH - XTOPANN_AXILITES_ADDR_BIAS_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_BIAS_V_BASE + offset + i);
    }
    return length;
}

u32 XTopann_Get_outputLayerWeigth_V_BaseAddress(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_BASE);
}

u32 XTopann_Get_outputLayerWeigth_V_HighAddress(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_HIGH);
}

u32 XTopann_Get_outputLayerWeigth_V_TotalBytes(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_HIGH - XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_BASE + 1);
}

u32 XTopann_Get_outputLayerWeigth_V_BitWidth(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTOPANN_AXILITES_WIDTH_OUTPUTLAYERWEIGTH_V;
}

u32 XTopann_Get_outputLayerWeigth_V_Depth(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTOPANN_AXILITES_DEPTH_OUTPUTLAYERWEIGTH_V;
}

u32 XTopann_Write_outputLayerWeigth_V_Words(XTopann *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_HIGH - XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XTopann_Read_outputLayerWeigth_V_Words(XTopann *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_HIGH - XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_BASE + (offset + i)*4);
    }
    return length;
}

u32 XTopann_Write_outputLayerWeigth_V_Bytes(XTopann *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_HIGH - XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XTopann_Read_outputLayerWeigth_V_Bytes(XTopann *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_HIGH - XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_OUTPUTLAYERWEIGTH_V_BASE + offset + i);
    }
    return length;
}

u32 XTopann_Get_outputLayerBias_V_BaseAddress(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_BASE);
}

u32 XTopann_Get_outputLayerBias_V_HighAddress(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_HIGH);
}

u32 XTopann_Get_outputLayerBias_V_TotalBytes(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_HIGH - XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_BASE + 1);
}

u32 XTopann_Get_outputLayerBias_V_BitWidth(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTOPANN_AXILITES_WIDTH_OUTPUTLAYERBIAS_V;
}

u32 XTopann_Get_outputLayerBias_V_Depth(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTOPANN_AXILITES_DEPTH_OUTPUTLAYERBIAS_V;
}

u32 XTopann_Write_outputLayerBias_V_Words(XTopann *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_HIGH - XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XTopann_Read_outputLayerBias_V_Words(XTopann *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_HIGH - XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_BASE + (offset + i)*4);
    }
    return length;
}

u32 XTopann_Write_outputLayerBias_V_Bytes(XTopann *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_HIGH - XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XTopann_Read_outputLayerBias_V_Bytes(XTopann *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_HIGH - XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Axilites_BaseAddress + XTOPANN_AXILITES_ADDR_OUTPUTLAYERBIAS_V_BASE + offset + i);
    }
    return length;
}

void XTopann_InterruptGlobalEnable(XTopann *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTopann_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_GIE, 1);
}

void XTopann_InterruptGlobalDisable(XTopann *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTopann_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_GIE, 0);
}

void XTopann_InterruptEnable(XTopann *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XTopann_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_IER);
    XTopann_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_IER, Register | Mask);
}

void XTopann_InterruptDisable(XTopann *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XTopann_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_IER);
    XTopann_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_IER, Register & (~Mask));
}

void XTopann_InterruptClear(XTopann *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTopann_WriteReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_ISR, Mask);
}

u32 XTopann_InterruptGetEnabled(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTopann_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_IER);
}

u32 XTopann_InterruptGetStatus(XTopann *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTopann_ReadReg(InstancePtr->Axilites_BaseAddress, XTOPANN_AXILITES_ADDR_ISR);
}


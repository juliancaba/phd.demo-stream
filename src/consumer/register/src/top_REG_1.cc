#include "top_REG_1.h"

void
top_REG_1(int input, bool input_vld, int &output)
{
#pragma HLS INTERFACE ap_stable port=input
#pragma HLS INTERFACE ap_stable port=input_vld
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE ap_none port=output
#pragma HLS RESET variable=REG_1_i
  
  output = REG_1_i;
  if(input_vld)
    REG_1_i = input;
}

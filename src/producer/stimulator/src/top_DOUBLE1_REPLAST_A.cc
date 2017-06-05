#include "top_DOUBLE1_REPLAST_A.h"

  

void 
top_DOUBLE1_REPLAST_A(hls::stream<float> a_input, 
		      float &a_dout, bool &a_empty_n, bool a_read, 
		      bool clk_en)
{
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE ap_none port=a_dout
#pragma HLS INTERFACE ap_none port=a_empty_n
#pragma HLS INTERFACE ap_stable port=a_read

  float a_aux;
  float a_aux_tmp;

    
  if (clk_en){
    a_empty_n = true;
    if(a_read){
      if(a_input.read_nb(a_aux)){
	a_aux_tmp = a_aux;
	DOUBLE1_a_input_last = a_aux;
      }
      else 
	a_aux_tmp = DOUBLE1_a_input_last;
    }
    else{
      a_aux_tmp = 0;
    }
  }
  else{
    a_empty_n = false;
    a_aux_tmp = 0;
  }   


  a_dout = a_aux_tmp;  
}

#ifndef TOP_DOUBLE1_REPLAST_A_H
#define TOP_DOUBLE1_REPLAST_A_H

static float DOUBLE1_a_input_last = 0;

#include "hls_stream.h"

void top_DOUBLE1_REPLAST_A(hls::stream<float> a_input, 
			   float &a_dout, bool &a_empty_n, bool a_read, 
			   bool a_enable,
			   bool clk_en);

#endif

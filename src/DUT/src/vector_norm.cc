// -*- coding: utf-8; mode: c++; tab-width: 4 -*-

#include "vector_norm.h"
#include <cmath>

#include "hls_math.h"
#include "hls_stream.h"



static hls::stream<float> histAUX_1;



float
sum_hist_pow(hls::stream<float> &histIN)
{
  float sum = 0.f;
  float inAUX;

  inAUX = histIN.read();
 loop1:for(int i = 0; i != HIST_SIZE; i++){
	sum += inAUX*inAUX;	  
	histAUX_1.write(inAUX);
    if (i < HIST_SIZE-1)
      inAUX = histIN.read();
  }
  return sum;
}


float
scale2(float sum)
{
#ifndef POSIX
  return hls::recipf(sqrtf(sum)+1.6f);
#else
  return 1.f/(sqrtf(sum)+1.6f);
#endif
}



void
mult_hist_scale(float scale, hls::stream<float> &histOUT)
{
  //#pragma HLS STREAM variable=histAUX dim=1
  //#pragma HLS STREAM variable=histAUX_2 dim=1
 loop2:for(int i = 0; i != HIST_SIZE; i++)
    histOUT.write(histAUX_1.read()*scale);
}


void
l2norm(hls::stream<float> histIN, hls::stream<float> histOUT)
{
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE ap_fifo port=histIN
#pragma HLS INTERFACE ap_fifo port=histOUT

  float scale = 0.f;
  float sum = 0.f;
  
  sum = sum_hist_pow(histIN);
  scale = scale2(sum);
  mult_hist_scale(scale, histOUT);
}


#ifndef TOP_CTRL_H
#define TOP_CTRL_H

//#include <ap_int.h>
#include <hls_stream.h>

#include "header.h"
#include "typeDoublesStream.h"



static struct headerStruct header_CTRL;

static hls::stream<unsigned int> bufferIN_CTRL;
static hls::stream<unsigned int> bufferOUT_CTRL;
static hls::stream<unsigned int> bufferRESP_CTRL;


void inputBuffer_CTRL(hls::stream<unsigned int> &src);
void outputBuffer_CTRL(hls::stream<unsigned int> &dst);
void forward_CTRL(short size);
void getRequestHead_CTRL();
void buildResponseHead_CTRL(hls::stream<unsigned int> &dst,
			   unsigned short objID, unsigned short size, 
			   unsigned char flags);

/* void forward_CTRL(hls::stream<unsigned int> &src, short size); */
/* void getRequestHead_CTRL(hls::stream<unsigned int> &src); */
/* void buildResponse_CTRL(hls::stream<unsigned int> &dst, */
/* 			unsigned short objID, unsigned short size,  */
/* 			unsigned char flags); */

void
manager_CTRL(hls::stream<float> &buffer_histIN,
	     unsigned int callCount_histIN,
	     hls::stream<unsigned int> &callTime_histIN,
	     hls::stream<float> &expect_histOUT,
	     unsigned int callCount_histOUT,
	     hls::stream<unsigned int> &callTime_histOUT,
	     unsigned int failureCount_histOUT,
	     hls::stream<tfailure> &failure_histOUT,
	     unsigned int &intervalDelay_histOUT);

void
top_CTRL(hls::stream<unsigned int> din,
	 hls::stream<unsigned int> dout,
	 hls::stream<float> buffer_histIN,
	 unsigned int callCount_histIN,
	 hls::stream<unsigned int> callTime_histIN,
	 hls::stream<float> expect_histOUT,
	 unsigned int callCount_histOUT,
	 hls::stream<unsigned int> callTime_histOUT,
	 unsigned int failureCount_histOUT,
	 hls::stream<tfailure> failure_histOUT,
	 unsigned int &intervalDelay_histOUT);


#endif

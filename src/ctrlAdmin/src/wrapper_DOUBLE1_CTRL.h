#ifndef WRAPPER_DOUBLE1_CTRL_H
#define WRAPPER_DOUBLE1_CTRL_H

//#include <ap_int.h>
#include <hls_stream.h>

const int DOUBLE1_BUS_WIDTH_BYTES = 4; //int

static char ID_DOUBLE1_CTRL=2;


///////////////////////////////////////////////////////////////////////
//                 Function:   return
//////////////////////////////////////////////////////////////////////
//static ap_int<12> ID_DOUBLE1_CTRL_return = 1;
static unsigned char ID_DOUBLE1_CTRL_return = 1;

//const int DOUBLE1_CTRL_RETURN_READ_SIZE_BYTES = 4; //int


struct PARAM_DOUBLE1_CTRL_return{
  float histIN;    
  // here padding if its necessary
}__attribute__((packed));


static struct PARAM_DOUBLE1_CTRL_return  args_DOUBLE1_CTRL_return;

void running_DOUBLE1_CTRL_return(hls::stream<unsigned int> &src, hls::stream<float> &buffer_histIN, unsigned short size);
//void readParameters_DOUBLE1_CTRL_return(hls::stream<unsigned int> &src);
//////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                 Function:   callCount
//////////////////////////////////////////////////////////////////////
//static ap_int<12> ID_DOUBLE1_CTRL_callCount = 2;
static unsigned char ID_DOUBLE1_CTRL_callCount = 2;

//const int DOUBLE1_CTRL_CALLCOUNT_WRITE_SIZE_BYTES = 4; //int

struct RETURN_DOUBLE1_CTRL_callCount{
  unsigned int _return;
  // here padding if its necessary
}__attribute__((packed));

static struct RETURN_DOUBLE1_CTRL_callCount ret_DOUBLE1_CTRL_callCount;

void running_DOUBLE1_CTRL_callCount(hls::stream<unsigned int> &dst, unsigned int callCount_histIN);
//////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                 Function:   callTime
//////////////////////////////////////////////////////////////////////
//static ap_int<12> ID_DOUBLE1_CTRL_callTime = 3;
static unsigned char ID_DOUBLE1_CTRL_callTime = 3;

//const int DOUBLE1_CTRL_CALLTIME_WRITE_SIZE_BYTES = 4; //int

struct RETURN_DOUBLE1_CTRL_callTime{
  unsigned int _return;
  // here padding if its necessary
}__attribute__((packed));

static struct RETURN_DOUBLE1_CTRL_callTime ret_DOUBLE1_CTRL_callTime;

void running_DOUBLE1_CTRL_callTime(hls::stream<unsigned int> &dst, hls::stream<unsigned int> &callTime_histIN);
//////////////////////////////////////////////////////////////////////

#endif

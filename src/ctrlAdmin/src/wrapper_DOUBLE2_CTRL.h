#ifndef WRAPPER_DOUBLE2_CTRL_H
#define WRAPPER_DOUBLE2_CTRL_H

//#include <ap_int.h>
#include <hls_stream.h>
#include "typeDoublesStream.h"


const int DOUBLE2_BUS_WIDTH_BYTES = 4; //int

static char ID_DOUBLE2_CTRL=3;



///////////////////////////////////////////////////////////////////////
//                 Function:   expect
//////////////////////////////////////////////////////////////////////
//static ap_int<12> ID_DOUBLE2_CTRL_expect = 1;
static unsigned char ID_DOUBLE2_CTRL_expect = 1;

//const int DOUBLE2_CTRL_EXPECT_READ_SIZE_BYTES = 4; //int


struct PARAM_DOUBLE2_CTRL_expect{
  float histOUT;    
  // here padding if its necessary
}__attribute__((packed));


static struct PARAM_DOUBLE2_CTRL_expect  args_DOUBLE2_CTRL_expect;

void running_DOUBLE2_CTRL_expect(hls::stream<unsigned int> &src, hls::stream<float> &expect_histOUT, unsigned short size);
//void readParameters_DOUBLE2_CTRL_expect(hls::stream<unsigned int> &src);
//////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                 Function:   callCount
//////////////////////////////////////////////////////////////////////
//static ap_int<12> ID_DOUBLE2_CTRL_callCount = 2;
static unsigned char ID_DOUBLE2_CTRL_callCount = 2;

//const int DOUBLE2_CTRL_CALLCOUNT_WRITE_SIZE_BYTES = 4; //int

struct RETURN_DOUBLE2_CTRL_callCount{
  unsigned int _return;
  // here padding if its necessary
}__attribute__((packed));

static struct RETURN_DOUBLE2_CTRL_callCount ret_DOUBLE2_CTRL_callCount;

void running_DOUBLE2_CTRL_callCount(hls::stream<unsigned int> &dst, unsigned int callCount_histOUT);
//////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                 Function:   callTime
//////////////////////////////////////////////////////////////////////
//static ap_int<12> ID_DOUBLE2_CTRL_callTime = 3;
static unsigned char ID_DOUBLE2_CTRL_callTime = 3;

//const int DOUBLE2_CTRL_CALLCOUNT_WRITE_SIZE_BYTES = 4; //int

struct RETURN_DOUBLE2_CTRL_callTime{
  unsigned int _return;
  // here padding if its necessary
}__attribute__((packed));

static struct RETURN_DOUBLE2_CTRL_callTime ret_DOUBLE2_CTRL_callTime;

void running_DOUBLE2_CTRL_callTime(hls::stream<unsigned int> &dst, hls::stream<unsigned int> &callTime_histOUT);
//////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                 Function:   failCount
//////////////////////////////////////////////////////////////////////
//static ap_int<12> ID_DOUBLE2_CTRL_failCount = 4;
static unsigned char ID_DOUBLE2_CTRL_failCount = 4;

//const int DOUBLE2_CTRL_FAILCOUNT_WRITE_SIZE_BYTES = 4; //int

struct RETURN_DOUBLE2_CTRL_failCount{
  unsigned int _return;
  // here padding if its necessary
}__attribute__((packed));

static struct RETURN_DOUBLE2_CTRL_failCount ret_DOUBLE2_CTRL_failCount;

void running_DOUBLE2_CTRL_failCount(hls::stream<unsigned int> &dst, unsigned int failCount_histOUT);
//////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                 Function:   fail
//////////////////////////////////////////////////////////////////////
//static ap_int<12> ID_DOUBLE2_CTRL_fail = 5;
static unsigned char ID_DOUBLE2_CTRL_fail = 5;

//const int DOUBLE2_CTRL_FAIL_WRITE_SIZE_BYTES = 4; //int

struct RETURN_DOUBLE2_CTRL_fail{
  unsigned int _callcount;
  float _return;
  float _expected;
  unsigned int _time;
  unsigned int _delay;
  // here padding if its necessary
}__attribute__((packed));

static struct RETURN_DOUBLE2_CTRL_fail ret_DOUBLE2_CTRL_fail;

void running_DOUBLE2_CTRL_fail(hls::stream<unsigned int> &dst, hls::stream<tfail> &fail_histOUT);
//////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                 Function:   intervalDelay
//////////////////////////////////////////////////////////////////////
//static ap_int<12> ID_DOUBLE2_CTRL_intervalDelay = 6;
static unsigned char ID_DOUBLE2_CTRL_intervalDelay = 6;

//const int DOUBLE2_CTRL_EXPECT_READ_SIZE_BYTES = 4; //int


struct PARAM_DOUBLE2_CTRL_intervalDelay{
  unsigned int interval;    
  // here padding if its necessary
}__attribute__((packed));


static struct PARAM_DOUBLE2_CTRL_intervalDelay  args_DOUBLE2_CTRL_intervalDelay;

void running_DOUBLE2_CTRL_intervalDelay(hls::stream<unsigned int> &src, unsigned int &intervalDelay_histOUT);
void readParameters_DOUBLE2_CTRL_intervalDelay(hls::stream<unsigned int> &src);
//////////////////////////////////////////////////////////////////////

#endif
 

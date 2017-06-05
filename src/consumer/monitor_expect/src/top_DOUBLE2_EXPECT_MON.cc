#include "top_DOUBLE2_EXPECT_MON.h"

#include <hls_math.h>

const static float DELTA = 0.00001;

static float _expect_a_last = 0;
static unsigned int _time_a_last = 0;

  
void 
top_DOUBLE2_EXPECT_MON(unsigned int intervalDelay_a,
		       unsigned int &failcount_a, 
		       hls::stream<float> &buffer_a,
		       hls::stream<unsigned int> &callTime_a,
		       hls::stream<float> &expect_a,
		       hls::stream<tfail> &fail_a)
{
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE ap_none port=failcount_a
  //#pragma HLS INTERFACE ap_stable port=timeClock
#pragma HLS INTERFACE ap_stable port=intervalDelay_a
#pragma HLS data_pack variable=fail_a
#pragma HLS RESET variable=DOUBLE2_failcount_a_i
#pragma HLS RESET variable=DOUBLE2_callcount_a_i
  
  float _return_a;
  float _expect_a;
  unsigned int diffTime;
  unsigned int _callTime;
  tfail auxFail;

#pragma HLS data_pack variable=auxFail  

  failcount_a = DOUBLE2_failcount_a_i;
  _return_a = buffer_a.read();
  _callTime = callTime_a.read();
  diffTime = _callTime - _time_a_last;
  


  if(expect_a.read_nb(_expect_a)){
    _expect_a_last = _expect_a;

    if (DOUBLE2_callcount_a_i == 0){
      if (_return_a != _expect_a){
	auxFail._callcount = DOUBLE2_callcount_a_i;
	auxFail._return = _return_a;
	auxFail._expect = _expect_a;
	auxFail._time = _callTime;//timeClock;
	auxFail._delay = diffTime;
	fail_a.write_nb(auxFail);
	DOUBLE2_failcount_a_i +=1;      
      }
    }
    else{
      if ((fabsf(_return_a - _expect_a)>DELTA) || diffTime > intervalDelay_a){
	auxFail._callcount = DOUBLE2_callcount_a_i;
	auxFail._return = _return_a;
	auxFail._expect = _expect_a;
	auxFail._time = _callTime;//timeClock;
	auxFail._delay = diffTime;
	fail_a.write_nb(auxFail);
	DOUBLE2_failcount_a_i +=1;      
      }
    }
  }
  else{
    if ((fabsf(_return_a - _expect_a_last)>DELTA) || diffTime > intervalDelay_a){
      auxFail._callcount = DOUBLE2_callcount_a_i;
      auxFail._return = _return_a;
      auxFail._expect = _expect_a_last;
      auxFail._time = _callTime;//timeClock;
      auxFail._delay = diffTime;
      fail_a.write_nb(auxFail);
      DOUBLE2_failcount_a_i +=1;      
    }
  }

  DOUBLE2_callcount_a_i +=1;    
  _time_a_last = _callTime;//timeClock;
  
}

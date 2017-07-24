#include "top_DOUBLE2_EXPECT_MON.h"

#include <hls_math.h>

const static float DELTA = 0.00001;

static float _expect_a_last = 0;
static unsigned int _time_a_last = 0;

  
void 
top_DOUBLE2_EXPECT_MON(unsigned int intervalDelay_a,
		       unsigned int &failurecount_a, 
		       hls::stream<float> &buffer_a,
		       hls::stream<unsigned int> &callTime_a,
		       hls::stream<float> &expect_a,
		       hls::stream<tfailure> &failure_a)
{
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE ap_none port=failurecount_a
  //#pragma HLS INTERFACE ap_stable port=timeClock
#pragma HLS INTERFACE ap_stable port=intervalDelay_a
#pragma HLS data_pack variable=failure_a
#pragma HLS RESET variable=DOUBLE2_failurecount_a_i
#pragma HLS RESET variable=DOUBLE2_callcount_a_i
  
  float _return_a;
  float _expect_a;
  unsigned int diffTime;
  unsigned int _callTime;
  tfailure auxFailure;

#pragma HLS data_pack variable=auxFailure  

  failurecount_a = DOUBLE2_failurecount_a_i;
  _return_a = buffer_a.read();
  _callTime = callTime_a.read();
  diffTime = _callTime - _time_a_last;
  


  if(expect_a.read_nb(_expect_a)){
    _expect_a_last = _expect_a;

    if (DOUBLE2_callcount_a_i == 0){
      if (_return_a != _expect_a){
	auxFailure._callcount = DOUBLE2_callcount_a_i;
	auxFailure._return = _return_a;
	auxFailure._expect = _expect_a;
	auxFailure._time = _callTime;//timeClock;
	auxFailure._delay = diffTime;
	failure_a.write_nb(auxFailure);
	DOUBLE2_failurecount_a_i +=1;      
      }
    }
    else{
      if ((fabsf(_return_a - _expect_a)>DELTA) || diffTime > intervalDelay_a){
	auxFailure._callcount = DOUBLE2_callcount_a_i;
	auxFailure._return = _return_a;
	auxFailure._expect = _expect_a;
	auxFailure._time = _callTime;//timeClock;
	auxFailure._delay = diffTime;
	failure_a.write_nb(auxFailure);
	DOUBLE2_failurecount_a_i +=1;      
      }
    }
  }
  else{
    if ((fabsf(_return_a - _expect_a_last)>DELTA) || diffTime > intervalDelay_a){
      auxFailure._callcount = DOUBLE2_callcount_a_i;
      auxFailure._return = _return_a;
      auxFailure._expect = _expect_a_last;
      auxFailure._time = _callTime;//timeClock;
      auxFailure._delay = diffTime;
      failure_a.write_nb(auxFailure);
      DOUBLE2_failurecount_a_i +=1;      
    }
  }

  DOUBLE2_callcount_a_i +=1;    
  _time_a_last = _callTime;//timeClock;
  
}

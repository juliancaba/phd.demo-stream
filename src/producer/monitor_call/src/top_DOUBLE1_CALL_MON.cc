#include "top_DOUBLE1_CALL_MON.h"

  
void 
top_DOUBLE1_CALL_MON(unsigned int timeClock, unsigned int &callcount_a, bool trigger_a,
		     hls::stream<unsigned int> &callTime_a)
{
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE ap_none port=callcount_a
#pragma HLS RESET variable=DOUBLE1_callcount_a_i

  callcount_a = DOUBLE1_callcount_a_i;
  if (trigger_a){
    callTime_a.write_nb(timeClock);
    DOUBLE1_callcount_a_i +=1;    
  }
}

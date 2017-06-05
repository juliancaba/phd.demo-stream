#ifndef TOP_DOUBLE1_CALL_MON_H
#define TOP_DOUBLE1_CALL_MON_H

static unsigned int DOUBLE1_callcount_a_i = 0;

#include "hls_stream.h"

void top_DOUBLE1_CALL_MON(unsigned int timeClock, unsigned int &callcount_a, bool trigger_a,
			  hls::stream<unsigned int> &callTime_a);

#endif

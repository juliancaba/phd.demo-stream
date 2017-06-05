#ifndef TOP_DOUBLE2_EXPECT_MON_H
#define TOP_DOUBLE2_EXPECT_MON_H

static unsigned int DOUBLE2_callcount_a_i = 0;
static unsigned int DOUBLE2_failcount_a_i = 0;

#include <hls_stream.h>
#include "typeDoubles.h"

void top_DOUBLE2_EXPECT_MON(unsigned int intervalDelay_a,
			    unsigned int &failcount_a, 
			    hls::stream<float> &buffer_a,
			    hls::stream<unsigned int> &callTime_a,
			    hls::stream<float> &expect_a,
			    hls::stream<tfail> &fail_a);

#endif

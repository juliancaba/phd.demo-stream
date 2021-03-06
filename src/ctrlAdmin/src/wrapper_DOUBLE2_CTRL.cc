#include "wrapper_DOUBLE2_CTRL.h"

#include "hls_casting.h"


///////////////////////////////////////////////////////////////////////
//                  Function:   expect
//////////////////////////////////////////////////////////////////////
void
running_DOUBLE2_CTRL_expect(hls::stream<unsigned int> &src, hls::stream<float> &expect_histOUT, unsigned short size)
{
  int words32[1];

  for(unsigned short it=0; it != size; it++){
    words32[0] = src.read();
  
  // Casting
    unsigned int *ptr= (unsigned int*)words32;  
    for(int itwr=0; itwr != sizeof(int)/sizeof(args_DOUBLE2_CTRL_expect.histOUT); itwr++)
      expect_histOUT.write(toFloat(*ptr++));
  }
}


// void
// running_DOUBLE2_CTRL_expect(hls::stream<unsigned int> &src, hls::stream<float> &expect_histOUT)
// {
//   readParameters_DOUBLE2_CTRL_expect(src);
//   expect_histOUT.write(args_DOUBLE2_CTRL_expect.histOUT);
// }


// void
// readParameters_DOUBLE2_CTRL_expect(hls::stream<unsigned int> &src)
// { 
//   int words32[sizeof(args_DOUBLE2_CTRL_expect)/sizeof(int)];

//   for(int it=0; it != sizeof(args_DOUBLE2_CTRL_expect)/DOUBLE2_BUS_WIDTH_BYTES; it++)
//     words32[it] = src.read();
  
//   // Casting
//   unsigned int *ptr= (unsigned int*)words32;  
//   args_DOUBLE2_CTRL_expect.histOUT = toFloat(*ptr++);  
// }
///////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                  Function:   callCount
//////////////////////////////////////////////////////////////////////
union UNION_RET_callCount{
  unsigned int words32[sizeof(ret_DOUBLE2_CTRL_callCount)/sizeof(int)];
  unsigned short words16[sizeof(ret_DOUBLE2_CTRL_callCount)/sizeof(short)];
  unsigned char words8[sizeof(ret_DOUBLE2_CTRL_callCount)]; 
}byteRet_callCount;


void
running_DOUBLE2_CTRL_callCount(hls::stream<unsigned int> &dst, unsigned int callCount_histOUT)
{
  short index = 0;
  unsigned int ptr_return;
  ptr_return = callCount_histOUT;
  byteRet_callCount.words32[index++] = ptr_return;

  for(int itReturn=0; itReturn != sizeof(byteRet_callCount.words32)/DOUBLE2_BUS_WIDTH_BYTES; itReturn++)  
    dst.write(byteRet_callCount.words32[itReturn]);
}
///////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                  Function:   callTime
//////////////////////////////////////////////////////////////////////
union UNION_RET_callTime{
  unsigned int words32[sizeof(ret_DOUBLE2_CTRL_callTime)/sizeof(int)];
  unsigned short words16[sizeof(ret_DOUBLE2_CTRL_callTime)/sizeof(short)];
  unsigned char words8[sizeof(ret_DOUBLE2_CTRL_callTime)]; 
}byteRet_callTime;


void
running_DOUBLE2_CTRL_callTime(hls::stream<unsigned int> &dst, hls::stream<unsigned int> &callTime_histOUT)
{
  short index = 0;
  unsigned int ptr_return;
  ptr_return = callTime_histOUT.read();
  byteRet_callTime.words32[index++] = ptr_return;

  for(int itReturn=0; itReturn != sizeof(byteRet_callTime.words32)/DOUBLE2_BUS_WIDTH_BYTES; itReturn++)  
    dst.write(byteRet_callTime.words32[itReturn]);
}
///////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                  Function:   failureCount
//////////////////////////////////////////////////////////////////////
union UNION_RET_failureCount{
  unsigned int words32[sizeof(ret_DOUBLE2_CTRL_failureCount)/sizeof(int)];
  unsigned short words16[sizeof(ret_DOUBLE2_CTRL_failureCount)/sizeof(short)];
  unsigned char words8[sizeof(ret_DOUBLE2_CTRL_failureCount)]; 
}byteRet_failureCount;


void
running_DOUBLE2_CTRL_failureCount(hls::stream<unsigned int> &dst, unsigned int failureCount_histOUT)
{
  short index = 0;
  unsigned int ptr_return;
  ptr_return = failureCount_histOUT;
  byteRet_failureCount.words32[index++] = ptr_return;

  for(int itReturn=0; itReturn != sizeof(byteRet_failureCount.words32)/DOUBLE2_BUS_WIDTH_BYTES; itReturn++)  
    dst.write(byteRet_failureCount.words32[itReturn]);
}
///////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                  Function:   failure
//////////////////////////////////////////////////////////////////////
union UNION_RET_failure{
  unsigned int words32[sizeof(ret_DOUBLE2_CTRL_failure)/sizeof(int)];
  unsigned short words16[sizeof(ret_DOUBLE2_CTRL_failure)/sizeof(short)];
  unsigned char words8[sizeof(ret_DOUBLE2_CTRL_failure)]; 
}byteRet_failure;

void
running_DOUBLE2_CTRL_failure(hls::stream<unsigned int> &dst, hls::stream<tfailure> &failure_histOUT)
{
  short index = 0;
  tfailure aux;
  
  aux = failure_histOUT.read();

  byteRet_failure.words32[index++] = aux._callcount;
  
  unsigned int ptr_return[1];
  toSequence(aux._return, ptr_return);
  byteRet_failure.words32[index++] = ptr_return[0];
  
  unsigned int ptr_expect[1];
  toSequence(aux._expect, ptr_expect);
  byteRet_failure.words32[index++] = ptr_expect[0];
  
  unsigned int ptr_time;
  ptr_time = aux._time;
  byteRet_failure.words32[index++] = ptr_time;
  
  unsigned int ptr_delay;
  ptr_delay = aux._delay;
  byteRet_failure.words32[index++] = ptr_delay;

  for(int itReturn=0; itReturn != sizeof(byteRet_failure.words32)/DOUBLE2_BUS_WIDTH_BYTES; itReturn++)  
    dst.write(byteRet_failure.words32[itReturn]);
}
///////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                  Function:   intervalDelay
//////////////////////////////////////////////////////////////////////
void
running_DOUBLE2_CTRL_intervalDelay(hls::stream<unsigned int> &src, unsigned int &intervalDelay_histOUT)
{
  intervalDelay_histOUT = src.read();
  // readParameters_DOUBLE2_CTRL_intervalDelay(src);
  // intervalDelay_histOUT = args_DOUBLE2_CTRL_intervalDelay.interval;
}


void
readParameters_DOUBLE2_CTRL_intervalDelay(hls::stream<unsigned int> &src)
{ 
  int words32[sizeof(args_DOUBLE2_CTRL_intervalDelay)/sizeof(int)];

  for(int it=0; it != sizeof(args_DOUBLE2_CTRL_intervalDelay)/DOUBLE2_BUS_WIDTH_BYTES; it++)
    words32[it] = src.read();
  
  // Casting
  unsigned int *ptr= (unsigned int*)words32;  
  args_DOUBLE2_CTRL_intervalDelay.interval = *ptr++;  
}
///////////////////////////////////////////////////////////////////////


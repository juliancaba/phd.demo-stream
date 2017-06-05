#include "wrapper_DOUBLE1_CTRL.h"

#include "hls_casting.h"


///////////////////////////////////////////////////////////////////////
//                  Function:   return
//////////////////////////////////////////////////////////////////////
void
running_DOUBLE1_CTRL_return(hls::stream<unsigned int> &src, hls::stream<float> &buffer_histIN, unsigned short size)
{
  int words32[1];

  for(unsigned short it=0; it != size; it++){
    words32[0] = src.read();
  
  // Casting
    unsigned int *ptr= (unsigned int*)words32;
    for(int itwr=0; itwr != sizeof(int)/sizeof(args_DOUBLE1_CTRL_return.histIN); itwr++)
      buffer_histIN.write(toFloat(*ptr++));
  }
}

// void
// running_DOUBLE1_CTRL_return(hls::stream<unsigned int> &src, hls::stream<float> &buffer_histIN)
// {
//   readParameters_DOUBLE1_CTRL_return(src, size);
//   buffer_histIN.write(args_DOUBLE1_CTRL_return.histIN);
// }

/*
void
readParameters_DOUBLE1_CTRL_return(hls::stream<unsigned int> &src, unsigned short size)
{ 
  int words32[size];//sizeof(args_DOUBLE1_CTRL_return)/sizeof(int)];

  for(int it=0; it != size; it++)
    //	sizeof(args_DOUBLE1_CTRL_return)/DOUBLE1_BUS_WIDTH_BYTES; it++)
    words32[it] = src.read();
  
  // Casting
  unsigned int *ptr= (unsigned int*)words32;
  for(int itwr; itwr != size*4/sizeof(args_DOUBLE1_CTRL_return.histIN); itwr++)
    buffer_histIN.write(toFloat(*ptr++));
  //args_DOUBLE1_CTRL_return.histIN = toFloat(*ptr++);  
}
*/
///////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//                  Function:   callCount
//////////////////////////////////////////////////////////////////////
union UNION_RET_DOUBLE1_CTRL_callCount{
  unsigned int words32[sizeof(ret_DOUBLE1_CTRL_callCount)/sizeof(int)];
  unsigned short words16[sizeof(ret_DOUBLE1_CTRL_callCount)/sizeof(short)];
  unsigned char words8[sizeof(ret_DOUBLE1_CTRL_callCount)];
}byteRet_DOUBLE1_callCount;


void
running_DOUBLE1_CTRL_callCount(hls::stream<unsigned int> &dst, unsigned int callCount_histIN)
{
  short index = 0;
  unsigned int ptr_return;
  ptr_return = callCount_histIN;
  byteRet_DOUBLE1_callCount.words32[index++] = ptr_return;

  for(int itReturn=0; itReturn != sizeof(byteRet_DOUBLE1_callCount.words32)/DOUBLE1_BUS_WIDTH_BYTES; itReturn++)  
    dst.write(byteRet_DOUBLE1_callCount.words32[itReturn]);
}
///////////////////////////////////////////////////////////////////////





///////////////////////////////////////////////////////////////////////
//                  Function:   callTime
//////////////////////////////////////////////////////////////////////
union UNION_RET_DOUBLE1_CTRL_callTime{
  unsigned int words32[sizeof(ret_DOUBLE1_CTRL_callTime)/sizeof(int)];
  unsigned short words16[sizeof(ret_DOUBLE1_CTRL_callTime)/sizeof(short)];
  unsigned char words8[sizeof(ret_DOUBLE1_CTRL_callTime)];
}byteRet_DOUBLE1_callTime;


void
running_DOUBLE1_CTRL_callTime(hls::stream<unsigned int> &dst, hls::stream<unsigned int> &callTime_histIN)
{
  short index = 0;
  unsigned int ptr_return;
  ptr_return = callTime_histIN.read();
  byteRet_DOUBLE1_callTime.words32[index++] = ptr_return;

  for(int itReturn=0; itReturn != sizeof(byteRet_DOUBLE1_callTime.words32)/DOUBLE1_BUS_WIDTH_BYTES; itReturn++)  
    dst.write(byteRet_DOUBLE1_callTime.words32[itReturn]);
}
///////////////////////////////////////////////////////////////////////


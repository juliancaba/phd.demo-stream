#include "flag_codes.h"
#include "top_CTRL.h"
#include "wrapper_DOUBLE1_CTRL.h"
#include "wrapper_DOUBLE2_CTRL.h"


// union typeHead{
//   unsigned int words32;
//   unsigned char words8[4];  
// }byteHeader[2];


void
inputBuffer_CTRL(hls::stream<unsigned int> &src)
{
  unsigned int aux;
  while(!src.empty()){
    aux = src.read();
    bufferIN_CTRL.write(aux);
  }
}


void
outputBuffer_CTRL(hls::stream<unsigned int> &dst)
{
  unsigned int aux;
  while(!bufferOUT_OBJ.empty()){
    aux = bufferOUT_OBJ.read();
    dst.write(aux);
  }
}


void
forward_CTRL(short size)
{
  short it=0;
  while(it != size){
    bufferIN_CTRL.read();
    it += 1;
  }
}


void
buildResponseHead_CTRL(hls::stream<unsigned int> &dst,
		       unsigned short objID, unsigned short size,
		       unsigned char flags)
{
  int words32;

  // words32 = (header_OBJ.cb<<16) | (header_OBJ.methodID<<4) | flags;
  words32 = (header_CTRL.cb<<16) | (header_CTRL.methodID<<8) | flags;
  dst.write(words32);
  //dst.write(byteHeader[0].words32);
  if(flags & FLAG_HAS_PAYLOAD){
    words32 = (objID<<16) | size;
    dst.write(words32);
  }
}

void
buildResponse_CTRL(unsigned short objID, unsigned short size,
		   unsigned char flags)
{
  if (!bufferRESP_CTRL.empty()){
    buildResponseHead_CTRL(bufferOUT_CTRL, objID, size, flags);
    while (!bufferRESP_CTRL.empty())
      bufferOUT_CTRL.write(bufferRESP_CTRL.read());
  }
}


void
getRequestHead_CTRL()
{
  int words32[2];

  for(int it=0; it != 2; it++)
    words32[it] = bufferIN_CTRL.read();
  //byteHeader[it].words32 = bufferIN.read();

  header_CTRL.nodeID = (words32[0] >> 24) & 0xFF;
  header_CTRL.objectID = (words32[0] >> 16) & 0xFF;
  header_CTRL.methodID = (words32[0] >> 8) & 0xFF;
  header_CTRL.flags = words32[0] & 0xFF;
  // header_CTRL.methodID = (words32[0] >> 4) & 0xFFF;
  // header_CTRL.flags = words32[0] & 0xF;
  header_CTRL.cb = (words32[1] >> 16) & 0xFFFF;
  header_CTRL.size = words32[1] & 0xFFFF;

  /*
  header.nodeID = byteHeader[0].words8[3];
  header.objectID = byteHeader[0].words8[2];
  header.methodID_flags = to_short(byteHeader[0].words8[1], byteHeader[0].words8[0]);
  header.cb = to_short(byteHeader[1].words8[3], byteHeader[1].words8[2]);
  header.size = to_short(byteHeader[1].words8[1], byteHeader[1].words8[0]);
  */
}



void
manager_CTRL(hls::stream<float> &buffer_histIN, unsigned int callCount_histIN,
	     hls::stream<unsigned int> &callTime_histIN,
	     hls::stream<float> &expect_histOUT,
	     unsigned int callCount_histOUT, hls::stream<unsigned int> &callTime_histOUT,
	     unsigned int failCount_histOUT, hls::stream<tfail> &fail_histOUT,
	     unsigned int &intervalDelay_histOUT)
{
  getRequestHead_CTRL();

  
  if (ID_DOUBLE1_CTRL == header_CTRL.objectID){
    //  if (ID_histINdd == header.methodID_flags){
    if (ID_DOUBLE1_CTRL_return == header_CTRL.methodID){
      running_DOUBLE1_CTRL_return(bufferIN_CTRL, buffer_histIN, header_CTRL.size);
      buildResponseHead_CTRL(bufferOUT_CTRL, ID_DOUBLE1_CTRL, 0,
			     FLAG_RESPONSE|FLAG_OK);
    }
    else if (ID_DOUBLE1_CTRL_callCount == header_CTRL.methodID){
      running_DOUBLE1_CTRL_callCount(bufferRESP_CTRL, callCount_histIN);
      buildResponse_CTRL(ID_DOUBLE1_CTRL, sizeof(ret_DOUBLE1_CTRL_callCount)/DOUBLE1_BUS_WIDTH_BYTES,
			 FLAG_HAS_PAYLOAD|FLAG_RESPONSE|FLAG_OK);
    }
    else if (ID_DOUBLE1_CTRL_callTime == header_CTRL.methodID){
      running_DOUBLE1_CTRL_callTime(bufferRESP_CTRL, callTime_histIN);
      buildResponse_CTRL(ID_DOUBLE1_CTRL, sizeof(ret_DOUBLE1_CTRL_callTime)/DOUBLE1_BUS_WIDTH_BYTES,
			 FLAG_HAS_PAYLOAD|FLAG_RESPONSE|FLAG_OK);
    }
    else{
      forward_CTRL(header_CTRL.size);
      buildResponseHead_CTRL(bufferOUT_CTRL, FLAG_FAIL, ID_DOUBLE1_CTRL, 
			     FLAG_RESPONSE|FLAG_FAIL);
    }
  }
  else if (ID_DOUBLE2_CTRL == header_CTRL.objectID)
    //  if (ID_histINdd == header.methodID_flags){
    if (ID_DOUBLE2_CTRL_expect == header_CTRL.methodID){
      running_DOUBLE2_CTRL_expect(bufferIN_CTRL, expect_histOUT, header_CTRL.size);
      buildResponseHead_CTRL(bufferOUT_CTRL, ID_DOUBLE2_CTRL, 0,
			     FLAG_RESPONSE|FLAG_OK);
    }
    else if (ID_DOUBLE2_CTRL_callCount == header_CTRL.methodID){
      running_DOUBLE2_CTRL_callCount(bufferRESP_CTRL, callCount_histOUT);
      buildResponse_CTRL(ID_DOUBLE2_CTRL, sizeof(ret_DOUBLE2_CTRL_callCount)/DOUBLE2_BUS_WIDTH_BYTES,
			 FLAG_HAS_PAYLOAD|FLAG_RESPONSE|FLAG_OK);
    }
    else if (ID_DOUBLE2_CTRL_callTime == header_CTRL.methodID){
      running_DOUBLE2_CTRL_callTime(bufferRESP_CTRL, callTime_histOUT);
      buildResponse_CTRL(ID_DOUBLE2_CTRL, sizeof(ret_DOUBLE2_CTRL_callTime)/DOUBLE2_BUS_WIDTH_BYTES,
			 FLAG_HAS_PAYLOAD|FLAG_RESPONSE|FLAG_OK);
    }
    else if (ID_DOUBLE2_CTRL_failCount == header_CTRL.methodID){
      running_DOUBLE2_CTRL_failCount(bufferRESP_CTRL, failCount_histOUT);
      buildResponse_CTRL(ID_DOUBLE2_CTRL, sizeof(ret_DOUBLE2_CTRL_failCount)/DOUBLE2_BUS_WIDTH_BYTES,
			 FLAG_HAS_PAYLOAD|FLAG_RESPONSE|FLAG_OK);
    }
    else if (ID_DOUBLE2_CTRL_fail == header_CTRL.methodID){
      running_DOUBLE2_CTRL_fail(bufferRESP_CTRL, fail_histOUT);
      buildResponse_CTRL(ID_DOUBLE2_CTRL, sizeof(ret_DOUBLE2_CTRL_fail)/DOUBLE2_BUS_WIDTH_BYTES,
			 FLAG_HAS_PAYLOAD|FLAG_RESPONSE|FLAG_OK);
    }
    else if (ID_DOUBLE2_CTRL_intervalDelay == header_CTRL.methodID){
      running_DOUBLE2_CTRL_intervalDelay(bufferIN_CTRL, intervalDelay_histOUT);
      buildResponseHead_CTRL(bufferOUT_CTRL, ID_DOUBLE2_CTRL, 0,
			     FLAG_RESPONSE|FLAG_OK);
    }
    else{
      forward_CTRL(header_CTRL.size);
      buildResponseHead_CTRL(bufferOUT_CTRL, FLAG_FAIL, ID_DOUBLE2_CTRL, 
			     FLAG_RESPONSE|FLAG_FAIL);
    }
  else{
      forward_CTRL(header_CTRL.size);
      buildResponseHead_CTRL(bufferOUT_CTRL, FLAG_FAIL, NULL_OBJ, 
			     FLAG_RESPONSE|FLAG_FAIL);
  }
}


void
top_CTRL(hls::stream<unsigned int> &din,
	 hls::stream<unsigned int> &dout,
	 hls::stream<float> &buffer_histIN,
	 unsigned int  callCount_histIN,
	 hls::stream<unsigned int> &callTime_histIN,
	 hls::stream<float> &expect_histOUT,
	 unsigned int callCount_histOUT,
	 hls::stream<unsigned int> &callTime_histOUT,
	 int failCount_histOUT, hls::stream<tfail> &fail_histOUT,
	 unsigned int &intervalDelay_histOUT)
{
#pragma HLS INTERFACE ap_stable port=callCount_histIN
#pragma HLS INTERFACE ap_stable port=callCount_histOUT
#pragma HLS INTERFACE ap_stable port=failCount_histOUT
#pragma HLS data_pack variable=fail_histOUT
  //#pragma HLS INTERFACE ap_fifo port=fail_histOUT
  //#pragma HLS INTERFACE ap_fifo port=callTime_histOUT
  inputBuffer_CTRL(din);
  manager_CTRL(buffer_histIN, callCount_histIN, callTime_histIN,
		expect_histOUT, callCount_histOUT, callTime_histOUT,
		failCount_histOUT, fail_histOUT, intervalDelay_histOUT);
  outputBuffer_CTRL(dout);
}




#!/usr/bin/python
# -*- coding: utf-8; mode: python -*-

import sys
from hwt_proxy import sendMessage
from arm_casting_ieee754 import *


_hw_addr = 0x42000000

_l2norm_failurecount = 0
_l2norm_failurecount_vld = 0

_l2norm_callcountIN = 0
_l2norm_callcountIN_vld = 0

_l2norm_callcountOUT = 0
_l2norm_callcountOUT_vld = 0



def l2norm_intervalDelay(i):
    din = []
    din.extend(int_to_byte(i))
    head,payload = sendMessage(_hw_addr, 0x00030604, 0x00000001, din)
    
    
def l2norm_stimuli(size, i):      
    din = []
    for it in i:
        din.extend(int_to_byte(float_to_ieee754(it)))
    head,payload = sendMessage(_hw_addr, 0x00020104, size, din)

    
def l2norm_expect(size, o):      
    din = []
    for it in o:
        din.extend(int_to_byte(float_to_ieee754(it)))
    head,payload = sendMessage(_hw_addr, 0x00030104, size, din)

    
def l2norm_callCountInput():
    head,payload = sendMessage(_hw_addr, 0x00020200, 0x00000000, None)
    _l2norm_callcountIN = int(payload[0],16)
    _l2norm_callcountIN_vld = 1
    return _l2norm_callcountIN

    
def l2norm_callCountOutput():    
    head,payload = sendMessage(_hw_addr, 0x00030200, 0x00000000, None)
    _l2norm_callcountOUT = int(payload[0],16)
    _l2norm_callcountOUT_vld = 1
    return _l2norm_callcountOUT


def l2norm_failureCount():       
    head,payload = sendMessage(_hw_addr, 0x00030400, 0x00000000, None)
    _l2norm_failurecount = int(payload[0],16)
    _l2norm_failurecount_vld = 1
    return _l2norm_failurecount

  
def l2norm_print_failures():
    if _l2norm_failurecount_vld:
        failures = _l2norm_failurecount;
    else:
        failures = l2norm_failureCount();

    if failures == 0:
        print("{0}: No failures".format(sys._getframe().f_code.co_name))
    else:
        print("Failures - {0}".format(sys._getframe().f_code.co_name))
        for it in range(0,failures):
            head,payload = sendMessage(_hw_addr, 0x00030500, 0x00000000, None)
            callCount = int(payload[0],16)
            print ("\tcallCount {0}".format(callCount))
            actual = ieee754_to_float(payload[1])
            print ("\tActual {0}".format(actual))
            expected = ieee754_to_float(payload[2])
            print ("\tExpected {0}".format(expected))
            time = int(payload[3],16)
            print ("\tTime {0}".format(time))
            delay = int(payload[4],16)
            print ("\tDelay {0}".format(delay))


def l2norm_print_inputTimes():
    if _l2norm_callcountIN_vld:
        readings = _l2norm_callcountIN;
    else:
        readings = l2norm_callCountInput();

    if readings == 0:
        print("{0}: No readings".format(sys._getframe().f_code.co_name))
    else:
        print("Readings - {0}".format(sys._getframe().f_code.co_name))
        for it in range(0,readings):
            head,payload = sendMessage(_hw_addr, 0x00020300, 0x00000000, None)
            time = int(payload[0],16)
            print ("\tTime {0}: {1}".format(it, time))

            
def l2norm_print_outputTimes():
    if _l2norm_callcountOUT_vld:
        writings = _l2norm_callcountOUT;
    else:
        writings = l2norm_callCountOutput();

    if writings == 0:
        print("{0}: No writings".format(sys._getframe().f_code.co_name))
    else:
        print("Writings - {0}".format(sys._getframe().f_code.co_name))
        for it in range(0,writings):
            head,payload = sendMessage(_hw_addr, 0x00030300, 0x00000000, None)
            time = int(payload[0],16)
            print ("\tTime {0}: {1}".format(it, time))
      



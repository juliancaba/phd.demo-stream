#!/usr/bin/python
# -*- coding: utf-8; mode: python -*-

import sys
from hwt_proxy import FPGA_hwtClient
from arm_casting_ieee754 import *


_hw_addr = 0x42000000

_scale2_failurecount = 0
_scale2_failurecount_vld = 0

_scale2_callcount = 0
_scale2_callcount_vld = 0



def l2norm_intervalDelay(i):      
    din = []
    din.extend(int_to_byte(0x00030604))
    din.extend(int_to_byte(0x00000001))
    din.extend(int_to_byte(i))

    testCli = FPGA_hwtClient()
    testCli.arguments(_hw_addr, din)
    testCli.main([None])
    dout = testCli.result()
    idout = charSeq_to_intSeq(dout)

    head1 = idout[0]

    del testCli
    del idout


def l2norm_stimuli(size, i):      
    din = []
    din.extend(int_to_byte(0x00020104))
    din.extend(int_to_byte(size))
    for it in i:
        din.extend(int_to_byte(float_to_ieee754(it)))

    testCli = FPGA_hwtClient()
    testCli.arguments(_hw_addr, din)
    testCli.main([None])
    dout = testCli.result()
    idout = charSeq_to_intSeq(dout)

    head1 = idout[0]

    del testCli
    del idout

    
def l2norm_expect(size, o):      
    din = []
    din.extend(int_to_byte(0x00020204))
    din.extend(int_to_byte(size))
    for it in o:
        din.extend(int_to_byte(float_to_ieee754(it)))

    testCli = FPGA_hwtClient()
    testCli.arguments(_hw_addr, din)
    testCli.main([None])
    dout = testCli.result()
    idout = charSeq_to_intSeq(dout)

    head1 = idout[0]

    del testCli
    del idout

    
def l2norm_callCountInput():      
    din = []
    din.extend(int_to_byte(0x00020200))
    din.extend(int_to_byte(0x00000000))

    testCli = FPGA_hwtClient()
    testCli.arguments(_hw_addr, din)
    testCli.main([None])
    dout = testCli.result()
    idout = charSeq_to_intSeq(dout)

    head1 = idout[0]
    head2 = idout[1]
    _callcountInput = idout[2]
        
    del testCli
    del idout
    return _callcountInput

    
def l2norm_callCountOutput():      
    din = []
    din.extend(int_to_byte(0x00030200))
    din.extend(int_to_byte(0x00000000))

    testCli = FPGA_hwtClient()
    testCli.arguments(_hw_addr, din)
    testCli.main([None])
    dout = testCli.result()
    idout = charSeq_to_intSeq(dout)

    head1 = idout[0]
    head2 = idout[1]
    _callcountOutput = idout[2]
        
    del testCli
    del idout
    return _callcountOutput


def l2norm_failureCount():      
    din = []
    din.extend(int_to_byte(0x00030400))
    din.extend(int_to_byte(0x00000000))

    testCli = FPGA_hwtClient()
    testCli.arguments(_hw_addr, din)
    testCli.main([None])
    dout = testCli.result()
    idout = charSeq_to_intSeq(dout)

    head1 = idout[0]
    head2 = idout[1]
    _l2norm_failurecount = idout[2]
    _l2norm_failurecount_vld = 1
    
    del testCli
    del idout
    return _l2norm_failurecount

  
def l2norm_print_failures():
    if _l2norm_failurecount_vld:
        failures = _l2norm_failurecount;
    else:
        failures = l2norm_failureCount();

    if failures == 0:
        print("{0}: No failures\n").format(__name__)
    else:
        for it in (0,failures):
            din = []
            din.extend(int_to_byte(0x00030500))
            din.extend(int_to_byte(0x00000000))

            testCli = FPGA_hwtClient()
            testCli.arguments(_hw_addr, din)
            testCli.main([None])
            dout = testCli.result()
            idout = charSeq_to_intSeq(dout)

            head1 = idout[0]
            head2 = idout[1]
            callCount = idout[2]
            print ("\tcallCount {0}\n").format(callCount)
            actual = ieee754_to_float(idout[3])
            print ("\tActual {0}\n").format(actual)
            expected = ieee754_to_float(idout[4])
            print ("\tExpected {0}\n").format(expected)
            time = idout[5]
            print ("\tTime {0}\n").format(time)
            delay = idout[6]
            print ("\tDelay {0}\n").format(delay)

            del testCli
            del idout



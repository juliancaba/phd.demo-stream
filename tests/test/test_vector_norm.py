#!/usr/bin/python
# -*- coding: utf-8; mode: python -*-



import unittest
from unittest_time import TimeTestCase

from l2norm_stream import *


class TestL2Norm(TimeTestCase):

    def test_l2norm(self):
        ref = [0.0, 0.027164, 0.054328,
               0.081492, 0.108655, 0.135819,
               0.162983, 0.190147, 0.217311,
               0.244475, 0.271639, 0.298802,
               0.325966, 0.353130, 0.380294,
               0.407458];
        din = []
        for i in range(0,16):
            din.append(float(i))
            
        self.UNITTEST_TIME_RESET()
        self.CONFIGURE_UNITTEST_TIME_HW_ADDR(0x41000000)
        self.CONFIGURE_UNITTEST_TIME_INPUT_32BIT_WORDS(1)
        self.CONFIGURE_UNITTEST_TIME_OUTPUT_32BIT_WORDS(1)
        self.CONFIGURE_UNITTEST_TIME_ENABLE_CYCLES(0x00000090)
        
        l2norm_intervalDelay(6)
        l2norm_expect(16, ref)
        l2norm_stimuli(16, din)
          
        self.UNITTEST_TIME_CONFIGURE()
        
        self.assertTimeLT(200)
        
        print ("l2norm-CallCountInput {0}".format(l2norm_callCountInput()))
        print ("l2norm-CallCountOutput {0}".format(l2norm_callCountOutput()))
        print ("l2norm-FailureCount {0}".format(l2norm_failureCount()))
        l2norm_print_failures()

            
# if __name__ == '__main__':
#     unittest.main()
    

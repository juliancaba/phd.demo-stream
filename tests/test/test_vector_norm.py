#!/usr/bin/python
# -*- coding: utf-8; mode: python -*-



import unittest
from rc_unittest_remote import RCUnittestTestCase

from l2norm_stream import *


class TestL2Norm(RCUnittestTestCase):

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
            
        self.TEST_RESET()
        self.CONFIGURE_HW_ADDR(0x41000000)
        self.CONFIGURE_IGNORE_INPUT(1)
        self.CONFIGURE_IGNORE_OUTPUT(1)
        self.CONFIGURE_ENABLE_CYCLES(0x00000090)
        
        l2norm_intervalDelay(6)
        l2norm_expect(16, ref)
        l2norm_stimuli(16, din)
          
        self.TEST_CONFIGURE()
        
        self.assertTimeLT(200)
        
        print ("l2norm-CallCountInput {0}".format(l2norm_callCountInput()))
        print ("l2norm-CallCountOutput {0}".format(l2norm_callCountOutput()))
        print ("l2norm-FailureCount {0}".format(l2norm_failureCount()))
        l2norm_print_failures()

        #l2norm_print_inputTimes()
        #l2norm_print_outputTimes()

        self.assertTrue(l2norm_failureCount()==0)
            
# if __name__ == '__main__':
#     unittest.main()
    

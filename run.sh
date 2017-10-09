#!/bin/bash --
# -*- coding: utf-8; mode: shell-script; tab-width: 4 -*-

HW_SOURCES=src/all/src
TEST_DIR=tests
TEST_TYPE=STREAM
VERSION=2015
PLATFORM_VERSION=2015

echo "[INFO] Setup testing environment"
source /opt/Xilinx/Vivado/$VERSION.4/settings64.sh
cp -r /opt/hw_testing/platform_$PLATFORM_VERSION/ platform
mkdir logs
mkdir output

echo "[INFO] Getting HW sources"
cd src/all
make -f create.mk clean all VERSION=$VERSION #>> logs/hls_synth.log
cd -

echo "[INFO] Synthesis design - Partial bitstream"
python3 /opt/hw_testing/tools/hwt_genTCLDesignConfiguration.py $TEST_TYPE $HW_SOURCES $PLATFORM_VERSION platform
cd platform
make buildPartial #>> ../logs/synth.log
cd -

/opt/hw_testing/tools/write_factory_bitstreams -z platform/Bitstreams/new_core_pblock_dutArea_dpr_partial.bit output/partial.bit

echo "[INFO] Send partial bitstream to FPGA"
python3 /opt/hw_testing/tools/remoteDPR.py output/partial.bit

echo "[INFO] Running tests"
cd $TEST_DIR
make tests


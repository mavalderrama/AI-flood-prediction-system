#!/bin/bash
# Program the PL with a topann bitstream.
#
#   fpga.sh [bitstream.bit]      (default: ann.bit)
#
# A new bitstream starts with empty weight registers, and touching the IP
# registers while the PL is being reprogrammed can hang the AXI bus. So a
# running predictor is paused first, then resumed and told (SIGHUP) to reload
# its weights.
set -e
BIT=${1:-ann.bit}

pkill -STOP -x predictor.bin 2>/dev/null || true
cat "$BIT" > /dev/xdevcfg
echo "prog_done: $(cat /sys/class/xdevcfg/xdevcfg/device/prog_done)"
pkill -CONT -x predictor.bin 2>/dev/null || true
pkill -HUP -x predictor.bin 2>/dev/null || true

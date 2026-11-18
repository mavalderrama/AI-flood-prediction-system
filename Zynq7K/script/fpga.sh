#!/bin/sh
# Program the PL with a topann bitstream (installed as /usr/bin/topann-load).
#
#   topann-load [VARIANT | FILE]
#     VARIANT  WO-OPT (default), PIPELINE or FULL-PIPE
#              -> /lib/firmware/topann/topann-<VARIANT>.bit.bin
#     FILE     path to a bitstream
#
# Uses the Linux FPGA Manager (current kernels). The Zynq-7000 FPGA Manager
# needs the byte-swapped .bit.bin made by `bootgen -arch zynq
# -process_bitstream bin` (Vivado/build_hw.tcl does this). Falls back to the
# legacy /dev/xdevcfg interface of PetaLinux <= 2018.2 kernels.
#
# An AXI access to the IP while the PL is being reprogrammed (or after a
# failed reprogramming) stalls the bus. So running predictors are stopped
# first and resumed only if programming succeeded, or if the PL was never
# touched. After a failure they stay stopped until a later successful
# topann-load, or until someone kills them.
#
# The new bitstream starts with empty weight registers; flood-predictor
# notices that by itself and reloads them (ANN::ensure_weights).
set -eu

FW_DIR=${FW_DIR:-/lib/firmware}
FPGA_MGR=${FPGA_MGR:-/sys/class/fpga_manager/fpga0}
XDEVCFG=${XDEVCFG:-/dev/xdevcfg}
XDEVCFG_DONE=${XDEVCFG_DONE:-/sys/class/xdevcfg/xdevcfg/device/prog_done}
PREDICTORS="flood-predictor predictor.bin"

die() { echo "topann-load: $*" >&2; exit 1; }

arg=${1:-WO-OPT}
case "$arg" in
    */* | *.bin | *.bit) file=$arg ;;
    *) file=$FW_DIR/topann/topann-$arg.bit.bin ;;
esac
[ -f "$file" ] || die "bitstream not found: $file"

# Decide everything that can fail before stopping anyone.
if [ -d "$FPGA_MGR" ]; then
    method=fpga_manager
    case "$file" in
        *.bit) die "the Zynq FPGA Manager needs the byte-swapped .bit.bin made by" \
                   "'bootgen -arch zynq -process_bitstream bin', not $file" ;;
    esac
elif [ -c "$XDEVCFG" ]; then
    method=xdevcfg
else
    die "no FPGA Manager ($FPGA_MGR) and no $XDEVCFG"
fi

pids=""
for p in $PREDICTORS; do
    pids="$pids $(pgrep -x "$p" 2>/dev/null || true)"
done
pids=$(echo $pids)
staged=""
touched_pl=0
programmed=0

cleanup() {
    if [ -n "$staged" ]; then rm -f "$staged"; fi
    [ -n "$pids" ] || return 0
    if [ "$programmed" = 1 ] || [ "$touched_pl" = 0 ]; then
        kill -CONT $pids 2>/dev/null || true
    else
        echo "topann-load: the PL may be unconfigured; predictors left stopped (PIDs: $pids)." >&2
        echo "  Load a valid bitstream with topann-load (they resume then), or kill them." >&2
    fi
}
trap cleanup EXIT
# dash/ash skip the EXIT trap on an unhandled signal: route signals through exit.
trap 'exit 130' INT TERM HUP

if [ -n "$pids" ]; then kill -STOP $pids; fi

if [ "$method" = fpga_manager ]; then
    # The firmware loader takes a path relative to the firmware directory.
    case "$file" in
        "$FW_DIR"/*) rel=${file#"$FW_DIR"/} ;;
        *)
            staged=$FW_DIR/topann-load.$$.bit.bin
            cp "$file" "$staged" || die "cannot copy $file to $FW_DIR"
            rel=${staged#"$FW_DIR"/}
            ;;
    esac
    echo 0 > "$FPGA_MGR/flags" || die "cannot write $FPGA_MGR/flags"   # 0 = full bitstream
    touched_pl=1
    printf '%s' "$rel" > "$FPGA_MGR/firmware" || die "the FPGA Manager rejected $file (see dmesg)"
    state=$(cat "$FPGA_MGR/state")
    [ "$state" = operating ] || die "FPGA Manager state is '$state' (see dmesg)"
else
    touched_pl=1
    cat "$file" > "$XDEVCFG" || die "write to $XDEVCFG failed"
    [ "$(cat "$XDEVCFG_DONE")" = 1 ] || die "xdevcfg reports prog_done != 1"
fi

programmed=1
echo "topann-load: programmed $file"

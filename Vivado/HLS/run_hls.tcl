# Build the topann inference IP with Vitis HLS (AMD 2026.2 unified flow).
#
#   cd Vivado/HLS && vitis-run --mode hls --tcl run_hls.tcl
#
# Every variant is built from the same source and the same interface pragmas
# (in topann.cpp), so all bitstreams share one AXI-Lite register map and the
# Zynq driver works with any of them. Only loop directives differ.
# Do NOT add array_partition on the interface arrays: it changes the register map.
#
# Output per variant: component directory topann_<variant>/ with the packaged
# IP (component.xml), used by Vivado/build_hw.tcl.

set part       xc7z010clg400-1
set period     10
set ip_version 2.0

set variants {
    WO-OPT    {}
    PIPELINE  {
        set_directive_pipeline -II 1 "hidden_preact/hidden_mac"
        set_directive_pipeline -II 1 "topann/output_mac"
    }
    FULL-PIPE {
        set_directive_pipeline -II 1 "topann/hidden_loop"
        set_directive_pipeline -II 1 "topann/output_mac"
    }
}

set here [file normalize [file dirname [info script]]]
source [file join $here .. tcl common.tcl]   ;# find_files
cd $here

foreach {name directives} $variants {
    open_component -reset topann_$name -flow_target vivado
    set_top topann
    add_files topann.cpp
    add_files -tb tb_topann.cpp
    set_part $part
    create_clock -period $period -name default
    eval $directives
    csim_design
    csynth_design
    cosim_design
    export_design -format ip_catalog -version $ip_version \
        -display_name "topann $name" -description "Flood forecast MLP ($name)"
}

# All variants share the register map; publish the driver header from the first one.
set headers [find_files [file join $here topann_WO-OPT] xtopann_hw.h]
if {[llength $headers] == 0} {
    error "xtopann_hw.h not found under topann_WO-OPT; check the export_design output"
}
file copy -force [lindex $headers 0] [file join $here .. .. Zynq7K Software xtopann_hw.h]
puts "Copied [lindex $headers 0] to Zynq7K/Software/xtopann_hw.h"
exit

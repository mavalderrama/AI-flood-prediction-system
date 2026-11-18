# Build the topann inference IP with Vivado HLS 2017.4.
#
#   cd Vivado/HLS && vivado_hls -f run_hls.tcl
#
# Every solution is built from the same source and the same interface pragmas
# (in topann.cpp), so all bitstreams share one AXI-Lite register map and the
# Zynq driver works with any of them. Only loop directives differ.
# Do NOT add array_partition on the interface arrays: it changes the register map.

set part      xc7z010clg400-1
set period    10
set ip_version 2.0

open_project -reset topann_prj
set_top topann
add_files topann.cpp
add_files -tb tb_topann.cpp

set solutions {
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

foreach {name directives} $solutions {
    open_solution -reset $name
    set_part $part -tool vivado
    create_clock -period $period -name default
    eval $directives
    csim_design
    csynth_design
    cosim_design
    export_design -flow impl -rtl verilog -format ip_catalog \
        -version $ip_version -display_name "topann $name" -description "Flood forecast MLP ($name)"
}

# All solutions share the register map; publish the driver header from the first one.
file copy -force topann_prj/WO-OPT/.autopilot/db/driver/src/xtopann_hw.h ../../Zynq7K/Software/xtopann_hw.h
puts "Copied xtopann_hw.h to Zynq7K/Software/"
exit

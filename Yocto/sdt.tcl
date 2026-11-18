# Generate the System Device Tree (SDT) for EDF from the Vivado XSA.
# Run from the repository root:
#
#   sdtgen Yocto/sdt.tcl            (or: sdtgen, then `source Yocto/sdt.tcl`)
#
# Input:  Vivado/build/WO-OPT/topann_zybo.xsa   (Vivado/build_hw.tcl)
# Output: build/sdt/                             (for gen-machine-conf parse-sdt)
#
# All bitstream variants share the same PS configuration and address map, so
# one SDT serves every variant.
set_dt_param -xsa Vivado/build/WO-OPT/topann_zybo.xsa
set_dt_param -dir build/sdt
set_dt_param -user_dts Yocto/dts/topann-user.dtsi
generate_sdt

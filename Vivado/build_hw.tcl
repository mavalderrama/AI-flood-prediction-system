# Recreate the ZYBO hardware around the topann IP (AMD Vivado 2026.2) and
# export everything the EDF/Yocto flow and the board need.
#
#   vivado -mode batch -source Vivado/build_hw.tcl -tclargs [VARIANT]
#     VARIANT: WO-OPT (default), PIPELINE or FULL-PIPE
#              (HLS component built by Vivado/HLS/run_hls.tcl)
#
# Outputs:
#   Vivado/build/<VARIANT>/topann_zybo.xsa        hardware handoff for sdtgen / EDF
#   Zynq7K/bitstreams/topann-<VARIANT>.bit        for JTAG / BOOT.BIN
#   Zynq7K/bitstreams/topann-<VARIANT>.bit.bin    byte-swapped, for the Linux FPGA Manager
#
# The block design replaces the 2017 one: no S_AXI_ACP / SmartConnect (the IP
# has no AXI master any more), FCLK0 = 100 MHz (the HLS clock), and the IP
# instance TOPANN_0 at 0x43C00000 / 64K, which the driver and the device-tree
# fragment (Yocto/dts/topann-user.dtsi) expect.

set variant [expr {[llength $argv] > 0 ? [lindex $argv 0] : "WO-OPT"}]
set part    xc7z010clg400-1
set here    [file normalize [file dirname [info script]]]
set repo    [file normalize [file join $here ..]]
set build   [file join $here build $variant]
set bitdir  [file join $repo Zynq7K bitstreams]

source [file join $here tcl common.tcl]   ;# find_files

proc latest_vlnv {name} {
    set defs [get_ipdefs -all -filter "NAME == $name"]
    if {[llength $defs] == 0} { error "IP '$name' not found in the IP catalog" }
    return [lindex [lsort -dictionary $defs] end]
}

# ZYBO (rev B) PS7 settings, taken from the thesis block design (Digilent
# preset, 2017) and used when the Digilent board files are not installed.
proc zybo_ps7_config {} {
    set cfg [list \
        CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
        CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
        CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {50.000000} \
        CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {650} \
        CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K128M16 JT-125} \
        CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {525} \
        CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.176} \
        CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.159} \
        CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.162} \
        CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.187} \
        CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {-0.073} \
        CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {-0.034} \
        CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {-0.03} \
        CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {-0.082} \
        CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
        CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
        CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
        CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
        CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} \
        CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
        CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
        CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
        CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
        CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
        CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
        CONFIG.PCW_USB0_RESET_ENABLE {1} \
        CONFIG.PCW_USB0_RESET_IO {MIO 46} \
        CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
        CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
        CONFIG.PCW_SD0_GRP_CD_IO {MIO 47} \
        CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
        CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
        CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {100} \
        CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
        CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
    ]
    # MIO electrical settings: RGMII (16-27) is HSTL 1.8V; pull-ups only on
    # the GPIO pins; fast slew on QSPI, Ethernet, USB and SD.
    set pullup_on {0 9 10 11 12 13 14 15 46}
    for {set i 0} {$i < 54} {incr i} {
        if {$i >= 16 && $i <= 27} { lappend cfg CONFIG.PCW_MIO_${i}_IOTYPE {HSTL 1.8V} }
        lappend cfg CONFIG.PCW_MIO_${i}_PULLUP [expr {$i in $pullup_on ? "enabled" : "disabled"}]
        set fast [expr {($i >= 1 && $i <= 6) || $i == 8 || ($i >= 16 && $i <= 45)}]
        lappend cfg CONFIG.PCW_MIO_${i}_SLEW [expr {$fast ? "fast" : "slow"}]
    }
    return $cfg
}

# ------------------------------------------------------------------ HLS IP
set comps [find_files [file join $here HLS topann_$variant] component.xml]
if {[llength $comps] == 0} {
    error "No packaged IP for variant $variant. Run: cd Vivado/HLS && vitis-run --mode hls --tcl run_hls.tcl"
}
set ip_repo [file dirname [lindex $comps 0]]

# ------------------------------------------------------------------ project
create_project -force topann_zybo $build -part $part
set board [lindex [get_board_parts -quiet -latest_file_version {digilentinc.com:zybo:*}] 0]
if {$board ne ""} { set_property board_part $board [current_project] }
set_property ip_repo_paths [list $ip_repo] [current_project]
update_ip_catalog

create_bd_design zybo
set ps [create_bd_cell -type ip -vlnv [latest_vlnv processing_system7] ps7]
if {$board ne ""} {
    puts "Using board preset $board"
    apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 \
        -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable"} $ps
} else {
    puts "Digilent board files not installed: using the ZYBO PS7 settings from the thesis design"
    apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 \
        -config {make_external "FIXED_IO, DDR" apply_board_preset "0" Master "Disable" Slave "Disable"} $ps
    set_property -dict [zybo_ps7_config] $ps
}
set_property -dict [list \
    CONFIG.PCW_USE_M_AXI_GP0 {1} \
    CONFIG.PCW_USE_S_AXI_ACP {0} \
    CONFIG.PCW_USE_S_AXI_HP0 {0} \
    CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
    CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
    CONFIG.PCW_EN_CLK0_PORT {1} \
    CONFIG.PCW_EN_RST0_PORT {1} \
] $ps

set ann [create_bd_cell -type ip -vlnv [latest_vlnv topann] TOPANN_0]
set slave [get_bd_intf_pins -of_objects $ann -filter {MODE == Slave}]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config [list \
    Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} \
    Master {/ps7/M_AXI_GP0} Slave $slave intc_ip {New AXI Interconnect} master_apm {0}] $slave
# The IP is polled; its interrupt output is left unconnected.

assign_bd_address -offset 0x43C00000 -range 64K -force \
    -target_address_space [get_bd_addr_spaces ps7/Data] [get_bd_addr_segs -of_objects $slave]

validate_bd_design
save_bd_design

set wrapper [make_wrapper -files [get_files zybo.bd] -top]
add_files -norecurse $wrapper
set_property top zybo_wrapper [current_fileset]

# ------------------------------------------------------------------ implementation
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
if {[get_property PROGRESS [get_runs impl_1]] ne "100%"} {
    error "Implementation failed; see $build/topann_zybo.runs/impl_1"
}
# A run that misses timing still reaches 100% and writes a bitstream; on the
# board that shows up as occasional wrong results. Refuse to export it.
set wns [get_property STATS.WNS [get_runs impl_1]]
set whs [get_property STATS.WHS [get_runs impl_1]]
if {$wns eq "" || $whs eq "" || $wns < 0 || $whs < 0} {
    error "Timing not met for $variant at 100 MHz (WNS=$wns ns, WHS=$whs ns); no bitstream exported.\
           See $build/topann_zybo.runs/impl_1 timing reports."
}
puts "Timing met: WNS=$wns ns, WHS=$whs ns"
set bit [lindex [glob -directory [get_property DIRECTORY [get_runs impl_1]] *.bit] 0]

# ------------------------------------------------------------------ outputs
write_hw_platform -fixed -include_bit -force -file [file join $build topann_zybo.xsa]

file mkdir $bitdir
set out_bit [file join $bitdir topann-$variant.bit]
file copy -force $bit $out_bit

# Zynq-7000 FPGA Manager needs the byte-swapped .bin made by bootgen.
set bif [file join $build topann.bif]
set fh [open $bif w]
puts $fh "all:\n\{\n  $out_bit\n\}"
close $fh
# -ignorestderr: bootgen may print banners/warnings on stderr while succeeding;
# a failure is still caught through its exit status.
if {[catch {exec -ignorestderr bootgen -image $bif -arch zynq -process_bitstream bin -w on} msg]} {
    error "bootgen failed: $msg (it ships with Vivado; is the Vivado settings script sourced?)"
}
if {![file exists $out_bit.bin]} {
    set made [concat [glob -nocomplain *.bit.bin] [glob -nocomplain -directory $build *.bit.bin]]
    if {[llength $made] == 0} { error "bootgen did not produce a .bit.bin" }
    file rename -force [lindex $made 0] $out_bit.bin
}

puts "XSA:       [file join $build topann_zybo.xsa]"
puts "Bitstream: $out_bit"
puts "FPGA Mgr:  $out_bit.bin"

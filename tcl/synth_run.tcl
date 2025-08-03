#===============================================================================
# synth_run.tcl
#===============================================================================
# Usage:
#   dc_shell -f synth_run.tcl -x "set DESIGN_NAME mydesign; set VERILOG_FILE /path/to/mydesign.v"
#===============================================================================

# Check arguments
if {![info exists DESIGN_NAME] || ![info exists VERILOG_FILE]} {
    puts "ERROR: DESIGN_NAME and VERILOG_FILE must be set before sourcing this script."
    exit 1
}

#===============================================================================
# 1. Environment Setup
#===============================================================================
suppress_message {VER-130 LINT-1 LINT-28 LINT-29 LINT-31 LINT-32 LINT-33 LINT-52 LINT-99}

set search_path [list . \
    /home/net/local/SAED14nm_EDK_08_2024/SAED14nm_EDK_STD_RVT/liberty/nldm/base \
    /home/net/ru480013/Asplos/verilog]

set target_library "saed14rvt_base_tt0p8v25c.db"
set link_library [list * $target_library]
set symbol_library ""

set OUTPUT_DIR "./results/$DESIGN_NAME"

# Create result directory (no -p, correct Tcl usage)
if {![file exists $OUTPUT_DIR]} {
    file mkdir $OUTPUT_DIR
}

#===============================================================================
# 2. Read Design
#===============================================================================
puts "Reading design: $DESIGN_NAME"
read_verilog $VERILOG_FILE

# Check if design exists
if {[llength [get_designs $DESIGN_NAME]] == 0} {
    puts "ERROR: Verilog file does not contain module: $DESIGN_NAME"
    exit 1
}

current_design $DESIGN_NAME
link
check_design > ${OUTPUT_DIR}/check_design.rpt

#===============================================================================
# 3. Design Constraints
#===============================================================================
puts "Applying design constraints"
create_clock -name clk -period 0.625 [get_ports clk]
set_clock_uncertainty -setup 0.0625 [get_clocks clk]
set_clock_transition 0.03125 [get_clocks clk]
set_input_delay -clock clk -max 0.125 [all_inputs]
set_output_delay -clock clk -max 0.125 [all_outputs]
set_dont_touch_network [get_clocks clk]
set_driving_cell -lib_cell BUFX2_RVT -library $target_library [all_inputs]
set_load 0.003 [all_outputs]
set_max_area 0
set_max_fanout 20 $DESIGN_NAME
set_max_transition 0.1 $DESIGN_NAME

#===============================================================================
# 4. Compile Design
#===============================================================================
puts "Compiling design"
compile -map_effort medium

#===============================================================================
# 5. Generate Reports
#===============================================================================
puts "Generating reports"
report_timing -path full -delay max -max_paths 10 -nworst 1 > ${OUTPUT_DIR}/timing.rpt
report_timing -path full -delay min -max_paths 10 -nworst 1 > ${OUTPUT_DIR}/timing_hold.rpt
report_area -hierarchy -physical -designware > ${OUTPUT_DIR}/area_detailed.rpt
report_area -nosplit > ${OUTPUT_DIR}/area_summary.rpt
report_power -analysis_effort high -verbose > ${OUTPUT_DIR}/power_detailed.rpt
report_power -hierarchy > ${OUTPUT_DIR}/power_hierarchy.rpt
report_design > ${OUTPUT_DIR}/design.rpt
report_qor > ${OUTPUT_DIR}/qor.rpt
report_constraint -all_violators > ${OUTPUT_DIR}/constraint_violations.rpt
report_cell > ${OUTPUT_DIR}/cells.rpt
report_reference > ${OUTPUT_DIR}/references.rpt

#===============================================================================
# 6. Generate Summary Report
#===============================================================================
puts "Generating summary report"
set summary_file [open "${OUTPUT_DIR}/summary.txt" w]

puts $summary_file "================================================"
puts $summary_file " DESIGN SUMMARY: $DESIGN_NAME"
puts $summary_file "================================================"
puts $summary_file ""

# Timing
redirect -variable timing_slack {report_timing -delay max -nworst 1 -max_paths 1}
if {[regexp {slack \(.*\)\s+([-0-9.]+)} $timing_slack match slack_value]} {
    puts $summary_file "Worst Negative Slack (WNS): $slack_value ns"
} else {
    puts $summary_file "Worst Negative Slack (WNS): Unknown"
}

# Area
redirect -variable area_info {report_area -nosplit}
if {[regexp {Total cell area:\s+([-0-9.]+)} $area_info match total_area]} {
    puts $summary_file "Total Cell Area: $total_area µm^2"
}

# Power
redirect -variable power_info {report_power -nosplit}
if {[regexp {Total Power\s+=\s+([-0-9.]+)\s+(\w+)} $power_info match total_power total_unit]} {
    puts $summary_file "Total Power: $total_power $total_unit"
}

close $summary_file

#===============================================================================
# 7. Save Design
#===============================================================================
puts "Saving synthesized design"
write -hierarchy -format verilog -output ${OUTPUT_DIR}/${DESIGN_NAME}_synth.v
write -hierarchy -format ddc -output ${OUTPUT_DIR}/${DESIGN_NAME}.ddc
write_sdf ${OUTPUT_DIR}/${DESIGN_NAME}.sdf
write_sdc ${OUTPUT_DIR}/${DESIGN_NAME}.sdc

#===============================================================================
# 8. Done
#===============================================================================
puts "Synthesis complete for $DESIGN_NAME"
puts "Reports saved in: ${OUTPUT_DIR}/"
sh cat ${OUTPUT_DIR}/summary.txt

exit


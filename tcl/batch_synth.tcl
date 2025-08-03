#===============================================================================
# batch_synth.tcl
#===============================================================================
# 功能：批量对 /home/net/ru480013/Asplos/verilog 下的 .v 文件进行综合仿真
# 每个文件生成一个 ./Asplos/results/<module_name>/ 文件夹保存结果
#===============================================================================

# 配置路径
set verilog_dir "/home/net/ru480013/Asplos/verilog"
set tcl_script  "/home/net/ru480013/Asplos/tcl/synth_run.tcl"
set result_dir  "./results"

file mkdir $result_dir

# 遍历所有 .v 文件
foreach file_path [glob -nocomplain "$verilog_dir/*.v"] {
    set file_name   [file tail $file_path]
    set design_name [file rootname $file_name]

    puts "==============================================="
    puts "Running synthesis for design: $design_name"
    puts "Source file: $file_path"
    puts "==============================================="

    # 调用 dc_shell 对每个设计运行 synth_run.tcl
    set cmd "dc_shell -f $tcl_script -x \"set DESIGN_NAME $design_name; set VERILOG_FILE $file_path\""
    puts "Executing: $cmd"
    exec sh -c $cmd
}


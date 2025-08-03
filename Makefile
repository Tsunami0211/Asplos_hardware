#===============================================================================
# Makefile for running and cleaning Design Compiler synthesis
#===============================================================================

DC_SHELL = dc_shell
BATCH_TCL = ./tcl/batch_synth.tcl
RESULT_DIR = ./results

.PHONY: all run clean

# 默认目标：执行综合
all: run

# 执行批量综合
run:
	@echo "Starting Design Compiler synthesis for all .v files..."
	$(DC_SHELL) -f $(BATCH_TCL)
	@echo "All synthesis runs completed."

# 清理所有中间文件和结果文件
clean:
	@echo "Cleaning synthesis results and intermediate files..."
	# 清除 results 文件夹内容
	rm -rf $(RESULT_DIR)/*
	# 清除当前目录下的中间文件（不删 Makefile、verilog/、tcl/）
	rm -f *.log *.rpt *.sdf *.ddc *.v *.txt *.svf *.out *.summary
	@echo "All results and temporary files cleaned."


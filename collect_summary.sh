#!/bin/bash

RESULTS_DIR="/home/ruizhi/Desktop/Asplos/results"
OUTPUT_FILE="summary.csv"

# 写入 CSV 表头
echo "Design,Cell Count,Cell Area (um^2),Total Power (mW/uW),Critical Path Delay (ns)" > "$OUTPUT_FILE"

# 遍历每个结果子目录
for dir in "$RESULTS_DIR"/*/; do
    DESIGN_NAME=$(basename "$dir")

    AREA_FILE="$dir/area_summary.rpt"
    POWER_FILE="$dir/power_detailed.rpt"
    TIMING_FILE="$dir/timing.rpt"

    # 默认值
    CELL_COUNT="N/A"
    CELL_AREA="N/A"
    TOTAL_POWER="N/A"
    DELAY="N/A"

    # 提取 Cell Count 和 Area
    if [ -f "$AREA_FILE" ]; then
        CELL_COUNT=$(grep -i "Number of cells" "$AREA_FILE" | awk '{print $NF}')
        CELL_AREA=$(grep -i "Total cell area" "$AREA_FILE" | awk '{print $NF}')
    fi

    # 提取 Total Power（数字 + 单位，如 5.0425 mW 或 92.1 uW）
    if [ -f "$POWER_FILE" ]; then
        POWER_LINE=$(grep -i "Total Dynamic Power" "$POWER_FILE" | head -1)
        TOTAL_POWER=$(echo "$POWER_LINE" | sed -n 's/.*= *\([0-9.]* [mu]W\).*/\1/p')
    fi

    # 提取最大 Critical Path Delay
    if [ -f "$TIMING_FILE" ]; then
        DELAY=$(grep "data arrival time" "$TIMING_FILE" | awk '{print $NF}' | sort -nr | head -1)
    fi

    # 写入 CSV 一行
    echo "$DESIGN_NAME,$CELL_COUNT,$CELL_AREA,$TOTAL_POWER,$DELAY" >> "$OUTPUT_FILE"
done

echo "✅ Summary saved to $OUTPUT_FILE"


// XED Decoder 9 (Dual Group)
// 功能：对8个chip进行解码和错误检测/纠正
// 处理流程：
// 1. 使用两组64位异或进行错误检测
// 2. 如果检测到错误，使用CRC定位错误chip
// 3. 如果只有一个chip错误，使用异或恢复数据
// 4. 超过一个chip错误则无法修复

module xed_decoder_9 (
    clk,
    rst_n,
    data_valid,
    chip0_data,
    chip1_data,
    chip2_data,
    chip3_data,
    chip4_data,
    chip5_data,
    chip6_data,
    chip7_data,
    chip0_crc,
    chip1_crc,
    chip2_crc,
    chip3_crc,
    chip4_crc,
    chip5_crc,
    chip6_crc,
    chip7_crc,
    xor_parity_group0,
    xor_parity_group1,
    xor_parity_crc,
    decoded_data_valid,
    corrected_chip0_data,
    corrected_chip1_data,
    corrected_chip2_data,
    corrected_chip3_data,
    corrected_chip4_data,
    corrected_chip5_data,
    corrected_chip6_data,
    corrected_chip7_data,
    error_detected,
    error_corrected,
    uncorrectable_error,
    error_chip_id,
    xor_crc_error
);

    // 端口声明
    input clk;
    input rst_n;
    input data_valid;
    input [127:0] chip0_data;    // 16字节 = 128位
    input [127:0] chip1_data;
    input [127:0] chip2_data;
    input [127:0] chip3_data;
    input [127:0] chip4_data;
    input [127:0] chip5_data;
    input [127:0] chip6_data;
    input [127:0] chip7_data;
    input [7:0] chip0_crc;       // 每个chip的CRC校验码
    input [7:0] chip1_crc;
    input [7:0] chip2_crc;
    input [7:0] chip3_crc;
    input [7:0] chip4_crc;
    input [7:0] chip5_crc;
    input [7:0] chip6_crc;
    input [7:0] chip7_crc;
    input [63:0] xor_parity_group0;   // 第0组8字节异或校验值
    input [63:0] xor_parity_group1;   // 第1组8字节异或校验值
    input [7:0] xor_parity_crc;      // 异或值的CRC校验码
    
    output reg decoded_data_valid;
    output [127:0] corrected_chip0_data;  // 纠错后的数据
    output [127:0] corrected_chip1_data;
    output [127:0] corrected_chip2_data;
    output [127:0] corrected_chip3_data;
    output [127:0] corrected_chip4_data;
    output [127:0] corrected_chip5_data;
    output [127:0] corrected_chip6_data;
    output [127:0] corrected_chip7_data;
    output reg error_detected;           // 检测到错误
    output reg error_corrected;          // 错误已纠正
    output reg uncorrectable_error;      // 不可纠正错误
    output reg [2:0] error_chip_id;      // 错误chip编号
    output reg xor_crc_error;            // 异或CRC错误标志

    // 内部信号 - chip数据分组
    wire [63:0] chip0_group0, chip0_group1;
    wire [63:0] chip1_group0, chip1_group1;
    wire [63:0] chip2_group0, chip2_group1;
    wire [63:0] chip3_group0, chip3_group1;
    wire [63:0] chip4_group0, chip4_group1;
    wire [63:0] chip5_group0, chip5_group1;
    wire [63:0] chip6_group0, chip6_group1;
    wire [63:0] chip7_group0, chip7_group1;
    
    // 异或计算相关信号
    wire [63:0] calculated_xor_group0;
    wire [63:0] calculated_xor_group1;
    wire [63:0] xor_syndrome_group0;
    wire [63:0] xor_syndrome_group1;
    wire xor_error_detected_group0;
    wire xor_error_detected_group1;
    wire xor_error_detected;
    
    // CRC校验相关信号
    wire [7:0] chip0_calc_crc, chip1_calc_crc, chip2_calc_crc, chip3_calc_crc;
    wire [7:0] chip4_calc_crc, chip5_calc_crc, chip6_calc_crc, chip7_calc_crc;
    wire chip0_crc_error, chip1_crc_error, chip2_crc_error, chip3_crc_error;
    wire chip4_crc_error, chip5_crc_error, chip6_crc_error, chip7_crc_error;
    wire [7:0] crc_error_vector;
    wire [2:0] error_count;
    
    // 异或CRC校验信号
    wire [127:0] combined_xor_received;
    wire [7:0] calculated_xor_crc;
    wire xor_crc_error_internal;
    
    // 错误纠正相关信号
    reg [127:0] temp_corrected_data [0:7];
    reg [2:0] error_chip_index;
    wire error_correctable;
    
    // 提取每个chip的两组数据
    assign chip0_group0 = chip0_data[63:0];
    assign chip0_group1 = chip0_data[127:64];
    assign chip1_group0 = chip1_data[63:0];
    assign chip1_group1 = chip1_data[127:64];
    assign chip2_group0 = chip2_data[63:0];
    assign chip2_group1 = chip2_data[127:64];
    assign chip3_group0 = chip3_data[63:0];
    assign chip3_group1 = chip3_data[127:64];
    assign chip4_group0 = chip4_data[63:0];
    assign chip4_group1 = chip4_data[127:64];
    assign chip5_group0 = chip5_data[63:0];
    assign chip5_group1 = chip5_data[127:64];
    assign chip6_group0 = chip6_data[63:0];
    assign chip6_group1 = chip6_data[127:64];
    assign chip7_group0 = chip7_data[63:0];
    assign chip7_group1 = chip7_data[127:64];
    
    // 计算当前数据的异或值
    assign calculated_xor_group0 = chip0_group0 ^ chip1_group0 ^ chip2_group0 ^ chip3_group0 ^
                                  chip4_group0 ^ chip5_group0 ^ chip6_group0 ^ chip7_group0;
    
    assign calculated_xor_group1 = chip0_group1 ^ chip1_group1 ^ chip2_group1 ^ chip3_group1 ^
                                  chip4_group1 ^ chip5_group1 ^ chip6_group1 ^ chip7_group1;
    
    // 异或syndrome计算
    assign xor_syndrome_group0 = calculated_xor_group0 ^ xor_parity_group0;
    assign xor_syndrome_group1 = calculated_xor_group1 ^ xor_parity_group1;
    assign xor_error_detected_group0 = |xor_syndrome_group0;
    assign xor_error_detected_group1 = |xor_syndrome_group1;
    assign xor_error_detected = xor_error_detected_group0 || xor_error_detected_group1;
    
    // 异或CRC校验
    assign combined_xor_received = {xor_parity_group1, xor_parity_group0};
    assign xor_crc_error_internal = (calculated_xor_crc != xor_parity_crc);
    
    // CRC校验计算
    crc_atm_8bit crc_check0 (.data_in(chip0_data), .crc_out(chip0_calc_crc));
    crc_atm_8bit crc_check1 (.data_in(chip1_data), .crc_out(chip1_calc_crc));
    crc_atm_8bit crc_check2 (.data_in(chip2_data), .crc_out(chip2_calc_crc));
    crc_atm_8bit crc_check3 (.data_in(chip3_data), .crc_out(chip3_calc_crc));
    crc_atm_8bit crc_check4 (.data_in(chip4_data), .crc_out(chip4_calc_crc));
    crc_atm_8bit crc_check5 (.data_in(chip5_data), .crc_out(chip5_calc_crc));
    crc_atm_8bit crc_check6 (.data_in(chip6_data), .crc_out(chip6_calc_crc));
    crc_atm_8bit crc_check7 (.data_in(chip7_data), .crc_out(chip7_calc_crc));
    
    // 异或数据CRC校验
    crc_atm_8bit crc_xor_check (.data_in(combined_xor_received), .crc_out(calculated_xor_crc));
    
    // CRC错误检测
    assign chip0_crc_error = (chip0_calc_crc != chip0_crc);
    assign chip1_crc_error = (chip1_calc_crc != chip1_crc);
    assign chip2_crc_error = (chip2_calc_crc != chip2_crc);
    assign chip3_crc_error = (chip3_calc_crc != chip3_crc);
    assign chip4_crc_error = (chip4_calc_crc != chip4_crc);
    assign chip5_crc_error = (chip5_calc_crc != chip5_crc);
    assign chip6_crc_error = (chip6_calc_crc != chip6_crc);
    assign chip7_crc_error = (chip7_calc_crc != chip7_crc);
    
    assign crc_error_vector = {chip7_crc_error, chip6_crc_error, chip5_crc_error, chip4_crc_error,
                              chip3_crc_error, chip2_crc_error, chip1_crc_error, chip0_crc_error};
    
    // 计算错误chip数量
    assign error_count = chip0_crc_error + chip1_crc_error + chip2_crc_error + chip3_crc_error +
                        chip4_crc_error + chip5_crc_error + chip6_crc_error + chip7_crc_error;
    
    // 判断错误是否可纠正（只有一个chip错误）
    assign error_correctable = (error_count == 3'd1) && xor_error_detected;
    
    // 错误chip编号编码
    always @(crc_error_vector) begin
        case (crc_error_vector)
            8'b00000001: error_chip_index = 3'd0;
            8'b00000010: error_chip_index = 3'd1;
            8'b00000100: error_chip_index = 3'd2;
            8'b00001000: error_chip_index = 3'd3;
            8'b00010000: error_chip_index = 3'd4;
            8'b00100000: error_chip_index = 3'd5;
            8'b01000000: error_chip_index = 3'd6;
            8'b10000000: error_chip_index = 3'd7;
            default:     error_chip_index = 3'd0;
        endcase
    end
    
    // 错误纠正逻辑
    always @(chip0_data or chip1_data or chip2_data or chip3_data or 
             chip4_data or chip5_data or chip6_data or chip7_data or
             error_correctable or error_chip_index or xor_syndrome_group0 or xor_syndrome_group1) begin
        
        // 默认数据不变
        temp_corrected_data[0] = chip0_data;
        temp_corrected_data[1] = chip1_data;
        temp_corrected_data[2] = chip2_data;
        temp_corrected_data[3] = chip3_data;
        temp_corrected_data[4] = chip4_data;
        temp_corrected_data[5] = chip5_data;
        temp_corrected_data[6] = chip6_data;
        temp_corrected_data[7] = chip7_data;
        
        // 如果错误可纠正，使用异或syndrome纠正错误chip的数据
        if (error_correctable) begin
            case (error_chip_index)
                3'd0: begin
                    temp_corrected_data[0][63:0] = chip0_data[63:0] ^ xor_syndrome_group0;
                    temp_corrected_data[0][127:64] = chip0_data[127:64] ^ xor_syndrome_group1;
                end
                3'd1: begin
                    temp_corrected_data[1][63:0] = chip1_data[63:0] ^ xor_syndrome_group0;
                    temp_corrected_data[1][127:64] = chip1_data[127:64] ^ xor_syndrome_group1;
                end
                3'd2: begin
                    temp_corrected_data[2][63:0] = chip2_data[63:0] ^ xor_syndrome_group0;
                    temp_corrected_data[2][127:64] = chip2_data[127:64] ^ xor_syndrome_group1;
                end
                3'd3: begin
                    temp_corrected_data[3][63:0] = chip3_data[63:0] ^ xor_syndrome_group0;
                    temp_corrected_data[3][127:64] = chip3_data[127:64] ^ xor_syndrome_group1;
                end
                3'd4: begin
                    temp_corrected_data[4][63:0] = chip4_data[63:0] ^ xor_syndrome_group0;
                    temp_corrected_data[4][127:64] = chip4_data[127:64] ^ xor_syndrome_group1;
                end
                3'd5: begin
                    temp_corrected_data[5][63:0] = chip5_data[63:0] ^ xor_syndrome_group0;
                    temp_corrected_data[5][127:64] = chip5_data[127:64] ^ xor_syndrome_group1;
                end
                3'd6: begin
                    temp_corrected_data[6][63:0] = chip6_data[63:0] ^ xor_syndrome_group0;
                    temp_corrected_data[6][127:64] = chip6_data[127:64] ^ xor_syndrome_group1;
                end
                3'd7: begin
                    temp_corrected_data[7][63:0] = chip7_data[63:0] ^ xor_syndrome_group0;
                    temp_corrected_data[7][127:64] = chip7_data[127:64] ^ xor_syndrome_group1;
                end
                default: begin
                    // 不做修改
                end
            endcase
        end
    end
    
    // 输出纠正后的数据
    assign corrected_chip0_data = temp_corrected_data[0];
    assign corrected_chip1_data = temp_corrected_data[1];
    assign corrected_chip2_data = temp_corrected_data[2];
    assign corrected_chip3_data = temp_corrected_data[3];
    assign corrected_chip4_data = temp_corrected_data[4];
    assign corrected_chip5_data = temp_corrected_data[5];
    assign corrected_chip6_data = temp_corrected_data[6];
    assign corrected_chip7_data = temp_corrected_data[7];
    
    // 状态信号更新
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            decoded_data_valid <= 1'b0;
            error_detected <= 1'b0;
            error_corrected <= 1'b0;
            uncorrectable_error <= 1'b0;
            error_chip_id <= 3'd0;
            xor_crc_error <= 1'b0;
        end else begin
            decoded_data_valid <= data_valid;
            
            if (data_valid) begin
                error_detected <= xor_error_detected;
                error_corrected <= error_correctable;
                uncorrectable_error <= xor_error_detected && !error_correctable;
                error_chip_id <= error_chip_index;
                xor_crc_error <= xor_crc_error_internal;
            end else begin
                error_detected <= 1'b0;
                error_corrected <= 1'b0;
                uncorrectable_error <= 1'b0;
                error_chip_id <= 3'd0;
                xor_crc_error <= 1'b0;
            end
        end
    end

endmodule

// CRC-ATM 8位校验码计算模块（与编码器相同）
// 多项式: x^8 + x^2 + x + 1 (0x107)
module crc_atm_8bit (
    data_in,
    crc_out
);

    input [127:0] data_in;      // 16字节输入数据
    output [7:0] crc_out;       // 8位CRC输出

    // 内部信号
    reg [7:0] crc_reg;
    integer i;

    // CRC-ATM计算函数
    function [7:0] crc_atm_update;
        input [7:0] crc_current;
        input [7:0] data_byte;
        reg [7:0] temp;
        integer j;
        begin
            temp = crc_current ^ data_byte;
            for (j = 0; j < 8; j = j + 1) begin
                if (temp[7]) begin
                    temp = (temp << 1) ^ 8'h07;  // 多项式 x^8 + x^2 + x + 1
                end else begin
                    temp = temp << 1;
                end
            end
            crc_atm_update = temp;
        end
    endfunction

    // 组合逻辑计算CRC
    always @(data_in) begin
        crc_reg = 8'hFF;  // CRC-ATM初始值
        
        // 按字节处理，从高位到低位
        crc_reg = crc_atm_update(crc_reg, data_in[127:120]);
        crc_reg = crc_atm_update(crc_reg, data_in[119:112]);
        crc_reg = crc_atm_update(crc_reg, data_in[111:104]);
        crc_reg = crc_atm_update(crc_reg, data_in[103:96]);
        crc_reg = crc_atm_update(crc_reg, data_in[95:88]);
        crc_reg = crc_atm_update(crc_reg, data_in[87:80]);
        crc_reg = crc_atm_update(crc_reg, data_in[79:72]);
        crc_reg = crc_atm_update(crc_reg, data_in[71:64]);
        crc_reg = crc_atm_update(crc_reg, data_in[63:56]);
        crc_reg = crc_atm_update(crc_reg, data_in[55:48]);
        crc_reg = crc_atm_update(crc_reg, data_in[47:40]);
        crc_reg = crc_atm_update(crc_reg, data_in[39:32]);
        crc_reg = crc_atm_update(crc_reg, data_in[31:24]);
        crc_reg = crc_atm_update(crc_reg, data_in[23:16]);
        crc_reg = crc_atm_update(crc_reg, data_in[15:8]);
        crc_reg = crc_atm_update(crc_reg, data_in[7:0]);
    end

    assign crc_out = ~crc_reg;  // CRC-ATM最终取反

endmodule

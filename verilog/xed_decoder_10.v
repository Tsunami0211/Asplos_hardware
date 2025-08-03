// XED Decoder 10 (Enhanced with Weighted XOR)
// 功能：对8个chip进行解码和错误检测/纠正
// 处理流程：
// 1. 使用简单异或和加权异或进行错误检测
// 2. 如果检测到错误，使用CRC定位错误chip
// 3. 如果只有一个chip错误，使用简单异或恢复数据
// 4. 超过一个chip错误则无法修复

module xed_decoder_10 (
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
    weighted_xor_group0,
    weighted_xor_group1,
    simple_xor_crc,
    weighted_xor_crc,
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
    simple_xor_crc_error,
    weighted_xor_crc_error
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
    input [63:0] xor_parity_group0;   // 第0组8字节简单异或校验值
    input [63:0] xor_parity_group1;   // 第1组8字节简单异或校验值
    input [63:0] weighted_xor_group0; // 第0组8字节加权异或校验值
    input [63:0] weighted_xor_group1; // 第1组8字节加权异或校验值
    input [7:0] simple_xor_crc;      // 简单异或CRC校验码
    input [7:0] weighted_xor_crc;    // 加权异或CRC校验码
    
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
    output reg simple_xor_crc_error;     // 简单异或CRC错误标志
    output reg weighted_xor_crc_error;   // 加权异或CRC错误标志

    // 内部信号 - chip数据分组
    wire [63:0] chip0_group0, chip0_group1;
    wire [63:0] chip1_group0, chip1_group1;
    wire [63:0] chip2_group0, chip2_group1;
    wire [63:0] chip3_group0, chip3_group1;
    wire [63:0] chip4_group0, chip4_group1;
    wire [63:0] chip5_group0, chip5_group1;
    wire [63:0] chip6_group0, chip6_group1;
    wire [63:0] chip7_group0, chip7_group1;
    
    // 线性无关系数（与编码器相同）
    wire [7:0] weight_coeff0, weight_coeff1, weight_coeff2, weight_coeff3;
    wire [7:0] weight_coeff4, weight_coeff5, weight_coeff6, weight_coeff7;
    assign weight_coeff0 = 8'h01;  // α^0 = 1
    assign weight_coeff1 = 8'h02;  // α^1 = 2
    assign weight_coeff2 = 8'h04;  // α^2 = 4
    assign weight_coeff3 = 8'h08;  // α^3 = 8
    assign weight_coeff4 = 8'h10;  // α^4 = 16
    assign weight_coeff5 = 8'h20;  // α^5 = 32
    assign weight_coeff6 = 8'h40;  // α^6 = 64
    assign weight_coeff7 = 8'h80;  // α^7 = 128
    
    // 加权后的chip数据组
    wire [63:0] weighted_chip0_group0, weighted_chip0_group1;
    wire [63:0] weighted_chip1_group0, weighted_chip1_group1;
    wire [63:0] weighted_chip2_group0, weighted_chip2_group1;
    wire [63:0] weighted_chip3_group0, weighted_chip3_group1;
    wire [63:0] weighted_chip4_group0, weighted_chip4_group1;
    wire [63:0] weighted_chip5_group0, weighted_chip5_group1;
    wire [63:0] weighted_chip6_group0, weighted_chip6_group1;
    wire [63:0] weighted_chip7_group0, weighted_chip7_group1;
    
    // 异或计算相关信号
    wire [63:0] calculated_xor_group0;
    wire [63:0] calculated_xor_group1;
    wire [63:0] calculated_weighted_xor_group0;
    wire [63:0] calculated_weighted_xor_group1;
    wire [63:0] simple_xor_syndrome_group0;
    wire [63:0] simple_xor_syndrome_group1;
    wire [63:0] weighted_xor_syndrome_group0;
    wire [63:0] weighted_xor_syndrome_group1;
    wire simple_xor_error_detected_group0;
    wire simple_xor_error_detected_group1;
    wire weighted_xor_error_detected_group0;
    wire weighted_xor_error_detected_group1;
    wire simple_xor_error_detected;
    wire weighted_xor_error_detected;
    wire any_xor_error_detected;
    
    // CRC校验相关信号
    wire [7:0] chip0_calc_crc, chip1_calc_crc, chip2_calc_crc, chip3_calc_crc;
    wire [7:0] chip4_calc_crc, chip5_calc_crc, chip6_calc_crc, chip7_calc_crc;
    wire chip0_crc_error, chip1_crc_error, chip2_crc_error, chip3_crc_error;
    wire chip4_crc_error, chip5_crc_error, chip6_crc_error, chip7_crc_error;
    wire [7:0] crc_error_vector;
    wire [2:0] error_count;
    
    // 异或CRC校验信号
    wire [127:0] combined_simple_xor_received;
    wire [127:0] combined_weighted_xor_received;
    wire [7:0] calculated_simple_xor_crc;
    wire [7:0] calculated_weighted_xor_crc;
    wire simple_xor_crc_error_internal;
    wire weighted_xor_crc_error_internal;
    
    // 错误纠正相关信号
    reg [127:0] temp_corrected_data0, temp_corrected_data1, temp_corrected_data2, temp_corrected_data3;
    reg [127:0] temp_corrected_data4, temp_corrected_data5, temp_corrected_data6, temp_corrected_data7;
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
    
    // 计算当前数据的简单异或值
    assign calculated_xor_group0 = chip0_group0 ^ chip1_group0 ^ chip2_group0 ^ chip3_group0 ^
                                  chip4_group0 ^ chip5_group0 ^ chip6_group0 ^ chip7_group0;
    
    assign calculated_xor_group1 = chip0_group1 ^ chip1_group1 ^ chip2_group1 ^ chip3_group1 ^
                                  chip4_group1 ^ chip5_group1 ^ chip6_group1 ^ chip7_group1;
    
    // 加权运算：每个chip的数据与对应的权重系数进行GF(256)乘法
    gf256_mult_64bit mult0_g0 (.data_in(chip0_group0), .coeff(weight_coeff0), .result(weighted_chip0_group0));
    gf256_mult_64bit mult0_g1 (.data_in(chip0_group1), .coeff(weight_coeff0), .result(weighted_chip0_group1));
    gf256_mult_64bit mult1_g0 (.data_in(chip1_group0), .coeff(weight_coeff1), .result(weighted_chip1_group0));
    gf256_mult_64bit mult1_g1 (.data_in(chip1_group1), .coeff(weight_coeff1), .result(weighted_chip1_group1));
    gf256_mult_64bit mult2_g0 (.data_in(chip2_group0), .coeff(weight_coeff2), .result(weighted_chip2_group0));
    gf256_mult_64bit mult2_g1 (.data_in(chip2_group1), .coeff(weight_coeff2), .result(weighted_chip2_group1));
    gf256_mult_64bit mult3_g0 (.data_in(chip3_group0), .coeff(weight_coeff3), .result(weighted_chip3_group0));
    gf256_mult_64bit mult3_g1 (.data_in(chip3_group1), .coeff(weight_coeff3), .result(weighted_chip3_group1));
    gf256_mult_64bit mult4_g0 (.data_in(chip4_group0), .coeff(weight_coeff4), .result(weighted_chip4_group0));
    gf256_mult_64bit mult4_g1 (.data_in(chip4_group1), .coeff(weight_coeff4), .result(weighted_chip4_group1));
    gf256_mult_64bit mult5_g0 (.data_in(chip5_group0), .coeff(weight_coeff5), .result(weighted_chip5_group0));
    gf256_mult_64bit mult5_g1 (.data_in(chip5_group1), .coeff(weight_coeff5), .result(weighted_chip5_group1));
    gf256_mult_64bit mult6_g0 (.data_in(chip6_group0), .coeff(weight_coeff6), .result(weighted_chip6_group0));
    gf256_mult_64bit mult6_g1 (.data_in(chip6_group1), .coeff(weight_coeff6), .result(weighted_chip6_group1));
    gf256_mult_64bit mult7_g0 (.data_in(chip7_group0), .coeff(weight_coeff7), .result(weighted_chip7_group0));
    gf256_mult_64bit mult7_g1 (.data_in(chip7_group1), .coeff(weight_coeff7), .result(weighted_chip7_group1));
    
    // 计算当前数据的加权异或值
    assign calculated_weighted_xor_group0 = weighted_chip0_group0 ^ weighted_chip1_group0 ^ weighted_chip2_group0 ^ weighted_chip3_group0 ^
                                           weighted_chip4_group0 ^ weighted_chip5_group0 ^ weighted_chip6_group0 ^ weighted_chip7_group0;
    
    assign calculated_weighted_xor_group1 = weighted_chip0_group1 ^ weighted_chip1_group1 ^ weighted_chip2_group1 ^ weighted_chip3_group1 ^
                                           weighted_chip4_group1 ^ weighted_chip5_group1 ^ weighted_chip6_group1 ^ weighted_chip7_group1;
    
    // 简单异或syndrome计算
    assign simple_xor_syndrome_group0 = calculated_xor_group0 ^ xor_parity_group0;
    assign simple_xor_syndrome_group1 = calculated_xor_group1 ^ xor_parity_group1;
    assign simple_xor_error_detected_group0 = |simple_xor_syndrome_group0;
    assign simple_xor_error_detected_group1 = |simple_xor_syndrome_group1;
    assign simple_xor_error_detected = simple_xor_error_detected_group0 || simple_xor_error_detected_group1;
    
    // 加权异或syndrome计算
    assign weighted_xor_syndrome_group0 = calculated_weighted_xor_group0 ^ weighted_xor_group0;
    assign weighted_xor_syndrome_group1 = calculated_weighted_xor_group1 ^ weighted_xor_group1;
    assign weighted_xor_error_detected_group0 = |weighted_xor_syndrome_group0;
    assign weighted_xor_error_detected_group1 = |weighted_xor_syndrome_group1;
    assign weighted_xor_error_detected = weighted_xor_error_detected_group0 || weighted_xor_error_detected_group1;
    
    // 任何异或错误检测
    assign any_xor_error_detected = simple_xor_error_detected || weighted_xor_error_detected;
    
    // 异或CRC校验
    assign combined_simple_xor_received = {xor_parity_group1, xor_parity_group0};
    assign combined_weighted_xor_received = {weighted_xor_group1, weighted_xor_group0};
    assign simple_xor_crc_error_internal = (calculated_simple_xor_crc != simple_xor_crc);
    assign weighted_xor_crc_error_internal = (calculated_weighted_xor_crc != weighted_xor_crc);
    
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
    crc_atm_8bit crc_simple_xor_check (.data_in(combined_simple_xor_received), .crc_out(calculated_simple_xor_crc));
    crc_atm_8bit crc_weighted_xor_check (.data_in(combined_weighted_xor_received), .crc_out(calculated_weighted_xor_crc));
    
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
    
    // 判断错误是否可纠正（只有一个chip错误且检测到异或错误）
    assign error_correctable = (error_count == 3'd1) && any_xor_error_detected;
    
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
    
    // 错误纠正逻辑（使用简单异或syndrome进行纠错）
    always @(chip0_data or chip1_data or chip2_data or chip3_data or 
             chip4_data or chip5_data or chip6_data or chip7_data or
             error_correctable or error_chip_index or simple_xor_syndrome_group0 or simple_xor_syndrome_group1) begin
        
        // 默认数据不变
        temp_corrected_data0 = chip0_data;
        temp_corrected_data1 = chip1_data;
        temp_corrected_data2 = chip2_data;
        temp_corrected_data3 = chip3_data;
        temp_corrected_data4 = chip4_data;
        temp_corrected_data5 = chip5_data;
        temp_corrected_data6 = chip6_data;
        temp_corrected_data7 = chip7_data;
        
        // 如果错误可纠正，使用简单异或syndrome纠正错误chip的数据
        if (error_correctable) begin
            case (error_chip_index)
                3'd0: begin
                    temp_corrected_data0[63:0] = chip0_data[63:0] ^ simple_xor_syndrome_group0;
                    temp_corrected_data0[127:64] = chip0_data[127:64] ^ simple_xor_syndrome_group1;
                end
                3'd1: begin
                    temp_corrected_data1[63:0] = chip1_data[63:0] ^ simple_xor_syndrome_group0;
                    temp_corrected_data1[127:64] = chip1_data[127:64] ^ simple_xor_syndrome_group1;
                end
                3'd2: begin
                    temp_corrected_data2[63:0] = chip2_data[63:0] ^ simple_xor_syndrome_group0;
                    temp_corrected_data2[127:64] = chip2_data[127:64] ^ simple_xor_syndrome_group1;
                end
                3'd3: begin
                    temp_corrected_data3[63:0] = chip3_data[63:0] ^ simple_xor_syndrome_group0;
                    temp_corrected_data3[127:64] = chip3_data[127:64] ^ simple_xor_syndrome_group1;
                end
                3'd4: begin
                    temp_corrected_data4[63:0] = chip4_data[63:0] ^ simple_xor_syndrome_group0;
                    temp_corrected_data4[127:64] = chip4_data[127:64] ^ simple_xor_syndrome_group1;
                end
                3'd5: begin
                    temp_corrected_data5[63:0] = chip5_data[63:0] ^ simple_xor_syndrome_group0;
                    temp_corrected_data5[127:64] = chip5_data[127:64] ^ simple_xor_syndrome_group1;
                end
                3'd6: begin
                    temp_corrected_data6[63:0] = chip6_data[63:0] ^ simple_xor_syndrome_group0;
                    temp_corrected_data6[127:64] = chip6_data[127:64] ^ simple_xor_syndrome_group1;
                end
                3'd7: begin
                    temp_corrected_data7[63:0] = chip7_data[63:0] ^ simple_xor_syndrome_group0;
                    temp_corrected_data7[127:64] = chip7_data[127:64] ^ simple_xor_syndrome_group1;
                end
            endcase
        end
    end
    
    // 输出纠正后的数据
    assign corrected_chip0_data = temp_corrected_data0;
    assign corrected_chip1_data = temp_corrected_data1;
    assign corrected_chip2_data = temp_corrected_data2;
    assign corrected_chip3_data = temp_corrected_data3;
    assign corrected_chip4_data = temp_corrected_data4;
    assign corrected_chip5_data = temp_corrected_data5;
    assign corrected_chip6_data = temp_corrected_data6;
    assign corrected_chip7_data = temp_corrected_data7;
    
    // 状态信号更新
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            decoded_data_valid <= 1'b0;
            error_detected <= 1'b0;
            error_corrected <= 1'b0;
            uncorrectable_error <= 1'b0;
            error_chip_id <= 3'd0;
            simple_xor_crc_error <= 1'b0;
            weighted_xor_crc_error <= 1'b0;
        end else begin
            decoded_data_valid <= data_valid;
            
            if (data_valid) begin
                error_detected <= any_xor_error_detected;
                error_corrected <= error_correctable;
                uncorrectable_error <= any_xor_error_detected && !error_correctable;
                error_chip_id <= error_chip_index;
                simple_xor_crc_error <= simple_xor_crc_error_internal;
                weighted_xor_crc_error <= weighted_xor_crc_error_internal;
            end else begin
                error_detected <= 1'b0;
                error_corrected <= 1'b0;
                uncorrectable_error <= 1'b0;
                error_chip_id <= 3'd0;
                simple_xor_crc_error <= 1'b0;
                weighted_xor_crc_error <= 1'b0;
            end
        end
    end

endmodule

// GF(256) 64位数据乘法器模块
// 对64位数据的每个字节与8位系数进行GF(256)乘法
module gf256_mult_64bit (
    data_in,
    coeff,
    result
);

    input [63:0] data_in;       // 8字节输入数据
    input [7:0] coeff;          // 8位乘法系数
    output [63:0] result;       // 8字节输出结果

    // 为每个字节实例化GF(256)乘法器
    gf256_mult_single mult_byte0 (.a(data_in[7:0]),   .b(coeff), .result(result[7:0]));
    gf256_mult_single mult_byte1 (.a(data_in[15:8]),  .b(coeff), .result(result[15:8]));
    gf256_mult_single mult_byte2 (.a(data_in[23:16]), .b(coeff), .result(result[23:16]));
    gf256_mult_single mult_byte3 (.a(data_in[31:24]), .b(coeff), .result(result[31:24]));
    gf256_mult_single mult_byte4 (.a(data_in[39:32]), .b(coeff), .result(result[39:32]));
    gf256_mult_single mult_byte5 (.a(data_in[47:40]), .b(coeff), .result(result[47:40]));
    gf256_mult_single mult_byte6 (.a(data_in[55:48]), .b(coeff), .result(result[55:48]));
    gf256_mult_single mult_byte7 (.a(data_in[63:56]), .b(coeff), .result(result[63:56]));

endmodule

// 单字节GF(256)乘法器
// 多项式: x^8 + x^4 + x^3 + x^2 + 1 (0x11D)
module gf256_mult_single (
    a,
    b,
    result
);

    input [7:0] a;
    input [7:0] b;
    output [7:0] result;

    reg [7:0] temp_result;
    reg [7:0] temp_a;
    integer i;

    always @(a or b) begin
        temp_result = 8'h00;
        temp_a = a;
        
        for (i = 0; i < 8; i = i + 1) begin
            if (b[i]) begin
                temp_result = temp_result ^ temp_a;
            end
            
            // 检查最高位，如果为1则需要模运算
            if (temp_a[7]) begin
                temp_a = (temp_a << 1) ^ 8'h1D;  // 本原多项式 0x11D 的低8位
            end else begin
                temp_a = temp_a << 1;
            end
        end
    end

    assign result = temp_result;

endmodule

// CRC-ATM 8位校验码计算模块
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

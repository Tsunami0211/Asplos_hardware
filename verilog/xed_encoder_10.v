// XED Encoder 10
// 功能：对8个chip进行编码处理
// 每个chip: 16字节数据
// 处理方式：
// 1. 每个chip的16字节生成1字节CRC-ATM校验码
// 2. 每个chip的16字节分成两组，每组8字节
// 3. 8个chip每一组的8字节按位异或生成两组异或值（简单异或）
// 4. 8个chip每一组的8字节与线性无关系数异或生成另外两组异或值（加权异或）
// 5. 四组异或值共32字节，分成两个16字节块，各自生成CRC-ATM校验码

module xed_encoder_10 (
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
    encoded_data_valid,
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
    weighted_xor_crc
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
    
    output reg encoded_data_valid;
    output [7:0] chip0_crc;      // 每个chip的CRC校验码
    output [7:0] chip1_crc;
    output [7:0] chip2_crc;
    output [7:0] chip3_crc;
    output [7:0] chip4_crc;
    output [7:0] chip5_crc;
    output [7:0] chip6_crc;
    output [7:0] chip7_crc;
    output [63:0] xor_parity_group0;     // 第0组8字节简单异或值
    output [63:0] xor_parity_group1;     // 第1组8字节简单异或值
    output [63:0] weighted_xor_group0;   // 第0组8字节加权异或值
    output [63:0] weighted_xor_group1;   // 第1组8字节加权异或值
    output [7:0] simple_xor_crc;         // 简单异或16字节的CRC校验码
    output [7:0] weighted_xor_crc;       // 加权异或16字节的CRC校验码

    // 内部信号 - 每个chip分成两组
    wire [63:0] chip0_group0, chip0_group1;
    wire [63:0] chip1_group0, chip1_group1;
    wire [63:0] chip2_group0, chip2_group1;
    wire [63:0] chip3_group0, chip3_group1;
    wire [63:0] chip4_group0, chip4_group1;
    wire [63:0] chip5_group0, chip5_group1;
    wire [63:0] chip6_group0, chip6_group1;
    wire [63:0] chip7_group0, chip7_group1;
    
    // 线性无关系数（Galois域中的本原元的幂次）
    wire [7:0] weight_coeff [0:7];
    assign weight_coeff[0] = 8'h01;  // α^0 = 1
    assign weight_coeff[1] = 8'h02;  // α^1 = 2
    assign weight_coeff[2] = 8'h04;  // α^2 = 4
    assign weight_coeff[3] = 8'h08;  // α^3 = 8
    assign weight_coeff[4] = 8'h10;  // α^4 = 16
    assign weight_coeff[5] = 8'h20;  // α^5 = 32
    assign weight_coeff[6] = 8'h40;  // α^6 = 64
    assign weight_coeff[7] = 8'h80;  // α^7 = 128
    
    // 加权后的chip数据组
    wire [63:0] weighted_chip0_group0, weighted_chip0_group1;
    wire [63:0] weighted_chip1_group0, weighted_chip1_group1;
    wire [63:0] weighted_chip2_group0, weighted_chip2_group1;
    wire [63:0] weighted_chip3_group0, weighted_chip3_group1;
    wire [63:0] weighted_chip4_group0, weighted_chip4_group1;
    wire [63:0] weighted_chip5_group0, weighted_chip5_group1;
    wire [63:0] weighted_chip6_group0, weighted_chip6_group1;
    wire [63:0] weighted_chip7_group0, weighted_chip7_group1;
    
    // 16字节数据组合信号
    wire [127:0] combined_simple_xor;
    wire [127:0] combined_weighted_xor;

    // 将每个chip的16字节分成两组，每组8字节
    assign chip0_group0 = chip0_data[63:0];      // 低8字节为第0组
    assign chip0_group1 = chip0_data[127:64];    // 高8字节为第1组
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

    // 简单异或：对8个chip的每一组进行按位异或
    assign xor_parity_group0 = chip0_group0 ^ chip1_group0 ^ chip2_group0 ^ chip3_group0 ^
                              chip4_group0 ^ chip5_group0 ^ chip6_group0 ^ chip7_group0;

    assign xor_parity_group1 = chip0_group1 ^ chip1_group1 ^ chip2_group1 ^ chip3_group1 ^
                              chip4_group1 ^ chip5_group1 ^ chip6_group1 ^ chip7_group1;

    // 加权运算：每个chip的数据与对应的权重系数进行GF(256)乘法
    gf256_mult_64bit mult0_g0 (.data_in(chip0_group0), .coeff(weight_coeff[0]), .result(weighted_chip0_group0));
    gf256_mult_64bit mult0_g1 (.data_in(chip0_group1), .coeff(weight_coeff[0]), .result(weighted_chip0_group1));
    gf256_mult_64bit mult1_g0 (.data_in(chip1_group0), .coeff(weight_coeff[1]), .result(weighted_chip1_group0));
    gf256_mult_64bit mult1_g1 (.data_in(chip1_group1), .coeff(weight_coeff[1]), .result(weighted_chip1_group1));
    gf256_mult_64bit mult2_g0 (.data_in(chip2_group0), .coeff(weight_coeff[2]), .result(weighted_chip2_group0));
    gf256_mult_64bit mult2_g1 (.data_in(chip2_group1), .coeff(weight_coeff[2]), .result(weighted_chip2_group1));
    gf256_mult_64bit mult3_g0 (.data_in(chip3_group0), .coeff(weight_coeff[3]), .result(weighted_chip3_group0));
    gf256_mult_64bit mult3_g1 (.data_in(chip3_group1), .coeff(weight_coeff[3]), .result(weighted_chip3_group1));
    gf256_mult_64bit mult4_g0 (.data_in(chip4_group0), .coeff(weight_coeff[4]), .result(weighted_chip4_group0));
    gf256_mult_64bit mult4_g1 (.data_in(chip4_group1), .coeff(weight_coeff[4]), .result(weighted_chip4_group1));
    gf256_mult_64bit mult5_g0 (.data_in(chip5_group0), .coeff(weight_coeff[5]), .result(weighted_chip5_group0));
    gf256_mult_64bit mult5_g1 (.data_in(chip5_group1), .coeff(weight_coeff[5]), .result(weighted_chip5_group1));
    gf256_mult_64bit mult6_g0 (.data_in(chip6_group0), .coeff(weight_coeff[6]), .result(weighted_chip6_group0));
    gf256_mult_64bit mult6_g1 (.data_in(chip6_group1), .coeff(weight_coeff[6]), .result(weighted_chip6_group1));
    gf256_mult_64bit mult7_g0 (.data_in(chip7_group0), .coeff(weight_coeff[7]), .result(weighted_chip7_group0));
    gf256_mult_64bit mult7_g1 (.data_in(chip7_group1), .coeff(weight_coeff[7]), .result(weighted_chip7_group1));

    // 加权异或：对加权后的数据进行异或
    assign weighted_xor_group0 = weighted_chip0_group0 ^ weighted_chip1_group0 ^ weighted_chip2_group0 ^ weighted_chip3_group0 ^
                                weighted_chip4_group0 ^ weighted_chip5_group0 ^ weighted_chip6_group0 ^ weighted_chip7_group0;

    assign weighted_xor_group1 = weighted_chip0_group1 ^ weighted_chip1_group1 ^ weighted_chip2_group1 ^ weighted_chip3_group1 ^
                                weighted_chip4_group1 ^ weighted_chip5_group1 ^ weighted_chip6_group1 ^ weighted_chip7_group1;

    // 将异或值组合为16字节数据块
    assign combined_simple_xor = {xor_parity_group1, xor_parity_group0};
    assign combined_weighted_xor = {weighted_xor_group1, weighted_xor_group0};

    // CRC-ATM计算模块实例化
    // 每个chip的CRC
    crc_atm_8bit crc0 (.data_in(chip0_data), .crc_out(chip0_crc));
    crc_atm_8bit crc1 (.data_in(chip1_data), .crc_out(chip1_crc));
    crc_atm_8bit crc2 (.data_in(chip2_data), .crc_out(chip2_crc));
    crc_atm_8bit crc3 (.data_in(chip3_data), .crc_out(chip3_crc));
    crc_atm_8bit crc4 (.data_in(chip4_data), .crc_out(chip4_crc));
    crc_atm_8bit crc5 (.data_in(chip5_data), .crc_out(chip5_crc));
    crc_atm_8bit crc6 (.data_in(chip6_data), .crc_out(chip6_crc));
    crc_atm_8bit crc7 (.data_in(chip7_data), .crc_out(chip7_crc));
    
    // 简单异或数据的CRC
    crc_atm_8bit crc_simple_xor (.data_in(combined_simple_xor), .crc_out(simple_xor_crc));
    
    // 加权异或数据的CRC
    crc_atm_8bit crc_weighted_xor (.data_in(combined_weighted_xor), .crc_out(weighted_xor_crc));

    // 输出有效信号控制
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            encoded_data_valid <= 1'b0;
        end else begin
            encoded_data_valid <= data_valid;
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

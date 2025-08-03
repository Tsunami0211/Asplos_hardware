// XED Encoder 9 (Modified with XOR CRC)
// 功能：对8个chip进行编码处理
// 每个chip: 16字节数据
// 处理方式：
// 1. 每个chip的16字节生成1字节CRC-ATM校验码
// 2. 每个chip的16字节分成两组，每组8字节
// 3. 8个chip每一组的8字节按位异或生成两组异或值，每组8字节
// 4. 两组异或值共16字节，生成1字节CRC-ATM校验码

module xed_encoder_9 (
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
    xor_parity_crc
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
    output [63:0] xor_parity_group0;  // 第0组8字节异或值
    output [63:0] xor_parity_group1;  // 第1组8字节异或值
    output [7:0] xor_parity_crc;      // 16字节异或值的CRC校验码

    // 内部信号 - 每个chip分成两组
    wire [63:0] chip0_group0, chip0_group1;
    wire [63:0] chip1_group0, chip1_group1;
    wire [63:0] chip2_group0, chip2_group1;
    wire [63:0] chip3_group0, chip3_group1;
    wire [63:0] chip4_group0, chip4_group1;
    wire [63:0] chip5_group0, chip5_group1;
    wire [63:0] chip6_group0, chip6_group1;
    wire [63:0] chip7_group0, chip7_group1;
    
    // 16字节异或数据组合信号
    wire [127:0] combined_xor_data;

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

    // 对8个chip的第0组进行按位异或
    assign xor_parity_group0 = chip0_group0 ^ chip1_group0 ^ chip2_group0 ^ chip3_group0 ^
                              chip4_group0 ^ chip5_group0 ^ chip6_group0 ^ chip7_group0;

    // 对8个chip的第1组进行按位异或
    assign xor_parity_group1 = chip0_group1 ^ chip1_group1 ^ chip2_group1 ^ chip3_group1 ^
                              chip4_group1 ^ chip5_group1 ^ chip6_group1 ^ chip7_group1;

    // 将两组异或值组合为16字节数据
    assign combined_xor_data = {xor_parity_group1, xor_parity_group0};

    // CRC-ATM计算模块实例化
    crc_atm_8bit crc0 (.data_in(chip0_data), .crc_out(chip0_crc));
    crc_atm_8bit crc1 (.data_in(chip1_data), .crc_out(chip1_crc));
    crc_atm_8bit crc2 (.data_in(chip2_data), .crc_out(chip2_crc));
    crc_atm_8bit crc3 (.data_in(chip3_data), .crc_out(chip3_crc));
    crc_atm_8bit crc4 (.data_in(chip4_data), .crc_out(chip4_crc));
    crc_atm_8bit crc5 (.data_in(chip5_data), .crc_out(chip5_crc));
    crc_atm_8bit crc6 (.data_in(chip6_data), .crc_out(chip6_crc));
    crc_atm_8bit crc7 (.data_in(chip7_data), .crc_out(chip7_crc));
    
    // 为16字节异或数据生成CRC校验码
    crc_atm_8bit crc_xor (.data_in(combined_xor_data), .crc_out(xor_parity_crc));

    // 输出有效信号控制
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            encoded_data_valid <= 1'b0;
        end else begin
            encoded_data_valid <= data_valid;
        end
    end

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

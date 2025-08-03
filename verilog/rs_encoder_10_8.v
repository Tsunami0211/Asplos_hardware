// Reed-Solomon RS(10,8) 编码器
// 输入：8个数据符号，每个符号8位 (64位总数据)
// 输出：10个编码符号，每个符号8位 (80位总编码数据)
// 生成多项式：g(x) = (x-α^0)(x-α^1) = x^2 + α^1*x + α^0
// 本原多项式：p(x) = x^8 + x^4 + x^3 + x^2 + 1 (0x11D)
// 本原元：α = 0x02

module rs_encoder_10_8 (
    input  clk,
    input  rst_n,
    input  start,                   // 开始编码信号
    input  [63:0] data_in,         // 8个数据符号 (8*8=64位)
    output [79:0] code_out,        // 10个编码符号 (10*8=80位)
    output reg valid_out           // 输出有效信号
);

    // 分离输入数据符号
    wire [7:0] data_symbols [0:7];
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : data_split
            assign data_symbols[i] = data_in[8*i+7:8*i];
        end
    endgenerate
    
    // 校验符号寄存器
    reg [7:0] parity_symbols [0:1];
    
    // 状态机
    reg [3:0] state;
    parameter IDLE = 4'd0;
    parameter ENCODE = 4'd1; 
    parameter DONE = 4'd2;
    
    // 编码计数器
    reg [2:0] encode_cnt;
    
    // GF(256) 乘法器模块实例
    wire [7:0] mult_a, mult_b, mult_result;
    wire [7:0] mult_a1, mult_result1;
    wire [7:0] mult_a2, mult_result2;
    
    // 两个乘法器用于并行计算
    gf256_mult mult1 (.a(mult_a1), .b(8'h02), .result(mult_result1)); // α^1 = 0x02
    gf256_mult mult2 (.a(mult_a2), .b(8'h01), .result(mult_result2)); // α^0 = 0x01
    
    // 编码逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            encode_cnt <= 3'd0;
            parity_symbols[0] <= 8'd0;
            parity_symbols[1] <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    valid_out <= 1'b0;
                    encode_cnt <= 3'd0;
                    parity_symbols[0] <= 8'd0;
                    parity_symbols[1] <= 8'd0;
                    if (start) begin
                        state <= ENCODE;
                    end
                end
                
                ENCODE: begin
                    if (encode_cnt < 8) begin
                        // 合成除法算法实现
                        // parity_symbols[1] = parity_symbols[1] ^ (data_symbols[7-encode_cnt] * α^1)
                        // parity_symbols[0] = parity_symbols[0] ^ (data_symbols[7-encode_cnt] * α^0)
                        
                        // 更新校验符号
                        parity_symbols[1] <= parity_symbols[1] ^ mult_result1;
                        parity_symbols[0] <= parity_symbols[0] ^ mult_result2;
                        
                        encode_cnt <= encode_cnt + 1;
                    end else begin
                        state <= DONE;
                        valid_out <= 1'b1;
                    end
                end
                
                DONE: begin
                    if (!start) begin
                        state <= IDLE;
                        valid_out <= 1'b0;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end
    
    // 乘法器输入连接
    assign mult_a1 = (state == ENCODE && encode_cnt < 8) ? 
                     (data_symbols[7-encode_cnt] ^ parity_symbols[1]) : 8'd0;
    assign mult_a2 = (state == ENCODE && encode_cnt < 8) ? 
                     (data_symbols[7-encode_cnt] ^ parity_symbols[1]) : 8'd0;
    
    // 输出码字构造：[数据符号][校验符号]
    assign code_out = {data_in, parity_symbols[1], parity_symbols[0]};

endmodule

// GF(256) 乘法器模块
// 使用本原多项式 p(x) = x^8 + x^4 + x^3 + x^2 + 1 (0x11D)
module gf256_mult (
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] result
);

    // 查找表方式实现GF乘法（节省资源）
    // 这里使用组合逻辑实现完整的GF(256)乘法
    wire [15:0] temp_mult;
    wire [7:0] reduced_result;
    
    // 普通二进制乘法
    assign temp_mult = a * b;
    
    // GF(256) 约简 - 使用本原多项式 0x11D
    wire [7:0] stage1, stage2, stage3, stage4, stage5, stage6, stage7;
    
    // 逐位约简
    assign stage1 = temp_mult[15] ? (temp_mult[14:7] ^ 8'h1D) : temp_mult[14:7];
    assign stage2 = temp_mult[14] ? (stage1 ^ 8'h1D) : stage1;
    assign stage3 = temp_mult[13] ? (stage2 ^ 8'h0E) : stage2; // 0x11D >> 1
    assign stage4 = temp_mult[12] ? (stage3 ^ 8'h07) : stage3; // 0x11D >> 2
    assign stage5 = temp_mult[11] ? (stage4 ^ 8'h83) : stage4; // 0x11D >> 3 with carry
    assign stage6 = temp_mult[10] ? (stage5 ^ 8'hC1) : stage5; // 0x11D >> 4 with carry
    assign stage7 = temp_mult[9]  ? (stage6 ^ 8'hE0) : stage6; // 0x11D >> 5 with carry
    
    assign reduced_result = temp_mult[8] ? (stage7 ^ 8'h70) : stage7; // 0x11D >> 6 with carry
    
    assign result = reduced_result ^ temp_mult[7:0];

endmodule

// 简化的GF(256)乘法器（查找表版本，更高效）
module gf256_mult_lut (
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] result
);

    // 预计算的部分乘法表（为了节省空间，这里只实现关键乘法）
    reg [7:0] mult_table [0:255];
    
    // 初始化乘法表（部分）
    initial begin
        // α^0 = 1 的乘法表
        mult_table[0] = 8'h00;
        mult_table[1] = 8'h01;
        mult_table[2] = 8'h02;
        mult_table[3] = 8'h03;
        // ... 完整的乘法表需要256个条目
        // 这里为了简化，使用通用乘法器
    end
    
    // 对于简单情况，直接使用组合逻辑
    assign result = (b == 8'h00) ? 8'h00 :
                   (b == 8'h01) ? a :
                   (b == 8'h02) ? gf_mult_by_2(a) :
                   gf_mult_generic(a, b);
    
    // GF(256)中乘以2的函数
    function [7:0] gf_mult_by_2;
        input [7:0] x;
        begin
            gf_mult_by_2 = (x[7]) ? ((x << 1) ^ 8'h1D) : (x << 1);
        end
    endfunction
    
    // 通用GF乘法函数（简化版）
    function [7:0] gf_mult_generic;
        input [7:0] x, y;
        reg [7:0] result_temp;
        integer i;
        begin
            result_temp = 8'h00;
            for (i = 0; i < 8; i = i + 1) begin
                if (y[i]) begin
                    result_temp = result_temp ^ x;
                end
                x = gf_mult_by_2(x);
            end
            gf_mult_generic = result_temp;
        end
    endfunction

endmodule

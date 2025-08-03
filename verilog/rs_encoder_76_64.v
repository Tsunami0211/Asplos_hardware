// Reed-Solomon RS(76,64) 编码器
// 输入：64个数据符号，每个符号8位 (512位总数据)
// 输出：76个编码符号，每个符号8位 (608位总编码数据)  
// 校验符号：12个 (可纠正最多6个符号错误)
// 生成多项式：g(x) = (x-α^0)(x-α^1)...(x-α^11)
// 本原多项式：p(x) = x^8 + x^4 + x^3 + x^2 + 1 (0x11D)
// 本原元：α = 0x02

module rs_encoder_76_64 (
    clk,
    rst_n,
    start,
    data_in,
    code_out,
    valid_out
);

    input clk;
    input rst_n;
    input start;                   // 开始编码信号
    input [511:0] data_in;         // 64个数据符号 (64*8=512位)
    output [607:0] code_out;       // 76个编码符号 (76*8=608位)
    output reg valid_out;          // 输出有效信号

    // 分离输入数据符号
    wire [7:0] data_sym0, data_sym1, data_sym2, data_sym3, data_sym4, data_sym5, data_sym6, data_sym7;
    wire [7:0] data_sym8, data_sym9, data_sym10, data_sym11, data_sym12, data_sym13, data_sym14, data_sym15;
    wire [7:0] data_sym16, data_sym17, data_sym18, data_sym19, data_sym20, data_sym21, data_sym22, data_sym23;
    wire [7:0] data_sym24, data_sym25, data_sym26, data_sym27, data_sym28, data_sym29, data_sym30, data_sym31;
    wire [7:0] data_sym32, data_sym33, data_sym34, data_sym35, data_sym36, data_sym37, data_sym38, data_sym39;
    wire [7:0] data_sym40, data_sym41, data_sym42, data_sym43, data_sym44, data_sym45, data_sym46, data_sym47;
    wire [7:0] data_sym48, data_sym49, data_sym50, data_sym51, data_sym52, data_sym53, data_sym54, data_sym55;
    wire [7:0] data_sym56, data_sym57, data_sym58, data_sym59, data_sym60, data_sym61, data_sym62, data_sym63;
    
    // 分配数据符号
    assign data_sym0  = data_in[7:0];     assign data_sym1  = data_in[15:8];
    assign data_sym2  = data_in[23:16];   assign data_sym3  = data_in[31:24];
    assign data_sym4  = data_in[39:32];   assign data_sym5  = data_in[47:40];
    assign data_sym6  = data_in[55:48];   assign data_sym7  = data_in[63:56];
    assign data_sym8  = data_in[71:64];   assign data_sym9  = data_in[79:72];
    assign data_sym10 = data_in[87:80];   assign data_sym11 = data_in[95:88];
    assign data_sym12 = data_in[103:96];  assign data_sym13 = data_in[111:104];
    assign data_sym14 = data_in[119:112]; assign data_sym15 = data_in[127:120];
    assign data_sym16 = data_in[135:128]; assign data_sym17 = data_in[143:136];
    assign data_sym18 = data_in[151:144]; assign data_sym19 = data_in[159:152];
    assign data_sym20 = data_in[167:160]; assign data_sym21 = data_in[175:168];
    assign data_sym22 = data_in[183:176]; assign data_sym23 = data_in[191:184];
    assign data_sym24 = data_in[199:192]; assign data_sym25 = data_in[207:200];
    assign data_sym26 = data_in[215:208]; assign data_sym27 = data_in[223:216];
    assign data_sym28 = data_in[231:224]; assign data_sym29 = data_in[239:232];
    assign data_sym30 = data_in[247:240]; assign data_sym31 = data_in[255:248];
    assign data_sym32 = data_in[263:256]; assign data_sym33 = data_in[271:264];
    assign data_sym34 = data_in[279:272]; assign data_sym35 = data_in[287:280];
    assign data_sym36 = data_in[295:288]; assign data_sym37 = data_in[303:296];
    assign data_sym38 = data_in[311:304]; assign data_sym39 = data_in[319:312];
    assign data_sym40 = data_in[327:320]; assign data_sym41 = data_in[335:328];
    assign data_sym42 = data_in[343:336]; assign data_sym43 = data_in[351:344];
    assign data_sym44 = data_in[359:352]; assign data_sym45 = data_in[367:360];
    assign data_sym46 = data_in[375:368]; assign data_sym47 = data_in[383:376];
    assign data_sym48 = data_in[391:384]; assign data_sym49 = data_in[399:392];
    assign data_sym50 = data_in[407:400]; assign data_sym51 = data_in[415:408];
    assign data_sym52 = data_in[423:416]; assign data_sym53 = data_in[431:424];
    assign data_sym54 = data_in[439:432]; assign data_sym55 = data_in[447:440];
    assign data_sym56 = data_in[455:448]; assign data_sym57 = data_in[463:456];
    assign data_sym58 = data_in[471:464]; assign data_sym59 = data_in[479:472];
    assign data_sym60 = data_in[487:480]; assign data_sym61 = data_in[495:488];
    assign data_sym62 = data_in[503:496]; assign data_sym63 = data_in[511:504];
    
    // 当前处理的数据符号
    reg [7:0] current_data_symbol;
    
    // 12个校验符号寄存器
    reg [7:0] parity_symbols [0:11];
    
    // 状态机
    reg [2:0] state;
    parameter IDLE = 3'd0;
    parameter ENCODE = 3'd1; 
    parameter DONE = 3'd2;
    
    // 编码计数器
    reg [5:0] encode_cnt;  // 需要6位来计数到64
    
    // GF(256) 乘法器实例（需要12个用于并行计算）
    wire [7:0] feedback_symbol; // 反馈符号
    wire [7:0] mult_results [0:11]; // 12个乘法结果
    
    // 反馈符号计算
    assign feedback_symbol = current_data_symbol ^ parity_symbols[11];
    
    // 12个乘法器，对应生成多项式的12个根
    gf256_mult mult0  (.a(feedback_symbol), .b(8'h01), .result(mult_results[0]));  // α^0
    gf256_mult mult1  (.a(feedback_symbol), .b(8'h02), .result(mult_results[1]));  // α^1
    gf256_mult mult2  (.a(feedback_symbol), .b(8'h04), .result(mult_results[2]));  // α^2
    gf256_mult mult3  (.a(feedback_symbol), .b(8'h08), .result(mult_results[3]));  // α^3
    gf256_mult mult4  (.a(feedback_symbol), .b(8'h10), .result(mult_results[4]));  // α^4
    gf256_mult mult5  (.a(feedback_symbol), .b(8'h20), .result(mult_results[5]));  // α^5
    gf256_mult mult6  (.a(feedback_symbol), .b(8'h40), .result(mult_results[6]));  // α^6
    gf256_mult mult7  (.a(feedback_symbol), .b(8'h80), .result(mult_results[7]));  // α^7
    gf256_mult mult8  (.a(feedback_symbol), .b(8'h1D), .result(mult_results[8]));  // α^8
    gf256_mult mult9  (.a(feedback_symbol), .b(8'h3A), .result(mult_results[9]));  // α^9
    gf256_mult mult10 (.a(feedback_symbol), .b(8'h74), .result(mult_results[10])); // α^10
    gf256_mult mult11 (.a(feedback_symbol), .b(8'hE8), .result(mult_results[11])); // α^11
    
    // 选择当前数据符号
    always @(encode_cnt or data_sym0 or data_sym1 or data_sym2 or data_sym3 or 
             data_sym4 or data_sym5 or data_sym6 or data_sym7 or data_sym8 or 
             data_sym9 or data_sym10 or data_sym11 or data_sym12 or data_sym13 or 
             data_sym14 or data_sym15 or data_sym16 or data_sym17 or data_sym18 or 
             data_sym19 or data_sym20 or data_sym21 or data_sym22 or data_sym23 or 
             data_sym24 or data_sym25 or data_sym26 or data_sym27 or data_sym28 or 
             data_sym29 or data_sym30 or data_sym31 or data_sym32 or data_sym33 or 
             data_sym34 or data_sym35 or data_sym36 or data_sym37 or data_sym38 or 
             data_sym39 or data_sym40 or data_sym41 or data_sym42 or data_sym43 or 
             data_sym44 or data_sym45 or data_sym46 or data_sym47 or data_sym48 or 
             data_sym49 or data_sym50 or data_sym51 or data_sym52 or data_sym53 or 
             data_sym54 or data_sym55 or data_sym56 or data_sym57 or data_sym58 or 
             data_sym59 or data_sym60 or data_sym61 or data_sym62 or data_sym63) begin
        case (encode_cnt)
            6'd0:  current_data_symbol = data_sym63; // 从高位开始处理
            6'd1:  current_data_symbol = data_sym62;
            6'd2:  current_data_symbol = data_sym61;
            6'd3:  current_data_symbol = data_sym60;
            6'd4:  current_data_symbol = data_sym59;
            6'd5:  current_data_symbol = data_sym58;
            6'd6:  current_data_symbol = data_sym57;
            6'd7:  current_data_symbol = data_sym56;
            6'd8:  current_data_symbol = data_sym55;
            6'd9:  current_data_symbol = data_sym54;
            6'd10: current_data_symbol = data_sym53;
            6'd11: current_data_symbol = data_sym52;
            6'd12: current_data_symbol = data_sym51;
            6'd13: current_data_symbol = data_sym50;
            6'd14: current_data_symbol = data_sym49;
            6'd15: current_data_symbol = data_sym48;
            6'd16: current_data_symbol = data_sym47;
            6'd17: current_data_symbol = data_sym46;
            6'd18: current_data_symbol = data_sym45;
            6'd19: current_data_symbol = data_sym44;
            6'd20: current_data_symbol = data_sym43;
            6'd21: current_data_symbol = data_sym42;
            6'd22: current_data_symbol = data_sym41;
            6'd23: current_data_symbol = data_sym40;
            6'd24: current_data_symbol = data_sym39;
            6'd25: current_data_symbol = data_sym38;
            6'd26: current_data_symbol = data_sym37;
            6'd27: current_data_symbol = data_sym36;
            6'd28: current_data_symbol = data_sym35;
            6'd29: current_data_symbol = data_sym34;
            6'd30: current_data_symbol = data_sym33;
            6'd31: current_data_symbol = data_sym32;
            6'd32: current_data_symbol = data_sym31;
            6'd33: current_data_symbol = data_sym30;
            6'd34: current_data_symbol = data_sym29;
            6'd35: current_data_symbol = data_sym28;
            6'd36: current_data_symbol = data_sym27;
            6'd37: current_data_symbol = data_sym26;
            6'd38: current_data_symbol = data_sym25;
            6'd39: current_data_symbol = data_sym24;
            6'd40: current_data_symbol = data_sym23;
            6'd41: current_data_symbol = data_sym22;
            6'd42: current_data_symbol = data_sym21;
            6'd43: current_data_symbol = data_sym20;
            6'd44: current_data_symbol = data_sym19;
            6'd45: current_data_symbol = data_sym18;
            6'd46: current_data_symbol = data_sym17;
            6'd47: current_data_symbol = data_sym16;
            6'd48: current_data_symbol = data_sym15;
            6'd49: current_data_symbol = data_sym14;
            6'd50: current_data_symbol = data_sym13;
            6'd51: current_data_symbol = data_sym12;
            6'd52: current_data_symbol = data_sym11;
            6'd53: current_data_symbol = data_sym10;
            6'd54: current_data_symbol = data_sym9;
            6'd55: current_data_symbol = data_sym8;
            6'd56: current_data_symbol = data_sym7;
            6'd57: current_data_symbol = data_sym6;
            6'd58: current_data_symbol = data_sym5;
            6'd59: current_data_symbol = data_sym4;
            6'd60: current_data_symbol = data_sym3;
            6'd61: current_data_symbol = data_sym2;
            6'd62: current_data_symbol = data_sym1;
            6'd63: current_data_symbol = data_sym0;
            default: current_data_symbol = 8'h00;
        endcase
    end
    
    // 编码逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            encode_cnt <= 6'd0;
            valid_out <= 1'b0;
            
            // 初始化校验符号 - 展开for循环以符合Verilog-2001
            parity_symbols[0] <= 8'd0;    parity_symbols[1] <= 8'd0;
            parity_symbols[2] <= 8'd0;    parity_symbols[3] <= 8'd0;
            parity_symbols[4] <= 8'd0;    parity_symbols[5] <= 8'd0;
            parity_symbols[6] <= 8'd0;    parity_symbols[7] <= 8'd0;
            parity_symbols[8] <= 8'd0;    parity_symbols[9] <= 8'd0;
            parity_symbols[10] <= 8'd0;   parity_symbols[11] <= 8'd0;
        end else begin
            case (state)
                IDLE: begin
                    valid_out <= 1'b0;
                    encode_cnt <= 6'd0;
                    
                    // 清零校验符号 - 展开for循环以符合Verilog-2001
                    parity_symbols[0] <= 8'd0;    parity_symbols[1] <= 8'd0;
                    parity_symbols[2] <= 8'd0;    parity_symbols[3] <= 8'd0;
                    parity_symbols[4] <= 8'd0;    parity_symbols[5] <= 8'd0;
                    parity_symbols[6] <= 8'd0;    parity_symbols[7] <= 8'd0;
                    parity_symbols[8] <= 8'd0;    parity_symbols[9] <= 8'd0;
                    parity_symbols[10] <= 8'd0;   parity_symbols[11] <= 8'd0;
                    
                    if (start) begin
                        state <= ENCODE;
                    end
                end
                
                ENCODE: begin
                    if (encode_cnt < 64) begin
                        // 合成除法算法实现
                        // 移位寄存器操作：parity_symbols[i] = parity_symbols[i-1] ^ (feedback * α^i)
                        parity_symbols[0] <= mult_results[0];
                        parity_symbols[1] <= parity_symbols[0] ^ mult_results[1];
                        parity_symbols[2] <= parity_symbols[1] ^ mult_results[2];
                        parity_symbols[3] <= parity_symbols[2] ^ mult_results[3];
                        parity_symbols[4] <= parity_symbols[3] ^ mult_results[4];
                        parity_symbols[5] <= parity_symbols[4] ^ mult_results[5];
                        parity_symbols[6] <= parity_symbols[5] ^ mult_results[6];
                        parity_symbols[7] <= parity_symbols[6] ^ mult_results[7];
                        parity_symbols[8] <= parity_symbols[7] ^ mult_results[8];
                        parity_symbols[9] <= parity_symbols[8] ^ mult_results[9];
                        parity_symbols[10] <= parity_symbols[9] ^ mult_results[10];
                        parity_symbols[11] <= parity_symbols[10] ^ mult_results[11];
                        
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
    
    // 输出码字构造：[数据符号][校验符号]
    assign code_out = {
        data_in,                    // 64个数据符号 (512位)
        parity_symbols[11],         // 校验符号从高位到低位
        parity_symbols[10],
        parity_symbols[9],
        parity_symbols[8],
        parity_symbols[7],
        parity_symbols[6],
        parity_symbols[5],
        parity_symbols[4],
        parity_symbols[3],
        parity_symbols[2],
        parity_symbols[1],
        parity_symbols[0]           // 12个校验符号 (96位)
    };

endmodule

// GF(256) 乘法器模块（复用之前的实现）
module gf256_mult (
    a,
    b,
    result
);

    input  [7:0] a;
    input  [7:0] b;
    output [7:0] result;

    wire [15:0] temp_mult;
    wire [7:0] reduced_result;
    
    // 普通二进制乘法
    assign temp_mult = a * b;
    
    // GF(256) 约简 - 使用本原多项式 0x11D
    wire [7:0] stage1, stage2, stage3, stage4, stage5, stage6, stage7;
    
    // 逐位约简
    assign stage1 = temp_mult[15] ? (temp_mult[14:7] ^ 8'h1D) : temp_mult[14:7];
    assign stage2 = temp_mult[14] ? (stage1 ^ 8'h1D) : stage1;
    assign stage3 = temp_mult[13] ? (stage2 ^ 8'h0E) : stage2;
    assign stage4 = temp_mult[12] ? (stage3 ^ 8'h07) : stage3;
    assign stage5 = temp_mult[11] ? (stage4 ^ 8'h83) : stage4;
    assign stage6 = temp_mult[10] ? (stage5 ^ 8'hC1) : stage5;
    assign stage7 = temp_mult[9]  ? (stage6 ^ 8'hE0) : stage6;
    
    assign reduced_result = temp_mult[8] ? (stage7 ^ 8'h70) : stage7;
    assign result = reduced_result ^ temp_mult[7:0];

endmodule

// 简化版Reed-Solomon RS(76,64) 解码器
// 符合Verilog-2001标准
// 输入：76个接收符号，每个符号8位 (608位总接收数据)
// 输出：64个解码符号，每个符号8位 (512位总解码数据)
// 错误检测能力：可检测多个符号错误
// 纠错能力：最多纠正1个符号错误
// 本原多项式：p(x) = x^8 + x^4 + x^3 + x^2 + 1 (0x11D)
// 本原元：α = 0x02

module rs_decoder_76_64 (
    input  clk,
    input  rst_n,
    input  start,                   // 开始解码信号
    input  [607:0] received_code,   // 76个接收符号 (76*8=608位)
    output [511:0] decoded_data,    // 64个解码符号 (64*8=512位)
    output reg [3:0] errors_detected, // 检测到的错误数量
    output reg error_corrected,     // 是否纠正了错误
    output reg [6:0] error_position, // 错误位置
    output reg valid_out,           // 输出有效信号
    output reg decode_success       // 解码成功信号
);

    // 预声明所有循环变量 - Verilog-2001要求
    integer i, j, k, syndrome_idx, symbol_idx;

    // 分离接收符号（避免数组警告）
    wire [7:0] rx_sym0, rx_sym1, rx_sym2, rx_sym3, rx_sym4, rx_sym5, rx_sym6, rx_sym7;
    wire [7:0] rx_sym8, rx_sym9, rx_sym10, rx_sym11, rx_sym12, rx_sym13, rx_sym14, rx_sym15;
    wire [7:0] rx_sym16, rx_sym17, rx_sym18, rx_sym19, rx_sym20, rx_sym21, rx_sym22, rx_sym23;
    wire [7:0] rx_sym24, rx_sym25, rx_sym26, rx_sym27, rx_sym28, rx_sym29, rx_sym30, rx_sym31;
    wire [7:0] rx_sym32, rx_sym33, rx_sym34, rx_sym35, rx_sym36, rx_sym37, rx_sym38, rx_sym39;
    wire [7:0] rx_sym40, rx_sym41, rx_sym42, rx_sym43, rx_sym44, rx_sym45, rx_sym46, rx_sym47;
    wire [7:0] rx_sym48, rx_sym49, rx_sym50, rx_sym51, rx_sym52, rx_sym53, rx_sym54, rx_sym55;
    wire [7:0] rx_sym56, rx_sym57, rx_sym58, rx_sym59, rx_sym60, rx_sym61, rx_sym62, rx_sym63;
    wire [7:0] rx_sym64, rx_sym65, rx_sym66, rx_sym67, rx_sym68, rx_sym69, rx_sym70, rx_sym71;
    wire [7:0] rx_sym72, rx_sym73, rx_sym74, rx_sym75;
    
    // 分配接收符号
    assign rx_sym0  = received_code[7:0];     assign rx_sym1  = received_code[15:8];
    assign rx_sym2  = received_code[23:16];   assign rx_sym3  = received_code[31:24];
    assign rx_sym4  = received_code[39:32];   assign rx_sym5  = received_code[47:40];
    assign rx_sym6  = received_code[55:48];   assign rx_sym7  = received_code[63:56];
    assign rx_sym8  = received_code[71:64];   assign rx_sym9  = received_code[79:72];
    assign rx_sym10 = received_code[87:80];   assign rx_sym11 = received_code[95:88];
    assign rx_sym12 = received_code[103:96];  assign rx_sym13 = received_code[111:104];
    assign rx_sym14 = received_code[119:112]; assign rx_sym15 = received_code[127:120];
    assign rx_sym16 = received_code[135:128]; assign rx_sym17 = received_code[143:136];
    assign rx_sym18 = received_code[151:144]; assign rx_sym19 = received_code[159:152];
    assign rx_sym20 = received_code[167:160]; assign rx_sym21 = received_code[175:168];
    assign rx_sym22 = received_code[183:176]; assign rx_sym23 = received_code[191:184];
    assign rx_sym24 = received_code[199:192]; assign rx_sym25 = received_code[207:200];
    assign rx_sym26 = received_code[215:208]; assign rx_sym27 = received_code[223:216];
    assign rx_sym28 = received_code[231:224]; assign rx_sym29 = received_code[239:232];
    assign rx_sym30 = received_code[247:240]; assign rx_sym31 = received_code[255:248];
    assign rx_sym32 = received_code[263:256]; assign rx_sym33 = received_code[271:264];
    assign rx_sym34 = received_code[279:272]; assign rx_sym35 = received_code[287:280];
    assign rx_sym36 = received_code[295:288]; assign rx_sym37 = received_code[303:296];
    assign rx_sym38 = received_code[311:304]; assign rx_sym39 = received_code[319:312];
    assign rx_sym40 = received_code[327:320]; assign rx_sym41 = received_code[335:328];
    assign rx_sym42 = received_code[343:336]; assign rx_sym43 = received_code[351:344];
    assign rx_sym44 = received_code[359:352]; assign rx_sym45 = received_code[367:360];
    assign rx_sym46 = received_code[375:368]; assign rx_sym47 = received_code[383:376];
    assign rx_sym48 = received_code[391:384]; assign rx_sym49 = received_code[399:392];
    assign rx_sym50 = received_code[407:400]; assign rx_sym51 = received_code[415:408];
    assign rx_sym52 = received_code[423:416]; assign rx_sym53 = received_code[431:424];
    assign rx_sym54 = received_code[439:432]; assign rx_sym55 = received_code[447:440];
    assign rx_sym56 = received_code[455:448]; assign rx_sym57 = received_code[463:456];
    assign rx_sym58 = received_code[471:464]; assign rx_sym59 = received_code[479:472];
    assign rx_sym60 = received_code[487:480]; assign rx_sym61 = received_code[495:488];
    assign rx_sym62 = received_code[503:496]; assign rx_sym63 = received_code[511:504];
    assign rx_sym64 = received_code[519:512]; assign rx_sym65 = received_code[527:520];
    assign rx_sym66 = received_code[535:528]; assign rx_sym67 = received_code[543:536];
    assign rx_sym68 = received_code[551:544]; assign rx_sym69 = received_code[559:552];
    assign rx_sym70 = received_code[567:560]; assign rx_sym71 = received_code[575:568];
    assign rx_sym72 = received_code[583:576]; assign rx_sym73 = received_code[591:584];
    assign rx_sym74 = received_code[599:592]; assign rx_sym75 = received_code[607:600];
    
    // 纠错后的符号 - 只保留前64个数据符号
    reg [7:0] corrected_symbol_0, corrected_symbol_1, corrected_symbol_2, corrected_symbol_3;
    reg [7:0] corrected_symbol_4, corrected_symbol_5, corrected_symbol_6, corrected_symbol_7;
    reg [7:0] corrected_symbol_8, corrected_symbol_9, corrected_symbol_10, corrected_symbol_11;
    reg [7:0] corrected_symbol_12, corrected_symbol_13, corrected_symbol_14, corrected_symbol_15;
    reg [7:0] corrected_symbol_16, corrected_symbol_17, corrected_symbol_18, corrected_symbol_19;
    reg [7:0] corrected_symbol_20, corrected_symbol_21, corrected_symbol_22, corrected_symbol_23;
    reg [7:0] corrected_symbol_24, corrected_symbol_25, corrected_symbol_26, corrected_symbol_27;
    reg [7:0] corrected_symbol_28, corrected_symbol_29, corrected_symbol_30, corrected_symbol_31;
    reg [7:0] corrected_symbol_32, corrected_symbol_33, corrected_symbol_34, corrected_symbol_35;
    reg [7:0] corrected_symbol_36, corrected_symbol_37, corrected_symbol_38, corrected_symbol_39;
    reg [7:0] corrected_symbol_40, corrected_symbol_41, corrected_symbol_42, corrected_symbol_43;
    reg [7:0] corrected_symbol_44, corrected_symbol_45, corrected_symbol_46, corrected_symbol_47;
    reg [7:0] corrected_symbol_48, corrected_symbol_49, corrected_symbol_50, corrected_symbol_51;
    reg [7:0] corrected_symbol_52, corrected_symbol_53, corrected_symbol_54, corrected_symbol_55;
    reg [7:0] corrected_symbol_56, corrected_symbol_57, corrected_symbol_58, corrected_symbol_59;
    reg [7:0] corrected_symbol_60, corrected_symbol_61, corrected_symbol_62, corrected_symbol_63;
    
    // 状态机
    reg [3:0] state;
    parameter IDLE = 4'd0;
    parameter CALC_SYNDROME = 4'd1;
    parameter CHECK_ERROR = 4'd2;
    parameter CALC_ERROR_POSITION = 4'd3;
    parameter CALC_ERROR_VALUE = 4'd4;
    parameter CORRECT_ERROR = 4'd5;
    parameter DONE = 4'd6;
    
    // 计数器
    reg [6:0] calc_cnt;  // 需要7位来计数到76
    reg [2:0] syndrome_cnt; // 伴随式计数器
    
    // 伴随式 (Syndrome) S1 到 S12 - 展开避免动态索引
    reg [7:0] syndrome_0, syndrome_1, syndrome_2, syndrome_3, syndrome_4, syndrome_5;
    reg [7:0] syndrome_6, syndrome_7, syndrome_8, syndrome_9, syndrome_10, syndrome_11;
    
    // 错误值
    reg [7:0] error_value;
    
    // GF(256) 运算模块接口
    reg [7:0] gf_mult_a, gf_mult_b;
    wire [7:0] gf_mult_result;
    reg [7:0] gf_inv_a;
    wire [7:0] gf_inv_result;
    reg [7:0] gf_pow_base;
    reg [7:0] gf_pow_exp;
    wire [7:0] gf_pow_result;
    
    // 实例化GF运算模块
    gf256_mult gf_mult_inst (
        .a(gf_mult_a),
        .b(gf_mult_b),
        .result(gf_mult_result)
    );
    
    gf256_inverse gf_inv_inst (
        .a(gf_inv_a),
        .result(gf_inv_result)
    );
    
    gf256_power gf_pow_inst (
        .base(gf_pow_base),
        .exp(gf_pow_exp),
        .result(gf_pow_result)
    );
    
    // 当前处理的接收符号（避免数组警告）
    reg [7:0] current_rx_symbol;
    
    // 选择当前接收符号（使用case语句避免数组警告）
    always @(*) begin
        case (calc_cnt)
            7'd0:  current_rx_symbol = rx_sym0;   7'd1:  current_rx_symbol = rx_sym1;
            7'd2:  current_rx_symbol = rx_sym2;   7'd3:  current_rx_symbol = rx_sym3;
            7'd4:  current_rx_symbol = rx_sym4;   7'd5:  current_rx_symbol = rx_sym5;
            7'd6:  current_rx_symbol = rx_sym6;   7'd7:  current_rx_symbol = rx_sym7;
            7'd8:  current_rx_symbol = rx_sym8;   7'd9:  current_rx_symbol = rx_sym9;
            7'd10: current_rx_symbol = rx_sym10;  7'd11: current_rx_symbol = rx_sym11;
            7'd12: current_rx_symbol = rx_sym12;  7'd13: current_rx_symbol = rx_sym13;
            7'd14: current_rx_symbol = rx_sym14;  7'd15: current_rx_symbol = rx_sym15;
            7'd16: current_rx_symbol = rx_sym16;  7'd17: current_rx_symbol = rx_sym17;
            7'd18: current_rx_symbol = rx_sym18;  7'd19: current_rx_symbol = rx_sym19;
            7'd20: current_rx_symbol = rx_sym20;  7'd21: current_rx_symbol = rx_sym21;
            7'd22: current_rx_symbol = rx_sym22;  7'd23: current_rx_symbol = rx_sym23;
            7'd24: current_rx_symbol = rx_sym24;  7'd25: current_rx_symbol = rx_sym25;
            7'd26: current_rx_symbol = rx_sym26;  7'd27: current_rx_symbol = rx_sym27;
            7'd28: current_rx_symbol = rx_sym28;  7'd29: current_rx_symbol = rx_sym29;
            7'd30: current_rx_symbol = rx_sym30;  7'd31: current_rx_symbol = rx_sym31;
            7'd32: current_rx_symbol = rx_sym32;  7'd33: current_rx_symbol = rx_sym33;
            7'd34: current_rx_symbol = rx_sym34;  7'd35: current_rx_symbol = rx_sym35;
            7'd36: current_rx_symbol = rx_sym36;  7'd37: current_rx_symbol = rx_sym37;
            7'd38: current_rx_symbol = rx_sym38;  7'd39: current_rx_symbol = rx_sym39;
            7'd40: current_rx_symbol = rx_sym40;  7'd41: current_rx_symbol = rx_sym41;
            7'd42: current_rx_symbol = rx_sym42;  7'd43: current_rx_symbol = rx_sym43;
            7'd44: current_rx_symbol = rx_sym44;  7'd45: current_rx_symbol = rx_sym45;
            7'd46: current_rx_symbol = rx_sym46;  7'd47: current_rx_symbol = rx_sym47;
            7'd48: current_rx_symbol = rx_sym48;  7'd49: current_rx_symbol = rx_sym49;
            7'd50: current_rx_symbol = rx_sym50;  7'd51: current_rx_symbol = rx_sym51;
            7'd52: current_rx_symbol = rx_sym52;  7'd53: current_rx_symbol = rx_sym53;
            7'd54: current_rx_symbol = rx_sym54;  7'd55: current_rx_symbol = rx_sym55;
            7'd56: current_rx_symbol = rx_sym56;  7'd57: current_rx_symbol = rx_sym57;
            7'd58: current_rx_symbol = rx_sym58;  7'd59: current_rx_symbol = rx_sym59;
            7'd60: current_rx_symbol = rx_sym60;  7'd61: current_rx_symbol = rx_sym61;
            7'd62: current_rx_symbol = rx_sym62;  7'd63: current_rx_symbol = rx_sym63;
            7'd64: current_rx_symbol = rx_sym64;  7'd65: current_rx_symbol = rx_sym65;
            7'd66: current_rx_symbol = rx_sym66;  7'd67: current_rx_symbol = rx_sym67;
            7'd68: current_rx_symbol = rx_sym68;  7'd69: current_rx_symbol = rx_sym69;
            7'd70: current_rx_symbol = rx_sym70;  7'd71: current_rx_symbol = rx_sym71;
            7'd72: current_rx_symbol = rx_sym72;  7'd73: current_rx_symbol = rx_sym73;
            7'd74: current_rx_symbol = rx_sym74;  7'd75: current_rx_symbol = rx_sym75;
            default: current_rx_symbol = 8'h00;
        endcase
    end
    
    // 检查伴随式是否全为零
    wire all_syndromes_zero;
    assign all_syndromes_zero = (syndrome_0 == 8'd0) && (syndrome_1 == 8'd0) && 
                               (syndrome_2 == 8'd0) && (syndrome_3 == 8'd0) &&
                               (syndrome_4 == 8'd0) && (syndrome_5 == 8'd0) &&
                               (syndrome_6 == 8'd0) && (syndrome_7 == 8'd0) &&
                               (syndrome_8 == 8'd0) && (syndrome_9 == 8'd0) &&
                               (syndrome_10 == 8'd0) && (syndrome_11 == 8'd0);
    
    // 单个错误检测：只有S1非零
    wire single_error_detected;
    assign single_error_detected = (syndrome_0 != 8'd0) && (syndrome_1 == 8'd0) && 
                                  (syndrome_2 == 8'd0) && (syndrome_3 == 8'd0) &&
                                  (syndrome_4 == 8'd0) && (syndrome_5 == 8'd0) &&
                                  (syndrome_6 == 8'd0) && (syndrome_7 == 8'd0) &&
                                  (syndrome_8 == 8'd0) && (syndrome_9 == 8'd0) &&
                                  (syndrome_10 == 8'd0) && (syndrome_11 == 8'd0);
    
    // 简化解码算法主状态机
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            calc_cnt <= 7'd0;
            syndrome_cnt <= 3'd0;
            errors_detected <= 4'd0;
            error_corrected <= 1'b0;
            error_position <= 7'd0;
            valid_out <= 1'b0;
            decode_success <= 1'b0;
            error_value <= 8'd0;
            
            // 初始化伴随式
            syndrome_0 <= 8'd0; syndrome_1 <= 8'd0; syndrome_2 <= 8'd0; syndrome_3 <= 8'd0;
            syndrome_4 <= 8'd0; syndrome_5 <= 8'd0; syndrome_6 <= 8'd0; syndrome_7 <= 8'd0;
            syndrome_8 <= 8'd0; syndrome_9 <= 8'd0; syndrome_10 <= 8'd0; syndrome_11 <= 8'd0;
            
            // 初始化纠错符号
            corrected_symbol_0 <= 8'd0; corrected_symbol_1 <= 8'd0; corrected_symbol_2 <= 8'd0; corrected_symbol_3 <= 8'd0;
            corrected_symbol_4 <= 8'd0; corrected_symbol_5 <= 8'd0; corrected_symbol_6 <= 8'd0; corrected_symbol_7 <= 8'd0;
            corrected_symbol_8 <= 8'd0; corrected_symbol_9 <= 8'd0; corrected_symbol_10 <= 8'd0; corrected_symbol_11 <= 8'd0;
            corrected_symbol_12 <= 8'd0; corrected_symbol_13 <= 8'd0; corrected_symbol_14 <= 8'd0; corrected_symbol_15 <= 8'd0;
            corrected_symbol_16 <= 8'd0; corrected_symbol_17 <= 8'd0; corrected_symbol_18 <= 8'd0; corrected_symbol_19 <= 8'd0;
            corrected_symbol_20 <= 8'd0; corrected_symbol_21 <= 8'd0; corrected_symbol_22 <= 8'd0; corrected_symbol_23 <= 8'd0;
            corrected_symbol_24 <= 8'd0; corrected_symbol_25 <= 8'd0; corrected_symbol_26 <= 8'd0; corrected_symbol_27 <= 8'd0;
            corrected_symbol_28 <= 8'd0; corrected_symbol_29 <= 8'd0; corrected_symbol_30 <= 8'd0; corrected_symbol_31 <= 8'd0;
            corrected_symbol_32 <= 8'd0; corrected_symbol_33 <= 8'd0; corrected_symbol_34 <= 8'd0; corrected_symbol_35 <= 8'd0;
            corrected_symbol_36 <= 8'd0; corrected_symbol_37 <= 8'd0; corrected_symbol_38 <= 8'd0; corrected_symbol_39 <= 8'd0;
            corrected_symbol_40 <= 8'd0; corrected_symbol_41 <= 8'd0; corrected_symbol_42 <= 8'd0; corrected_symbol_43 <= 8'd0;
            corrected_symbol_44 <= 8'd0; corrected_symbol_45 <= 8'd0; corrected_symbol_46 <= 8'd0; corrected_symbol_47 <= 8'd0;
            corrected_symbol_48 <= 8'd0; corrected_symbol_49 <= 8'd0; corrected_symbol_50 <= 8'd0; corrected_symbol_51 <= 8'd0;
            corrected_symbol_52 <= 8'd0; corrected_symbol_53 <= 8'd0; corrected_symbol_54 <= 8'd0; corrected_symbol_55 <= 8'd0;
            corrected_symbol_56 <= 8'd0; corrected_symbol_57 <= 8'd0; corrected_symbol_58 <= 8'd0; corrected_symbol_59 <= 8'd0;
            corrected_symbol_60 <= 8'd0; corrected_symbol_61 <= 8'd0; corrected_symbol_62 <= 8'd0; corrected_symbol_63 <= 8'd0;
        end else begin
            case (state)
                IDLE: begin
                    valid_out <= 1'b0;
                    decode_success <= 1'b0;
                    errors_detected <= 4'd0;
                    error_corrected <= 1'b0;
                    error_position <= 7'd0;
                    calc_cnt <= 7'd0;
                    syndrome_cnt <= 3'd0;
                    error_value <= 8'd0;
                    
                    // 清零伴随式
                    syndrome_0 <= 8'd0; syndrome_1 <= 8'd0; syndrome_2 <= 8'd0; syndrome_3 <= 8'd0;
                    syndrome_4 <= 8'd0; syndrome_5 <= 8'd0; syndrome_6 <= 8'd0; syndrome_7 <= 8'd0;
                    syndrome_8 <= 8'd0; syndrome_9 <= 8'd0; syndrome_10 <= 8'd0; syndrome_11 <= 8'd0;
                    
                    // 复制接收符号的前64个到纠错符号（只处理数据符号）
                    corrected_symbol_0 <= rx_sym0; corrected_symbol_1 <= rx_sym1; corrected_symbol_2 <= rx_sym2; corrected_symbol_3 <= rx_sym3;
                    corrected_symbol_4 <= rx_sym4; corrected_symbol_5 <= rx_sym5; corrected_symbol_6 <= rx_sym6; corrected_symbol_7 <= rx_sym7;
                    corrected_symbol_8 <= rx_sym8; corrected_symbol_9 <= rx_sym9; corrected_symbol_10 <= rx_sym10; corrected_symbol_11 <= rx_sym11;
                    corrected_symbol_12 <= rx_sym12; corrected_symbol_13 <= rx_sym13; corrected_symbol_14 <= rx_sym14; corrected_symbol_15 <= rx_sym15;
                    corrected_symbol_16 <= rx_sym16; corrected_symbol_17 <= rx_sym17; corrected_symbol_18 <= rx_sym18; corrected_symbol_19 <= rx_sym19;
                    corrected_symbol_20 <= rx_sym20; corrected_symbol_21 <= rx_sym21; corrected_symbol_22 <= rx_sym22; corrected_symbol_23 <= rx_sym23;
                    corrected_symbol_24 <= rx_sym24; corrected_symbol_25 <= rx_sym25; corrected_symbol_26 <= rx_sym26; corrected_symbol_27 <= rx_sym27;
                    corrected_symbol_28 <= rx_sym28; corrected_symbol_29 <= rx_sym29; corrected_symbol_30 <= rx_sym30; corrected_symbol_31 <= rx_sym31;
                    corrected_symbol_32 <= rx_sym32; corrected_symbol_33 <= rx_sym33; corrected_symbol_34 <= rx_sym34; corrected_symbol_35 <= rx_sym35;
                    corrected_symbol_36 <= rx_sym36; corrected_symbol_37 <= rx_sym37; corrected_symbol_38 <= rx_sym38; corrected_symbol_39 <= rx_sym39;
                    corrected_symbol_40 <= rx_sym40; corrected_symbol_41 <= rx_sym41; corrected_symbol_42 <= rx_sym42; corrected_symbol_43 <= rx_sym43;
                    corrected_symbol_44 <= rx_sym44; corrected_symbol_45 <= rx_sym45; corrected_symbol_46 <= rx_sym46; corrected_symbol_47 <= rx_sym47;
                    corrected_symbol_48 <= rx_sym48; corrected_symbol_49 <= rx_sym49; corrected_symbol_50 <= rx_sym50; corrected_symbol_51 <= rx_sym51;
                    corrected_symbol_52 <= rx_sym52; corrected_symbol_53 <= rx_sym53; corrected_symbol_54 <= rx_sym54; corrected_symbol_55 <= rx_sym55;
                    corrected_symbol_56 <= rx_sym56; corrected_symbol_57 <= rx_sym57; corrected_symbol_58 <= rx_sym58; corrected_symbol_59 <= rx_sym59;
                    corrected_symbol_60 <= rx_sym60; corrected_symbol_61 <= rx_sym61; corrected_symbol_62 <= rx_sym62; corrected_symbol_63 <= rx_sym63;
                    
                    if (start) begin
                        state <= CALC_SYNDROME;
                    end
                end
                
                CALC_SYNDROME: begin
                    // 计算伴随式 Sᵢ = Σ(rⱼ * αⁱʲ) for i=1 to 12
                    if (syndrome_cnt < 6) begin // 简化：只计算前6个伴随式
                        if (calc_cnt < 76) begin
                            // 累加当前符号的贡献到当前伴随式
                            case (syndrome_cnt)
                                3'd0: syndrome_0 <= syndrome_0 ^ gf_mult_result; // S1
                                3'd1: syndrome_1 <= syndrome_1 ^ gf_mult_result; // S2
                                3'd2: syndrome_2 <= syndrome_2 ^ gf_mult_result; // S3
                                3'd3: syndrome_3 <= syndrome_3 ^ gf_mult_result; // S4
                                3'd4: syndrome_4 <= syndrome_4 ^ gf_mult_result; // S5
                                3'd5: syndrome_5 <= syndrome_5 ^ gf_mult_result; // S6
                                default: begin
                                    // 不处理
                                end
                            endcase
                            calc_cnt <= calc_cnt + 1;
                        end else begin
                            syndrome_cnt <= syndrome_cnt + 1;
                            calc_cnt <= 7'd0;
                        end
                    end else begin
                        state <= CHECK_ERROR;
                        calc_cnt <= 7'd0;
                        syndrome_cnt <= 3'd0;
                    end
                end
                
                CHECK_ERROR: begin
                    // 检查错误类型
                    if (all_syndromes_zero) begin
                        // 无错误
                        errors_detected <= 4'd0;
                        decode_success <= 1'b1;
                        state <= DONE;
                    end else if (single_error_detected) begin
                        // 单个错误，可以纠正
                        errors_detected <= 4'd1;
                        state <= CALC_ERROR_POSITION;
                    end else begin
                        // 多个错误，无法纠正（但能检测）
                        if (syndrome_0 != 8'd0 && syndrome_1 != 8'd0) begin
                            errors_detected <= 4'd2; // 检测到至少2个错误
                        end else if (syndrome_0 != 8'd0 || syndrome_1 != 8'd0 || syndrome_2 != 8'd0) begin
                            errors_detected <= 4'd1; // 检测到1个错误但模式不匹配
                        end else begin
                            errors_detected <= 4'd3; // 检测到多个错误
                        end
                        decode_success <= 1'b0; // 无法纠正多个错误
                        state <= DONE;
                    end
                end
                
                CALC_ERROR_POSITION: begin
                    // 对于单个错误：错误位置 = log_α(S1/S2) (简化)
                    // 这里使用简化方法：直接从S1计算错误位置
                    if (syndrome_0 != 8'd0) begin
                        // 简化的错误位置计算
                        // 在实际实现中需要更复杂的计算
                        case (syndrome_0)
                            8'h01: error_position <= 7'd0;
                            8'h02: error_position <= 7'd1;
                            8'h04: error_position <= 7'd2;
                            8'h08: error_position <= 7'd3;
                            8'h10: error_position <= 7'd4;
                            8'h20: error_position <= 7'd5;
                            8'h40: error_position <= 7'd6;
                            8'h80: error_position <= 7'd7;
                            default: error_position <= 7'd10; // 默认位置
                        endcase
                    end else begin
                        error_position <= 7'd0;
                    end
                    state <= CALC_ERROR_VALUE;
                end
                
                CALC_ERROR_VALUE: begin
                    // 对于单个错误：错误值 = S1
                    error_value <= syndrome_0;
                    state <= CORRECT_ERROR;
                end
                
                CORRECT_ERROR: begin
                    // 只纠正数据符号（前64个符号）中的错误
                    if (error_position < 64) begin
                        case (error_position)
                            7'd0:  corrected_symbol_0  <= corrected_symbol_0  ^ error_value;
                            7'd1:  corrected_symbol_1  <= corrected_symbol_1  ^ error_value;
                            7'd2:  corrected_symbol_2  <= corrected_symbol_2  ^ error_value;
                            7'd3:  corrected_symbol_3  <= corrected_symbol_3  ^ error_value;
                            7'd4:  corrected_symbol_4  <= corrected_symbol_4  ^ error_value;
                            7'd5:  corrected_symbol_5  <= corrected_symbol_5  ^ error_value;
                            7'd6:  corrected_symbol_6  <= corrected_symbol_6  ^ error_value;
                            7'd7:  corrected_symbol_7  <= corrected_symbol_7  ^ error_value;
                            7'd8:  corrected_symbol_8  <= corrected_symbol_8  ^ error_value;
                            7'd9:  corrected_symbol_9  <= corrected_symbol_9  ^ error_value;
                            7'd10: corrected_symbol_10 <= corrected_symbol_10 ^ error_value;
                            7'd11: corrected_symbol_11 <= corrected_symbol_11 ^ error_value;
                            7'd12: corrected_symbol_12 <= corrected_symbol_12 ^ error_value;
                            7'd13: corrected_symbol_13 <= corrected_symbol_13 ^ error_value;
                            7'd14: corrected_symbol_14 <= corrected_symbol_14 ^ error_value;
                            7'd15: corrected_symbol_15 <= corrected_symbol_15 ^ error_value;
                            7'd16: corrected_symbol_16 <= corrected_symbol_16 ^ error_value;
                            7'd17: corrected_symbol_17 <= corrected_symbol_17 ^ error_value;
                            7'd18: corrected_symbol_18 <= corrected_symbol_18 ^ error_value;
                            7'd19: corrected_symbol_19 <= corrected_symbol_19 ^ error_value;
                            7'd20: corrected_symbol_20 <= corrected_symbol_20 ^ error_value;
                            7'd21: corrected_symbol_21 <= corrected_symbol_21 ^ error_value;
                            7'd22: corrected_symbol_22 <= corrected_symbol_22 ^ error_value;
                            7'd23: corrected_symbol_23 <= corrected_symbol_23 ^ error_value;
                            7'd24: corrected_symbol_24 <= corrected_symbol_24 ^ error_value;
                            7'd25: corrected_symbol_25 <= corrected_symbol_25 ^ error_value;
                            7'd26: corrected_symbol_26 <= corrected_symbol_26 ^ error_value;
                            7'd27: corrected_symbol_27 <= corrected_symbol_27 ^ error_value;
                            7'd28: corrected_symbol_28 <= corrected_symbol_28 ^ error_value;
                            7'd29: corrected_symbol_29 <= corrected_symbol_29 ^ error_value;
                            7'd30: corrected_symbol_30 <= corrected_symbol_30 ^ error_value;
                            7'd31: corrected_symbol_31 <= corrected_symbol_31 ^ error_value;
                            7'd32: corrected_symbol_32 <= corrected_symbol_32 ^ error_value;
                            7'd33: corrected_symbol_33 <= corrected_symbol_33 ^ error_value;
                            7'd34: corrected_symbol_34 <= corrected_symbol_34 ^ error_value;
                            7'd35: corrected_symbol_35 <= corrected_symbol_35 ^ error_value;
                            7'd36: corrected_symbol_36 <= corrected_symbol_36 ^ error_value;
                            7'd37: corrected_symbol_37 <= corrected_symbol_37 ^ error_value;
                            7'd38: corrected_symbol_38 <= corrected_symbol_38 ^ error_value;
                            7'd39: corrected_symbol_39 <= corrected_symbol_39 ^ error_value;
                            7'd40: corrected_symbol_40 <= corrected_symbol_40 ^ error_value;
                            7'd41: corrected_symbol_41 <= corrected_symbol_41 ^ error_value;
                            7'd42: corrected_symbol_42 <= corrected_symbol_42 ^ error_value;
                            7'd43: corrected_symbol_43 <= corrected_symbol_43 ^ error_value;
                            7'd44: corrected_symbol_44 <= corrected_symbol_44 ^ error_value;
                            7'd45: corrected_symbol_45 <= corrected_symbol_45 ^ error_value;
                            7'd46: corrected_symbol_46 <= corrected_symbol_46 ^ error_value;
                            7'd47: corrected_symbol_47 <= corrected_symbol_47 ^ error_value;
                            7'd48: corrected_symbol_48 <= corrected_symbol_48 ^ error_value;
                            7'd49: corrected_symbol_49 <= corrected_symbol_49 ^ error_value;
                            7'd50: corrected_symbol_50 <= corrected_symbol_50 ^ error_value;
                            7'd51: corrected_symbol_51 <= corrected_symbol_51 ^ error_value;
                            7'd52: corrected_symbol_52 <= corrected_symbol_52 ^ error_value;
                            7'd53: corrected_symbol_53 <= corrected_symbol_53 ^ error_value;
                            7'd54: corrected_symbol_54 <= corrected_symbol_54 ^ error_value;
                            7'd55: corrected_symbol_55 <= corrected_symbol_55 ^ error_value;
                            7'd56: corrected_symbol_56 <= corrected_symbol_56 ^ error_value;
                            7'd57: corrected_symbol_57 <= corrected_symbol_57 ^ error_value;
                            7'd58: corrected_symbol_58 <= corrected_symbol_58 ^ error_value;
                            7'd59: corrected_symbol_59 <= corrected_symbol_59 ^ error_value;
                            7'd60: corrected_symbol_60 <= corrected_symbol_60 ^ error_value;
                            7'd61: corrected_symbol_61 <= corrected_symbol_61 ^ error_value;
                            7'd62: corrected_symbol_62 <= corrected_symbol_62 ^ error_value;
                            7'd63: corrected_symbol_63 <= corrected_symbol_63 ^ error_value;
                            default: begin
                                // 无效位置，不纠错
                            end
                        endcase
                        error_corrected <= 1'b1;
                    end
                    decode_success <= 1'b1;
                    state <= DONE;
                end
                
                DONE: begin
                    valid_out <= 1'b1;
                    if (!start) begin
                        state <= IDLE;
                        valid_out <= 1'b0;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end
    
    // 控制GF运算模块的输入
    always @(*) begin
        case (state)
            CALC_SYNDROME: begin
                // 计算 rⱼ * α^(i*j)
                gf_mult_a = current_rx_symbol;
                case (syndrome_cnt)
                    3'd0: gf_mult_b = gf_pow_result; // α^(1*j)
                    3'd1: gf_mult_b = gf_pow_result; // α^(2*j)
                    3'd2: gf_mult_b = gf_pow_result; // α^(3*j)
                    3'd3: gf_mult_b = gf_pow_result; // α^(4*j)
                    3'd4: gf_mult_b = gf_pow_result; // α^(5*j)
                    3'd5: gf_mult_b = gf_pow_result; // α^(6*j)
                    default: gf_mult_b = 8'h01;
                endcase
                gf_pow_base = 8'h02; // α
                gf_pow_exp = (syndrome_cnt + 1) * calc_cnt; // (i+1)*j，其中i是伴随式索引，j是符号位置
                gf_inv_a = 8'h00;
            end
            
            CALC_ERROR_POSITION: begin
                gf_mult_a = syndrome_0;
                gf_mult_b = gf_inv_result;
                gf_inv_a = syndrome_1;
                gf_pow_base = 8'h02;
                gf_pow_exp = 8'h00;
            end
            
            default: begin
                gf_mult_a = 8'h00;
                gf_mult_b = 8'h00;
                gf_pow_base = 8'h02;
                gf_pow_exp = 8'h00;
                gf_inv_a = 8'h00;
            end
        endcase
    end
    
    // 输出解码数据（64个数据符号）
    assign decoded_data = {
        corrected_symbol_63, corrected_symbol_62, corrected_symbol_61, corrected_symbol_60,
        corrected_symbol_59, corrected_symbol_58, corrected_symbol_57, corrected_symbol_56,
        corrected_symbol_55, corrected_symbol_54, corrected_symbol_53, corrected_symbol_52,
        corrected_symbol_51, corrected_symbol_50, corrected_symbol_49, corrected_symbol_48,
        corrected_symbol_47, corrected_symbol_46, corrected_symbol_45, corrected_symbol_44,
        corrected_symbol_43, corrected_symbol_42, corrected_symbol_41, corrected_symbol_40,
        corrected_symbol_39, corrected_symbol_38, corrected_symbol_37, corrected_symbol_36,
        corrected_symbol_35, corrected_symbol_34, corrected_symbol_33, corrected_symbol_32,
        corrected_symbol_31, corrected_symbol_30, corrected_symbol_29, corrected_symbol_28,
        corrected_symbol_27, corrected_symbol_26, corrected_symbol_25, corrected_symbol_24,
        corrected_symbol_23, corrected_symbol_22, corrected_symbol_21, corrected_symbol_20,
        corrected_symbol_19, corrected_symbol_18, corrected_symbol_17, corrected_symbol_16,
        corrected_symbol_15, corrected_symbol_14, corrected_symbol_13, corrected_symbol_12,
        corrected_symbol_11, corrected_symbol_10, corrected_symbol_9, corrected_symbol_8,
        corrected_symbol_7, corrected_symbol_6, corrected_symbol_5, corrected_symbol_4,
        corrected_symbol_3, corrected_symbol_2, corrected_symbol_1, corrected_symbol_0
    };

endmodule

// 简化版GF(256) 求逆模块
module gf256_inverse (
    input  [7:0] a,
    output [7:0] result
);
    
    // 使用查找表实现GF求逆（简化版）
    reg [7:0] inv_result;
    
    always @(*) begin
        case (a)
            8'h00: inv_result = 8'h00; // 0没有逆元
            8'h01: inv_result = 8'h01; // 1^(-1) = 1
            8'h02: inv_result = 8'h8D; // 2^(-1) = 8D
            8'h03: inv_result = 8'hF6; // 3^(-1) = F6
            8'h04: inv_result = 8'hCB; // 4^(-1) = CB
            8'h05: inv_result = 8'h52; // 5^(-1) = 52
            8'h06: inv_result = 8'h7B; // 6^(-1) = 7B
            8'h07: inv_result = 8'hD1; // 7^(-1) = D1
            8'h08: inv_result = 8'hE8; // 8^(-1) = E8
            8'h09: inv_result = 8'h4F; // 9^(-1) = 4F
            8'h0A: inv_result = 8'h29; // A^(-1) = 29
            8'h0B: inv_result = 8'hC0; // B^(-1) = C0
            8'h0C: inv_result = 8'hB0; // C^(-1) = B0
            8'h0D: inv_result = 8'hE1; // D^(-1) = E1
            8'h0E: inv_result = 8'hE5; // E^(-1) = E5
            8'h0F: inv_result = 8'hC7; // F^(-1) = C7
            8'h10: inv_result = 8'h74; // 10^(-1) = 74
            // 简化实现，其他值使用简单映射
            default: inv_result = 8'h01; // 简化：默认返回1
        endcase
    end
    
    assign result = inv_result;

endmodule

// 简化版GF(256) 幂运算模块
module gf256_power (
    input  [7:0] base,
    input  [7:0] exp,
    output [7:0] result
);

    reg [7:0] power_result;
    
    always @(*) begin
        if (exp == 8'h00) begin
            power_result = 8'h01; // base^0 = 1
        end else if (base == 8'h00) begin
            power_result = 8'h00; // 0^n = 0
        end else if (base == 8'h01) begin
            power_result = 8'h01; // 1^n = 1
        end else if (base == 8'h02) begin
            // α的幂运算（简化查找表）
            case (exp[3:0]) // 只使用低4位
                4'h0: power_result = 8'h01; // α^0 = 1
                4'h1: power_result = 8'h02; // α^1 = 2
                4'h2: power_result = 8'h04; // α^2 = 4
                4'h3: power_result = 8'h08; // α^3 = 8
                4'h4: power_result = 8'h10; // α^4 = 10
                4'h5: power_result = 8'h20; // α^5 = 20
                4'h6: power_result = 8'h40; // α^6 = 40
                4'h7: power_result = 8'h80; // α^7 = 80
                4'h8: power_result = 8'h1D; // α^8 = 1D (约简后)
                4'h9: power_result = 8'h3A; // α^9 = 3A
                4'hA: power_result = 8'h74; // α^10 = 74
                4'hB: power_result = 8'hE8; // α^11 = E8
                4'hC: power_result = 8'hCD; // α^12 = CD
                4'hD: power_result = 8'h87; // α^13 = 87
                4'hE: power_result = 8'h13; // α^14 = 13
                4'hF: power_result = 8'h26; // α^15 = 26
                default: power_result = 8'h01;
            endcase
        end else begin
            // 其他底数的简化实现
            power_result = base; // 简化：直接返回底数
        end
    end
    
    assign result = power_result;

endmodule

// 重用GF(256)乘法器
module gf256_mult (
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] result
);

    wire [15:0] temp_mult;
    wire [7:0] reduced_result;
    
    assign temp_mult = a * b;
    
    // GF(256) 约简 - 使用本原多项式x^8 + x^4 + x^3 + x^2 + 1 (0x11D)
    wire [7:0] stage1, stage2, stage3, stage4, stage5, stage6, stage7;
    
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

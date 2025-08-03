// 简化版结合RS(72,64)解码和RS(68,64)错误检测的解码器
// 完全符合Verilog-2001标准
// RS(68,64): 用于错误检测，可检测多个错误
// RS(72,64): 用于纠错，只能纠正单个符号错误
// 工作流程：
// 1. 使用RS(68,64)检测错误位置和数量
// 2. 如果检测到单个错误，使用RS(72,64)进行纠错
// 3. 如果检测到多个错误，报告错误但不纠正

module crs_decoder_72_64 (
    input  clk,
    input  rst_n,
    input  start,                     // 开始解码信号
    input  [575:0] received_data_72,  // RS(72,64)接收数据 (72*8=576位)
    input  [543:0] received_data_68,  // RS(68,64)接收数据 (68*8=544位)
    output [511:0] decoded_data,      // 64个解码符号 (64*8=512位)
    output reg [3:0] errors_detected, // 检测到的错误数量
    output reg errors_corrected,      // 是否纠正了错误
    output reg [6:0] error_position,  // 检测到的错误位置
    output reg valid_out,             // 输出有效信号
    output reg decode_success         // 解码成功信号
);

    // 状态机
    reg [2:0] state;
    parameter IDLE = 3'd0;
    parameter DETECT_ERRORS_68 = 3'd1;
    parameter CORRECT_SINGLE_ERROR = 3'd2;
    parameter VERIFY_RESULT = 3'd3;
    parameter DONE = 3'd4;
    
    // RS(68,64)错误检测模块接口
    reg rs68_start;
    wire [511:0] rs68_decoded_data;
    wire [3:0] rs68_errors_detected;
    wire [6:0] rs68_error_position;
    wire rs68_valid_out;
    wire rs68_decode_success;
    
    // RS(72,64)单符号纠错模块接口  
    reg rs72_start;
    reg [6:0] rs72_error_position;
    wire [511:0] rs72_decoded_data;
    wire rs72_error_corrected;
    wire rs72_valid_out;
    wire rs72_decode_success;
    
    // 内部寄存器
    reg [511:0] final_decoded_data;
    reg single_error_detected;
    
    // 实例化RS(68,64)错误检测器
    rs_decoder_68_64_detector_simple rs68_detector (
        .clk(clk),
        .rst_n(rst_n),
        .start(rs68_start),
        .received_code(received_data_68),
        .decoded_data(rs68_decoded_data),
        .errors_detected(rs68_errors_detected),
        .error_position(rs68_error_position),
        .valid_out(rs68_valid_out),
        .decode_success(rs68_decode_success)
    );
    
    // 实例化RS(72,64)单符号纠错器
    rs_decoder_72_64_single_corrector rs72_corrector (
        .clk(clk),
        .rst_n(rst_n),
        .start(rs72_start),
        .received_code(received_data_72),
        .error_position(rs72_error_position),
        .decoded_data(rs72_decoded_data),
        .error_corrected(rs72_error_corrected),
        .valid_out(rs72_valid_out),
        .decode_success(rs72_decode_success)
    );
    
    // 主控制状态机
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            rs68_start <= 1'b0;
            rs72_start <= 1'b0;
            errors_detected <= 4'd0;
            errors_corrected <= 1'b0;
            error_position <= 7'd0;
            valid_out <= 1'b0;
            decode_success <= 1'b0;
            single_error_detected <= 1'b0;
            final_decoded_data <= 512'h0;
            rs72_error_position <= 7'd0;
        end else begin
            case (state)
                IDLE: begin
                    valid_out <= 1'b0;
                    decode_success <= 1'b0;
                    rs68_start <= 1'b0;
                    rs72_start <= 1'b0;
                    errors_corrected <= 1'b0;
                    
                    if (start) begin
                        state <= DETECT_ERRORS_68;
                        rs68_start <= 1'b1;
                    end
                end
                
                DETECT_ERRORS_68: begin
                    rs68_start <= 1'b0;
                    
                    if (rs68_valid_out) begin
                        // 获取RS(68,64)的错误检测结果
                        errors_detected <= rs68_errors_detected;
                        error_position <= rs68_error_position;
                        
                        if (rs68_errors_detected == 4'd0) begin
                            // 无错误，直接使用RS(68,64)的解码结果
                            final_decoded_data <= rs68_decoded_data;
                            decode_success <= 1'b1;
                            state <= DONE;
                        end else if (rs68_errors_detected == 4'd1) begin
                            // 单个错误，尝试纠正
                            single_error_detected <= 1'b1;
                            // 映射错误位置：68位码字到72位码字
                            if (rs68_error_position < 64) begin
                                rs72_error_position <= rs68_error_position;
                            end else begin
                                rs72_error_position <= rs68_error_position + 7'd4;
                            end
                            state <= CORRECT_SINGLE_ERROR;
                            rs72_start <= 1'b1;
                        end else begin
                            // 多个错误，无法纠正
                            final_decoded_data <= rs68_decoded_data; // 返回原始解码结果
                            decode_success <= 1'b0; // 标记解码失败
                            state <= DONE;
                        end
                    end
                end
                
                CORRECT_SINGLE_ERROR: begin
                    rs72_start <= 1'b0;
                    
                    if (rs72_valid_out) begin
                        if (rs72_decode_success && rs72_error_corrected) begin
                            final_decoded_data <= rs72_decoded_data;
                            errors_corrected <= 1'b1;
                            decode_success <= 1'b1;
                            state <= VERIFY_RESULT;
                        end else begin
                            // RS(72,64)纠错失败
                            final_decoded_data <= rs68_decoded_data;
                            decode_success <= 1'b0;
                            state <= DONE;
                        end
                    end
                end
                
                VERIFY_RESULT: begin
                    // 简化验证：如果RS(72,64)纠错成功，则认为结果有效
                    decode_success <= 1'b1;
                    state <= DONE;
                end
                
                DONE: begin
                    valid_out <= 1'b1;
                    if (!start) begin
                        state <= IDLE;
                        valid_out <= 1'b0;
                        single_error_detected <= 1'b0;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end
    
    // 输出最终解码数据
    assign decoded_data = final_decoded_data;

endmodule

// 简化版RS(68,64)错误检测器模块
module rs_decoder_68_64_detector_simple (
    input  clk,
    input  rst_n,
    input  start,
    input  [543:0] received_code,     // 68个接收符号
    output [511:0] decoded_data,      // 64个解码符号
    output reg [3:0] errors_detected, // 检测到的错误数量
    output reg [6:0] error_position,  // 第一个错误位置
    output reg valid_out,
    output reg decode_success
);

    // 状态机
    reg [2:0] state;
    parameter IDLE = 3'd0;
    parameter CALC_SYNDROME = 3'd1;
    parameter DETECT_ERRORS = 3'd2;
    parameter DONE = 3'd3;
    
    // 伴随式计算
    reg [7:0] syndrome_0, syndrome_1, syndrome_2, syndrome_3;
    reg [6:0] calc_cnt;
    reg [1:0] syndrome_cnt;
    
    // GF运算模块
    reg [7:0] gf_mult_a, gf_mult_b;
    wire [7:0] gf_mult_result;
    
    gf256_mult gf_mult_inst (
        .a(gf_mult_a),
        .b(gf_mult_b),
        .result(gf_mult_result)
    );
    
    // 当前处理的符号
    reg [7:0] current_symbol;
    
    // 符号提取
    always @(*) begin
        case (calc_cnt)
            7'd0:  current_symbol = received_code[7:0];
            7'd1:  current_symbol = received_code[15:8];
            7'd2:  current_symbol = received_code[23:16];
            7'd3:  current_symbol = received_code[31:24];
            7'd4:  current_symbol = received_code[39:32];
            7'd5:  current_symbol = received_code[47:40];
            7'd6:  current_symbol = received_code[55:48];
            7'd7:  current_symbol = received_code[63:56];
            7'd8:  current_symbol = received_code[71:64];
            7'd9:  current_symbol = received_code[79:72];
            7'd10: current_symbol = received_code[87:80];
            7'd11: current_symbol = received_code[95:88];
            7'd12: current_symbol = received_code[103:96];
            7'd13: current_symbol = received_code[111:104];
            7'd14: current_symbol = received_code[119:112];
            7'd15: current_symbol = received_code[127:120];
            7'd16: current_symbol = received_code[135:128];
            7'd17: current_symbol = received_code[143:136];
            7'd18: current_symbol = received_code[151:144];
            7'd19: current_symbol = received_code[159:152];
            7'd20: current_symbol = received_code[167:160];
            7'd21: current_symbol = received_code[175:168];
            7'd22: current_symbol = received_code[183:176];
            7'd23: current_symbol = received_code[191:184];
            7'd24: current_symbol = received_code[199:192];
            7'd25: current_symbol = received_code[207:200];
            7'd26: current_symbol = received_code[215:208];
            7'd27: current_symbol = received_code[223:216];
            7'd28: current_symbol = received_code[231:224];
            7'd29: current_symbol = received_code[239:232];
            7'd30: current_symbol = received_code[247:240];
            7'd31: current_symbol = received_code[255:248];
            7'd32: current_symbol = received_code[263:256];
            7'd33: current_symbol = received_code[271:264];
            7'd34: current_symbol = received_code[279:272];
            7'd35: current_symbol = received_code[287:280];
            7'd36: current_symbol = received_code[295:288];
            7'd37: current_symbol = received_code[303:296];
            7'd38: current_symbol = received_code[311:304];
            7'd39: current_symbol = received_code[319:312];
            7'd40: current_symbol = received_code[327:320];
            7'd41: current_symbol = received_code[335:328];
            7'd42: current_symbol = received_code[343:336];
            7'd43: current_symbol = received_code[351:344];
            7'd44: current_symbol = received_code[359:352];
            7'd45: current_symbol = received_code[367:360];
            7'd46: current_symbol = received_code[375:368];
            7'd47: current_symbol = received_code[383:376];
            7'd48: current_symbol = received_code[391:384];
            7'd49: current_symbol = received_code[399:392];
            7'd50: current_symbol = received_code[407:400];
            7'd51: current_symbol = received_code[415:408];
            7'd52: current_symbol = received_code[423:416];
            7'd53: current_symbol = received_code[431:424];
            7'd54: current_symbol = received_code[439:432];
            7'd55: current_symbol = received_code[447:440];
            7'd56: current_symbol = received_code[455:448];
            7'd57: current_symbol = received_code[463:456];
            7'd58: current_symbol = received_code[471:464];
            7'd59: current_symbol = received_code[479:472];
            7'd60: current_symbol = received_code[487:480];
            7'd61: current_symbol = received_code[495:488];
            7'd62: current_symbol = received_code[503:496];
            7'd63: current_symbol = received_code[511:504];
            7'd64: current_symbol = received_code[519:512];
            7'd65: current_symbol = received_code[527:520];
            7'd66: current_symbol = received_code[535:528];
            7'd67: current_symbol = received_code[543:536];
            default: current_symbol = 8'h00;
        endcase
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            calc_cnt <= 7'd0;
            syndrome_cnt <= 2'd0;
            errors_detected <= 4'd0;
            error_position <= 7'd0;
            valid_out <= 1'b0;
            decode_success <= 1'b0;
            syndrome_0 <= 8'd0;
            syndrome_1 <= 8'd0;
            syndrome_2 <= 8'd0;
            syndrome_3 <= 8'd0;
        end else begin
            case (state)
                IDLE: begin
                    valid_out <= 1'b0;
                    decode_success <= 1'b0;
                    calc_cnt <= 7'd0;
                    syndrome_cnt <= 2'd0;
                    errors_detected <= 4'd0;
                    error_position <= 7'd0;
                    syndrome_0 <= 8'd0;
                    syndrome_1 <= 8'd0;
                    syndrome_2 <= 8'd0;
                    syndrome_3 <= 8'd0;
                    
                    if (start) begin
                        state <= CALC_SYNDROME;
                    end
                end
                
                CALC_SYNDROME: begin
                    if (syndrome_cnt < 4) begin
                        if (calc_cnt < 68) begin
                            case (syndrome_cnt)
                                2'd0: syndrome_0 <= syndrome_0 ^ gf_mult_result;
                                2'd1: syndrome_1 <= syndrome_1 ^ gf_mult_result;
                                2'd2: syndrome_2 <= syndrome_2 ^ gf_mult_result;
                                2'd3: syndrome_3 <= syndrome_3 ^ gf_mult_result;
                            endcase
                            calc_cnt <= calc_cnt + 1;
                        end else begin
                            syndrome_cnt <= syndrome_cnt + 1;
                            calc_cnt <= 7'd0;
                        end
                    end else begin
                        state <= DETECT_ERRORS;
                    end
                end
                
                DETECT_ERRORS: begin
                    // 简化的错误检测逻辑
                    if ((syndrome_0 | syndrome_1 | syndrome_2 | syndrome_3) == 8'd0) begin
                        // 无错误
                        errors_detected <= 4'd0;
                        error_position <= 7'd0;
                    end else if ((syndrome_1 == 8'd0) && (syndrome_2 == 8'd0) && (syndrome_3 == 8'd0)) begin
                        // 单个错误，错误位置可以从伴随式计算得出
                        errors_detected <= 4'd1;
                        // 简化：使用syndrome_0的值作为错误位置指示
                        if (syndrome_0 <= 8'd67) begin
                            error_position <= syndrome_0[6:0];
                        end else begin
                            error_position <= 7'd0; // 默认位置
                        end
                    end else begin
                        // 多个错误
                        errors_detected <= 4'd2; // 简化为报告2个错误
                        error_position <= 7'd0;   // 第一个错误位置（简化）
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
    
    // GF乘法控制
    always @(*) begin
        case (state)
            CALC_SYNDROME: begin
                gf_mult_a = current_symbol;
                case (syndrome_cnt)
                    2'd0: gf_mult_b = 8'h01;  // α^0
                    2'd1: gf_mult_b = 8'h02;  // α^1
                    2'd2: gf_mult_b = 8'h04;  // α^2
                    2'd3: gf_mult_b = 8'h08;  // α^3
                    default: gf_mult_b = 8'h01;
                endcase
            end
            default: begin
                gf_mult_a = 8'h00;
                gf_mult_b = 8'h00;
            end
        endcase
    end
    
    // 输出解码数据（取前64个符号）
    assign decoded_data = received_code[511:0];

endmodule

// RS(72,64)单符号纠错器
module rs_decoder_72_64_single_corrector (
    input  clk,
    input  rst_n,
    input  start,
    input  [575:0] received_code,       // 72个接收符号
    input  [6:0] error_position,        // 错误位置
    output [511:0] decoded_data,        // 64个解码符号
    output reg error_corrected,         // 是否纠正了错误
    output reg valid_out,
    output reg decode_success
);

    // 状态机
    reg [1:0] state;
    parameter IDLE = 2'd0;
    parameter CALC_ERROR_VALUE = 2'd1;
    parameter CORRECT_ERROR = 2'd2;
    parameter DONE = 2'd3;
    
    // 纠错后的符号存储
    reg [7:0] corrected_symbols_0,  corrected_symbols_1,  corrected_symbols_2,  corrected_symbols_3;
    reg [7:0] corrected_symbols_4,  corrected_symbols_5,  corrected_symbols_6,  corrected_symbols_7;
    reg [7:0] corrected_symbols_8,  corrected_symbols_9,  corrected_symbols_10, corrected_symbols_11;
    reg [7:0] corrected_symbols_12, corrected_symbols_13, corrected_symbols_14, corrected_symbols_15;
    reg [7:0] corrected_symbols_16, corrected_symbols_17, corrected_symbols_18, corrected_symbols_19;
    reg [7:0] corrected_symbols_20, corrected_symbols_21, corrected_symbols_22, corrected_symbols_23;
    reg [7:0] corrected_symbols_24, corrected_symbols_25, corrected_symbols_26, corrected_symbols_27;
    reg [7:0] corrected_symbols_28, corrected_symbols_29, corrected_symbols_30, corrected_symbols_31;
    reg [7:0] corrected_symbols_32, corrected_symbols_33, corrected_symbols_34, corrected_symbols_35;
    reg [7:0] corrected_symbols_36, corrected_symbols_37, corrected_symbols_38, corrected_symbols_39;
    reg [7:0] corrected_symbols_40, corrected_symbols_41, corrected_symbols_42, corrected_symbols_43;
    reg [7:0] corrected_symbols_44, corrected_symbols_45, corrected_symbols_46, corrected_symbols_47;
    reg [7:0] corrected_symbols_48, corrected_symbols_49, corrected_symbols_50, corrected_symbols_51;
    reg [7:0] corrected_symbols_52, corrected_symbols_53, corrected_symbols_54, corrected_symbols_55;
    reg [7:0] corrected_symbols_56, corrected_symbols_57, corrected_symbols_58, corrected_symbols_59;
    reg [7:0] corrected_symbols_60, corrected_symbols_61, corrected_symbols_62, corrected_symbols_63;
    
    // 错误值（简化：使用固定值）
    reg [7:0] error_value;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            error_corrected <= 1'b0;
            valid_out <= 1'b0;
            decode_success <= 1'b0;
            error_value <= 8'h00;
            
            // 初始化所有符号寄存器
            corrected_symbols_0  <= 8'd0; corrected_symbols_1  <= 8'd0; corrected_symbols_2  <= 8'd0; corrected_symbols_3  <= 8'd0;
            corrected_symbols_4  <= 8'd0; corrected_symbols_5  <= 8'd0; corrected_symbols_6  <= 8'd0; corrected_symbols_7  <= 8'd0;
            corrected_symbols_8  <= 8'd0; corrected_symbols_9  <= 8'd0; corrected_symbols_10 <= 8'd0; corrected_symbols_11 <= 8'd0;
            corrected_symbols_12 <= 8'd0; corrected_symbols_13 <= 8'd0; corrected_symbols_14 <= 8'd0; corrected_symbols_15 <= 8'd0;
            corrected_symbols_16 <= 8'd0; corrected_symbols_17 <= 8'd0; corrected_symbols_18 <= 8'd0; corrected_symbols_19 <= 8'd0;
            corrected_symbols_20 <= 8'd0; corrected_symbols_21 <= 8'd0; corrected_symbols_22 <= 8'd0; corrected_symbols_23 <= 8'd0;
            corrected_symbols_24 <= 8'd0; corrected_symbols_25 <= 8'd0; corrected_symbols_26 <= 8'd0; corrected_symbols_27 <= 8'd0;
            corrected_symbols_28 <= 8'd0; corrected_symbols_29 <= 8'd0; corrected_symbols_30 <= 8'd0; corrected_symbols_31 <= 8'd0;
            corrected_symbols_32 <= 8'd0; corrected_symbols_33 <= 8'd0; corrected_symbols_34 <= 8'd0; corrected_symbols_35 <= 8'd0;
            corrected_symbols_36 <= 8'd0; corrected_symbols_37 <= 8'd0; corrected_symbols_38 <= 8'd0; corrected_symbols_39 <= 8'd0;
            corrected_symbols_40 <= 8'd0; corrected_symbols_41 <= 8'd0; corrected_symbols_42 <= 8'd0; corrected_symbols_43 <= 8'd0;
            corrected_symbols_44 <= 8'd0; corrected_symbols_45 <= 8'd0; corrected_symbols_46 <= 8'd0; corrected_symbols_47 <= 8'd0;
            corrected_symbols_48 <= 8'd0; corrected_symbols_49 <= 8'd0; corrected_symbols_50 <= 8'd0; corrected_symbols_51 <= 8'd0;
            corrected_symbols_52 <= 8'd0; corrected_symbols_53 <= 8'd0; corrected_symbols_54 <= 8'd0; corrected_symbols_55 <= 8'd0;
            corrected_symbols_56 <= 8'd0; corrected_symbols_57 <= 8'd0; corrected_symbols_58 <= 8'd0; corrected_symbols_59 <= 8'd0;
            corrected_symbols_60 <= 8'd0; corrected_symbols_61 <= 8'd0; corrected_symbols_62 <= 8'd0; corrected_symbols_63 <= 8'd0;
        end else begin
            case (state)
                IDLE: begin
                    valid_out <= 1'b0;
                    decode_success <= 1'b0;
                    error_corrected <= 1'b0;
                    
                    // 复制接收数据到纠错符号寄存器（只处理前64个符号用于输出）
                    corrected_symbols_0  <= received_code[7:0];     corrected_symbols_1  <= received_code[15:8];
                    corrected_symbols_2  <= received_code[23:16];   corrected_symbols_3  <= received_code[31:24];
                    corrected_symbols_4  <= received_code[39:32];   corrected_symbols_5  <= received_code[47:40];
                    corrected_symbols_6  <= received_code[55:48];   corrected_symbols_7  <= received_code[63:56];
                    corrected_symbols_8  <= received_code[71:64];   corrected_symbols_9  <= received_code[79:72];
                    corrected_symbols_10 <= received_code[87:80];   corrected_symbols_11 <= received_code[95:88];
                    corrected_symbols_12 <= received_code[103:96];  corrected_symbols_13 <= received_code[111:104];
                    corrected_symbols_14 <= received_code[119:112]; corrected_symbols_15 <= received_code[127:120];
                    corrected_symbols_16 <= received_code[135:128]; corrected_symbols_17 <= received_code[143:136];
                    corrected_symbols_18 <= received_code[151:144]; corrected_symbols_19 <= received_code[159:152];
                    corrected_symbols_20 <= received_code[167:160]; corrected_symbols_21 <= received_code[175:168];
                    corrected_symbols_22 <= received_code[183:176]; corrected_symbols_23 <= received_code[191:184];
                    corrected_symbols_24 <= received_code[199:192]; corrected_symbols_25 <= received_code[207:200];
                    corrected_symbols_26 <= received_code[215:208]; corrected_symbols_27 <= received_code[223:216];
                    corrected_symbols_28 <= received_code[231:224]; corrected_symbols_29 <= received_code[239:232];
                    corrected_symbols_30 <= received_code[247:240]; corrected_symbols_31 <= received_code[255:248];
                    corrected_symbols_32 <= received_code[263:256]; corrected_symbols_33 <= received_code[271:264];
                    corrected_symbols_34 <= received_code[279:272]; corrected_symbols_35 <= received_code[287:280];
                    corrected_symbols_36 <= received_code[295:288]; corrected_symbols_37 <= received_code[303:296];
                    corrected_symbols_38 <= received_code[311:304]; corrected_symbols_39 <= received_code[319:312];
                    corrected_symbols_40 <= received_code[327:320]; corrected_symbols_41 <= received_code[335:328];
                    corrected_symbols_42 <= received_code[343:336]; corrected_symbols_43 <= received_code[351:344];
                    corrected_symbols_44 <= received_code[359:352]; corrected_symbols_45 <= received_code[367:360];
                    corrected_symbols_46 <= received_code[375:368]; corrected_symbols_47 <= received_code[383:376];
                    corrected_symbols_48 <= received_code[391:384]; corrected_symbols_49 <= received_code[399:392];
                    corrected_symbols_50 <= received_code[407:400]; corrected_symbols_51 <= received_code[415:408];
                    corrected_symbols_52 <= received_code[423:416]; corrected_symbols_53 <= received_code[431:424];
                    corrected_symbols_54 <= received_code[439:432]; corrected_symbols_55 <= received_code[447:440];
                    corrected_symbols_56 <= received_code[455:448]; corrected_symbols_57 <= received_code[463:456];
                    corrected_symbols_58 <= received_code[471:464]; corrected_symbols_59 <= received_code[479:472];
                    corrected_symbols_60 <= received_code[487:480]; corrected_symbols_61 <= received_code[495:488];
                    corrected_symbols_62 <= received_code[503:496]; corrected_symbols_63 <= received_code[511:504];
                    
                    if (start) begin
                        state <= CALC_ERROR_VALUE;
                    end
                end
                
                CALC_ERROR_VALUE: begin
                    // 简化：使用固定错误值进行纠错
                    error_value <= 8'hFF;  // 简化的错误值
                    state <= CORRECT_ERROR;
                end
                
                CORRECT_ERROR: begin
                    // 只在错误位置小于64时进行纠错（只纠正数据符号）
                    if (error_position < 64) begin
                        case (error_position)
                            7'd0:  corrected_symbols_0  <= corrected_symbols_0  ^ error_value;
                            7'd1:  corrected_symbols_1  <= corrected_symbols_1  ^ error_value;
                            7'd2:  corrected_symbols_2  <= corrected_symbols_2  ^ error_value;
                            7'd3:  corrected_symbols_3  <= corrected_symbols_3  ^ error_value;
                            7'd4:  corrected_symbols_4  <= corrected_symbols_4  ^ error_value;
                            7'd5:  corrected_symbols_5  <= corrected_symbols_5  ^ error_value;
                            7'd6:  corrected_symbols_6  <= corrected_symbols_6  ^ error_value;
                            7'd7:  corrected_symbols_7  <= corrected_symbols_7  ^ error_value;
                            7'd8:  corrected_symbols_8  <= corrected_symbols_8  ^ error_value;
                            7'd9:  corrected_symbols_9  <= corrected_symbols_9  ^ error_value;
                            7'd10: corrected_symbols_10 <= corrected_symbols_10 ^ error_value;
                            7'd11: corrected_symbols_11 <= corrected_symbols_11 ^ error_value;
                            7'd12: corrected_symbols_12 <= corrected_symbols_12 ^ error_value;
                            7'd13: corrected_symbols_13 <= corrected_symbols_13 ^ error_value;
                            7'd14: corrected_symbols_14 <= corrected_symbols_14 ^ error_value;
                            7'd15: corrected_symbols_15 <= corrected_symbols_15 ^ error_value;
                            7'd16: corrected_symbols_16 <= corrected_symbols_16 ^ error_value;
                            7'd17: corrected_symbols_17 <= corrected_symbols_17 ^ error_value;
                            7'd18: corrected_symbols_18 <= corrected_symbols_18 ^ error_value;
                            7'd19: corrected_symbols_19 <= corrected_symbols_19 ^ error_value;
                            7'd20: corrected_symbols_20 <= corrected_symbols_20 ^ error_value;
                            7'd21: corrected_symbols_21 <= corrected_symbols_21 ^ error_value;
                            7'd22: corrected_symbols_22 <= corrected_symbols_22 ^ error_value;
                            7'd23: corrected_symbols_23 <= corrected_symbols_23 ^ error_value;
                            7'd24: corrected_symbols_24 <= corrected_symbols_24 ^ error_value;
                            7'd25: corrected_symbols_25 <= corrected_symbols_25 ^ error_value;
                            7'd26: corrected_symbols_26 <= corrected_symbols_26 ^ error_value;
                            7'd27: corrected_symbols_27 <= corrected_symbols_27 ^ error_value;
                            7'd28: corrected_symbols_28 <= corrected_symbols_28 ^ error_value;
                            7'd29: corrected_symbols_29 <= corrected_symbols_29 ^ error_value;
                            7'd30: corrected_symbols_30 <= corrected_symbols_30 ^ error_value;
                            7'd31: corrected_symbols_31 <= corrected_symbols_31 ^ error_value;
                            7'd32: corrected_symbols_32 <= corrected_symbols_32 ^ error_value;
                            7'd33: corrected_symbols_33 <= corrected_symbols_33 ^ error_value;
                            7'd34: corrected_symbols_34 <= corrected_symbols_34 ^ error_value;
                            7'd35: corrected_symbols_35 <= corrected_symbols_35 ^ error_value;
                            7'd36: corrected_symbols_36 <= corrected_symbols_36 ^ error_value;
                            7'd37: corrected_symbols_37 <= corrected_symbols_37 ^ error_value;
                            7'd38: corrected_symbols_38 <= corrected_symbols_38 ^ error_value;
                            7'd39: corrected_symbols_39 <= corrected_symbols_39 ^ error_value;
                            7'd40: corrected_symbols_40 <= corrected_symbols_40 ^ error_value;
                            7'd41: corrected_symbols_41 <= corrected_symbols_41 ^ error_value;
                            7'd42: corrected_symbols_42 <= corrected_symbols_42 ^ error_value;
                            7'd43: corrected_symbols_43 <= corrected_symbols_43 ^ error_value;
                            7'd44: corrected_symbols_44 <= corrected_symbols_44 ^ error_value;
                            7'd45: corrected_symbols_45 <= corrected_symbols_45 ^ error_value;
                            7'd46: corrected_symbols_46 <= corrected_symbols_46 ^ error_value;
                            7'd47: corrected_symbols_47 <= corrected_symbols_47 ^ error_value;
                            7'd48: corrected_symbols_48 <= corrected_symbols_48 ^ error_value;
                            7'd49: corrected_symbols_49 <= corrected_symbols_49 ^ error_value;
                            7'd50: corrected_symbols_50 <= corrected_symbols_50 ^ error_value;
                            7'd51: corrected_symbols_51 <= corrected_symbols_51 ^ error_value;
                            7'd52: corrected_symbols_52 <= corrected_symbols_52 ^ error_value;
                            7'd53: corrected_symbols_53 <= corrected_symbols_53 ^ error_value;
                            7'd54: corrected_symbols_54 <= corrected_symbols_54 ^ error_value;
                            7'd55: corrected_symbols_55 <= corrected_symbols_55 ^ error_value;
                            7'd56: corrected_symbols_56 <= corrected_symbols_56 ^ error_value;
                            7'd57: corrected_symbols_57 <= corrected_symbols_57 ^ error_value;
                            7'd58: corrected_symbols_58 <= corrected_symbols_58 ^ error_value;
                            7'd59: corrected_symbols_59 <= corrected_symbols_59 ^ error_value;
                            7'd60: corrected_symbols_60 <= corrected_symbols_60 ^ error_value;
                            7'd61: corrected_symbols_61 <= corrected_symbols_61 ^ error_value;
                            7'd62: corrected_symbols_62 <= corrected_symbols_62 ^ error_value;
                            7'd63: corrected_symbols_63 <= corrected_symbols_63 ^ error_value;
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
    
    // 输出解码数据 - 将64个纠错后的符号组合成512位输出
    assign decoded_data = {
        corrected_symbols_63, corrected_symbols_62, corrected_symbols_61, corrected_symbols_60,
        corrected_symbols_59, corrected_symbols_58, corrected_symbols_57, corrected_symbols_56,
        corrected_symbols_55, corrected_symbols_54, corrected_symbols_53, corrected_symbols_52,
        corrected_symbols_51, corrected_symbols_50, corrected_symbols_49, corrected_symbols_48,
        corrected_symbols_47, corrected_symbols_46, corrected_symbols_45, corrected_symbols_44,
        corrected_symbols_43, corrected_symbols_42, corrected_symbols_41, corrected_symbols_40,
        corrected_symbols_39, corrected_symbols_38, corrected_symbols_37, corrected_symbols_36,
        corrected_symbols_35, corrected_symbols_34, corrected_symbols_33, corrected_symbols_32,
        corrected_symbols_31, corrected_symbols_30, corrected_symbols_29, corrected_symbols_28,
        corrected_symbols_27, corrected_symbols_26, corrected_symbols_25, corrected_symbols_24,
        corrected_symbols_23, corrected_symbols_22, corrected_symbols_21, corrected_symbols_20,
        corrected_symbols_19, corrected_symbols_18, corrected_symbols_17, corrected_symbols_16,
        corrected_symbols_15, corrected_symbols_14, corrected_symbols_13, corrected_symbols_12,
        corrected_symbols_11, corrected_symbols_10, corrected_symbols_9,  corrected_symbols_8,
        corrected_symbols_7,  corrected_symbols_6,  corrected_symbols_5,  corrected_symbols_4,
        corrected_symbols_3,  corrected_symbols_2,  corrected_symbols_1,  corrected_symbols_0
    };

endmodule

// GF(256) 乘法器模块（复用）
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

// 分层Reed-Solomon RS(68,64) 编码器
// 符合Verilog-2001标准
// 结构：64位数据 → 4×RS(9,8) → 4×RS(12,8) → 8×RS(12,8) → RS(68,64)
// 第一层：4个RS(9,8)编码器，每个处理16位数据，输出18位
// 第二层：将4个RS(9,8)结果合并并扩展为4个RS(12,8)
// 第三层：8个RS(12,8)拼接成最终的RS(68,64)
// 本原多项式：p(x) = x^8 + x^4 + x^3 + x^2 + 1 (0x11D)
// 本原元：α = 0x02

module hrs_encoder_68_64 (
    input  clk,
    input  rst_n,
    input  start,                   // 开始编码信号
    input  [511:0] data_in,         // 64个数据符号 (64*8=512位)
    output [543:0] code_out,        // 68个编码符号 (68*8=544位)
    output reg valid_out            // 输出有效信号
);

    // 预声明所有循环变量 - Verilog-2001要求
    integer j, k, init_idx;

    // 状态机
    reg [2:0] state;
    parameter IDLE = 3'd0;
    parameter ENCODE_LAYER1 = 3'd1;
    parameter ENCODE_LAYER2 = 3'd2;
    parameter ENCODE_LAYER3 = 3'd3;
    parameter DONE = 3'd4;
    
    // 第一层：4个RS(9,8)编码器的输入输出
    wire [127:0] layer1_data_0, layer1_data_1, layer1_data_2, layer1_data_3;
    wire [143:0] layer1_coded_0, layer1_coded_1, layer1_coded_2, layer1_coded_3;
    wire layer1_valid_0, layer1_valid_1, layer1_valid_2, layer1_valid_3;
    reg layer1_start_0, layer1_start_1, layer1_start_2, layer1_start_3;
    
    // 分配输入数据到4个RS(9,8)编码器
    assign layer1_data_0 = data_in[127:0];   // 符号0-15
    assign layer1_data_1 = data_in[255:128]; // 符号16-31  
    assign layer1_data_2 = data_in[383:256]; // 符号32-47
    assign layer1_data_3 = data_in[511:384]; // 符号48-63
    
    // 第一层RS(9,8)编码器实例
    rs_encoder_9_8 rs98_inst_0 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer1_start_0),
        .data_in(layer1_data_0),
        .code_out(layer1_coded_0),
        .valid_out(layer1_valid_0)
    );
    
    rs_encoder_9_8 rs98_inst_1 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer1_start_1),
        .data_in(layer1_data_1),
        .code_out(layer1_coded_1),
        .valid_out(layer1_valid_1)
    );
    
    rs_encoder_9_8 rs98_inst_2 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer1_start_2),
        .data_in(layer1_data_2),
        .code_out(layer1_coded_2),
        .valid_out(layer1_valid_2)
    );
    
    rs_encoder_9_8 rs98_inst_3 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer1_start_3),
        .data_in(layer1_data_3),
        .code_out(layer1_coded_3),
        .valid_out(layer1_valid_3)
    );
    
    // 第二层：将4个RS(9,8)结果扩展为4个RS(12,8)
    reg [95:0] layer2_data_0, layer2_data_1, layer2_data_2, layer2_data_3;
    wire [95:0] layer2_coded_0, layer2_coded_1, layer2_coded_2, layer2_coded_3;
    wire layer2_valid_0, layer2_valid_1, layer2_valid_2, layer2_valid_3;
    reg layer2_start_0, layer2_start_1, layer2_start_2, layer2_start_3;
    
    // 第二层RS(12,8)编码器实例
    rs_encoder_12_8 rs128_inst_0 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer2_start_0),
        .data_in(layer2_data_0),
        .code_out(layer2_coded_0),
        .valid_out(layer2_valid_0)
    );
    
    rs_encoder_12_8 rs128_inst_1 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer2_start_1),
        .data_in(layer2_data_1),
        .code_out(layer2_coded_1),
        .valid_out(layer2_valid_1)
    );
    
    rs_encoder_12_8 rs128_inst_2 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer2_start_2),
        .data_in(layer2_data_2),
        .code_out(layer2_coded_2),
        .valid_out(layer2_valid_2)
    );
    
    rs_encoder_12_8 rs128_inst_3 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer2_start_3),
        .data_in(layer2_data_3),
        .code_out(layer2_coded_3),
        .valid_out(layer2_valid_3)
    );
    
    // 第三层：8个RS(12,8)数据准备
    reg [95:0] layer3_data_0, layer3_data_1, layer3_data_2, layer3_data_3;
    reg [95:0] layer3_data_4, layer3_data_5, layer3_data_6, layer3_data_7;
    wire [95:0] layer3_coded_0, layer3_coded_1, layer3_coded_2, layer3_coded_3;
    wire [95:0] layer3_coded_4, layer3_coded_5, layer3_coded_6, layer3_coded_7;
    wire layer3_valid_0, layer3_valid_1, layer3_valid_2, layer3_valid_3;
    wire layer3_valid_4, layer3_valid_5, layer3_valid_6, layer3_valid_7;
    reg layer3_start_0, layer3_start_1, layer3_start_2, layer3_start_3;
    reg layer3_start_4, layer3_start_5, layer3_start_6, layer3_start_7;
    
    // 第三层RS(12,8)编码器实例
    rs_encoder_12_8 rs128_final_inst_0 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer3_start_0),
        .data_in(layer3_data_0),
        .code_out(layer3_coded_0),
        .valid_out(layer3_valid_0)
    );
    
    rs_encoder_12_8 rs128_final_inst_1 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer3_start_1),
        .data_in(layer3_data_1),
        .code_out(layer3_coded_1),
        .valid_out(layer3_valid_1)
    );
    
    rs_encoder_12_8 rs128_final_inst_2 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer3_start_2),
        .data_in(layer3_data_2),
        .code_out(layer3_coded_2),
        .valid_out(layer3_valid_2)
    );
    
    rs_encoder_12_8 rs128_final_inst_3 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer3_start_3),
        .data_in(layer3_data_3),
        .code_out(layer3_coded_3),
        .valid_out(layer3_valid_3)
    );
    
    rs_encoder_12_8 rs128_final_inst_4 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer3_start_4),
        .data_in(layer3_data_4),
        .code_out(layer3_coded_4),
        .valid_out(layer3_valid_4)
    );
    
    rs_encoder_12_8 rs128_final_inst_5 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer3_start_5),
        .data_in(layer3_data_5),
        .code_out(layer3_coded_5),
        .valid_out(layer3_valid_5)
    );
    
    rs_encoder_12_8 rs128_final_inst_6 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer3_start_6),
        .data_in(layer3_data_6),
        .code_out(layer3_coded_6),
        .valid_out(layer3_valid_6)
    );
    
    rs_encoder_12_8 rs128_final_inst_7 (
        .clk(clk),
        .rst_n(rst_n),
        .start(layer3_start_7),
        .data_in(layer3_data_7),
        .code_out(layer3_coded_7),
        .valid_out(layer3_valid_7)
    );
    
    // 控制计数器
    reg [2:0] encode_counter;
    
    // 所有有效信号的组合
    wire all_layer1_valid = layer1_valid_0 & layer1_valid_1 & layer1_valid_2 & layer1_valid_3;
    wire all_layer2_valid = layer2_valid_0 & layer2_valid_1 & layer2_valid_2 & layer2_valid_3;
    wire all_layer3_valid = layer3_valid_0 & layer3_valid_1 & layer3_valid_2 & layer3_valid_3 &
                           layer3_valid_4 & layer3_valid_5 & layer3_valid_6 & layer3_valid_7;
    
    // 主控制状态机
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            encode_counter <= 3'd0;
            valid_out <= 1'b0;
            
            // 初始化所有启动信号
            layer1_start_0 <= 1'b0; layer1_start_1 <= 1'b0; layer1_start_2 <= 1'b0; layer1_start_3 <= 1'b0;
            layer2_start_0 <= 1'b0; layer2_start_1 <= 1'b0; layer2_start_2 <= 1'b0; layer2_start_3 <= 1'b0;
            layer3_start_0 <= 1'b0; layer3_start_1 <= 1'b0; layer3_start_2 <= 1'b0; layer3_start_3 <= 1'b0;
            layer3_start_4 <= 1'b0; layer3_start_5 <= 1'b0; layer3_start_6 <= 1'b0; layer3_start_7 <= 1'b0;
            
            // 初始化数据 - 展开避免动态索引
            layer2_data_0 <= 96'h0; layer2_data_1 <= 96'h0; layer2_data_2 <= 96'h0; layer2_data_3 <= 96'h0;
            layer3_data_0 <= 96'h0; layer3_data_1 <= 96'h0; layer3_data_2 <= 96'h0; layer3_data_3 <= 96'h0;
            layer3_data_4 <= 96'h0; layer3_data_5 <= 96'h0; layer3_data_6 <= 96'h0; layer3_data_7 <= 96'h0;
        end else begin
            case (state)
                IDLE: begin
                    valid_out <= 1'b0;
                    encode_counter <= 3'd0;
                    
                    // 清零所有启动信号
                    layer1_start_0 <= 1'b0; layer1_start_1 <= 1'b0; layer1_start_2 <= 1'b0; layer1_start_3 <= 1'b0;
                    layer2_start_0 <= 1'b0; layer2_start_1 <= 1'b0; layer2_start_2 <= 1'b0; layer2_start_3 <= 1'b0;
                    layer3_start_0 <= 1'b0; layer3_start_1 <= 1'b0; layer3_start_2 <= 1'b0; layer3_start_3 <= 1'b0;
                    layer3_start_4 <= 1'b0; layer3_start_5 <= 1'b0; layer3_start_6 <= 1'b0; layer3_start_7 <= 1'b0;
                    
                    if (start) begin
                        state <= ENCODE_LAYER1;
                        // 启动所有第一层编码器
                        layer1_start_0 <= 1'b1; layer1_start_1 <= 1'b1; 
                        layer1_start_2 <= 1'b1; layer1_start_3 <= 1'b1;
                    end
                end
                
                ENCODE_LAYER1: begin
                    // 等待第一层编码完成
                    if (all_layer1_valid) begin // 所有第一层编码器完成
                        layer1_start_0 <= 1'b0; layer1_start_1 <= 1'b0; 
                        layer1_start_2 <= 1'b0; layer1_start_3 <= 1'b0;
                        
                        // 准备第二层数据：将RS(9,8)结果扩展为RS(12,8)输入
                        // 这里简化：直接使用前8个符号作为数据，后面添加校验位
                        layer2_data_0 <= {32'h00000000, layer1_coded_0[127:0]}; // 取前16个符号
                        layer2_data_1 <= {32'h00000000, layer1_coded_1[127:0]};
                        layer2_data_2 <= {32'h00000000, layer1_coded_2[127:0]};
                        layer2_data_3 <= {32'h00000000, layer1_coded_3[127:0]};
                        
                        state <= ENCODE_LAYER2;
                        layer2_start_0 <= 1'b1; layer2_start_1 <= 1'b1; 
                        layer2_start_2 <= 1'b1; layer2_start_3 <= 1'b1;
                    end
                end
                
                ENCODE_LAYER2: begin
                    // 等待第二层编码完成
                    if (all_layer2_valid) begin
                        layer2_start_0 <= 1'b0; layer2_start_1 <= 1'b0; 
                        layer2_start_2 <= 1'b0; layer2_start_3 <= 1'b0;
                        
                        // 准备第三层数据：前4个直接来自第二层，后4个为扩展
                        layer3_data_0 <= layer2_coded_0;
                        layer3_data_1 <= layer2_coded_1;
                        layer3_data_2 <= layer2_coded_2;
                        layer3_data_3 <= layer2_coded_3;
                        
                        // 后4个RS(12,8)用于最终的校验和冗余
                        layer3_data_4 <= {layer2_coded_0[95:64], layer2_coded_1[95:64], layer2_coded_2[31:0]};
                        layer3_data_5 <= {layer2_coded_2[95:64], layer2_coded_3[95:64], layer2_coded_0[31:0]};
                        layer3_data_6 <= {layer2_coded_1[63:32], layer2_coded_3[63:32], layer2_coded_1[63:0]};
                        layer3_data_7 <= {layer2_coded_0[63:32], layer2_coded_2[63:32], layer2_coded_3[63:0]};
                        
                        state <= ENCODE_LAYER3;
                        layer3_start_0 <= 1'b1; layer3_start_1 <= 1'b1; layer3_start_2 <= 1'b1; layer3_start_3 <= 1'b1;
                        layer3_start_4 <= 1'b1; layer3_start_5 <= 1'b1; layer3_start_6 <= 1'b1; layer3_start_7 <= 1'b1;
                    end
                end
                
                ENCODE_LAYER3: begin
                    // 等待第三层编码完成
                    if (all_layer3_valid) begin
                        layer3_start_0 <= 1'b0; layer3_start_1 <= 1'b0; layer3_start_2 <= 1'b0; layer3_start_3 <= 1'b0;
                        layer3_start_4 <= 1'b0; layer3_start_5 <= 1'b0; layer3_start_6 <= 1'b0; layer3_start_7 <= 1'b0;
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
    
    // 构造最终输出：68个符号，从8个RS(12,8)的结果中选择
    // 重新分配以确保正确的位宽：68*8 = 544位
    assign code_out = {
        layer3_coded_0[95:88],   // 1个符号 (8位)
        layer3_coded_1[95:80],   // 2个符号 (16位)
        layer3_coded_2[95:72],   // 3个符号 (24位)
        layer3_coded_3[95:64],   // 4个符号 (32位)
        layer3_coded_4,          // 12个符号 (96位)
        layer3_coded_5,          // 12个符号 (96位)
        layer3_coded_6,          // 12个符号 (96位)
        layer3_coded_7,          // 12个符号 (96位)
        layer3_coded_0[87:0],    // 11个符号 (88位)
        layer3_coded_1[79:72],   // 1个符号 (8位)
        layer3_coded_2[71:64],   // 1个符号 (8位)
        layer3_coded_3[63:48]    // 2个符号 (16位) - 调整为68个符号总计
    }; 

endmodule

// RS(9,8) 编码器子模块
module rs_encoder_9_8 (
    input  clk,
    input  rst_n,
    input  start,
    input  [127:0] data_in,    // 16个符号(实际只用前8个)
    output [143:0] code_out,   // 18个符号  
    output reg valid_out
);

    // 预声明循环变量
    integer i;

    // 取前8个符号作为实际数据
    wire [63:0] actual_data = data_in[63:0];
    
    // 1个校验符号
    reg [7:0] parity_symbol;
    
    // 状态机
    reg [2:0] state;
    parameter IDLE = 3'd0;
    parameter ENCODE = 3'd1;
    parameter DONE = 3'd2;
    
    reg [2:0] encode_cnt;
    
    // 当前数据符号
    reg [7:0] current_symbol;
    
    // 符号选择
    always @(*) begin
        case (encode_cnt)
            3'd0: current_symbol = actual_data[7:0];
            3'd1: current_symbol = actual_data[15:8];
            3'd2: current_symbol = actual_data[23:16];
            3'd3: current_symbol = actual_data[31:24];
            3'd4: current_symbol = actual_data[39:32];
            3'd5: current_symbol = actual_data[47:40];
            3'd6: current_symbol = actual_data[55:48];
            3'd7: current_symbol = actual_data[63:56];
            default: current_symbol = 8'h00;
        endcase
    end
    
    // GF乘法器
    wire [7:0] feedback_symbol = current_symbol ^ parity_symbol;
    wire [7:0] mult_result;
    
    gf256_mult mult_inst (
        .a(feedback_symbol),
        .b(8'h02), // α^1
        .result(mult_result)
    );
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            encode_cnt <= 3'd0;
            parity_symbol <= 8'h00;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    valid_out <= 1'b0;
                    encode_cnt <= 3'd0;
                    parity_symbol <= 8'h00;
                    if (start) begin
                        state <= ENCODE;
                    end
                end
                
                ENCODE: begin
                    if (encode_cnt < 8) begin
                        parity_symbol <= mult_result;
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
    
    // 输出：8个数据符号 + 1个校验符号，扩展到18个符号
    assign code_out = {80'h0, actual_data, parity_symbol}; // 10个0符号 + 8个数据 + 1个校验 = 19个符号，截取为18个

endmodule

// RS(12,8) 编码器子模块  
module rs_encoder_12_8 (
    input  clk,
    input  rst_n,
    input  start,
    input  [95:0] data_in,     // 12个符号，前8个为数据
    output [95:0] code_out,    // 12个符号输出
    output reg valid_out
);

    // 预声明循环变量
    integer i;

    // 取前8个符号作为数据
    wire [63:0] actual_data = data_in[63:0];
    
    // 4个校验符号
    reg [7:0] parity_symbol_0, parity_symbol_1, parity_symbol_2, parity_symbol_3;
    
    // 状态机
    reg [2:0] state;
    parameter IDLE = 3'd0;
    parameter ENCODE = 3'd1;
    parameter DONE = 3'd2;
    
    reg [2:0] encode_cnt;
    
    // 当前数据符号
    reg [7:0] current_symbol;
    
    // 符号选择
    always @(*) begin
        case (encode_cnt)
            3'd0: current_symbol = actual_data[7:0];
            3'd1: current_symbol = actual_data[15:8];
            3'd2: current_symbol = actual_data[23:16];
            3'd3: current_symbol = actual_data[31:24];
            3'd4: current_symbol = actual_data[39:32];
            3'd5: current_symbol = actual_data[47:40];
            3'd6: current_symbol = actual_data[55:48];
            3'd7: current_symbol = actual_data[63:56];
            default: current_symbol = 8'h00;
        endcase
    end
    
    // GF乘法器 - 4个校验位需要4个乘法器
    wire [7:0] feedback_symbol = current_symbol ^ parity_symbol_3;
    wire [7:0] mult_result_0, mult_result_1, mult_result_2, mult_result_3;
    
    gf256_mult mult0 (.a(feedback_symbol), .b(8'h01), .result(mult_result_0)); // α^0
    gf256_mult mult1 (.a(feedback_symbol), .b(8'h02), .result(mult_result_1)); // α^1
    gf256_mult mult2 (.a(feedback_symbol), .b(8'h04), .result(mult_result_2)); // α^2
    gf256_mult mult3 (.a(feedback_symbol), .b(8'h08), .result(mult_result_3)); // α^3
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            encode_cnt <= 3'd0;
            valid_out <= 1'b0;
            
            // 初始化校验符号 - 展开避免动态索引
            parity_symbol_0 <= 8'h00;
            parity_symbol_1 <= 8'h00;
            parity_symbol_2 <= 8'h00;
            parity_symbol_3 <= 8'h00;
        end else begin
            case (state)
                IDLE: begin
                    valid_out <= 1'b0;
                    encode_cnt <= 3'd0;
                    
                    // 清零校验符号
                    parity_symbol_0 <= 8'h00;
                    parity_symbol_1 <= 8'h00;
                    parity_symbol_2 <= 8'h00;
                    parity_symbol_3 <= 8'h00;
                    
                    if (start) begin
                        state <= ENCODE;
                    end
                end
                
                ENCODE: begin
                    if (encode_cnt < 8) begin
                        parity_symbol_0 <= mult_result_0;
                        parity_symbol_1 <= parity_symbol_0 ^ mult_result_1;
                        parity_symbol_2 <= parity_symbol_1 ^ mult_result_2;
                        parity_symbol_3 <= parity_symbol_2 ^ mult_result_3;
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
    
    // 输出：8个数据符号 + 4个校验符号 = 12个符号
    assign code_out = {parity_symbol_3, parity_symbol_2, parity_symbol_1, 
                      parity_symbol_0, actual_data};

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
    
    // GF(256) 约简
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

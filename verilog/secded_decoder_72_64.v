// SECDED(72,64) 解码器
// 输入：72位编码数据
// 输出：64位解码数据 + 错误状态信号
// 功能：单错纠正，双错检测

module secded_decoder_72_64 (
    code_in,
    data_out,
    single_error,
    double_error,
    no_error,
    error_position
);

    input  [71:0] code_in;          // 72位编码输入
    output [63:0] data_out;         // 64位解码输出
    output        single_error;     // 单错检测信号
    output        double_error;     // 双错检测信号  
    output        no_error;         // 无错信号
    output [6:0]  error_position;   // 错误位置（用于调试）

    // 内部信号
    wire [6:0] syndrome;            // 校验子
    wire       overall_parity_error; // 总体校验错误
    wire [71:0] corrected_code;     // 纠错后的码字
    
    // 提取接收到的校验位
    wire p0_received;
    wire p1_received;
    wire p2_received;
    wire p4_received;
    wire p8_received;
    wire p16_received;
    wire p32_received;
    wire p64_received;
    
    assign p0_received = code_in[0];   // 总体校验位
    assign p1_received = code_in[1];   // P1校验位
    assign p2_received = code_in[2];   // P2校验位
    assign p4_received = code_in[4];   // P4校验位
    assign p8_received = code_in[8];   // P8校验位
    assign p16_received = code_in[16]; // P16校验位
    assign p32_received = code_in[32]; // P32校验位
    assign p64_received = code_in[64]; // P64校验位
    
    // 重新计算校验位（基于接收到的完整码字）
    wire p1_calculated, p2_calculated, p4_calculated, p8_calculated;
    wire p16_calculated, p32_calculated, p64_calculated;
    wire p0_calculated;
    
    // 计算P1校验位：检查所有奇数位置
    assign p1_calculated = code_in[1] ^ code_in[3] ^ code_in[5] ^ code_in[7] ^ 
                          code_in[9] ^ code_in[11] ^ code_in[13] ^ code_in[15] ^ 
                          code_in[17] ^ code_in[19] ^ code_in[21] ^ code_in[23] ^ 
                          code_in[25] ^ code_in[27] ^ code_in[29] ^ code_in[31] ^ 
                          code_in[33] ^ code_in[35] ^ code_in[37] ^ code_in[39] ^ 
                          code_in[41] ^ code_in[43] ^ code_in[45] ^ code_in[47] ^ 
                          code_in[49] ^ code_in[51] ^ code_in[53] ^ code_in[55] ^ 
                          code_in[57] ^ code_in[59] ^ code_in[61] ^ code_in[63] ^ 
                          code_in[65] ^ code_in[67] ^ code_in[69] ^ code_in[71];
    
    // 计算P2校验位：检查位置模4为2或3的位
    assign p2_calculated = code_in[2] ^ code_in[3] ^ code_in[6] ^ code_in[7] ^ 
                          code_in[10] ^ code_in[11] ^ code_in[14] ^ code_in[15] ^ 
                          code_in[18] ^ code_in[19] ^ code_in[22] ^ code_in[23] ^ 
                          code_in[26] ^ code_in[27] ^ code_in[30] ^ code_in[31] ^ 
                          code_in[34] ^ code_in[35] ^ code_in[38] ^ code_in[39] ^ 
                          code_in[42] ^ code_in[43] ^ code_in[46] ^ code_in[47] ^ 
                          code_in[50] ^ code_in[51] ^ code_in[54] ^ code_in[55] ^ 
                          code_in[58] ^ code_in[59] ^ code_in[62] ^ code_in[63] ^ 
                          code_in[66] ^ code_in[67] ^ code_in[70] ^ code_in[71];
    
    // 计算P4校验位：检查位置模8为4,5,6,7的位
    assign p4_calculated = code_in[4] ^ code_in[5] ^ code_in[6] ^ code_in[7] ^ 
                          code_in[12] ^ code_in[13] ^ code_in[14] ^ code_in[15] ^ 
                          code_in[20] ^ code_in[21] ^ code_in[22] ^ code_in[23] ^ 
                          code_in[28] ^ code_in[29] ^ code_in[30] ^ code_in[31] ^ 
                          code_in[36] ^ code_in[37] ^ code_in[38] ^ code_in[39] ^ 
                          code_in[44] ^ code_in[45] ^ code_in[46] ^ code_in[47] ^ 
                          code_in[52] ^ code_in[53] ^ code_in[54] ^ code_in[55] ^ 
                          code_in[60] ^ code_in[61] ^ code_in[62] ^ code_in[63] ^ 
                          code_in[68] ^ code_in[69] ^ code_in[70] ^ code_in[71];
    
    // 计算P8校验位：检查位置模16为8-15的位
    assign p8_calculated = code_in[8] ^ code_in[9] ^ code_in[10] ^ code_in[11] ^ 
                          code_in[12] ^ code_in[13] ^ code_in[14] ^ code_in[15] ^ 
                          code_in[24] ^ code_in[25] ^ code_in[26] ^ code_in[27] ^ 
                          code_in[28] ^ code_in[29] ^ code_in[30] ^ code_in[31] ^ 
                          code_in[40] ^ code_in[41] ^ code_in[42] ^ code_in[43] ^ 
                          code_in[44] ^ code_in[45] ^ code_in[46] ^ code_in[47] ^ 
                          code_in[56] ^ code_in[57] ^ code_in[58] ^ code_in[59] ^ 
                          code_in[60] ^ code_in[61] ^ code_in[62] ^ code_in[63];
    
    // 计算P16校验位：检查位置模32为16-31的位
    assign p16_calculated = code_in[16] ^ code_in[17] ^ code_in[18] ^ code_in[19] ^ 
                           code_in[20] ^ code_in[21] ^ code_in[22] ^ code_in[23] ^ 
                           code_in[24] ^ code_in[25] ^ code_in[26] ^ code_in[27] ^ 
                           code_in[28] ^ code_in[29] ^ code_in[30] ^ code_in[31] ^ 
                           code_in[48] ^ code_in[49] ^ code_in[50] ^ code_in[51] ^ 
                           code_in[52] ^ code_in[53] ^ code_in[54] ^ code_in[55] ^ 
                           code_in[56] ^ code_in[57] ^ code_in[58] ^ code_in[59] ^ 
                           code_in[60] ^ code_in[61] ^ code_in[62] ^ code_in[63];
    
    // 计算P32校验位：检查位置模64为32-63的位
    assign p32_calculated = code_in[32] ^ code_in[33] ^ code_in[34] ^ code_in[35] ^ 
                           code_in[36] ^ code_in[37] ^ code_in[38] ^ code_in[39] ^ 
                           code_in[40] ^ code_in[41] ^ code_in[42] ^ code_in[43] ^ 
                           code_in[44] ^ code_in[45] ^ code_in[46] ^ code_in[47] ^ 
                           code_in[48] ^ code_in[49] ^ code_in[50] ^ code_in[51] ^ 
                           code_in[52] ^ code_in[53] ^ code_in[54] ^ code_in[55] ^ 
                           code_in[56] ^ code_in[57] ^ code_in[58] ^ code_in[59] ^ 
                           code_in[60] ^ code_in[61] ^ code_in[62] ^ code_in[63];
    
    // 计算P64校验位：检查位置≥64的位
    assign p64_calculated = code_in[64] ^ code_in[65] ^ code_in[66] ^ code_in[67] ^ 
                           code_in[68] ^ code_in[69] ^ code_in[70] ^ code_in[71];
    
    // 计算总体校验位
    assign p0_calculated = ^code_in[71:1]; // 对除P0外的所有位进行XOR
    
    // 计算校验子（syndrome）
    assign syndrome[0] = p1_calculated;   // S1
    assign syndrome[1] = p2_calculated;   // S2  
    assign syndrome[2] = p4_calculated;   // S4
    assign syndrome[3] = p8_calculated;   // S8
    assign syndrome[4] = p16_calculated;  // S16
    assign syndrome[5] = p32_calculated;  // S32
    assign syndrome[6] = p64_calculated;  // S64
    
    // 计算总体校验错误
    assign overall_parity_error = p0_calculated;
    
    // 错误检测和分类逻辑
    wire syndrome_nonzero;
    assign syndrome_nonzero = |syndrome;
    
    assign no_error = ~syndrome_nonzero & ~overall_parity_error;
    assign single_error = syndrome_nonzero & overall_parity_error;
    assign double_error = syndrome_nonzero & ~overall_parity_error;
    
    // 错误位置指示（校验子的值就是错误位置）
    assign error_position = syndrome;
    
    // 单比特错误纠正 - 展开generate循环以符合Verilog-2001
    // 生成纠错码字：如果检测到单错，翻转错误位
    assign corrected_code[0] = (single_error && (syndrome == 7'd0)) ? ~code_in[0] : code_in[0];
    assign corrected_code[1] = (single_error && (syndrome == 7'd1)) ? ~code_in[1] : code_in[1];
    assign corrected_code[2] = (single_error && (syndrome == 7'd2)) ? ~code_in[2] : code_in[2];
    assign corrected_code[3] = (single_error && (syndrome == 7'd3)) ? ~code_in[3] : code_in[3];
    assign corrected_code[4] = (single_error && (syndrome == 7'd4)) ? ~code_in[4] : code_in[4];
    assign corrected_code[5] = (single_error && (syndrome == 7'd5)) ? ~code_in[5] : code_in[5];
    assign corrected_code[6] = (single_error && (syndrome == 7'd6)) ? ~code_in[6] : code_in[6];
    assign corrected_code[7] = (single_error && (syndrome == 7'd7)) ? ~code_in[7] : code_in[7];
    assign corrected_code[8] = (single_error && (syndrome == 7'd8)) ? ~code_in[8] : code_in[8];
    assign corrected_code[9] = (single_error && (syndrome == 7'd9)) ? ~code_in[9] : code_in[9];
    assign corrected_code[10] = (single_error && (syndrome == 7'd10)) ? ~code_in[10] : code_in[10];
    assign corrected_code[11] = (single_error && (syndrome == 7'd11)) ? ~code_in[11] : code_in[11];
    assign corrected_code[12] = (single_error && (syndrome == 7'd12)) ? ~code_in[12] : code_in[12];
    assign corrected_code[13] = (single_error && (syndrome == 7'd13)) ? ~code_in[13] : code_in[13];
    assign corrected_code[14] = (single_error && (syndrome == 7'd14)) ? ~code_in[14] : code_in[14];
    assign corrected_code[15] = (single_error && (syndrome == 7'd15)) ? ~code_in[15] : code_in[15];
    assign corrected_code[16] = (single_error && (syndrome == 7'd16)) ? ~code_in[16] : code_in[16];
    assign corrected_code[17] = (single_error && (syndrome == 7'd17)) ? ~code_in[17] : code_in[17];
    assign corrected_code[18] = (single_error && (syndrome == 7'd18)) ? ~code_in[18] : code_in[18];
    assign corrected_code[19] = (single_error && (syndrome == 7'd19)) ? ~code_in[19] : code_in[19];
    assign corrected_code[20] = (single_error && (syndrome == 7'd20)) ? ~code_in[20] : code_in[20];
    assign corrected_code[21] = (single_error && (syndrome == 7'd21)) ? ~code_in[21] : code_in[21];
    assign corrected_code[22] = (single_error && (syndrome == 7'd22)) ? ~code_in[22] : code_in[22];
    assign corrected_code[23] = (single_error && (syndrome == 7'd23)) ? ~code_in[23] : code_in[23];
    assign corrected_code[24] = (single_error && (syndrome == 7'd24)) ? ~code_in[24] : code_in[24];
    assign corrected_code[25] = (single_error && (syndrome == 7'd25)) ? ~code_in[25] : code_in[25];
    assign corrected_code[26] = (single_error && (syndrome == 7'd26)) ? ~code_in[26] : code_in[26];
    assign corrected_code[27] = (single_error && (syndrome == 7'd27)) ? ~code_in[27] : code_in[27];
    assign corrected_code[28] = (single_error && (syndrome == 7'd28)) ? ~code_in[28] : code_in[28];
    assign corrected_code[29] = (single_error && (syndrome == 7'd29)) ? ~code_in[29] : code_in[29];
    assign corrected_code[30] = (single_error && (syndrome == 7'd30)) ? ~code_in[30] : code_in[30];
    assign corrected_code[31] = (single_error && (syndrome == 7'd31)) ? ~code_in[31] : code_in[31];
    assign corrected_code[32] = (single_error && (syndrome == 7'd32)) ? ~code_in[32] : code_in[32];
    assign corrected_code[33] = (single_error && (syndrome == 7'd33)) ? ~code_in[33] : code_in[33];
    assign corrected_code[34] = (single_error && (syndrome == 7'd34)) ? ~code_in[34] : code_in[34];
    assign corrected_code[35] = (single_error && (syndrome == 7'd35)) ? ~code_in[35] : code_in[35];
    assign corrected_code[36] = (single_error && (syndrome == 7'd36)) ? ~code_in[36] : code_in[36];
    assign corrected_code[37] = (single_error && (syndrome == 7'd37)) ? ~code_in[37] : code_in[37];
    assign corrected_code[38] = (single_error && (syndrome == 7'd38)) ? ~code_in[38] : code_in[38];
    assign corrected_code[39] = (single_error && (syndrome == 7'd39)) ? ~code_in[39] : code_in[39];
    assign corrected_code[40] = (single_error && (syndrome == 7'd40)) ? ~code_in[40] : code_in[40];
    assign corrected_code[41] = (single_error && (syndrome == 7'd41)) ? ~code_in[41] : code_in[41];
    assign corrected_code[42] = (single_error && (syndrome == 7'd42)) ? ~code_in[42] : code_in[42];
    assign corrected_code[43] = (single_error && (syndrome == 7'd43)) ? ~code_in[43] : code_in[43];
    assign corrected_code[44] = (single_error && (syndrome == 7'd44)) ? ~code_in[44] : code_in[44];
    assign corrected_code[45] = (single_error && (syndrome == 7'd45)) ? ~code_in[45] : code_in[45];
    assign corrected_code[46] = (single_error && (syndrome == 7'd46)) ? ~code_in[46] : code_in[46];
    assign corrected_code[47] = (single_error && (syndrome == 7'd47)) ? ~code_in[47] : code_in[47];
    assign corrected_code[48] = (single_error && (syndrome == 7'd48)) ? ~code_in[48] : code_in[48];
    assign corrected_code[49] = (single_error && (syndrome == 7'd49)) ? ~code_in[49] : code_in[49];
    assign corrected_code[50] = (single_error && (syndrome == 7'd50)) ? ~code_in[50] : code_in[50];
    assign corrected_code[51] = (single_error && (syndrome == 7'd51)) ? ~code_in[51] : code_in[51];
    assign corrected_code[52] = (single_error && (syndrome == 7'd52)) ? ~code_in[52] : code_in[52];
    assign corrected_code[53] = (single_error && (syndrome == 7'd53)) ? ~code_in[53] : code_in[53];
    assign corrected_code[54] = (single_error && (syndrome == 7'd54)) ? ~code_in[54] : code_in[54];
    assign corrected_code[55] = (single_error && (syndrome == 7'd55)) ? ~code_in[55] : code_in[55];
    assign corrected_code[56] = (single_error && (syndrome == 7'd56)) ? ~code_in[56] : code_in[56];
    assign corrected_code[57] = (single_error && (syndrome == 7'd57)) ? ~code_in[57] : code_in[57];
    assign corrected_code[58] = (single_error && (syndrome == 7'd58)) ? ~code_in[58] : code_in[58];
    assign corrected_code[59] = (single_error && (syndrome == 7'd59)) ? ~code_in[59] : code_in[59];
    assign corrected_code[60] = (single_error && (syndrome == 7'd60)) ? ~code_in[60] : code_in[60];
    assign corrected_code[61] = (single_error && (syndrome == 7'd61)) ? ~code_in[61] : code_in[61];
    assign corrected_code[62] = (single_error && (syndrome == 7'd62)) ? ~code_in[62] : code_in[62];
    assign corrected_code[63] = (single_error && (syndrome == 7'd63)) ? ~code_in[63] : code_in[63];
    assign corrected_code[64] = (single_error && (syndrome == 7'd64)) ? ~code_in[64] : code_in[64];
    assign corrected_code[65] = (single_error && (syndrome == 7'd65)) ? ~code_in[65] : code_in[65];
    assign corrected_code[66] = (single_error && (syndrome == 7'd66)) ? ~code_in[66] : code_in[66];
    assign corrected_code[67] = (single_error && (syndrome == 7'd67)) ? ~code_in[67] : code_in[67];
    assign corrected_code[68] = (single_error && (syndrome == 7'd68)) ? ~code_in[68] : code_in[68];
    assign corrected_code[69] = (single_error && (syndrome == 7'd69)) ? ~code_in[69] : code_in[69];
    assign corrected_code[70] = (single_error && (syndrome == 7'd70)) ? ~code_in[70] : code_in[70];
    assign corrected_code[71] = (single_error && (syndrome == 7'd71)) ? ~code_in[71] : code_in[71];
    
    // 从纠正后的码字中提取64位数据
    // 数据位在码字中的位置（跳过校验位位置0,1,2,4,8,16,32,64）
    assign data_out = {
        corrected_code[71:65],  // data[63:57] 
        corrected_code[63:33],  // data[56:26]
        corrected_code[31:17],  // data[25:11] 
        corrected_code[15:9],   // data[10:4]
        corrected_code[7:5],    // data[3:1]
        corrected_code[3]       // data[0]
    };

endmodule

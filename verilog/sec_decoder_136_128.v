// SEC(136,128) 解码器
// 输入：136位编码数据
// 输出：128位解码数据 + 错误状态信号
// 功能：单错纠正

module sec_decoder_136_128 (
    code_in,
    data_out,
    single_error,
    no_error,
    error_position
);

    input  [135:0] code_in;         // 136位编码输入
    output [127:0] data_out;        // 128位解码输出
    output         single_error;    // 单错检测信号
    output         no_error;        // 无错信号
    output [7:0]   error_position;  // 错误位置（8位校验子）

    // 内部信号
    wire [7:0] syndrome;            // 校验子
    wire [135:0] corrected_code;    // 纠错后的码字
    
    // 重新计算校验位（基于接收到的完整码字）
    wire p1_calculated, p2_calculated, p4_calculated, p8_calculated;
    wire p16_calculated, p32_calculated, p64_calculated, p128_calculated;
    
    // 计算P1校验位：检查所有奇数位置
    assign p1_calculated = code_in[1] ^ code_in[3] ^ code_in[5] ^ code_in[7] ^ 
                          code_in[9] ^ code_in[11] ^ code_in[13] ^ code_in[15] ^ 
                          code_in[17] ^ code_in[19] ^ code_in[21] ^ code_in[23] ^ 
                          code_in[25] ^ code_in[27] ^ code_in[29] ^ code_in[31] ^ 
                          code_in[33] ^ code_in[35] ^ code_in[37] ^ code_in[39] ^ 
                          code_in[41] ^ code_in[43] ^ code_in[45] ^ code_in[47] ^ 
                          code_in[49] ^ code_in[51] ^ code_in[53] ^ code_in[55] ^ 
                          code_in[57] ^ code_in[59] ^ code_in[61] ^ code_in[63] ^ 
                          code_in[65] ^ code_in[67] ^ code_in[69] ^ code_in[71] ^ 
                          code_in[73] ^ code_in[75] ^ code_in[77] ^ code_in[79] ^ 
                          code_in[81] ^ code_in[83] ^ code_in[85] ^ code_in[87] ^ 
                          code_in[89] ^ code_in[91] ^ code_in[93] ^ code_in[95] ^ 
                          code_in[97] ^ code_in[99] ^ code_in[101] ^ code_in[103] ^ 
                          code_in[105] ^ code_in[107] ^ code_in[109] ^ code_in[111] ^ 
                          code_in[113] ^ code_in[115] ^ code_in[117] ^ code_in[119] ^ 
                          code_in[121] ^ code_in[123] ^ code_in[125] ^ code_in[127] ^ 
                          code_in[129] ^ code_in[131] ^ code_in[133] ^ code_in[135];
    
    // 计算P2校验位：检查位置模4为2或3的位
    assign p2_calculated = code_in[2] ^ code_in[3] ^ code_in[6] ^ code_in[7] ^ 
                          code_in[10] ^ code_in[11] ^ code_in[14] ^ code_in[15] ^ 
                          code_in[18] ^ code_in[19] ^ code_in[22] ^ code_in[23] ^ 
                          code_in[26] ^ code_in[27] ^ code_in[30] ^ code_in[31] ^ 
                          code_in[34] ^ code_in[35] ^ code_in[38] ^ code_in[39] ^ 
                          code_in[42] ^ code_in[43] ^ code_in[46] ^ code_in[47] ^ 
                          code_in[50] ^ code_in[51] ^ code_in[54] ^ code_in[55] ^ 
                          code_in[58] ^ code_in[59] ^ code_in[62] ^ code_in[63] ^ 
                          code_in[66] ^ code_in[67] ^ code_in[70] ^ code_in[71] ^ 
                          code_in[74] ^ code_in[75] ^ code_in[78] ^ code_in[79] ^ 
                          code_in[82] ^ code_in[83] ^ code_in[86] ^ code_in[87] ^ 
                          code_in[90] ^ code_in[91] ^ code_in[94] ^ code_in[95] ^ 
                          code_in[98] ^ code_in[99] ^ code_in[102] ^ code_in[103] ^ 
                          code_in[106] ^ code_in[107] ^ code_in[110] ^ code_in[111] ^ 
                          code_in[114] ^ code_in[115] ^ code_in[118] ^ code_in[119] ^ 
                          code_in[122] ^ code_in[123] ^ code_in[126] ^ code_in[127] ^ 
                          code_in[130] ^ code_in[131] ^ code_in[134] ^ code_in[135];
    
    // 计算P4校验位：检查位置模8为4,5,6,7的位
    assign p4_calculated = code_in[4] ^ code_in[5] ^ code_in[6] ^ code_in[7] ^ 
                          code_in[12] ^ code_in[13] ^ code_in[14] ^ code_in[15] ^ 
                          code_in[20] ^ code_in[21] ^ code_in[22] ^ code_in[23] ^ 
                          code_in[28] ^ code_in[29] ^ code_in[30] ^ code_in[31] ^ 
                          code_in[36] ^ code_in[37] ^ code_in[38] ^ code_in[39] ^ 
                          code_in[44] ^ code_in[45] ^ code_in[46] ^ code_in[47] ^ 
                          code_in[52] ^ code_in[53] ^ code_in[54] ^ code_in[55] ^ 
                          code_in[60] ^ code_in[61] ^ code_in[62] ^ code_in[63] ^ 
                          code_in[68] ^ code_in[69] ^ code_in[70] ^ code_in[71] ^ 
                          code_in[76] ^ code_in[77] ^ code_in[78] ^ code_in[79] ^ 
                          code_in[84] ^ code_in[85] ^ code_in[86] ^ code_in[87] ^ 
                          code_in[92] ^ code_in[93] ^ code_in[94] ^ code_in[95] ^ 
                          code_in[100] ^ code_in[101] ^ code_in[102] ^ code_in[103] ^ 
                          code_in[108] ^ code_in[109] ^ code_in[110] ^ code_in[111] ^ 
                          code_in[116] ^ code_in[117] ^ code_in[118] ^ code_in[119] ^ 
                          code_in[124] ^ code_in[125] ^ code_in[126] ^ code_in[127] ^ 
                          code_in[132] ^ code_in[133] ^ code_in[134] ^ code_in[135];
    
    // 计算P8校验位：检查位置模16为8-15的位
    assign p8_calculated = code_in[8] ^ code_in[9] ^ code_in[10] ^ code_in[11] ^ 
                          code_in[12] ^ code_in[13] ^ code_in[14] ^ code_in[15] ^ 
                          code_in[24] ^ code_in[25] ^ code_in[26] ^ code_in[27] ^ 
                          code_in[28] ^ code_in[29] ^ code_in[30] ^ code_in[31] ^ 
                          code_in[40] ^ code_in[41] ^ code_in[42] ^ code_in[43] ^ 
                          code_in[44] ^ code_in[45] ^ code_in[46] ^ code_in[47] ^ 
                          code_in[56] ^ code_in[57] ^ code_in[58] ^ code_in[59] ^ 
                          code_in[60] ^ code_in[61] ^ code_in[62] ^ code_in[63] ^ 
                          code_in[72] ^ code_in[73] ^ code_in[74] ^ code_in[75] ^ 
                          code_in[76] ^ code_in[77] ^ code_in[78] ^ code_in[79] ^ 
                          code_in[88] ^ code_in[89] ^ code_in[90] ^ code_in[91] ^ 
                          code_in[92] ^ code_in[93] ^ code_in[94] ^ code_in[95] ^ 
                          code_in[104] ^ code_in[105] ^ code_in[106] ^ code_in[107] ^ 
                          code_in[108] ^ code_in[109] ^ code_in[110] ^ code_in[111] ^ 
                          code_in[120] ^ code_in[121] ^ code_in[122] ^ code_in[123] ^ 
                          code_in[124] ^ code_in[125] ^ code_in[126] ^ code_in[127];
    
    // 计算P16校验位：检查位置模32为16-31的位
    assign p16_calculated = code_in[16] ^ code_in[17] ^ code_in[18] ^ code_in[19] ^ 
                           code_in[20] ^ code_in[21] ^ code_in[22] ^ code_in[23] ^ 
                           code_in[24] ^ code_in[25] ^ code_in[26] ^ code_in[27] ^ 
                           code_in[28] ^ code_in[29] ^ code_in[30] ^ code_in[31] ^ 
                           code_in[48] ^ code_in[49] ^ code_in[50] ^ code_in[51] ^ 
                           code_in[52] ^ code_in[53] ^ code_in[54] ^ code_in[55] ^ 
                           code_in[56] ^ code_in[57] ^ code_in[58] ^ code_in[59] ^ 
                           code_in[60] ^ code_in[61] ^ code_in[62] ^ code_in[63] ^ 
                           code_in[80] ^ code_in[81] ^ code_in[82] ^ code_in[83] ^ 
                           code_in[84] ^ code_in[85] ^ code_in[86] ^ code_in[87] ^ 
                           code_in[88] ^ code_in[89] ^ code_in[90] ^ code_in[91] ^ 
                           code_in[92] ^ code_in[93] ^ code_in[94] ^ code_in[95] ^ 
                           code_in[112] ^ code_in[113] ^ code_in[114] ^ code_in[115] ^ 
                           code_in[116] ^ code_in[117] ^ code_in[118] ^ code_in[119] ^ 
                           code_in[120] ^ code_in[121] ^ code_in[122] ^ code_in[123] ^ 
                           code_in[124] ^ code_in[125] ^ code_in[126] ^ code_in[127];
    
    // 计算P32校验位：检查位置模64为32-63的位
    assign p32_calculated = code_in[32] ^ code_in[33] ^ code_in[34] ^ code_in[35] ^ 
                           code_in[36] ^ code_in[37] ^ code_in[38] ^ code_in[39] ^ 
                           code_in[40] ^ code_in[41] ^ code_in[42] ^ code_in[43] ^ 
                           code_in[44] ^ code_in[45] ^ code_in[46] ^ code_in[47] ^ 
                           code_in[48] ^ code_in[49] ^ code_in[50] ^ code_in[51] ^ 
                           code_in[52] ^ code_in[53] ^ code_in[54] ^ code_in[55] ^ 
                           code_in[56] ^ code_in[57] ^ code_in[58] ^ code_in[59] ^ 
                           code_in[60] ^ code_in[61] ^ code_in[62] ^ code_in[63] ^ 
                           code_in[96] ^ code_in[97] ^ code_in[98] ^ code_in[99] ^ 
                           code_in[100] ^ code_in[101] ^ code_in[102] ^ code_in[103] ^ 
                           code_in[104] ^ code_in[105] ^ code_in[106] ^ code_in[107] ^ 
                           code_in[108] ^ code_in[109] ^ code_in[110] ^ code_in[111] ^ 
                           code_in[112] ^ code_in[113] ^ code_in[114] ^ code_in[115] ^ 
                           code_in[116] ^ code_in[117] ^ code_in[118] ^ code_in[119] ^ 
                           code_in[120] ^ code_in[121] ^ code_in[122] ^ code_in[123] ^ 
                           code_in[124] ^ code_in[125] ^ code_in[126] ^ code_in[127];
    
    // 计算P64校验位：检查位置模128为64-127的位
    assign p64_calculated = code_in[64] ^ code_in[65] ^ code_in[66] ^ code_in[67] ^ 
                           code_in[68] ^ code_in[69] ^ code_in[70] ^ code_in[71] ^ 
                           code_in[72] ^ code_in[73] ^ code_in[74] ^ code_in[75] ^ 
                           code_in[76] ^ code_in[77] ^ code_in[78] ^ code_in[79] ^ 
                           code_in[80] ^ code_in[81] ^ code_in[82] ^ code_in[83] ^ 
                           code_in[84] ^ code_in[85] ^ code_in[86] ^ code_in[87] ^ 
                           code_in[88] ^ code_in[89] ^ code_in[90] ^ code_in[91] ^ 
                           code_in[92] ^ code_in[93] ^ code_in[94] ^ code_in[95] ^ 
                           code_in[96] ^ code_in[97] ^ code_in[98] ^ code_in[99] ^ 
                           code_in[100] ^ code_in[101] ^ code_in[102] ^ code_in[103] ^ 
                           code_in[104] ^ code_in[105] ^ code_in[106] ^ code_in[107] ^ 
                           code_in[108] ^ code_in[109] ^ code_in[110] ^ code_in[111] ^ 
                           code_in[112] ^ code_in[113] ^ code_in[114] ^ code_in[115] ^ 
                           code_in[116] ^ code_in[117] ^ code_in[118] ^ code_in[119] ^ 
                           code_in[120] ^ code_in[121] ^ code_in[122] ^ code_in[123] ^ 
                           code_in[124] ^ code_in[125] ^ code_in[126] ^ code_in[127];
    
    // 计算P128校验位：检查位置≥128的位
    assign p128_calculated = code_in[128] ^ code_in[129] ^ code_in[130] ^ code_in[131] ^ 
                            code_in[132] ^ code_in[133] ^ code_in[134] ^ code_in[135];
    
    // 计算校验子（syndrome）
    assign syndrome[0] = p1_calculated;    // S1
    assign syndrome[1] = p2_calculated;    // S2  
    assign syndrome[2] = p4_calculated;    // S4
    assign syndrome[3] = p8_calculated;    // S8
    assign syndrome[4] = p16_calculated;   // S16
    assign syndrome[5] = p32_calculated;   // S32
    assign syndrome[6] = p64_calculated;   // S64
    assign syndrome[7] = p128_calculated;  // S128
    
    // 错误检测逻辑
    wire syndrome_nonzero;
    assign syndrome_nonzero = |syndrome;
    
    assign no_error = ~syndrome_nonzero;
    assign single_error = syndrome_nonzero;
    
    // 错误位置指示（校验子的值就是错误位置）
    assign error_position = syndrome;
    
    // 单比特错误纠正 - 展开generate循环以符合Verilog-2001
    // 生成纠错码字：如果检测到单错，翻转错误位
    assign corrected_code[0] = (single_error && (syndrome == 8'd0)) ? ~code_in[0] : code_in[0];
    assign corrected_code[1] = (single_error && (syndrome == 8'd1)) ? ~code_in[1] : code_in[1];
    assign corrected_code[2] = (single_error && (syndrome == 8'd2)) ? ~code_in[2] : code_in[2];
    assign corrected_code[3] = (single_error && (syndrome == 8'd3)) ? ~code_in[3] : code_in[3];
    assign corrected_code[4] = (single_error && (syndrome == 8'd4)) ? ~code_in[4] : code_in[4];
    assign corrected_code[5] = (single_error && (syndrome == 8'd5)) ? ~code_in[5] : code_in[5];
    assign corrected_code[6] = (single_error && (syndrome == 8'd6)) ? ~code_in[6] : code_in[6];
    assign corrected_code[7] = (single_error && (syndrome == 8'd7)) ? ~code_in[7] : code_in[7];
    assign corrected_code[8] = (single_error && (syndrome == 8'd8)) ? ~code_in[8] : code_in[8];
    assign corrected_code[9] = (single_error && (syndrome == 8'd9)) ? ~code_in[9] : code_in[9];
    assign corrected_code[10] = (single_error && (syndrome == 8'd10)) ? ~code_in[10] : code_in[10];
    assign corrected_code[11] = (single_error && (syndrome == 8'd11)) ? ~code_in[11] : code_in[11];
    assign corrected_code[12] = (single_error && (syndrome == 8'd12)) ? ~code_in[12] : code_in[12];
    assign corrected_code[13] = (single_error && (syndrome == 8'd13)) ? ~code_in[13] : code_in[13];
    assign corrected_code[14] = (single_error && (syndrome == 8'd14)) ? ~code_in[14] : code_in[14];
    assign corrected_code[15] = (single_error && (syndrome == 8'd15)) ? ~code_in[15] : code_in[15];
    assign corrected_code[16] = (single_error && (syndrome == 8'd16)) ? ~code_in[16] : code_in[16];
    assign corrected_code[17] = (single_error && (syndrome == 8'd17)) ? ~code_in[17] : code_in[17];
    assign corrected_code[18] = (single_error && (syndrome == 8'd18)) ? ~code_in[18] : code_in[18];
    assign corrected_code[19] = (single_error && (syndrome == 8'd19)) ? ~code_in[19] : code_in[19];
    assign corrected_code[20] = (single_error && (syndrome == 8'd20)) ? ~code_in[20] : code_in[20];
    assign corrected_code[21] = (single_error && (syndrome == 8'd21)) ? ~code_in[21] : code_in[21];
    assign corrected_code[22] = (single_error && (syndrome == 8'd22)) ? ~code_in[22] : code_in[22];
    assign corrected_code[23] = (single_error && (syndrome == 8'd23)) ? ~code_in[23] : code_in[23];
    assign corrected_code[24] = (single_error && (syndrome == 8'd24)) ? ~code_in[24] : code_in[24];
    assign corrected_code[25] = (single_error && (syndrome == 8'd25)) ? ~code_in[25] : code_in[25];
    assign corrected_code[26] = (single_error && (syndrome == 8'd26)) ? ~code_in[26] : code_in[26];
    assign corrected_code[27] = (single_error && (syndrome == 8'd27)) ? ~code_in[27] : code_in[27];
    assign corrected_code[28] = (single_error && (syndrome == 8'd28)) ? ~code_in[28] : code_in[28];
    assign corrected_code[29] = (single_error && (syndrome == 8'd29)) ? ~code_in[29] : code_in[29];
    assign corrected_code[30] = (single_error && (syndrome == 8'd30)) ? ~code_in[30] : code_in[30];
    assign corrected_code[31] = (single_error && (syndrome == 8'd31)) ? ~code_in[31] : code_in[31];
    assign corrected_code[32] = (single_error && (syndrome == 8'd32)) ? ~code_in[32] : code_in[32];
    assign corrected_code[33] = (single_error && (syndrome == 8'd33)) ? ~code_in[33] : code_in[33];
    assign corrected_code[34] = (single_error && (syndrome == 8'd34)) ? ~code_in[34] : code_in[34];
    assign corrected_code[35] = (single_error && (syndrome == 8'd35)) ? ~code_in[35] : code_in[35];
    assign corrected_code[36] = (single_error && (syndrome == 8'd36)) ? ~code_in[36] : code_in[36];
    assign corrected_code[37] = (single_error && (syndrome == 8'd37)) ? ~code_in[37] : code_in[37];
    assign corrected_code[38] = (single_error && (syndrome == 8'd38)) ? ~code_in[38] : code_in[38];
    assign corrected_code[39] = (single_error && (syndrome == 8'd39)) ? ~code_in[39] : code_in[39];
    assign corrected_code[40] = (single_error && (syndrome == 8'd40)) ? ~code_in[40] : code_in[40];
    assign corrected_code[41] = (single_error && (syndrome == 8'd41)) ? ~code_in[41] : code_in[41];
    assign corrected_code[42] = (single_error && (syndrome == 8'd42)) ? ~code_in[42] : code_in[42];
    assign corrected_code[43] = (single_error && (syndrome == 8'd43)) ? ~code_in[43] : code_in[43];
    assign corrected_code[44] = (single_error && (syndrome == 8'd44)) ? ~code_in[44] : code_in[44];
    assign corrected_code[45] = (single_error && (syndrome == 8'd45)) ? ~code_in[45] : code_in[45];
    assign corrected_code[46] = (single_error && (syndrome == 8'd46)) ? ~code_in[46] : code_in[46];
    assign corrected_code[47] = (single_error && (syndrome == 8'd47)) ? ~code_in[47] : code_in[47];
    assign corrected_code[48] = (single_error && (syndrome == 8'd48)) ? ~code_in[48] : code_in[48];
    assign corrected_code[49] = (single_error && (syndrome == 8'd49)) ? ~code_in[49] : code_in[49];
    assign corrected_code[50] = (single_error && (syndrome == 8'd50)) ? ~code_in[50] : code_in[50];
    assign corrected_code[51] = (single_error && (syndrome == 8'd51)) ? ~code_in[51] : code_in[51];
    assign corrected_code[52] = (single_error && (syndrome == 8'd52)) ? ~code_in[52] : code_in[52];
    assign corrected_code[53] = (single_error && (syndrome == 8'd53)) ? ~code_in[53] : code_in[53];
    assign corrected_code[54] = (single_error && (syndrome == 8'd54)) ? ~code_in[54] : code_in[54];
    assign corrected_code[55] = (single_error && (syndrome == 8'd55)) ? ~code_in[55] : code_in[55];
    assign corrected_code[56] = (single_error && (syndrome == 8'd56)) ? ~code_in[56] : code_in[56];
    assign corrected_code[57] = (single_error && (syndrome == 8'd57)) ? ~code_in[57] : code_in[57];
    assign corrected_code[58] = (single_error && (syndrome == 8'd58)) ? ~code_in[58] : code_in[58];
    assign corrected_code[59] = (single_error && (syndrome == 8'd59)) ? ~code_in[59] : code_in[59];
    assign corrected_code[60] = (single_error && (syndrome == 8'd60)) ? ~code_in[60] : code_in[60];
    assign corrected_code[61] = (single_error && (syndrome == 8'd61)) ? ~code_in[61] : code_in[61];
    assign corrected_code[62] = (single_error && (syndrome == 8'd62)) ? ~code_in[62] : code_in[62];
    assign corrected_code[63] = (single_error && (syndrome == 8'd63)) ? ~code_in[63] : code_in[63];
    assign corrected_code[64] = (single_error && (syndrome == 8'd64)) ? ~code_in[64] : code_in[64];
    assign corrected_code[65] = (single_error && (syndrome == 8'd65)) ? ~code_in[65] : code_in[65];
    assign corrected_code[66] = (single_error && (syndrome == 8'd66)) ? ~code_in[66] : code_in[66];
    assign corrected_code[67] = (single_error && (syndrome == 8'd67)) ? ~code_in[67] : code_in[67];
    assign corrected_code[68] = (single_error && (syndrome == 8'd68)) ? ~code_in[68] : code_in[68];
    assign corrected_code[69] = (single_error && (syndrome == 8'd69)) ? ~code_in[69] : code_in[69];
    assign corrected_code[70] = (single_error && (syndrome == 8'd70)) ? ~code_in[70] : code_in[70];
    assign corrected_code[71] = (single_error && (syndrome == 8'd71)) ? ~code_in[71] : code_in[71];
    assign corrected_code[72] = (single_error && (syndrome == 8'd72)) ? ~code_in[72] : code_in[72];
    assign corrected_code[73] = (single_error && (syndrome == 8'd73)) ? ~code_in[73] : code_in[73];
    assign corrected_code[74] = (single_error && (syndrome == 8'd74)) ? ~code_in[74] : code_in[74];
    assign corrected_code[75] = (single_error && (syndrome == 8'd75)) ? ~code_in[75] : code_in[75];
    assign corrected_code[76] = (single_error && (syndrome == 8'd76)) ? ~code_in[76] : code_in[76];
    assign corrected_code[77] = (single_error && (syndrome == 8'd77)) ? ~code_in[77] : code_in[77];
    assign corrected_code[78] = (single_error && (syndrome == 8'd78)) ? ~code_in[78] : code_in[78];
    assign corrected_code[79] = (single_error && (syndrome == 8'd79)) ? ~code_in[79] : code_in[79];
    assign corrected_code[80] = (single_error && (syndrome == 8'd80)) ? ~code_in[80] : code_in[80];
    assign corrected_code[81] = (single_error && (syndrome == 8'd81)) ? ~code_in[81] : code_in[81];
    assign corrected_code[82] = (single_error && (syndrome == 8'd82)) ? ~code_in[82] : code_in[82];
    assign corrected_code[83] = (single_error && (syndrome == 8'd83)) ? ~code_in[83] : code_in[83];
    assign corrected_code[84] = (single_error && (syndrome == 8'd84)) ? ~code_in[84] : code_in[84];
    assign corrected_code[85] = (single_error && (syndrome == 8'd85)) ? ~code_in[85] : code_in[85];
    assign corrected_code[86] = (single_error && (syndrome == 8'd86)) ? ~code_in[86] : code_in[86];
    assign corrected_code[87] = (single_error && (syndrome == 8'd87)) ? ~code_in[87] : code_in[87];
    assign corrected_code[88] = (single_error && (syndrome == 8'd88)) ? ~code_in[88] : code_in[88];
    assign corrected_code[89] = (single_error && (syndrome == 8'd89)) ? ~code_in[89] : code_in[89];
    assign corrected_code[90] = (single_error && (syndrome == 8'd90)) ? ~code_in[90] : code_in[90];
    assign corrected_code[91] = (single_error && (syndrome == 8'd91)) ? ~code_in[91] : code_in[91];
    assign corrected_code[92] = (single_error && (syndrome == 8'd92)) ? ~code_in[92] : code_in[92];
    assign corrected_code[93] = (single_error && (syndrome == 8'd93)) ? ~code_in[93] : code_in[93];
    assign corrected_code[94] = (single_error && (syndrome == 8'd94)) ? ~code_in[94] : code_in[94];
    assign corrected_code[95] = (single_error && (syndrome == 8'd95)) ? ~code_in[95] : code_in[95];
    assign corrected_code[96] = (single_error && (syndrome == 8'd96)) ? ~code_in[96] : code_in[96];
    assign corrected_code[97] = (single_error && (syndrome == 8'd97)) ? ~code_in[97] : code_in[97];
    assign corrected_code[98] = (single_error && (syndrome == 8'd98)) ? ~code_in[98] : code_in[98];
    assign corrected_code[99] = (single_error && (syndrome == 8'd99)) ? ~code_in[99] : code_in[99];
    assign corrected_code[100] = (single_error && (syndrome == 8'd100)) ? ~code_in[100] : code_in[100];
    assign corrected_code[101] = (single_error && (syndrome == 8'd101)) ? ~code_in[101] : code_in[101];
    assign corrected_code[102] = (single_error && (syndrome == 8'd102)) ? ~code_in[102] : code_in[102];
    assign corrected_code[103] = (single_error && (syndrome == 8'd103)) ? ~code_in[103] : code_in[103];
    assign corrected_code[104] = (single_error && (syndrome == 8'd104)) ? ~code_in[104] : code_in[104];
    assign corrected_code[105] = (single_error && (syndrome == 8'd105)) ? ~code_in[105] : code_in[105];
    assign corrected_code[106] = (single_error && (syndrome == 8'd106)) ? ~code_in[106] : code_in[106];
    assign corrected_code[107] = (single_error && (syndrome == 8'd107)) ? ~code_in[107] : code_in[107];
    assign corrected_code[108] = (single_error && (syndrome == 8'd108)) ? ~code_in[108] : code_in[108];
    assign corrected_code[109] = (single_error && (syndrome == 8'd109)) ? ~code_in[109] : code_in[109];
    assign corrected_code[110] = (single_error && (syndrome == 8'd110)) ? ~code_in[110] : code_in[110];
    assign corrected_code[111] = (single_error && (syndrome == 8'd111)) ? ~code_in[111] : code_in[111];
    assign corrected_code[112] = (single_error && (syndrome == 8'd112)) ? ~code_in[112] : code_in[112];
    assign corrected_code[113] = (single_error && (syndrome == 8'd113)) ? ~code_in[113] : code_in[113];
    assign corrected_code[114] = (single_error && (syndrome == 8'd114)) ? ~code_in[114] : code_in[114];
    assign corrected_code[115] = (single_error && (syndrome == 8'd115)) ? ~code_in[115] : code_in[115];
    assign corrected_code[116] = (single_error && (syndrome == 8'd116)) ? ~code_in[116] : code_in[116];
    assign corrected_code[117] = (single_error && (syndrome == 8'd117)) ? ~code_in[117] : code_in[117];
    assign corrected_code[118] = (single_error && (syndrome == 8'd118)) ? ~code_in[118] : code_in[118];
    assign corrected_code[119] = (single_error && (syndrome == 8'd119)) ? ~code_in[119] : code_in[119];
    assign corrected_code[120] = (single_error && (syndrome == 8'd120)) ? ~code_in[120] : code_in[120];
    assign corrected_code[121] = (single_error && (syndrome == 8'd121)) ? ~code_in[121] : code_in[121];
    assign corrected_code[122] = (single_error && (syndrome == 8'd122)) ? ~code_in[122] : code_in[122];
    assign corrected_code[123] = (single_error && (syndrome == 8'd123)) ? ~code_in[123] : code_in[123];
    assign corrected_code[124] = (single_error && (syndrome == 8'd124)) ? ~code_in[124] : code_in[124];
    assign corrected_code[125] = (single_error && (syndrome == 8'd125)) ? ~code_in[125] : code_in[125];
    assign corrected_code[126] = (single_error && (syndrome == 8'd126)) ? ~code_in[126] : code_in[126];
    assign corrected_code[127] = (single_error && (syndrome == 8'd127)) ? ~code_in[127] : code_in[127];
    assign corrected_code[128] = (single_error && (syndrome == 8'd128)) ? ~code_in[128] : code_in[128];
    assign corrected_code[129] = (single_error && (syndrome == 8'd129)) ? ~code_in[129] : code_in[129];
    assign corrected_code[130] = (single_error && (syndrome == 8'd130)) ? ~code_in[130] : code_in[130];
    assign corrected_code[131] = (single_error && (syndrome == 8'd131)) ? ~code_in[131] : code_in[131];
    assign corrected_code[132] = (single_error && (syndrome == 8'd132)) ? ~code_in[132] : code_in[132];
    assign corrected_code[133] = (single_error && (syndrome == 8'd133)) ? ~code_in[133] : code_in[133];
    assign corrected_code[134] = (single_error && (syndrome == 8'd134)) ? ~code_in[134] : code_in[134];
    assign corrected_code[135] = (single_error && (syndrome == 8'd135)) ? ~code_in[135] : code_in[135];
    
    // 从纠正后的码字中提取128位数据
    // 数据位在码字中的位置（跳过校验位位置1,2,4,8,16,32,64,128）
    assign data_out = {
        corrected_code[135:129], // data[127:121] 
        corrected_code[127:65],  // data[120:58]
        corrected_code[63:33],   // data[57:27]
        corrected_code[31:17],   // data[26:12] 
        corrected_code[15:9],    // data[11:5]
        corrected_code[7:5],     // data[4:2]
        corrected_code[3],       // data[1]
        corrected_code[0]        // data[0]
    };

endmodule

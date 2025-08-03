// SEC(136,128) 编码器
// 输入：128位数据
// 输出：136位编码后的数据（128位数据 + 8位校验位）
// 使用汉明码实现单错纠正

module sec_encoder_136_128 (
    data_in,
    code_out
);

    input  [127:0] data_in;     // 128位输入数据
    output [135:0] code_out;    // 136位编码输出（包含校验位）

    // 内部信号 - 8个汉明校验位
    wire [7:0] parity_bits;     // P1, P2, P4, P8, P16, P32, P64, P128
    
    // 汉明码校验位计算
    // P1 (位置1): 检查所有二进制表示中第1位为1的位置
    assign parity_bits[0] = data_in[0] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ 
                           data_in[6] ^ data_in[8] ^ data_in[10] ^ data_in[11] ^ 
                           data_in[13] ^ data_in[15] ^ data_in[17] ^ data_in[19] ^ 
                           data_in[21] ^ data_in[23] ^ data_in[25] ^ data_in[26] ^ 
                           data_in[28] ^ data_in[30] ^ data_in[32] ^ data_in[34] ^ 
                           data_in[36] ^ data_in[38] ^ data_in[40] ^ data_in[42] ^ 
                           data_in[44] ^ data_in[46] ^ data_in[48] ^ data_in[50] ^ 
                           data_in[52] ^ data_in[54] ^ data_in[56] ^ data_in[57] ^ 
                           data_in[59] ^ data_in[61] ^ data_in[63] ^ data_in[65] ^ 
                           data_in[67] ^ data_in[69] ^ data_in[71] ^ data_in[73] ^ 
                           data_in[75] ^ data_in[77] ^ data_in[79] ^ data_in[81] ^ 
                           data_in[83] ^ data_in[85] ^ data_in[87] ^ data_in[89] ^ 
                           data_in[90] ^ data_in[92] ^ data_in[94] ^ data_in[96] ^ 
                           data_in[98] ^ data_in[100] ^ data_in[102] ^ data_in[104] ^ 
                           data_in[106] ^ data_in[108] ^ data_in[110] ^ data_in[112] ^ 
                           data_in[114] ^ data_in[116] ^ data_in[118] ^ data_in[120] ^ 
                           data_in[121] ^ data_in[123] ^ data_in[125] ^ data_in[127];
    
    // P2 (位置2): 检查所有二进制表示中第2位为1的位置
    assign parity_bits[1] = data_in[0] ^ data_in[2] ^ data_in[3] ^ data_in[5] ^ 
                           data_in[6] ^ data_in[8] ^ data_in[9] ^ data_in[11] ^ 
                           data_in[12] ^ data_in[14] ^ data_in[15] ^ data_in[17] ^ 
                           data_in[18] ^ data_in[20] ^ data_in[21] ^ data_in[23] ^ 
                           data_in[24] ^ data_in[26] ^ data_in[27] ^ data_in[29] ^ 
                           data_in[30] ^ data_in[32] ^ data_in[33] ^ data_in[35] ^ 
                           data_in[36] ^ data_in[38] ^ data_in[39] ^ data_in[41] ^ 
                           data_in[42] ^ data_in[44] ^ data_in[45] ^ data_in[47] ^ 
                           data_in[48] ^ data_in[50] ^ data_in[51] ^ data_in[53] ^ 
                           data_in[54] ^ data_in[56] ^ data_in[57] ^ data_in[59] ^ 
                           data_in[60] ^ data_in[62] ^ data_in[63] ^ data_in[65] ^ 
                           data_in[66] ^ data_in[68] ^ data_in[69] ^ data_in[71] ^ 
                           data_in[72] ^ data_in[74] ^ data_in[75] ^ data_in[77] ^ 
                           data_in[78] ^ data_in[80] ^ data_in[81] ^ data_in[83] ^ 
                           data_in[84] ^ data_in[86] ^ data_in[87] ^ data_in[89] ^ 
                           data_in[90] ^ data_in[92] ^ data_in[93] ^ data_in[95] ^ 
                           data_in[96] ^ data_in[98] ^ data_in[99] ^ data_in[101] ^ 
                           data_in[102] ^ data_in[104] ^ data_in[105] ^ data_in[107] ^ 
                           data_in[108] ^ data_in[110] ^ data_in[111] ^ data_in[113] ^ 
                           data_in[114] ^ data_in[116] ^ data_in[117] ^ data_in[119] ^ 
                           data_in[120] ^ data_in[122] ^ data_in[123] ^ data_in[125] ^ 
                           data_in[126];
    
    // P4 (位置4): 检查所有二进制表示中第3位为1的位置
    assign parity_bits[2] = data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[7] ^ 
                           data_in[8] ^ data_in[9] ^ data_in[10] ^ data_in[14] ^ 
                           data_in[15] ^ data_in[16] ^ data_in[17] ^ data_in[21] ^ 
                           data_in[22] ^ data_in[23] ^ data_in[24] ^ data_in[28] ^ 
                           data_in[29] ^ data_in[30] ^ data_in[31] ^ data_in[35] ^ 
                           data_in[36] ^ data_in[37] ^ data_in[38] ^ data_in[42] ^ 
                           data_in[43] ^ data_in[44] ^ data_in[45] ^ data_in[49] ^ 
                           data_in[50] ^ data_in[51] ^ data_in[52] ^ data_in[56] ^ 
                           data_in[57] ^ data_in[58] ^ data_in[59] ^ data_in[63] ^ 
                           data_in[64] ^ data_in[65] ^ data_in[66] ^ data_in[70] ^ 
                           data_in[71] ^ data_in[72] ^ data_in[73] ^ data_in[77] ^ 
                           data_in[78] ^ data_in[79] ^ data_in[80] ^ data_in[84] ^ 
                           data_in[85] ^ data_in[86] ^ data_in[87] ^ data_in[91] ^ 
                           data_in[92] ^ data_in[93] ^ data_in[94] ^ data_in[98] ^ 
                           data_in[99] ^ data_in[100] ^ data_in[101] ^ data_in[105] ^ 
                           data_in[106] ^ data_in[107] ^ data_in[108] ^ data_in[112] ^ 
                           data_in[113] ^ data_in[114] ^ data_in[115] ^ data_in[119] ^ 
                           data_in[120] ^ data_in[121] ^ data_in[122] ^ data_in[126] ^ 
                           data_in[127];
    
    // P8 (位置8): 检查所有二进制表示中第4位为1的位置
    assign parity_bits[3] = data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7] ^ 
                           data_in[11] ^ data_in[12] ^ data_in[13] ^ data_in[14] ^ 
                           data_in[18] ^ data_in[19] ^ data_in[20] ^ data_in[21] ^ 
                           data_in[25] ^ data_in[26] ^ data_in[27] ^ data_in[28] ^ 
                           data_in[32] ^ data_in[33] ^ data_in[34] ^ data_in[35] ^ 
                           data_in[39] ^ data_in[40] ^ data_in[41] ^ data_in[42] ^ 
                           data_in[46] ^ data_in[47] ^ data_in[48] ^ data_in[49] ^ 
                           data_in[53] ^ data_in[54] ^ data_in[55] ^ data_in[56] ^ 
                           data_in[60] ^ data_in[61] ^ data_in[62] ^ data_in[63] ^ 
                           data_in[67] ^ data_in[68] ^ data_in[69] ^ data_in[70] ^ 
                           data_in[74] ^ data_in[75] ^ data_in[76] ^ data_in[77] ^ 
                           data_in[81] ^ data_in[82] ^ data_in[83] ^ data_in[84] ^ 
                           data_in[88] ^ data_in[89] ^ data_in[90] ^ data_in[91] ^ 
                           data_in[95] ^ data_in[96] ^ data_in[97] ^ data_in[98] ^ 
                           data_in[102] ^ data_in[103] ^ data_in[104] ^ data_in[105] ^ 
                           data_in[109] ^ data_in[110] ^ data_in[111] ^ data_in[112] ^ 
                           data_in[116] ^ data_in[117] ^ data_in[118] ^ data_in[119] ^ 
                           data_in[123] ^ data_in[124] ^ data_in[125] ^ data_in[126];
    
    // P16 (位置16): 检查所有二进制表示中第5位为1的位置
    assign parity_bits[4] = data_in[15] ^ data_in[16] ^ data_in[17] ^ data_in[18] ^ 
                           data_in[19] ^ data_in[20] ^ data_in[21] ^ data_in[22] ^ 
                           data_in[23] ^ data_in[24] ^ data_in[25] ^ data_in[26] ^ 
                           data_in[27] ^ data_in[28] ^ data_in[29] ^ data_in[30] ^ 
                           data_in[46] ^ data_in[47] ^ data_in[48] ^ data_in[49] ^ 
                           data_in[50] ^ data_in[51] ^ data_in[52] ^ data_in[53] ^ 
                           data_in[54] ^ data_in[55] ^ data_in[56] ^ data_in[57] ^ 
                           data_in[58] ^ data_in[59] ^ data_in[60] ^ data_in[61] ^ 
                           data_in[77] ^ data_in[78] ^ data_in[79] ^ data_in[80] ^ 
                           data_in[81] ^ data_in[82] ^ data_in[83] ^ data_in[84] ^ 
                           data_in[85] ^ data_in[86] ^ data_in[87] ^ data_in[88] ^ 
                           data_in[89] ^ data_in[90] ^ data_in[91] ^ data_in[92] ^ 
                           data_in[108] ^ data_in[109] ^ data_in[110] ^ data_in[111] ^ 
                           data_in[112] ^ data_in[113] ^ data_in[114] ^ data_in[115] ^ 
                           data_in[116] ^ data_in[117] ^ data_in[118] ^ data_in[119] ^ 
                           data_in[120] ^ data_in[121] ^ data_in[122] ^ data_in[123];
    
    // P32 (位置32): 检查所有二进制表示中第6位为1的位置
    assign parity_bits[5] = data_in[31] ^ data_in[32] ^ data_in[33] ^ data_in[34] ^ 
                           data_in[35] ^ data_in[36] ^ data_in[37] ^ data_in[38] ^ 
                           data_in[39] ^ data_in[40] ^ data_in[41] ^ data_in[42] ^ 
                           data_in[43] ^ data_in[44] ^ data_in[45] ^ data_in[46] ^ 
                           data_in[47] ^ data_in[48] ^ data_in[49] ^ data_in[50] ^ 
                           data_in[51] ^ data_in[52] ^ data_in[53] ^ data_in[54] ^ 
                           data_in[55] ^ data_in[56] ^ data_in[57] ^ data_in[58] ^ 
                           data_in[59] ^ data_in[60] ^ data_in[61] ^ data_in[62] ^ 
                           data_in[93] ^ data_in[94] ^ data_in[95] ^ data_in[96] ^ 
                           data_in[97] ^ data_in[98] ^ data_in[99] ^ data_in[100] ^ 
                           data_in[101] ^ data_in[102] ^ data_in[103] ^ data_in[104] ^ 
                           data_in[105] ^ data_in[106] ^ data_in[107] ^ data_in[108] ^ 
                           data_in[109] ^ data_in[110] ^ data_in[111] ^ data_in[112] ^ 
                           data_in[113] ^ data_in[114] ^ data_in[115] ^ data_in[116] ^ 
                           data_in[117] ^ data_in[118] ^ data_in[119] ^ data_in[120] ^ 
                           data_in[121] ^ data_in[122] ^ data_in[123] ^ data_in[124];
    
    // P64 (位置64): 检查所有二进制表示中第7位为1的位置
    assign parity_bits[6] = data_in[63] ^ data_in[64] ^ data_in[65] ^ data_in[66] ^ 
                           data_in[67] ^ data_in[68] ^ data_in[69] ^ data_in[70] ^ 
                           data_in[71] ^ data_in[72] ^ data_in[73] ^ data_in[74] ^ 
                           data_in[75] ^ data_in[76] ^ data_in[77] ^ data_in[78] ^ 
                           data_in[79] ^ data_in[80] ^ data_in[81] ^ data_in[82] ^ 
                           data_in[83] ^ data_in[84] ^ data_in[85] ^ data_in[86] ^ 
                           data_in[87] ^ data_in[88] ^ data_in[89] ^ data_in[90] ^ 
                           data_in[91] ^ data_in[92] ^ data_in[93] ^ data_in[94] ^ 
                           data_in[95] ^ data_in[96] ^ data_in[97] ^ data_in[98] ^ 
                           data_in[99] ^ data_in[100] ^ data_in[101] ^ data_in[102] ^ 
                           data_in[103] ^ data_in[104] ^ data_in[105] ^ data_in[106] ^ 
                           data_in[107] ^ data_in[108] ^ data_in[109] ^ data_in[110] ^ 
                           data_in[111] ^ data_in[112] ^ data_in[113] ^ data_in[114] ^ 
                           data_in[115] ^ data_in[116] ^ data_in[117] ^ data_in[118] ^ 
                           data_in[119] ^ data_in[120] ^ data_in[121] ^ data_in[122] ^ 
                           data_in[123] ^ data_in[124] ^ data_in[125] ^ data_in[126];
    
    // P128 (位置128): 检查所有二进制表示中第8位为1的位置
    assign parity_bits[7] = data_in[127];
    
    // 输出码字构造
    // 将数据位和校验位按照汉明码的位置要求排列
    assign code_out = {
        // 位135-129: data_in[127:121]  
        data_in[127:121],
        
        // 位128: P128校验位
        parity_bits[7],
        
        // 位127-65: data_in[120:58]
        data_in[120:58],
        
        // 位64: P64校验位
        parity_bits[6],
        
        // 位63-33: data_in[57:27]
        data_in[57:27],
        
        // 位32: P32校验位
        parity_bits[5],
        
        // 位31-17: data_in[26:12]
        data_in[26:12],
        
        // 位16: P16校验位
        parity_bits[4],
        
        // 位15-9: data_in[11:5]
        data_in[11:5],
        
        // 位8: P8校验位
        parity_bits[3],
        
        // 位7-5: data_in[4:2]
        data_in[4:2],
        
        // 位4: P4校验位
        parity_bits[2],
        
        // 位3: data_in[1]
        data_in[1],
        
        // 位2: P2校验位
        parity_bits[1],
        
        // 位1: P1校验位
        parity_bits[0],
        
        // 位0: data_in[0]
        data_in[0]
    };

endmodule

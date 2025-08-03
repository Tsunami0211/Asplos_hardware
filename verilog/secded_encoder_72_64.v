// SECDED(72,64) 编码器
// 输入：64位数据
// 输出：72位编码后的数据（64位数据 + 8位校验位）
// 使用汉明码扩展实现单错纠正双错检测

module secded_encoder_72_64 (
    data_in,
    code_out
);

    input  [63:0] data_in;      // 64位输入数据
    output [71:0] code_out;     // 72位编码输出（包含校验位）

    // 内部信号
    wire [6:0] parity_bits;     // 7个汉明校验位 (P1, P2, P4, P8, P16, P32, P64)
    wire       overall_parity;   // 总体校验位 (P0)
    
    // 数据位分配：将64位数据分配到72位码字中（跳过校验位位置）
    // 校验位位置：P0(0), P1(1), P2(2), P4(4), P8(8), P16(16), P32(32), P64(64)
    // 数据位位置：3,5,6,7,9,10,11,12,13,14,15,17,18,...
    
    // 计算汉明校验位
    // P1 (位置1): 检查所有奇数位置（除了校验位本身）
    assign parity_bits[0] = data_in[0] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ 
                           data_in[6] ^ data_in[8] ^ data_in[10] ^ data_in[11] ^ 
                           data_in[13] ^ data_in[15] ^ data_in[17] ^ data_in[19] ^ 
                           data_in[21] ^ data_in[23] ^ data_in[25] ^ data_in[26] ^ 
                           data_in[28] ^ data_in[30] ^ data_in[32] ^ data_in[34] ^ 
                           data_in[36] ^ data_in[38] ^ data_in[40] ^ data_in[42] ^ 
                           data_in[44] ^ data_in[46] ^ data_in[48] ^ data_in[50] ^ 
                           data_in[52] ^ data_in[54] ^ data_in[56] ^ data_in[57] ^ 
                           data_in[59] ^ data_in[61] ^ data_in[63];
    
    // P2 (位置2): 检查位置模4为2或3的位
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
                           data_in[60] ^ data_in[62] ^ data_in[63];
    
    // P4 (位置4): 检查位置模8为4,5,6,7的位
    assign parity_bits[2] = data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[7] ^ 
                           data_in[8] ^ data_in[9] ^ data_in[10] ^ data_in[14] ^ 
                           data_in[15] ^ data_in[16] ^ data_in[17] ^ data_in[21] ^ 
                           data_in[22] ^ data_in[23] ^ data_in[24] ^ data_in[28] ^ 
                           data_in[29] ^ data_in[30] ^ data_in[31] ^ data_in[35] ^ 
                           data_in[36] ^ data_in[37] ^ data_in[38] ^ data_in[42] ^ 
                           data_in[43] ^ data_in[44] ^ data_in[45] ^ data_in[49] ^ 
                           data_in[50] ^ data_in[51] ^ data_in[52] ^ data_in[56] ^ 
                           data_in[57] ^ data_in[58] ^ data_in[59];
    
    // P8 (位置8): 检查位置模16为8-15的位
    assign parity_bits[3] = data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7] ^ 
                           data_in[11] ^ data_in[12] ^ data_in[13] ^ data_in[14] ^ 
                           data_in[18] ^ data_in[19] ^ data_in[20] ^ data_in[21] ^ 
                           data_in[25] ^ data_in[26] ^ data_in[27] ^ data_in[28] ^ 
                           data_in[32] ^ data_in[33] ^ data_in[34] ^ data_in[35] ^ 
                           data_in[39] ^ data_in[40] ^ data_in[41] ^ data_in[42] ^ 
                           data_in[46] ^ data_in[47] ^ data_in[48] ^ data_in[49] ^ 
                           data_in[53] ^ data_in[54] ^ data_in[55] ^ data_in[56];
    
    // P16 (位置16): 检查位置模32为16-31的位
    assign parity_bits[4] = data_in[15] ^ data_in[16] ^ data_in[17] ^ data_in[18] ^ 
                           data_in[19] ^ data_in[20] ^ data_in[21] ^ data_in[22] ^ 
                           data_in[23] ^ data_in[24] ^ data_in[25] ^ data_in[26] ^ 
                           data_in[27] ^ data_in[28] ^ data_in[29] ^ data_in[30] ^ 
                           data_in[46] ^ data_in[47] ^ data_in[48] ^ data_in[49] ^ 
                           data_in[50] ^ data_in[51] ^ data_in[52] ^ data_in[53] ^ 
                           data_in[54] ^ data_in[55] ^ data_in[56] ^ data_in[57] ^ 
                           data_in[58] ^ data_in[59] ^ data_in[60] ^ data_in[61];
    
    // P32 (位置32): 检查位置模64为32-63的位
    assign parity_bits[5] = data_in[31] ^ data_in[32] ^ data_in[33] ^ data_in[34] ^ 
                           data_in[35] ^ data_in[36] ^ data_in[37] ^ data_in[38] ^ 
                           data_in[39] ^ data_in[40] ^ data_in[41] ^ data_in[42] ^ 
                           data_in[43] ^ data_in[44] ^ data_in[45] ^ data_in[46] ^ 
                           data_in[47] ^ data_in[48] ^ data_in[49] ^ data_in[50] ^ 
                           data_in[51] ^ data_in[52] ^ data_in[53] ^ data_in[54] ^ 
                           data_in[55] ^ data_in[56] ^ data_in[57] ^ data_in[58] ^ 
                           data_in[59] ^ data_in[60] ^ data_in[61] ^ data_in[62];
    
    // P64 (位置64): 检查位置≥64的位
    assign parity_bits[6] = data_in[63];
    
    // 总体校验位P0：对所有位（包括汉明校验位和数据位）进行XOR
    assign overall_parity = ^data_in ^ ^parity_bits;
    
    // 输出码字构造
    // 将数据位和校验位按照汉明码的位置要求排列
    assign code_out = {
        // 位71-65: data_in[63:57]  
        data_in[63:57],
        
        // 位64: P64校验位
        parity_bits[6],
        
        // 位63-33: data_in[56:26]
        data_in[56:26],
        
        // 位32: P32校验位
        parity_bits[5],
        
        // 位31-17: data_in[25:11]
        data_in[25:11],
        
        // 位16: P16校验位
        parity_bits[4],
        
        // 位15-9: data_in[10:4]
        data_in[10:4],
        
        // 位8: P8校验位
        parity_bits[3],
        
        // 位7-5: data_in[3:1]
        data_in[3:1],
        
        // 位4: P4校验位
        parity_bits[2],
        
        // 位3: data_in[0]
        data_in[0],
        
        // 位2: P2校验位
        parity_bits[1],
        
        // 位1: P1校验位
        parity_bits[0],
        
        // 位0: P0总体校验位
        overall_parity
    };

endmodule

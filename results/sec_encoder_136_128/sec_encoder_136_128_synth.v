/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : W-2024.09-SP5
// Date      : Fri Aug  1 20:30:04 2025
/////////////////////////////////////////////////////////////


module sec_encoder_136_128 ( data_in, code_out );
  input [127:0] data_in;
  output [135:0] code_out;
  wire   code_out_135, code_out_134, code_out_133, code_out_132, code_out_131,
         code_out_130, code_out_129, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156, n157, n158, n159, n160, n161, n162, n163, n164, n165, n166,
         n167, n168, n169, n170, n171, n172, n173, n174, n175, n176, n177,
         n178, n179, n180, n181, n182, n183, n184;
  assign code_out[128] = code_out_135;
  assign code_out[135] = code_out_135;
  assign code_out_135 = data_in[127];
  assign code_out[134] = code_out_134;
  assign code_out_134 = data_in[126];
  assign code_out[133] = code_out_133;
  assign code_out_133 = data_in[125];
  assign code_out[132] = code_out_132;
  assign code_out_132 = data_in[124];
  assign code_out[131] = code_out_131;
  assign code_out_131 = data_in[123];
  assign code_out[130] = code_out_130;
  assign code_out_130 = data_in[122];
  assign code_out[129] = code_out_129;
  assign code_out_129 = data_in[121];
  assign code_out[127] = data_in[120];
  assign code_out[126] = data_in[119];
  assign code_out[125] = data_in[118];
  assign code_out[124] = data_in[117];
  assign code_out[123] = data_in[116];
  assign code_out[122] = data_in[115];
  assign code_out[121] = data_in[114];
  assign code_out[120] = data_in[113];
  assign code_out[119] = data_in[112];
  assign code_out[118] = data_in[111];
  assign code_out[117] = data_in[110];
  assign code_out[116] = data_in[109];
  assign code_out[115] = data_in[108];
  assign code_out[114] = data_in[107];
  assign code_out[113] = data_in[106];
  assign code_out[112] = data_in[105];
  assign code_out[111] = data_in[104];
  assign code_out[110] = data_in[103];
  assign code_out[109] = data_in[102];
  assign code_out[108] = data_in[101];
  assign code_out[107] = data_in[100];
  assign code_out[106] = data_in[99];
  assign code_out[105] = data_in[98];
  assign code_out[104] = data_in[97];
  assign code_out[103] = data_in[96];
  assign code_out[102] = data_in[95];
  assign code_out[101] = data_in[94];
  assign code_out[100] = data_in[93];
  assign code_out[99] = data_in[92];
  assign code_out[98] = data_in[91];
  assign code_out[97] = data_in[90];
  assign code_out[96] = data_in[89];
  assign code_out[95] = data_in[88];
  assign code_out[94] = data_in[87];
  assign code_out[93] = data_in[86];
  assign code_out[92] = data_in[85];
  assign code_out[91] = data_in[84];
  assign code_out[90] = data_in[83];
  assign code_out[89] = data_in[82];
  assign code_out[88] = data_in[81];
  assign code_out[87] = data_in[80];
  assign code_out[86] = data_in[79];
  assign code_out[85] = data_in[78];
  assign code_out[84] = data_in[77];
  assign code_out[83] = data_in[76];
  assign code_out[82] = data_in[75];
  assign code_out[81] = data_in[74];
  assign code_out[80] = data_in[73];
  assign code_out[79] = data_in[72];
  assign code_out[78] = data_in[71];
  assign code_out[77] = data_in[70];
  assign code_out[76] = data_in[69];
  assign code_out[75] = data_in[68];
  assign code_out[74] = data_in[67];
  assign code_out[73] = data_in[66];
  assign code_out[72] = data_in[65];
  assign code_out[71] = data_in[64];
  assign code_out[70] = data_in[63];
  assign code_out[69] = data_in[62];
  assign code_out[68] = data_in[61];
  assign code_out[67] = data_in[60];
  assign code_out[66] = data_in[59];
  assign code_out[65] = data_in[58];
  assign code_out[63] = data_in[57];
  assign code_out[62] = data_in[56];
  assign code_out[61] = data_in[55];
  assign code_out[60] = data_in[54];
  assign code_out[59] = data_in[53];
  assign code_out[58] = data_in[52];
  assign code_out[57] = data_in[51];
  assign code_out[56] = data_in[50];
  assign code_out[55] = data_in[49];
  assign code_out[54] = data_in[48];
  assign code_out[53] = data_in[47];
  assign code_out[52] = data_in[46];
  assign code_out[51] = data_in[45];
  assign code_out[50] = data_in[44];
  assign code_out[49] = data_in[43];
  assign code_out[48] = data_in[42];
  assign code_out[47] = data_in[41];
  assign code_out[46] = data_in[40];
  assign code_out[45] = data_in[39];
  assign code_out[44] = data_in[38];
  assign code_out[43] = data_in[37];
  assign code_out[42] = data_in[36];
  assign code_out[41] = data_in[35];
  assign code_out[40] = data_in[34];
  assign code_out[39] = data_in[33];
  assign code_out[38] = data_in[32];
  assign code_out[37] = data_in[31];
  assign code_out[36] = data_in[30];
  assign code_out[35] = data_in[29];
  assign code_out[34] = data_in[28];
  assign code_out[33] = data_in[27];
  assign code_out[31] = data_in[26];
  assign code_out[30] = data_in[25];
  assign code_out[29] = data_in[24];
  assign code_out[28] = data_in[23];
  assign code_out[27] = data_in[22];
  assign code_out[26] = data_in[21];
  assign code_out[25] = data_in[20];
  assign code_out[24] = data_in[19];
  assign code_out[23] = data_in[18];
  assign code_out[22] = data_in[17];
  assign code_out[21] = data_in[16];
  assign code_out[20] = data_in[15];
  assign code_out[19] = data_in[14];
  assign code_out[18] = data_in[13];
  assign code_out[17] = data_in[12];
  assign code_out[15] = data_in[11];
  assign code_out[14] = data_in[10];
  assign code_out[13] = data_in[9];
  assign code_out[12] = data_in[8];
  assign code_out[11] = data_in[7];
  assign code_out[10] = data_in[6];
  assign code_out[9] = data_in[5];
  assign code_out[7] = data_in[4];
  assign code_out[6] = data_in[3];
  assign code_out[5] = data_in[2];
  assign code_out[3] = data_in[1];
  assign code_out[0] = data_in[0];

  SAEDRVT14_INV_0P5 U100 ( .A(n93), .X(code_out[8]) );
  SAEDRVT14_EO4_1 U101 ( .A1(code_out[91]), .A2(code_out[55]), .A3(n94), .A4(
        code_out[31]), .X(n93) );
  SAEDRVT14_EO4_1 U102 ( .A1(code_out[26]), .A2(n95), .A3(n96), .A4(n97), .X(
        n94) );
  SAEDRVT14_EO4_1 U103 ( .A1(n98), .A2(n99), .A3(n100), .A4(n101), .X(n96) );
  SAEDRVT14_EO4_1 U104 ( .A1(n102), .A2(n103), .A3(code_out[119]), .A4(n104), 
        .X(n95) );
  SAEDRVT14_EO4_1 U105 ( .A1(n105), .A2(n106), .A3(n107), .A4(code_out_134), 
        .X(code_out[64]) );
  SAEDRVT14_EO4_1 U106 ( .A1(n108), .A2(n109), .A3(n110), .A4(n111), .X(n107)
         );
  SAEDRVT14_EO4_1 U107 ( .A1(n98), .A2(n112), .A3(n113), .A4(n114), .X(n106)
         );
  SAEDRVT14_EN3_1 U108 ( .A1(n115), .A2(n116), .A3(n117), .X(n98) );
  SAEDRVT14_EN3_1 U109 ( .A1(code_out[83]), .A2(n118), .A3(n119), .X(n117) );
  SAEDRVT14_EN3_1 U110 ( .A1(n120), .A2(n121), .A3(n122), .X(code_out[4]) );
  SAEDRVT14_EO4_1 U111 ( .A1(n123), .A2(n124), .A3(code_out[105]), .A4(
        code_out[34]), .X(n122) );
  SAEDRVT14_EN3_1 U112 ( .A1(n125), .A2(n126), .A3(n127), .X(n121) );
  SAEDRVT14_EO4_1 U113 ( .A1(n128), .A2(n129), .A3(n101), .A4(n110), .X(n126)
         );
  SAEDRVT14_EN3_1 U114 ( .A1(n130), .A2(n131), .A3(n132), .X(n110) );
  SAEDRVT14_EN3_1 U115 ( .A1(code_out[80]), .A2(code_out[71]), .A3(n104), .X(
        n132) );
  SAEDRVT14_EO2_0P5 U116 ( .A1(code_out[98]), .A2(code_out[77]), .X(n104) );
  SAEDRVT14_EN2_1 U117 ( .A1(n133), .A2(code_out[11]), .X(n101) );
  SAEDRVT14_EO4_1 U118 ( .A1(n134), .A2(n135), .A3(n136), .A4(n137), .X(n125)
         );
  SAEDRVT14_EO4_1 U119 ( .A1(n138), .A2(n137), .A3(n139), .A4(n140), .X(
        code_out[32]) );
  SAEDRVT14_EO2_0P5 U120 ( .A1(n141), .A2(n142), .X(n140) );
  SAEDRVT14_EN3_1 U121 ( .A1(n143), .A2(n144), .A3(n145), .X(n137) );
  SAEDRVT14_EN3_1 U122 ( .A1(code_out[49]), .A2(code_out[43]), .A3(
        code_out[37]), .X(n145) );
  SAEDRVT14_EO4_1 U123 ( .A1(n118), .A2(n146), .A3(code_out[41]), .A4(
        code_out[122]), .X(n138) );
  SAEDRVT14_EO4_1 U124 ( .A1(code_out[110]), .A2(code_out[104]), .A3(
        code_out[116]), .A4(code_out_132), .X(n118) );
  SAEDRVT14_EO4_1 U125 ( .A1(n147), .A2(n148), .A3(n149), .A4(n134), .X(
        code_out[2]) );
  SAEDRVT14_EO2_0P5 U126 ( .A1(code_out[5]), .A2(code_out[13]), .X(n134) );
  SAEDRVT14_EO4_1 U127 ( .A1(n150), .A2(code_out[0]), .A3(n151), .A4(n116), 
        .X(n149) );
  SAEDRVT14_EN2_1 U128 ( .A1(code_out[81]), .A2(code_out[75]), .X(n116) );
  SAEDRVT14_EN3_1 U129 ( .A1(n152), .A2(n153), .A3(n154), .X(n147) );
  SAEDRVT14_EO4_1 U130 ( .A1(n155), .A2(n143), .A3(n156), .A4(n157), .X(n153)
         );
  SAEDRVT14_EO2_0P5 U131 ( .A1(n158), .A2(code_out[51]), .X(n143) );
  SAEDRVT14_EO4_1 U132 ( .A1(n133), .A2(n159), .A3(n130), .A4(n97), .X(n152)
         );
  SAEDRVT14_EN3_1 U133 ( .A1(n141), .A2(n160), .A3(n161), .X(n97) );
  SAEDRVT14_EN3_1 U134 ( .A1(code_out[9]), .A2(code_out[17]), .A3(n162), .X(
        n161) );
  SAEDRVT14_EO4_1 U135 ( .A1(n112), .A2(code_out[39]), .A3(n163), .A4(n164), 
        .X(n141) );
  SAEDRVT14_EN3_1 U136 ( .A1(code_out[69]), .A2(code_out[47]), .A3(
        code_out[45]), .X(n163) );
  SAEDRVT14_EO4_1 U137 ( .A1(n123), .A2(n165), .A3(n166), .A4(code_out[102]), 
        .X(n112) );
  SAEDRVT14_EO2_0P5 U138 ( .A1(code_out[126]), .A2(code_out[112]), .X(n123) );
  SAEDRVT14_EO4_1 U139 ( .A1(code_out[79]), .A2(code_out[73]), .A3(n167), .A4(
        n142), .X(n130) );
  SAEDRVT14_INV_0P5 U140 ( .A(n168), .X(n142) );
  SAEDRVT14_EN4_M_1 U141 ( .A1(code_out[106]), .A2(code_out[100]), .A3(
        code_out[114]), .A4(code_out[108]), .X(n168) );
  SAEDRVT14_EN3_1 U142 ( .A1(code_out_134), .A2(code_out[41]), .A3(
        code_out[19]), .X(n133) );
  SAEDRVT14_EO4_1 U143 ( .A1(n169), .A2(n170), .A3(n171), .A4(n172), .X(
        code_out[1]) );
  SAEDRVT14_EN2_1 U144 ( .A1(n160), .A2(n164), .X(n172) );
  SAEDRVT14_EO2_0P5 U145 ( .A1(n124), .A2(code_out[38]), .X(n164) );
  SAEDRVT14_EO2_0P5 U146 ( .A1(code_out[62]), .A2(code_out[48]), .X(n124) );
  SAEDRVT14_EO2_0P5 U147 ( .A1(code_out[15]), .A2(code_out[10]), .X(n160) );
  SAEDRVT14_EO4_1 U148 ( .A1(n144), .A2(n173), .A3(n135), .A4(n167), .X(n171)
         );
  SAEDRVT14_EN3_1 U149 ( .A1(code_out[78]), .A2(code_out[72]), .A3(n103), .X(
        n167) );
  SAEDRVT14_EO2_0P5 U150 ( .A1(code_out[84]), .A2(code_out[70]), .X(n103) );
  SAEDRVT14_EO4_1 U151 ( .A1(code_out_135), .A2(code_out[3]), .A3(n154), .A4(
        code_out[14]), .X(n135) );
  SAEDRVT14_EN2_1 U152 ( .A1(code_out[6]), .A2(code_out[12]), .X(n154) );
  SAEDRVT14_EN3_1 U153 ( .A1(n108), .A2(n156), .A3(n174), .X(n144) );
  SAEDRVT14_EN3_1 U154 ( .A1(code_out[50]), .A2(code_out[44]), .A3(
        code_out[42]), .X(n156) );
  SAEDRVT14_EO3_0P5 U155 ( .A1(code_out[113]), .A2(code_out[107]), .A3(
        code_out[101]), .X(n108) );
  SAEDRVT14_EO4_1 U156 ( .A1(n99), .A2(n175), .A3(n176), .A4(n119), .X(n170)
         );
  SAEDRVT14_EO2_0P5 U157 ( .A1(n151), .A2(code_out[74]), .X(n119) );
  SAEDRVT14_EN3_1 U158 ( .A1(code_out_133), .A2(code_out[82]), .A3(
        code_out[76]), .X(n151) );
  SAEDRVT14_EO4_1 U159 ( .A1(code_out[7]), .A2(code_out[18]), .A3(n177), .A4(
        n146), .X(n99) );
  SAEDRVT14_EO2_0P5 U160 ( .A1(code_out[46]), .A2(code_out[40]), .X(n146) );
  SAEDRVT14_EO4_1 U161 ( .A1(n178), .A2(n165), .A3(code_out[80]), .A4(
        code_out[0]), .X(n169) );
  SAEDRVT14_EO4_1 U162 ( .A1(code_out[111]), .A2(code_out[109]), .A3(
        code_out[105]), .A4(code_out[103]), .X(n165) );
  SAEDRVT14_EO4_1 U163 ( .A1(code_out[116]), .A2(n179), .A3(code_out[62]), 
        .A4(code_out[126]), .X(code_out[16]) );
  SAEDRVT14_EO4_1 U164 ( .A1(n128), .A2(n174), .A3(n180), .A4(n181), .X(n179)
         );
  SAEDRVT14_EN3_1 U165 ( .A1(n115), .A2(code_out[98]), .A3(code_out[84]), .X(
        n181) );
  SAEDRVT14_EO2_0P5 U166 ( .A1(code_out[95]), .A2(code_out[89]), .X(n115) );
  SAEDRVT14_EO4_1 U167 ( .A1(n139), .A2(n158), .A3(n182), .A4(n155), .X(n180)
         );
  SAEDRVT14_EO2_0P5 U168 ( .A1(n120), .A2(n173), .X(n155) );
  SAEDRVT14_EN3_1 U169 ( .A1(code_out[31]), .A2(n114), .A3(n129), .X(n173) );
  SAEDRVT14_EN3_1 U170 ( .A1(code_out[22]), .A2(code_out[20]), .A3(n183), .X(
        n129) );
  SAEDRVT14_EN3_1 U171 ( .A1(code_out[36]), .A2(code_out[28]), .A3(
        code_out[26]), .X(n183) );
  SAEDRVT14_EO2_0P5 U172 ( .A1(n127), .A2(n102), .X(n114) );
  SAEDRVT14_INV_0P5 U173 ( .A(n184), .X(n102) );
  SAEDRVT14_EN4_M_1 U174 ( .A1(code_out[90]), .A2(code_out[88]), .A3(
        code_out[97]), .A4(code_out[96]), .X(n184) );
  SAEDRVT14_EN2_1 U175 ( .A1(code_out[99]), .A2(code_out[94]), .X(n127) );
  SAEDRVT14_EN2_1 U176 ( .A1(code_out[35]), .A2(code_out[29]), .X(n120) );
  SAEDRVT14_EO4_1 U177 ( .A1(n166), .A2(n131), .A3(n162), .A4(n177), .X(n182)
         );
  SAEDRVT14_EO3_0P5 U178 ( .A1(code_out[34]), .A2(code_out[30]), .A3(
        code_out[24]), .X(n177) );
  SAEDRVT14_EN3_1 U179 ( .A1(code_out[33]), .A2(code_out[25]), .A3(
        code_out[23]), .X(n162) );
  SAEDRVT14_EO3_0P5 U180 ( .A1(code_out[122]), .A2(n175), .A3(n148), .X(n131)
         );
  SAEDRVT14_EO4_1 U181 ( .A1(code_out[87]), .A2(code_out[85]), .A3(
        code_out[91]), .A4(code_out[93]), .X(n148) );
  SAEDRVT14_EO2_0P5 U182 ( .A1(code_out[92]), .A2(code_out[86]), .X(n175) );
  SAEDRVT14_EO2_0P5 U183 ( .A1(code_out[124]), .A2(code_out[118]), .X(n166) );
  SAEDRVT14_EO2_0P5 U184 ( .A1(n111), .A2(code_out[57]), .X(n158) );
  SAEDRVT14_EO2_0P5 U185 ( .A1(code_out_130), .A2(code_out[120]), .X(n111) );
  SAEDRVT14_EO2_0P5 U186 ( .A1(n100), .A2(n136), .X(n139) );
  SAEDRVT14_EO2_0P5 U187 ( .A1(code_out[55]), .A2(code_out[65]), .X(n136) );
  SAEDRVT14_EN3_1 U188 ( .A1(code_out[61]), .A2(n176), .A3(n159), .X(n100) );
  SAEDRVT14_EO4_1 U189 ( .A1(code_out[67]), .A2(code_out[59]), .A3(n178), .A4(
        code_out[53]), .X(n159) );
  SAEDRVT14_EO2_0P5 U190 ( .A1(code_out[60]), .A2(code_out[54]), .X(n178) );
  SAEDRVT14_EN3_1 U191 ( .A1(code_out[68]), .A2(code_out[52]), .A3(n113), .X(
        n176) );
  SAEDRVT14_EO2_0P5 U192 ( .A1(n150), .A2(code_out[125]), .X(n113) );
  SAEDRVT14_EN3_1 U193 ( .A1(code_out_131), .A2(code_out[123]), .A3(
        code_out[117]), .X(n150) );
  SAEDRVT14_EN3_1 U194 ( .A1(n109), .A2(code_out[58]), .A3(n157), .X(n174) );
  SAEDRVT14_EO4_1 U195 ( .A1(code_out[66]), .A2(code_out[63]), .A3(n105), .A4(
        code_out[56]), .X(n157) );
  SAEDRVT14_EN3_1 U196 ( .A1(code_out[127]), .A2(code_out[121]), .A3(
        code_out[115]), .X(n105) );
  SAEDRVT14_EO2_0P5 U197 ( .A1(code_out[119]), .A2(code_out_129), .X(n109) );
  SAEDRVT14_EO2_0P5 U198 ( .A1(code_out[27]), .A2(code_out[21]), .X(n128) );
endmodule


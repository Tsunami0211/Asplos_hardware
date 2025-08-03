/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : W-2024.09-SP5
// Date      : Fri Aug  1 20:29:25 2025
/////////////////////////////////////////////////////////////


module secded_encoder_72_64 ( data_in, code_out );
  input [63:0] data_in;
  output [71:0] code_out;
  wire   code_out_71, code_out_70, code_out_69, code_out_68, code_out_67,
         code_out_66, code_out_65, n56, n57, n58, n59, n60, n61, n62, n63, n64,
         n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78,
         n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92,
         n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112;
  assign code_out[64] = code_out_71;
  assign code_out[71] = code_out_71;
  assign code_out_71 = data_in[63];
  assign code_out[70] = code_out_70;
  assign code_out_70 = data_in[62];
  assign code_out[69] = code_out_69;
  assign code_out_69 = data_in[61];
  assign code_out[68] = code_out_68;
  assign code_out_68 = data_in[60];
  assign code_out[67] = code_out_67;
  assign code_out_67 = data_in[59];
  assign code_out[66] = code_out_66;
  assign code_out_66 = data_in[58];
  assign code_out[65] = code_out_65;
  assign code_out_65 = data_in[57];
  assign code_out[63] = data_in[56];
  assign code_out[62] = data_in[55];
  assign code_out[61] = data_in[54];
  assign code_out[60] = data_in[53];
  assign code_out[59] = data_in[52];
  assign code_out[58] = data_in[51];
  assign code_out[57] = data_in[50];
  assign code_out[56] = data_in[49];
  assign code_out[55] = data_in[48];
  assign code_out[54] = data_in[47];
  assign code_out[53] = data_in[46];
  assign code_out[52] = data_in[45];
  assign code_out[51] = data_in[44];
  assign code_out[50] = data_in[43];
  assign code_out[49] = data_in[42];
  assign code_out[48] = data_in[41];
  assign code_out[47] = data_in[40];
  assign code_out[46] = data_in[39];
  assign code_out[45] = data_in[38];
  assign code_out[44] = data_in[37];
  assign code_out[43] = data_in[36];
  assign code_out[42] = data_in[35];
  assign code_out[41] = data_in[34];
  assign code_out[40] = data_in[33];
  assign code_out[39] = data_in[32];
  assign code_out[38] = data_in[31];
  assign code_out[37] = data_in[30];
  assign code_out[36] = data_in[29];
  assign code_out[35] = data_in[28];
  assign code_out[34] = data_in[27];
  assign code_out[33] = data_in[26];
  assign code_out[31] = data_in[25];
  assign code_out[30] = data_in[24];
  assign code_out[29] = data_in[23];
  assign code_out[28] = data_in[22];
  assign code_out[27] = data_in[21];
  assign code_out[26] = data_in[20];
  assign code_out[25] = data_in[19];
  assign code_out[24] = data_in[18];
  assign code_out[23] = data_in[17];
  assign code_out[22] = data_in[16];
  assign code_out[21] = data_in[15];
  assign code_out[20] = data_in[14];
  assign code_out[19] = data_in[13];
  assign code_out[18] = data_in[12];
  assign code_out[17] = data_in[11];
  assign code_out[15] = data_in[10];
  assign code_out[14] = data_in[9];
  assign code_out[13] = data_in[8];
  assign code_out[12] = data_in[7];
  assign code_out[11] = data_in[6];
  assign code_out[10] = data_in[5];
  assign code_out[9] = data_in[4];
  assign code_out[7] = data_in[3];
  assign code_out[6] = data_in[2];
  assign code_out[5] = data_in[1];
  assign code_out[3] = data_in[0];

  SAEDRVT14_EO4_1 U63 ( .A1(n56), .A2(n57), .A3(n58), .A4(n59), .X(code_out[8]) );
  SAEDRVT14_EO4_1 U64 ( .A1(n60), .A2(code_out[12]), .A3(n61), .A4(n62), .X(
        n56) );
  SAEDRVT14_EO4_1 U65 ( .A1(n63), .A2(n64), .A3(code_out[63]), .A4(
        code_out[56]), .X(code_out[4]) );
  SAEDRVT14_EO4_1 U66 ( .A1(n65), .A2(n66), .A3(n67), .A4(n68), .X(n64) );
  SAEDRVT14_EO4_1 U67 ( .A1(n69), .A2(n70), .A3(code_out[35]), .A4(
        code_out[20]), .X(n63) );
  SAEDRVT14_INV_0P5 U68 ( .A(n71), .X(n69) );
  SAEDRVT14_INV_0P5 U69 ( .A(n72), .X(code_out[32]) );
  SAEDRVT14_EO4_1 U70 ( .A1(n65), .A2(n73), .A3(n74), .A4(n75), .X(n72) );
  SAEDRVT14_EO4_1 U71 ( .A1(code_out_70), .A2(code_out[49]), .A3(n58), .A4(n76), .X(n74) );
  SAEDRVT14_EN3_1 U72 ( .A1(n77), .A2(code_out[62]), .A3(n78), .X(n58) );
  SAEDRVT14_EO2_0P5 U73 ( .A1(code_out[52]), .A2(code_out_66), .X(n65) );
  SAEDRVT14_EO4_1 U74 ( .A1(n79), .A2(n80), .A3(n81), .A4(n82), .X(code_out[2]) );
  SAEDRVT14_EO4_1 U75 ( .A1(n83), .A2(n84), .A3(n85), .A4(n86), .X(n81) );
  SAEDRVT14_EO4_1 U76 ( .A1(n78), .A2(n87), .A3(n57), .A4(n88), .X(n80) );
  SAEDRVT14_EO4_1 U77 ( .A1(code_out[20]), .A2(n89), .A3(n90), .A4(n91), .X(
        n57) );
  SAEDRVT14_EN3_1 U78 ( .A1(code_out[48]), .A2(code_out[46]), .A3(code_out[40]), .X(n78) );
  SAEDRVT14_EO3_0P5 U79 ( .A1(n92), .A2(code_out[52]), .A3(code_out[33]), .X(
        n79) );
  SAEDRVT14_EN3_1 U80 ( .A1(n93), .A2(n94), .A3(n95), .X(code_out[1]) );
  SAEDRVT14_EO4_1 U81 ( .A1(n96), .A2(n83), .A3(n97), .A4(n73), .X(n94) );
  SAEDRVT14_EO2_0P5 U82 ( .A1(n62), .A2(code_out_69), .X(n73) );
  SAEDRVT14_EN2_1 U83 ( .A1(code_out[47]), .A2(code_out[41]), .X(n62) );
  SAEDRVT14_EO2_0P5 U84 ( .A1(n66), .A2(code_out_71), .X(n83) );
  SAEDRVT14_EO2_0P5 U85 ( .A1(code_out[7]), .A2(code_out[13]), .X(n66) );
  SAEDRVT14_EO4_1 U86 ( .A1(n59), .A2(n90), .A3(code_out[3]), .A4(n98), .X(n93) );
  SAEDRVT14_EN3_1 U87 ( .A1(code_out[17]), .A2(code_out[11]), .A3(n71), .X(n90) );
  SAEDRVT14_EO2_0P5 U88 ( .A1(code_out[27]), .A2(code_out[49]), .X(n71) );
  SAEDRVT14_EO2_0P5 U89 ( .A1(n99), .A2(n100), .X(n59) );
  SAEDRVT14_EO4_1 U90 ( .A1(n101), .A2(n102), .A3(n103), .A4(code_out[59]), 
        .X(code_out[16]) );
  SAEDRVT14_EN3_1 U91 ( .A1(code_out_69), .A2(code_out_66), .A3(code_out[63]), 
        .X(n103) );
  SAEDRVT14_EN3_1 U92 ( .A1(n104), .A2(n99), .A3(n105), .X(n102) );
  SAEDRVT14_EN3_1 U93 ( .A1(code_out[31]), .A2(code_out[25]), .A3(n106), .X(
        n99) );
  SAEDRVT14_EN3_1 U94 ( .A1(n84), .A2(code_out[58]), .A3(code_out[53]), .X(
        n104) );
  SAEDRVT14_EN3_1 U95 ( .A1(n68), .A2(n107), .A3(n75), .X(n84) );
  SAEDRVT14_EO2_0P5 U96 ( .A1(n96), .A2(code_out_68), .X(n75) );
  SAEDRVT14_EO2_0P5 U97 ( .A1(n67), .A2(n61), .X(n96) );
  SAEDRVT14_EO2_0P5 U98 ( .A1(code_out[61]), .A2(code_out[55]), .X(n61) );
  SAEDRVT14_EN3_1 U99 ( .A1(code_out_67), .A2(code_out_65), .A3(code_out[57]), 
        .X(n67) );
  SAEDRVT14_EO2_0P5 U100 ( .A1(code_out[36]), .A2(code_out[30]), .X(n68) );
  SAEDRVT14_EO4_1 U101 ( .A1(n108), .A2(n91), .A3(code_out[62]), .A4(
        code_out[27]), .X(n101) );
  SAEDRVT14_EN3_1 U102 ( .A1(code_out[34]), .A2(code_out[26]), .A3(
        code_out[24]), .X(n91) );
  SAEDRVT14_EO4_1 U103 ( .A1(n106), .A2(n70), .A3(n109), .A4(n85), .X(
        code_out[0]) );
  SAEDRVT14_EO2_0P5 U104 ( .A1(code_out[3]), .A2(code_out_70), .X(n85) );
  SAEDRVT14_EN3_1 U105 ( .A1(n77), .A2(n89), .A3(n100), .X(n109) );
  SAEDRVT14_EO2_0P5 U106 ( .A1(code_out[9]), .A2(code_out[19]), .X(n100) );
  SAEDRVT14_EO2_0P5 U107 ( .A1(code_out[18]), .A2(code_out[10]), .X(n89) );
  SAEDRVT14_EO2_0P5 U108 ( .A1(n98), .A2(n108), .X(n77) );
  SAEDRVT14_EO2_0P5 U109 ( .A1(n92), .A2(code_out[56]), .X(n108) );
  SAEDRVT14_EO2_0P5 U110 ( .A1(code_out[60]), .A2(code_out[54]), .X(n92) );
  SAEDRVT14_EO2_0P5 U111 ( .A1(code_out[53]), .A2(n82), .X(n98) );
  SAEDRVT14_EN2_1 U112 ( .A1(code_out[63]), .A2(code_out[39]), .X(n82) );
  SAEDRVT14_EN3_1 U113 ( .A1(n76), .A2(n86), .A3(n110), .X(n70) );
  SAEDRVT14_EN3_1 U114 ( .A1(n95), .A2(code_out[12]), .A3(n105), .X(n110) );
  SAEDRVT14_EN2_1 U115 ( .A1(code_out[28]), .A2(code_out[22]), .X(n105) );
  SAEDRVT14_EN3_1 U116 ( .A1(code_out[5]), .A2(code_out[15]), .A3(n107), .X(
        n95) );
  SAEDRVT14_EN4_M_1 U117 ( .A1(n111), .A2(code_out[21]), .A3(code_out[37]), 
        .A4(code_out[29]), .X(n107) );
  SAEDRVT14_INV_0P5 U118 ( .A(code_out[23]), .X(n111) );
  SAEDRVT14_EO2_0P5 U119 ( .A1(code_out[6]), .A2(code_out[14]), .X(n86) );
  SAEDRVT14_EN3_1 U120 ( .A1(n97), .A2(n88), .A3(n112), .X(n76) );
  SAEDRVT14_EN3_1 U121 ( .A1(code_out[50]), .A2(code_out[44]), .A3(
        code_out[38]), .X(n112) );
  SAEDRVT14_EO2_0P5 U122 ( .A1(n60), .A2(code_out[58]), .X(n88) );
  SAEDRVT14_INV_0P5 U123 ( .A(code_out[42]), .X(n60) );
  SAEDRVT14_EO2_0P5 U124 ( .A1(n87), .A2(code_out[59]), .X(n97) );
  SAEDRVT14_EN3_1 U125 ( .A1(code_out[51]), .A2(code_out[45]), .A3(
        code_out[43]), .X(n87) );
  SAEDRVT14_EO2_0P5 U126 ( .A1(code_out[33]), .A2(code_out[35]), .X(n106) );
endmodule


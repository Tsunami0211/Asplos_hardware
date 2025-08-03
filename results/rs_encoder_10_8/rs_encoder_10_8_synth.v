/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : W-2024.09-SP5
// Date      : Fri Aug  1 20:19:27 2025
/////////////////////////////////////////////////////////////


module gf256_mult_0_DW01_add_0 ( A, B, CI, SUM, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] SUM;
  input CI;
  output CO;
  wire   \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , n2, n3, n4, n5, n6,
         n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24;
  assign SUM[5] = \A[5] ;
  assign \A[5]  = A[5];
  assign SUM[4] = \A[4] ;
  assign \A[4]  = A[4];
  assign SUM[3] = \A[3] ;
  assign \A[3]  = A[3];
  assign SUM[2] = \A[2] ;
  assign \A[2]  = A[2];
  assign SUM[1] = \A[1] ;
  assign \A[1]  = A[1];
  assign SUM[0] = \A[0] ;
  assign \A[0]  = A[0];

  SAEDRVT14_BUF_S_4 U2 ( .A(A[6]), .X(SUM[6]) );
  SAEDRVT14_AOI21_1P5 U3 ( .A1(n4), .A2(n17), .B(n18), .X(n15) );
  SAEDRVT14_EO2_2 U4 ( .A1(n24), .A2(n22), .X(SUM[10]) );
  SAEDRVT14_EO2_1 U5 ( .A1(n11), .A2(n6), .X(SUM[8]) );
  SAEDRVT14_EO2_2 U6 ( .A1(A[7]), .A2(B[7]), .X(SUM[7]) );
  SAEDRVT14_INV_S_1 U7 ( .A(n19), .X(n4) );
  SAEDRVT14_INV_S_1 U8 ( .A(n10), .X(n5) );
  SAEDRVT14_INV_S_1 U9 ( .A(B[12]), .X(n3) );
  SAEDRVT14_INV_S_1 U10 ( .A(A[12]), .X(n2) );
  SAEDRVT14_EN2_2 U11 ( .A1(B[13]), .A2(n14), .X(SUM[13]) );
  SAEDRVT14_ND2_CDC_0P5 U12 ( .A1(A[7]), .A2(B[7]), .X(n6) );
  SAEDRVT14_EO2_0P5 U13 ( .A1(n7), .A2(n8), .X(SUM[9]) );
  SAEDRVT14_NR2_1 U14 ( .A1(n9), .A2(n10), .X(n8) );
  SAEDRVT14_ND2B_U_0P5 U15 ( .A(n12), .B(n13), .X(n11) );
  SAEDRVT14_OA21B_1 U16 ( .A1(n2), .A2(n15), .B(n16), .X(n14) );
  SAEDRVT14_AOI21_0P5 U17 ( .A1(n15), .A2(n2), .B(n3), .X(n16) );
  SAEDRVT14_EN3_1 U18 ( .A1(B[12]), .A2(n15), .A3(A[12]), .X(SUM[12]) );
  SAEDRVT14_EO2_0P5 U19 ( .A1(n17), .A2(n20), .X(SUM[11]) );
  SAEDRVT14_NR2_1 U20 ( .A1(n18), .A2(n19), .X(n20) );
  SAEDRVT14_NR2_1 U21 ( .A1(B[11]), .A2(A[11]), .X(n19) );
  SAEDRVT14_AN2_1 U22 ( .A1(B[11]), .A2(A[11]), .X(n18) );
  SAEDRVT14_OAI21_0P5 U23 ( .A1(n21), .A2(n22), .B(n23), .X(n17) );
  SAEDRVT14_AOI21_0P5 U24 ( .A1(n7), .A2(n5), .B(n9), .X(n22) );
  SAEDRVT14_AN2_1 U25 ( .A1(B[9]), .A2(A[9]), .X(n9) );
  SAEDRVT14_NR2_1 U26 ( .A1(B[9]), .A2(A[9]), .X(n10) );
  SAEDRVT14_OAI21_0P5 U27 ( .A1(n6), .A2(n12), .B(n13), .X(n7) );
  SAEDRVT14_ND2_CDC_0P5 U28 ( .A1(B[8]), .A2(A[8]), .X(n13) );
  SAEDRVT14_NR2_1 U29 ( .A1(B[8]), .A2(A[8]), .X(n12) );
  SAEDRVT14_ND2B_U_0P5 U30 ( .A(n21), .B(n23), .X(n24) );
  SAEDRVT14_ND2_CDC_0P5 U31 ( .A1(B[10]), .A2(A[10]), .X(n23) );
  SAEDRVT14_NR2_1 U32 ( .A1(B[10]), .A2(A[10]), .X(n21) );
endmodule


module gf256_mult_0_DW02_mult_0 ( A, B, TC, PRODUCT );
  input [7:0] A;
  input [7:0] B;
  output [15:0] PRODUCT;
  input TC;
  wire   net2265, \ab[7][7] , \ab[7][6] , \ab[7][5] , \ab[7][4] , \ab[7][3] ,
         \ab[7][2] , \ab[7][1] , \ab[7][0] , \ab[6][7] , \ab[6][6] ,
         \ab[6][5] , \ab[6][4] , \ab[6][3] , \ab[6][2] , \ab[6][1] ,
         \ab[6][0] , \ab[5][7] , \ab[5][6] , \ab[5][5] , \ab[5][4] ,
         \ab[5][3] , \ab[5][2] , \ab[5][1] , \ab[5][0] , \ab[4][7] ,
         \ab[4][6] , \ab[4][5] , \ab[4][4] , \ab[4][3] , \ab[4][2] ,
         \ab[4][1] , \ab[4][0] , \ab[3][7] , \ab[3][6] , \ab[3][5] ,
         \ab[3][4] , \ab[3][3] , \ab[3][2] , \ab[3][1] , \ab[3][0] ,
         \ab[2][7] , \ab[2][6] , \ab[2][5] , \ab[2][4] , \ab[2][3] ,
         \ab[2][2] , \ab[2][1] , \ab[2][0] , \ab[1][7] , \ab[1][6] ,
         \ab[1][5] , \ab[1][4] , \ab[1][3] , \ab[1][2] , \ab[1][1] ,
         \ab[1][0] , \ab[0][7] , \ab[0][6] , \ab[0][5] , \ab[0][4] ,
         \ab[0][3] , \ab[0][2] , \ab[0][1] , \CARRYB[7][6] , \CARRYB[7][5] ,
         \CARRYB[7][4] , \CARRYB[7][3] , \CARRYB[7][2] , \CARRYB[7][1] ,
         \CARRYB[7][0] , \CARRYB[6][6] , \CARRYB[6][5] , \CARRYB[6][4] ,
         \CARRYB[6][3] , \CARRYB[6][2] , \CARRYB[6][1] , \CARRYB[6][0] ,
         \CARRYB[5][6] , \CARRYB[5][5] , \CARRYB[5][4] , \CARRYB[5][3] ,
         \CARRYB[5][2] , \CARRYB[5][1] , \CARRYB[5][0] , \CARRYB[4][6] ,
         \CARRYB[4][5] , \CARRYB[4][4] , \CARRYB[4][3] , \CARRYB[4][2] ,
         \CARRYB[4][1] , \CARRYB[4][0] , \CARRYB[3][6] , \CARRYB[3][5] ,
         \CARRYB[3][4] , \CARRYB[3][3] , \CARRYB[3][2] , \CARRYB[3][1] ,
         \CARRYB[3][0] , \CARRYB[2][6] , \CARRYB[2][5] , \CARRYB[2][4] ,
         \CARRYB[2][3] , \CARRYB[2][2] , \CARRYB[2][1] , \CARRYB[2][0] ,
         \CARRYB[1][0] , \SUMB[7][6] , \SUMB[7][5] , \SUMB[7][4] ,
         \SUMB[7][3] , \SUMB[7][2] , \SUMB[7][1] , \SUMB[7][0] , \SUMB[6][6] ,
         \SUMB[6][5] , \SUMB[6][4] , \SUMB[6][3] , \SUMB[6][2] , \SUMB[6][1] ,
         \SUMB[5][6] , \SUMB[5][5] , \SUMB[5][4] , \SUMB[5][3] , \SUMB[5][2] ,
         \SUMB[5][1] , \SUMB[4][6] , \SUMB[4][5] , \SUMB[4][4] , \SUMB[4][3] ,
         \SUMB[4][2] , \SUMB[4][1] , \SUMB[3][6] , \SUMB[3][5] , \SUMB[3][4] ,
         \SUMB[3][3] , \SUMB[3][2] , \SUMB[3][1] , \SUMB[2][6] , \SUMB[2][5] ,
         \SUMB[2][4] , \SUMB[2][3] , \SUMB[2][2] , \SUMB[2][1] , \SUMB[1][6] ,
         \SUMB[1][5] , \SUMB[1][4] , \SUMB[1][3] , \SUMB[1][2] , \SUMB[1][1] ,
         \A1[12] , \A1[11] , \A1[10] , \A1[9] , \A1[8] , \A1[7] , \A1[6] ,
         \A1[4] , \A1[3] , \A1[2] , \A1[1] , \A1[0] , \A2[7] , n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32;

  gf256_mult_0_DW01_add_0 FS_1 ( .A({net2265, \A1[12] , \A1[11] , \A1[10] , 
        \A1[9] , \A1[8] , \A1[7] , \A1[6] , \SUMB[7][0] , \A1[4] , \A1[3] , 
        \A1[2] , \A1[1] , \A1[0] }), .B({n8, n12, n16, n14, n15, n13, \A2[7] , 
        net2265, net2265, net2265, net2265, net2265, net2265, net2265}), .CI(
        net2265), .SUM(PRODUCT[15:2]) );
  SAEDRVT14_ADDF_V1_1 S2_6_5 ( .A(\ab[6][5] ), .B(\CARRYB[5][5] ), .CI(
        \SUMB[5][6] ), .CO(\CARRYB[6][5] ), .S(\SUMB[6][5] ) );
  SAEDRVT14_ADDF_V1_1 S2_6_3 ( .A(\ab[6][3] ), .B(\CARRYB[5][3] ), .CI(
        \SUMB[5][4] ), .CO(\CARRYB[6][3] ), .S(\SUMB[6][3] ) );
  SAEDRVT14_ADDF_V1_1 S2_6_4 ( .A(\ab[6][4] ), .B(\CARRYB[5][4] ), .CI(
        \SUMB[5][5] ), .CO(\CARRYB[6][4] ), .S(\SUMB[6][4] ) );
  SAEDRVT14_ADDF_V1_1 S2_5_4 ( .A(\ab[5][4] ), .B(\CARRYB[4][4] ), .CI(
        \SUMB[4][5] ), .CO(\CARRYB[5][4] ), .S(\SUMB[5][4] ) );
  SAEDRVT14_ADDF_V1_1 S2_5_5 ( .A(\ab[5][5] ), .B(\CARRYB[4][5] ), .CI(
        \SUMB[4][6] ), .CO(\CARRYB[5][5] ), .S(\SUMB[5][5] ) );
  SAEDRVT14_ADDF_V1_1 S2_6_2 ( .A(\ab[6][2] ), .B(\CARRYB[5][2] ), .CI(
        \SUMB[5][3] ), .CO(\CARRYB[6][2] ), .S(\SUMB[6][2] ) );
  SAEDRVT14_ADDF_V1_1 S2_4_5 ( .A(\ab[4][5] ), .B(\CARRYB[3][5] ), .CI(
        \SUMB[3][6] ), .CO(\CARRYB[4][5] ), .S(\SUMB[4][5] ) );
  SAEDRVT14_ADDF_V1_1 S2_5_2 ( .A(\ab[5][2] ), .B(\CARRYB[4][2] ), .CI(
        \SUMB[4][3] ), .CO(\CARRYB[5][2] ), .S(\SUMB[5][2] ) );
  SAEDRVT14_ADDF_V1_1 S2_5_3 ( .A(\ab[5][3] ), .B(\CARRYB[4][3] ), .CI(
        \SUMB[4][4] ), .CO(\CARRYB[5][3] ), .S(\SUMB[5][3] ) );
  SAEDRVT14_ADDF_V1_1 S2_4_2 ( .A(\ab[4][2] ), .B(\CARRYB[3][2] ), .CI(
        \SUMB[3][3] ), .CO(\CARRYB[4][2] ), .S(\SUMB[4][2] ) );
  SAEDRVT14_ADDF_V1_1 S2_4_3 ( .A(\ab[4][3] ), .B(\CARRYB[3][3] ), .CI(
        \SUMB[3][4] ), .CO(\CARRYB[4][3] ), .S(\SUMB[4][3] ) );
  SAEDRVT14_ADDF_V1_1 S2_4_4 ( .A(\ab[4][4] ), .B(\CARRYB[3][4] ), .CI(
        \SUMB[3][5] ), .CO(\CARRYB[4][4] ), .S(\SUMB[4][4] ) );
  SAEDRVT14_ADDF_V1_1 S2_3_2 ( .A(\ab[3][2] ), .B(\CARRYB[2][2] ), .CI(
        \SUMB[2][3] ), .CO(\CARRYB[3][2] ), .S(\SUMB[3][2] ) );
  SAEDRVT14_ADDF_V1_1 S2_3_3 ( .A(\ab[3][3] ), .B(\CARRYB[2][3] ), .CI(
        \SUMB[2][4] ), .CO(\CARRYB[3][3] ), .S(\SUMB[3][3] ) );
  SAEDRVT14_ADDF_V1_1 S2_3_4 ( .A(\ab[3][4] ), .B(\CARRYB[2][4] ), .CI(
        \SUMB[2][5] ), .CO(\CARRYB[3][4] ), .S(\SUMB[3][4] ) );
  SAEDRVT14_ADDF_V1_1 S2_3_5 ( .A(\ab[3][5] ), .B(\CARRYB[2][5] ), .CI(
        \SUMB[2][6] ), .CO(\CARRYB[3][5] ), .S(\SUMB[3][5] ) );
  SAEDRVT14_ADDF_V1_1 S2_2_2 ( .A(\ab[2][2] ), .B(n2), .CI(\SUMB[1][3] ), .CO(
        \CARRYB[2][2] ), .S(\SUMB[2][2] ) );
  SAEDRVT14_ADDF_V1_1 S2_2_3 ( .A(\ab[2][3] ), .B(n6), .CI(\SUMB[1][4] ), .CO(
        \CARRYB[2][3] ), .S(\SUMB[2][3] ) );
  SAEDRVT14_ADDF_V1_1 S2_2_4 ( .A(\ab[2][4] ), .B(n5), .CI(\SUMB[1][5] ), .CO(
        \CARRYB[2][4] ), .S(\SUMB[2][4] ) );
  SAEDRVT14_ADDF_V1_1 S2_2_5 ( .A(\ab[2][5] ), .B(n4), .CI(\SUMB[1][6] ), .CO(
        \CARRYB[2][5] ), .S(\SUMB[2][5] ) );
  SAEDRVT14_ADDF_V1_1 S3_6_6 ( .A(\ab[6][6] ), .B(\CARRYB[5][6] ), .CI(
        \ab[5][7] ), .CO(\CARRYB[6][6] ), .S(\SUMB[6][6] ) );
  SAEDRVT14_ADDF_V1_1 S3_2_6 ( .A(\ab[2][6] ), .B(n3), .CI(\ab[1][7] ), .CO(
        \CARRYB[2][6] ), .S(\SUMB[2][6] ) );
  SAEDRVT14_ADDF_V1_1 S3_5_6 ( .A(\ab[5][6] ), .B(\CARRYB[4][6] ), .CI(
        \ab[4][7] ), .CO(\CARRYB[5][6] ), .S(\SUMB[5][6] ) );
  SAEDRVT14_ADDF_V1_1 S3_4_6 ( .A(\ab[4][6] ), .B(\CARRYB[3][6] ), .CI(
        \ab[3][7] ), .CO(\CARRYB[4][6] ), .S(\SUMB[4][6] ) );
  SAEDRVT14_ADDF_V1_1 S3_3_6 ( .A(\ab[3][6] ), .B(\CARRYB[2][6] ), .CI(
        \ab[2][7] ), .CO(\CARRYB[3][6] ), .S(\SUMB[3][6] ) );
  SAEDRVT14_ADDF_V1_1 S4_5 ( .A(\ab[7][5] ), .B(\CARRYB[6][5] ), .CI(
        \SUMB[6][6] ), .CO(\CARRYB[7][5] ), .S(\SUMB[7][5] ) );
  SAEDRVT14_ADDF_V1_1 S4_4 ( .A(\ab[7][4] ), .B(\CARRYB[6][4] ), .CI(
        \SUMB[6][5] ), .CO(\CARRYB[7][4] ), .S(\SUMB[7][4] ) );
  SAEDRVT14_ADDF_V1_1 S4_3 ( .A(\ab[7][3] ), .B(\CARRYB[6][3] ), .CI(
        \SUMB[6][4] ), .CO(\CARRYB[7][3] ), .S(\SUMB[7][3] ) );
  SAEDRVT14_ADDF_V1_1 S4_2 ( .A(\ab[7][2] ), .B(\CARRYB[6][2] ), .CI(
        \SUMB[6][3] ), .CO(\CARRYB[7][2] ), .S(\SUMB[7][2] ) );
  SAEDRVT14_ADDF_V1_1 S5_6 ( .A(\ab[7][6] ), .B(\CARRYB[6][6] ), .CI(
        \ab[6][7] ), .CO(\CARRYB[7][6] ), .S(\SUMB[7][6] ) );
  SAEDRVT14_ADDF_V1_1 S1_2_0 ( .A(\ab[2][0] ), .B(\CARRYB[1][0] ), .CI(
        \SUMB[1][1] ), .CO(\CARRYB[2][0] ), .S(\A1[0] ) );
  SAEDRVT14_ADDF_V1_1 S4_1 ( .A(\ab[7][1] ), .B(\CARRYB[6][1] ), .CI(
        \SUMB[6][2] ), .CO(\CARRYB[7][1] ), .S(\SUMB[7][1] ) );
  SAEDRVT14_ADDF_V1_1 S2_3_1 ( .A(\ab[3][1] ), .B(\CARRYB[2][1] ), .CI(
        \SUMB[2][2] ), .CO(\CARRYB[3][1] ), .S(\SUMB[3][1] ) );
  SAEDRVT14_ADDF_V1_1 S1_3_0 ( .A(\ab[3][0] ), .B(\CARRYB[2][0] ), .CI(
        \SUMB[2][1] ), .CO(\CARRYB[3][0] ), .S(\A1[1] ) );
  SAEDRVT14_ADDF_V1_2 S2_4_1 ( .A(\ab[4][1] ), .B(\CARRYB[3][1] ), .CI(
        \SUMB[3][2] ), .CO(\CARRYB[4][1] ), .S(\SUMB[4][1] ) );
  SAEDRVT14_ADDF_V1_2 S2_6_1 ( .A(\ab[6][1] ), .B(\CARRYB[5][1] ), .CI(
        \SUMB[5][2] ), .CO(\CARRYB[6][1] ), .S(\SUMB[6][1] ) );
  SAEDRVT14_ADDF_V1_1 S1_5_0 ( .A(\ab[5][0] ), .B(\CARRYB[4][0] ), .CI(
        \SUMB[4][1] ), .CO(\CARRYB[5][0] ), .S(\A1[3] ) );
  SAEDRVT14_ADDF_V2_2 S2_2_1 ( .A(\ab[2][1] ), .B(n7), .CI(\SUMB[1][2] ), .CO(
        \CARRYB[2][1] ), .S(\SUMB[2][1] ) );
  SAEDRVT14_ADDF_V1_2 S2_5_1 ( .A(\ab[5][1] ), .B(\CARRYB[4][1] ), .CI(
        \SUMB[4][2] ), .CO(\CARRYB[5][1] ), .S(\SUMB[5][1] ) );
  SAEDRVT14_ADDF_V2_2 S4_0 ( .A(\ab[7][0] ), .B(\CARRYB[6][0] ), .CI(
        \SUMB[6][1] ), .CO(\CARRYB[7][0] ), .S(\SUMB[7][0] ) );
  SAEDRVT14_ADDF_V1_1 S1_4_0 ( .A(\ab[4][0] ), .B(\CARRYB[3][0] ), .CI(
        \SUMB[3][1] ), .CO(\CARRYB[4][0] ), .S(\A1[2] ) );
  SAEDRVT14_ADDF_V1_1 S1_6_0 ( .A(\ab[6][0] ), .B(\CARRYB[5][0] ), .CI(
        \SUMB[5][1] ), .CO(\CARRYB[6][0] ), .S(\A1[4] ) );
  SAEDRVT14_ADDF_V1_1 S0_0 ( .A(\ab[0][1] ), .B(\ab[1][0] ), .CI(net2265), 
        .CO(\CARRYB[1][0] ), .S(PRODUCT[1]) );
  SAEDRVT14_ADDF_V1_1 S14_8 ( .A(net2265), .B(\CARRYB[7][0] ), .CI(
        \SUMB[7][1] ), .CO(\A2[7] ), .S(\A1[6] ) );
  SAEDRVT14_TIE0_V1_2 U2 ( .X(net2265) );
  SAEDRVT14_INV_S_10 U3 ( .A(A[3]), .X(n29) );
  SAEDRVT14_INV_S_8 U4 ( .A(A[4]), .X(n28) );
  SAEDRVT14_INV_3 U5 ( .A(A[2]), .X(n30) );
  SAEDRVT14_INV_S_16 U6 ( .A(A[0]), .X(n32) );
  SAEDRVT14_NR2_MM_0P5 U7 ( .A1(n17), .A2(n27), .X(\ab[5][1] ) );
  SAEDRVT14_NR2_ECO_2 U8 ( .A1(n17), .A2(n29), .X(\ab[3][1] ) );
  SAEDRVT14_NR2_MM_3 U9 ( .A1(n17), .A2(n28), .X(\ab[4][1] ) );
  SAEDRVT14_INV_3 U10 ( .A(B[7]), .X(n24) );
  SAEDRVT14_INV_2 U11 ( .A(A[2]), .X(n9) );
  SAEDRVT14_AN2_MM_1 U12 ( .A1(\ab[0][2] ), .A2(\ab[1][1] ), .X(n7) );
  SAEDRVT14_NR2_MM_0P5 U13 ( .A1(n17), .A2(n32), .X(\ab[0][1] ) );
  SAEDRVT14_AN2_4 U14 ( .A1(B[1]), .A2(A[1]), .X(\ab[1][1] ) );
  SAEDRVT14_AN2_MM_1 U15 ( .A1(\ab[0][3] ), .A2(\ab[1][2] ), .X(n2) );
  SAEDRVT14_AN2_MM_1 U16 ( .A1(\ab[0][7] ), .A2(\ab[1][6] ), .X(n3) );
  SAEDRVT14_AN2_MM_1 U17 ( .A1(\ab[0][6] ), .A2(\ab[1][5] ), .X(n4) );
  SAEDRVT14_AN2_MM_1 U18 ( .A1(\ab[0][5] ), .A2(\ab[1][4] ), .X(n5) );
  SAEDRVT14_AN2_MM_1 U19 ( .A1(\ab[0][4] ), .A2(\ab[1][3] ), .X(n6) );
  SAEDRVT14_AN2_MM_1 U20 ( .A1(\CARRYB[7][6] ), .A2(\ab[7][7] ), .X(n8) );
  SAEDRVT14_EO2_2 U21 ( .A1(\ab[1][1] ), .A2(\ab[0][2] ), .X(\SUMB[1][1] ) );
  SAEDRVT14_NR2_MM_0P5 U22 ( .A1(n17), .A2(n30), .X(\ab[2][1] ) );
  SAEDRVT14_NR2_MM_16 U23 ( .A1(n25), .A2(n17), .X(\ab[7][1] ) );
  SAEDRVT14_NR2_MM_0P5 U24 ( .A1(n25), .A2(n24), .X(\ab[7][7] ) );
  SAEDRVT14_NR2_MM_0P5 U25 ( .A1(n25), .A2(n23), .X(\ab[7][6] ) );
  SAEDRVT14_NR2_MM_0P5 U26 ( .A1(n25), .A2(n22), .X(\ab[7][5] ) );
  SAEDRVT14_NR2_MM_0P5 U27 ( .A1(n25), .A2(n21), .X(\ab[7][4] ) );
  SAEDRVT14_NR2_MM_0P5 U28 ( .A1(n25), .A2(n20), .X(\ab[7][3] ) );
  SAEDRVT14_INV_S_20 U29 ( .A(A[7]), .X(n25) );
  SAEDRVT14_INV_S_1 U30 ( .A(A[5]), .X(n27) );
  SAEDRVT14_INV_2 U31 ( .A(A[5]), .X(n10) );
  SAEDRVT14_NR2_MM_0P5 U32 ( .A1(n19), .A2(n29), .X(\ab[3][2] ) );
  SAEDRVT14_NR2_MM_0P5 U33 ( .A1(n18), .A2(n29), .X(\ab[3][0] ) );
  SAEDRVT14_INV_S_1 U34 ( .A(A[6]), .X(n26) );
  SAEDRVT14_INV_2 U35 ( .A(A[6]), .X(n11) );
  SAEDRVT14_EO2_1 U36 ( .A1(\ab[1][2] ), .A2(\ab[0][3] ), .X(\SUMB[1][2] ) );
  SAEDRVT14_NR2_MM_0P5 U37 ( .A1(n24), .A2(n9), .X(\ab[2][7] ) );
  SAEDRVT14_NR2_MM_0P5 U38 ( .A1(n24), .A2(n28), .X(\ab[4][7] ) );
  SAEDRVT14_NR2_MM_0P5 U39 ( .A1(n24), .A2(n11), .X(\ab[6][7] ) );
  SAEDRVT14_NR2_MM_0P5 U40 ( .A1(n23), .A2(n11), .X(\ab[6][6] ) );
  SAEDRVT14_EO2_1 U41 ( .A1(\CARRYB[7][1] ), .A2(\SUMB[7][2] ), .X(\A1[7] ) );
  SAEDRVT14_INV_2 U42 ( .A(A[1]), .X(n31) );
  SAEDRVT14_EO2_1 U43 ( .A1(\CARRYB[7][6] ), .A2(\ab[7][7] ), .X(\A1[12] ) );
  SAEDRVT14_EO2_1 U44 ( .A1(\CARRYB[7][2] ), .A2(\SUMB[7][3] ), .X(\A1[8] ) );
  SAEDRVT14_EO2_1 U45 ( .A1(\CARRYB[7][4] ), .A2(\SUMB[7][5] ), .X(\A1[10] )
         );
  SAEDRVT14_EO2_1 U46 ( .A1(\CARRYB[7][3] ), .A2(\SUMB[7][4] ), .X(\A1[9] ) );
  SAEDRVT14_EO2_1 U47 ( .A1(\CARRYB[7][5] ), .A2(\SUMB[7][6] ), .X(\A1[11] )
         );
  SAEDRVT14_AN2_MM_1 U48 ( .A1(\CARRYB[7][5] ), .A2(\SUMB[7][6] ), .X(n12) );
  SAEDRVT14_AN2_MM_1 U49 ( .A1(\CARRYB[7][1] ), .A2(\SUMB[7][2] ), .X(n13) );
  SAEDRVT14_AN2_MM_1 U50 ( .A1(\CARRYB[7][3] ), .A2(\SUMB[7][4] ), .X(n14) );
  SAEDRVT14_AN2_MM_1 U51 ( .A1(\CARRYB[7][2] ), .A2(\SUMB[7][3] ), .X(n15) );
  SAEDRVT14_AN2_MM_1 U52 ( .A1(\CARRYB[7][4] ), .A2(\SUMB[7][5] ), .X(n16) );
  SAEDRVT14_NR2_MM_1 U53 ( .A1(n17), .A2(n26), .X(\ab[6][1] ) );
  SAEDRVT14_EO2_0P5 U54 ( .A1(\ab[1][6] ), .A2(\ab[0][7] ), .X(\SUMB[1][6] )
         );
  SAEDRVT14_EO2_0P5 U55 ( .A1(\ab[1][5] ), .A2(\ab[0][6] ), .X(\SUMB[1][5] )
         );
  SAEDRVT14_EO2_0P5 U56 ( .A1(\ab[1][4] ), .A2(\ab[0][5] ), .X(\SUMB[1][4] )
         );
  SAEDRVT14_EO2_0P5 U57 ( .A1(\ab[1][3] ), .A2(\ab[0][4] ), .X(\SUMB[1][3] )
         );
  SAEDRVT14_INV_3 U58 ( .A(B[5]), .X(n22) );
  SAEDRVT14_INV_3 U59 ( .A(B[4]), .X(n21) );
  SAEDRVT14_INV_3 U60 ( .A(B[3]), .X(n20) );
  SAEDRVT14_INV_3 U61 ( .A(B[6]), .X(n23) );
  SAEDRVT14_INV_3 U62 ( .A(B[2]), .X(n19) );
  SAEDRVT14_INV_3 U63 ( .A(B[0]), .X(n18) );
  SAEDRVT14_INV_2 U64 ( .A(B[1]), .X(n17) );
  SAEDRVT14_NR2_MM_0P5 U65 ( .A1(n20), .A2(n29), .X(\ab[3][3] ) );
  SAEDRVT14_NR2_MM_0P5 U66 ( .A1(n21), .A2(n29), .X(\ab[3][4] ) );
  SAEDRVT14_NR2_MM_0P5 U67 ( .A1(n22), .A2(n29), .X(\ab[3][5] ) );
  SAEDRVT14_NR2_MM_0P5 U68 ( .A1(n23), .A2(n29), .X(\ab[3][6] ) );
  SAEDRVT14_NR2_MM_0P5 U69 ( .A1(n24), .A2(n29), .X(\ab[3][7] ) );
  SAEDRVT14_NR2_1 U70 ( .A1(n25), .A2(n19), .X(\ab[7][2] ) );
  SAEDRVT14_NR2_1 U71 ( .A1(n25), .A2(n18), .X(\ab[7][0] ) );
  SAEDRVT14_NR2_1 U72 ( .A1(n22), .A2(n11), .X(\ab[6][5] ) );
  SAEDRVT14_NR2_1 U73 ( .A1(n21), .A2(n11), .X(\ab[6][4] ) );
  SAEDRVT14_NR2_1 U74 ( .A1(n20), .A2(n11), .X(\ab[6][3] ) );
  SAEDRVT14_NR2_1 U75 ( .A1(n19), .A2(n11), .X(\ab[6][2] ) );
  SAEDRVT14_NR2_1 U76 ( .A1(n18), .A2(n11), .X(\ab[6][0] ) );
  SAEDRVT14_NR2_1 U77 ( .A1(n24), .A2(n10), .X(\ab[5][7] ) );
  SAEDRVT14_NR2_1 U78 ( .A1(n23), .A2(n10), .X(\ab[5][6] ) );
  SAEDRVT14_NR2_1 U79 ( .A1(n22), .A2(n10), .X(\ab[5][5] ) );
  SAEDRVT14_NR2_1 U80 ( .A1(n21), .A2(n10), .X(\ab[5][4] ) );
  SAEDRVT14_NR2_1 U81 ( .A1(n20), .A2(n10), .X(\ab[5][3] ) );
  SAEDRVT14_NR2_1 U82 ( .A1(n19), .A2(n10), .X(\ab[5][2] ) );
  SAEDRVT14_NR2_1 U83 ( .A1(n18), .A2(n10), .X(\ab[5][0] ) );
  SAEDRVT14_NR2_1 U84 ( .A1(n23), .A2(n28), .X(\ab[4][6] ) );
  SAEDRVT14_NR2_1 U85 ( .A1(n22), .A2(n28), .X(\ab[4][5] ) );
  SAEDRVT14_NR2_1 U86 ( .A1(n21), .A2(n28), .X(\ab[4][4] ) );
  SAEDRVT14_NR2_1 U87 ( .A1(n20), .A2(n28), .X(\ab[4][3] ) );
  SAEDRVT14_NR2_1 U88 ( .A1(n19), .A2(n28), .X(\ab[4][2] ) );
  SAEDRVT14_NR2_1 U89 ( .A1(n18), .A2(n28), .X(\ab[4][0] ) );
  SAEDRVT14_NR2_1 U90 ( .A1(n23), .A2(n9), .X(\ab[2][6] ) );
  SAEDRVT14_NR2_1 U91 ( .A1(n22), .A2(n9), .X(\ab[2][5] ) );
  SAEDRVT14_NR2_1 U92 ( .A1(n21), .A2(n9), .X(\ab[2][4] ) );
  SAEDRVT14_NR2_1 U93 ( .A1(n20), .A2(n9), .X(\ab[2][3] ) );
  SAEDRVT14_NR2_1 U94 ( .A1(n19), .A2(n9), .X(\ab[2][2] ) );
  SAEDRVT14_NR2_1 U95 ( .A1(n18), .A2(n9), .X(\ab[2][0] ) );
  SAEDRVT14_NR2_1 U96 ( .A1(n24), .A2(n31), .X(\ab[1][7] ) );
  SAEDRVT14_NR2_1 U97 ( .A1(n23), .A2(n31), .X(\ab[1][6] ) );
  SAEDRVT14_NR2_1 U98 ( .A1(n22), .A2(n31), .X(\ab[1][5] ) );
  SAEDRVT14_NR2_1 U99 ( .A1(n21), .A2(n31), .X(\ab[1][4] ) );
  SAEDRVT14_NR2_1 U100 ( .A1(n20), .A2(n31), .X(\ab[1][3] ) );
  SAEDRVT14_NR2_1 U101 ( .A1(n19), .A2(n31), .X(\ab[1][2] ) );
  SAEDRVT14_NR2_1 U102 ( .A1(n18), .A2(n31), .X(\ab[1][0] ) );
  SAEDRVT14_NR2_1 U103 ( .A1(n24), .A2(n32), .X(\ab[0][7] ) );
  SAEDRVT14_NR2_1 U104 ( .A1(n23), .A2(n32), .X(\ab[0][6] ) );
  SAEDRVT14_NR2_1 U105 ( .A1(n22), .A2(n32), .X(\ab[0][5] ) );
  SAEDRVT14_NR2_1 U106 ( .A1(n21), .A2(n32), .X(\ab[0][4] ) );
  SAEDRVT14_NR2_1 U107 ( .A1(n20), .A2(n32), .X(\ab[0][3] ) );
  SAEDRVT14_NR2_1 U108 ( .A1(n19), .A2(n32), .X(\ab[0][2] ) );
  SAEDRVT14_NR2_1 U109 ( .A1(n18), .A2(n32), .X(PRODUCT[0]) );
endmodule


module gf256_mult_0 ( a, b, result );
  input [7:0] a;
  input [7:0] b;
  output [7:0] result;
  wire   n6, n7, n8, n9, n10, n11, n12, n1, n2, n3, n4, n5, n13, n14;
  wire   [15:0] temp_mult;

  SAEDRVT14_EO4_2 U10 ( .A1(n4), .A2(temp_mult[13]), .A3(n10), .A4(
        temp_mult[12]), .X(result[2]) );
  gf256_mult_0_DW02_mult_0 mult_121 ( .A(a), .B(b), .TC(n1), .PRODUCT(
        temp_mult) );
  SAEDRVT14_TIE0_V1_2 U1 ( .X(n1) );
  SAEDRVT14_EN3_1 U2 ( .A1(n4), .A2(temp_mult[9]), .A3(temp_mult[7]), .X(n6)
         );
  SAEDRVT14_EO2_2 U3 ( .A1(temp_mult[8]), .A2(temp_mult[9]), .X(n3) );
  SAEDRVT14_EN3_3 U4 ( .A1(temp_mult[4]), .A2(temp_mult[8]), .A3(temp_mult[15]), .X(n8) );
  SAEDRVT14_EO2_1 U5 ( .A1(n6), .A2(temp_mult[10]), .X(n2) );
  SAEDRVT14_EO4_2 U6 ( .A1(temp_mult[14]), .A2(temp_mult[7]), .A3(
        temp_mult[12]), .A4(temp_mult[15]), .X(n12) );
  SAEDRVT14_EO4_2 U7 ( .A1(n13), .A2(n14), .A3(n12), .A4(temp_mult[0]), .X(
        result[0]) );
  SAEDRVT14_EN3_3 U8 ( .A1(n11), .A2(temp_mult[12]), .A3(n13), .X(result[1])
         );
  SAEDRVT14_EN3_3 U9 ( .A1(temp_mult[8]), .A2(temp_mult[1]), .A3(n5), .X(n11)
         );
  SAEDRVT14_EO3_4 U11 ( .A1(temp_mult[5]), .A2(n3), .A3(temp_mult[12]), .X(
        result[5]) );
  SAEDRVT14_EN3_3 U12 ( .A1(n7), .A2(n5), .A3(n14), .X(result[6]) );
  SAEDRVT14_EN3_3 U13 ( .A1(temp_mult[6]), .A2(temp_mult[9]), .A3(temp_mult[8]), .X(n7) );
  SAEDRVT14_EN3_3 U14 ( .A1(n8), .A2(n4), .A3(n13), .X(result[4]) );
  SAEDRVT14_EN3_3 U15 ( .A1(n9), .A2(n5), .A3(temp_mult[10]), .X(result[3]) );
  SAEDRVT14_INV_S_1 U16 ( .A(temp_mult[11]), .X(n13) );
  SAEDRVT14_EN2_4 U17 ( .A1(n2), .A2(n13), .X(result[7]) );
  SAEDRVT14_INV_S_1 U18 ( .A(temp_mult[13]), .X(n5) );
  SAEDRVT14_INV_S_1 U19 ( .A(temp_mult[14]), .X(n4) );
  SAEDRVT14_INV_S_0P5 U20 ( .A(temp_mult[10]), .X(n14) );
  SAEDRVT14_EN3_1 U21 ( .A1(temp_mult[3]), .A2(temp_mult[15]), .A3(n4), .X(n9)
         );
  SAEDRVT14_EN3_1 U22 ( .A1(temp_mult[9]), .A2(temp_mult[2]), .A3(
        temp_mult[15]), .X(n10) );
endmodule


module gf256_mult_1_DW01_add_0_DW01_add_1 ( A, B, CI, SUM, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] SUM;
  input CI;
  output CO;
  wire   \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23;
  assign SUM[6] = A[6];
  assign SUM[5] = \A[5] ;
  assign \A[5]  = A[5];
  assign SUM[4] = \A[4] ;
  assign \A[4]  = A[4];
  assign SUM[3] = \A[3] ;
  assign \A[3]  = A[3];
  assign SUM[2] = \A[2] ;
  assign \A[2]  = A[2];
  assign SUM[1] = \A[1] ;
  assign \A[1]  = A[1];
  assign SUM[0] = \A[0] ;
  assign \A[0]  = A[0];

  SAEDRVT14_AOI21_1P5 U2 ( .A1(n3), .A2(n16), .B(n17), .X(n14) );
  SAEDRVT14_EO2_2 U3 ( .A1(n23), .A2(n21), .X(SUM[10]) );
  SAEDRVT14_EO2_1 U4 ( .A1(n10), .A2(n5), .X(SUM[8]) );
  SAEDRVT14_EO2_2 U5 ( .A1(A[7]), .A2(B[7]), .X(SUM[7]) );
  SAEDRVT14_INV_S_1 U6 ( .A(n18), .X(n3) );
  SAEDRVT14_INV_S_1 U7 ( .A(n9), .X(n4) );
  SAEDRVT14_INV_S_1 U8 ( .A(B[12]), .X(n2) );
  SAEDRVT14_ND2_CDC_0P5 U9 ( .A1(A[7]), .A2(B[7]), .X(n5) );
  SAEDRVT14_INV_S_1 U10 ( .A(A[12]), .X(n1) );
  SAEDRVT14_EN2_2 U11 ( .A1(B[13]), .A2(n13), .X(SUM[13]) );
  SAEDRVT14_EO2_0P5 U12 ( .A1(n6), .A2(n7), .X(SUM[9]) );
  SAEDRVT14_NR2_1 U13 ( .A1(n8), .A2(n9), .X(n7) );
  SAEDRVT14_ND2B_U_0P5 U14 ( .A(n11), .B(n12), .X(n10) );
  SAEDRVT14_OA21B_1 U15 ( .A1(n1), .A2(n14), .B(n15), .X(n13) );
  SAEDRVT14_AOI21_0P5 U16 ( .A1(n14), .A2(n1), .B(n2), .X(n15) );
  SAEDRVT14_EN3_1 U17 ( .A1(B[12]), .A2(n14), .A3(A[12]), .X(SUM[12]) );
  SAEDRVT14_EO2_0P5 U18 ( .A1(n16), .A2(n19), .X(SUM[11]) );
  SAEDRVT14_NR2_1 U19 ( .A1(n17), .A2(n18), .X(n19) );
  SAEDRVT14_NR2_1 U20 ( .A1(B[11]), .A2(A[11]), .X(n18) );
  SAEDRVT14_AN2_1 U21 ( .A1(B[11]), .A2(A[11]), .X(n17) );
  SAEDRVT14_OAI21_0P5 U22 ( .A1(n20), .A2(n21), .B(n22), .X(n16) );
  SAEDRVT14_AOI21_0P5 U23 ( .A1(n6), .A2(n4), .B(n8), .X(n21) );
  SAEDRVT14_AN2_1 U24 ( .A1(B[9]), .A2(A[9]), .X(n8) );
  SAEDRVT14_NR2_1 U25 ( .A1(B[9]), .A2(A[9]), .X(n9) );
  SAEDRVT14_OAI21_0P5 U26 ( .A1(n5), .A2(n11), .B(n12), .X(n6) );
  SAEDRVT14_ND2_CDC_0P5 U27 ( .A1(B[8]), .A2(A[8]), .X(n12) );
  SAEDRVT14_NR2_1 U28 ( .A1(B[8]), .A2(A[8]), .X(n11) );
  SAEDRVT14_ND2B_U_0P5 U29 ( .A(n20), .B(n22), .X(n23) );
  SAEDRVT14_ND2_CDC_0P5 U30 ( .A1(B[10]), .A2(A[10]), .X(n22) );
  SAEDRVT14_NR2_1 U31 ( .A1(B[10]), .A2(A[10]), .X(n20) );
endmodule


module gf256_mult_1_DW02_mult_0_DW02_mult_1 ( A, B, TC, PRODUCT );
  input [7:0] A;
  input [7:0] B;
  output [15:0] PRODUCT;
  input TC;
  wire   net2271, \ab[7][7] , \ab[7][6] , \ab[7][5] , \ab[7][4] , \ab[7][3] ,
         \ab[7][2] , \ab[7][1] , \ab[7][0] , \ab[6][7] , \ab[6][6] ,
         \ab[6][5] , \ab[6][4] , \ab[6][3] , \ab[6][2] , \ab[6][1] ,
         \ab[6][0] , \ab[5][7] , \ab[5][6] , \ab[5][5] , \ab[5][4] ,
         \ab[5][3] , \ab[5][2] , \ab[5][1] , \ab[5][0] , \ab[4][7] ,
         \ab[4][6] , \ab[4][5] , \ab[4][4] , \ab[4][3] , \ab[4][2] ,
         \ab[4][1] , \ab[4][0] , \ab[3][7] , \ab[3][6] , \ab[3][5] ,
         \ab[3][4] , \ab[3][3] , \ab[3][2] , \ab[3][1] , \ab[3][0] ,
         \ab[2][7] , \ab[2][6] , \ab[2][5] , \ab[2][4] , \ab[2][3] ,
         \ab[2][2] , \ab[2][1] , \ab[2][0] , \ab[1][7] , \ab[1][6] ,
         \ab[1][5] , \ab[1][4] , \ab[1][3] , \ab[1][2] , \ab[1][1] ,
         \ab[1][0] , \ab[0][7] , \ab[0][6] , \ab[0][5] , \ab[0][4] ,
         \ab[0][3] , \ab[0][2] , \ab[0][1] , \CARRYB[7][6] , \CARRYB[7][5] ,
         \CARRYB[7][4] , \CARRYB[7][3] , \CARRYB[7][2] , \CARRYB[7][1] ,
         \CARRYB[7][0] , \CARRYB[6][6] , \CARRYB[6][5] , \CARRYB[6][4] ,
         \CARRYB[6][3] , \CARRYB[6][2] , \CARRYB[6][1] , \CARRYB[6][0] ,
         \CARRYB[5][6] , \CARRYB[5][5] , \CARRYB[5][4] , \CARRYB[5][3] ,
         \CARRYB[5][2] , \CARRYB[5][1] , \CARRYB[5][0] , \CARRYB[4][6] ,
         \CARRYB[4][5] , \CARRYB[4][4] , \CARRYB[4][3] , \CARRYB[4][2] ,
         \CARRYB[4][1] , \CARRYB[4][0] , \CARRYB[3][6] , \CARRYB[3][5] ,
         \CARRYB[3][4] , \CARRYB[3][3] , \CARRYB[3][2] , \CARRYB[3][1] ,
         \CARRYB[3][0] , \CARRYB[2][6] , \CARRYB[2][5] , \CARRYB[2][4] ,
         \CARRYB[2][3] , \CARRYB[2][2] , \CARRYB[2][1] , \CARRYB[2][0] ,
         \SUMB[7][6] , \SUMB[7][5] , \SUMB[7][4] , \SUMB[7][3] , \SUMB[7][2] ,
         \SUMB[7][1] , \SUMB[7][0] , \SUMB[6][6] , \SUMB[6][5] , \SUMB[6][4] ,
         \SUMB[6][3] , \SUMB[6][2] , \SUMB[6][1] , \SUMB[5][6] , \SUMB[5][5] ,
         \SUMB[5][4] , \SUMB[5][3] , \SUMB[5][2] , \SUMB[5][1] , \SUMB[4][6] ,
         \SUMB[4][5] , \SUMB[4][4] , \SUMB[4][3] , \SUMB[4][2] , \SUMB[4][1] ,
         \SUMB[3][6] , \SUMB[3][5] , \SUMB[3][4] , \SUMB[3][3] , \SUMB[3][2] ,
         \SUMB[3][1] , \SUMB[2][6] , \SUMB[2][5] , \SUMB[2][4] , \SUMB[2][3] ,
         \SUMB[2][2] , \SUMB[2][1] , \SUMB[1][6] , \SUMB[1][5] , \SUMB[1][4] ,
         \SUMB[1][3] , \SUMB[1][2] , \SUMB[1][1] , \A1[12] , \A1[11] ,
         \A1[10] , \A1[9] , \A1[8] , \A1[7] , \A1[6] , \A1[4] , \A1[3] ,
         \A1[2] , \A1[1] , \A1[0] , n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34;

  gf256_mult_1_DW01_add_0_DW01_add_1 FS_1 ( .A({net2271, \A1[12] , \A1[11] , 
        \A1[10] , \A1[9] , \A1[8] , \A1[7] , \A1[6] , \SUMB[7][0] , \A1[4] , 
        \A1[3] , \A1[2] , \A1[1] , \A1[0] }), .B({n9, n14, n18, n16, n17, n15, 
        n13, net2271, net2271, net2271, net2271, net2271, net2271, net2271}), 
        .CI(net2271), .SUM(PRODUCT[15:2]) );
  SAEDRVT14_ADDF_V1_1 S2_6_5 ( .A(\ab[6][5] ), .B(\CARRYB[5][5] ), .CI(
        \SUMB[5][6] ), .CO(\CARRYB[6][5] ), .S(\SUMB[6][5] ) );
  SAEDRVT14_ADDF_V1_1 S2_6_3 ( .A(\ab[6][3] ), .B(\CARRYB[5][3] ), .CI(
        \SUMB[5][4] ), .CO(\CARRYB[6][3] ), .S(\SUMB[6][3] ) );
  SAEDRVT14_ADDF_V1_1 S2_6_4 ( .A(\ab[6][4] ), .B(\CARRYB[5][4] ), .CI(
        \SUMB[5][5] ), .CO(\CARRYB[6][4] ), .S(\SUMB[6][4] ) );
  SAEDRVT14_ADDF_V1_1 S2_5_4 ( .A(\ab[5][4] ), .B(\CARRYB[4][4] ), .CI(
        \SUMB[4][5] ), .CO(\CARRYB[5][4] ), .S(\SUMB[5][4] ) );
  SAEDRVT14_ADDF_V1_1 S2_5_5 ( .A(\ab[5][5] ), .B(\CARRYB[4][5] ), .CI(
        \SUMB[4][6] ), .CO(\CARRYB[5][5] ), .S(\SUMB[5][5] ) );
  SAEDRVT14_ADDF_V1_1 S2_6_1 ( .A(\ab[6][1] ), .B(\CARRYB[5][1] ), .CI(
        \SUMB[5][2] ), .CO(\CARRYB[6][1] ), .S(\SUMB[6][1] ) );
  SAEDRVT14_ADDF_V1_1 S2_6_2 ( .A(\ab[6][2] ), .B(\CARRYB[5][2] ), .CI(
        \SUMB[5][3] ), .CO(\CARRYB[6][2] ), .S(\SUMB[6][2] ) );
  SAEDRVT14_ADDF_V1_1 S2_4_5 ( .A(\ab[4][5] ), .B(\CARRYB[3][5] ), .CI(
        \SUMB[3][6] ), .CO(\CARRYB[4][5] ), .S(\SUMB[4][5] ) );
  SAEDRVT14_ADDF_V1_1 S2_5_1 ( .A(\ab[5][1] ), .B(\CARRYB[4][1] ), .CI(
        \SUMB[4][2] ), .CO(\CARRYB[5][1] ), .S(\SUMB[5][1] ) );
  SAEDRVT14_ADDF_V1_1 S2_5_2 ( .A(\ab[5][2] ), .B(\CARRYB[4][2] ), .CI(
        \SUMB[4][3] ), .CO(\CARRYB[5][2] ), .S(\SUMB[5][2] ) );
  SAEDRVT14_ADDF_V1_1 S2_5_3 ( .A(\ab[5][3] ), .B(\CARRYB[4][3] ), .CI(
        \SUMB[4][4] ), .CO(\CARRYB[5][3] ), .S(\SUMB[5][3] ) );
  SAEDRVT14_ADDF_V1_1 S2_4_1 ( .A(\ab[4][1] ), .B(\CARRYB[3][1] ), .CI(
        \SUMB[3][2] ), .CO(\CARRYB[4][1] ), .S(\SUMB[4][1] ) );
  SAEDRVT14_ADDF_V1_1 S2_4_2 ( .A(\ab[4][2] ), .B(\CARRYB[3][2] ), .CI(
        \SUMB[3][3] ), .CO(\CARRYB[4][2] ), .S(\SUMB[4][2] ) );
  SAEDRVT14_ADDF_V1_1 S2_4_3 ( .A(\ab[4][3] ), .B(\CARRYB[3][3] ), .CI(
        \SUMB[3][4] ), .CO(\CARRYB[4][3] ), .S(\SUMB[4][3] ) );
  SAEDRVT14_ADDF_V1_1 S2_4_4 ( .A(\ab[4][4] ), .B(\CARRYB[3][4] ), .CI(
        \SUMB[3][5] ), .CO(\CARRYB[4][4] ), .S(\SUMB[4][4] ) );
  SAEDRVT14_ADDF_V1_1 S2_3_1 ( .A(\ab[3][1] ), .B(\CARRYB[2][1] ), .CI(
        \SUMB[2][2] ), .CO(\CARRYB[3][1] ), .S(\SUMB[3][1] ) );
  SAEDRVT14_ADDF_V1_1 S2_3_2 ( .A(\ab[3][2] ), .B(\CARRYB[2][2] ), .CI(
        \SUMB[2][3] ), .CO(\CARRYB[3][2] ), .S(\SUMB[3][2] ) );
  SAEDRVT14_ADDF_V1_1 S2_3_3 ( .A(\ab[3][3] ), .B(\CARRYB[2][3] ), .CI(
        \SUMB[2][4] ), .CO(\CARRYB[3][3] ), .S(\SUMB[3][3] ) );
  SAEDRVT14_ADDF_V1_1 S2_3_4 ( .A(\ab[3][4] ), .B(\CARRYB[2][4] ), .CI(
        \SUMB[2][5] ), .CO(\CARRYB[3][4] ), .S(\SUMB[3][4] ) );
  SAEDRVT14_ADDF_V1_1 S2_3_5 ( .A(\ab[3][5] ), .B(\CARRYB[2][5] ), .CI(
        \SUMB[2][6] ), .CO(\CARRYB[3][5] ), .S(\SUMB[3][5] ) );
  SAEDRVT14_ADDF_V1_1 S2_2_1 ( .A(\ab[2][1] ), .B(n7), .CI(\SUMB[1][2] ), .CO(
        \CARRYB[2][1] ), .S(\SUMB[2][1] ) );
  SAEDRVT14_ADDF_V1_1 S2_2_2 ( .A(\ab[2][2] ), .B(n6), .CI(\SUMB[1][3] ), .CO(
        \CARRYB[2][2] ), .S(\SUMB[2][2] ) );
  SAEDRVT14_ADDF_V1_1 S2_2_3 ( .A(\ab[2][3] ), .B(n5), .CI(\SUMB[1][4] ), .CO(
        \CARRYB[2][3] ), .S(\SUMB[2][3] ) );
  SAEDRVT14_ADDF_V1_1 S2_2_4 ( .A(\ab[2][4] ), .B(n4), .CI(\SUMB[1][5] ), .CO(
        \CARRYB[2][4] ), .S(\SUMB[2][4] ) );
  SAEDRVT14_ADDF_V1_1 S2_2_5 ( .A(\ab[2][5] ), .B(n3), .CI(\SUMB[1][6] ), .CO(
        \CARRYB[2][5] ), .S(\SUMB[2][5] ) );
  SAEDRVT14_ADDF_V1_1 S3_5_6 ( .A(\ab[5][6] ), .B(\CARRYB[4][6] ), .CI(
        \ab[4][7] ), .CO(\CARRYB[5][6] ), .S(\SUMB[5][6] ) );
  SAEDRVT14_ADDF_V1_1 S3_3_6 ( .A(\ab[3][6] ), .B(\CARRYB[2][6] ), .CI(
        \ab[2][7] ), .CO(\CARRYB[3][6] ), .S(\SUMB[3][6] ) );
  SAEDRVT14_ADDF_V1_1 S3_6_6 ( .A(\ab[6][6] ), .B(\CARRYB[5][6] ), .CI(
        \ab[5][7] ), .CO(\CARRYB[6][6] ), .S(\SUMB[6][6] ) );
  SAEDRVT14_ADDF_V1_1 S3_4_6 ( .A(\ab[4][6] ), .B(\CARRYB[3][6] ), .CI(
        \ab[3][7] ), .CO(\CARRYB[4][6] ), .S(\SUMB[4][6] ) );
  SAEDRVT14_ADDF_V1_1 S3_2_6 ( .A(\ab[2][6] ), .B(n2), .CI(\ab[1][7] ), .CO(
        \CARRYB[2][6] ), .S(\SUMB[2][6] ) );
  SAEDRVT14_ADDF_V1_1 S4_5 ( .A(\ab[7][5] ), .B(\CARRYB[6][5] ), .CI(
        \SUMB[6][6] ), .CO(\CARRYB[7][5] ), .S(\SUMB[7][5] ) );
  SAEDRVT14_ADDF_V1_1 S4_4 ( .A(\ab[7][4] ), .B(\CARRYB[6][4] ), .CI(
        \SUMB[6][5] ), .CO(\CARRYB[7][4] ), .S(\SUMB[7][4] ) );
  SAEDRVT14_ADDF_V1_1 S4_3 ( .A(\ab[7][3] ), .B(\CARRYB[6][3] ), .CI(
        \SUMB[6][4] ), .CO(\CARRYB[7][3] ), .S(\SUMB[7][3] ) );
  SAEDRVT14_ADDF_V1_1 S4_2 ( .A(\ab[7][2] ), .B(\CARRYB[6][2] ), .CI(
        \SUMB[6][3] ), .CO(\CARRYB[7][2] ), .S(\SUMB[7][2] ) );
  SAEDRVT14_ADDF_V1_1 S4_1 ( .A(\ab[7][1] ), .B(\CARRYB[6][1] ), .CI(
        \SUMB[6][2] ), .CO(\CARRYB[7][1] ), .S(\SUMB[7][1] ) );
  SAEDRVT14_ADDF_V1_1 S5_6 ( .A(\ab[7][6] ), .B(\CARRYB[6][6] ), .CI(
        \ab[6][7] ), .CO(\CARRYB[7][6] ), .S(\SUMB[7][6] ) );
  SAEDRVT14_ADDF_V1_1 S1_2_0 ( .A(\ab[2][0] ), .B(n8), .CI(\SUMB[1][1] ), .CO(
        \CARRYB[2][0] ), .S(\A1[0] ) );
  SAEDRVT14_ADDF_V1_1 S1_3_0 ( .A(\ab[3][0] ), .B(\CARRYB[2][0] ), .CI(
        \SUMB[2][1] ), .CO(\CARRYB[3][0] ), .S(\A1[1] ) );
  SAEDRVT14_ADDF_V1_1 S1_5_0 ( .A(\ab[5][0] ), .B(\CARRYB[4][0] ), .CI(
        \SUMB[4][1] ), .CO(\CARRYB[5][0] ), .S(\A1[3] ) );
  SAEDRVT14_ADDF_V1_1 S1_6_0 ( .A(\SUMB[5][1] ), .B(\CARRYB[5][0] ), .CI(
        \ab[6][0] ), .CO(\CARRYB[6][0] ), .S(\A1[4] ) );
  SAEDRVT14_ADDF_V2_2 S4_0 ( .A(\ab[7][0] ), .B(\CARRYB[6][0] ), .CI(
        \SUMB[6][1] ), .CO(\CARRYB[7][0] ), .S(\SUMB[7][0] ) );
  SAEDRVT14_ADDF_V1_2 S1_4_0 ( .A(\ab[4][0] ), .B(\CARRYB[3][0] ), .CI(
        \SUMB[3][1] ), .CO(\CARRYB[4][0] ), .S(\A1[2] ) );
  SAEDRVT14_TIE0_V1_2 U2 ( .X(net2271) );
  SAEDRVT14_INV_S_8 U3 ( .A(A[5]), .X(n29) );
  SAEDRVT14_INV_6 U4 ( .A(A[0]), .X(n34) );
  SAEDRVT14_INV_S_16 U5 ( .A(A[7]), .X(n27) );
  SAEDRVT14_INV_S_1 U6 ( .A(A[5]), .X(n10) );
  SAEDRVT14_INV_2 U7 ( .A(A[3]), .X(n11) );
  SAEDRVT14_INV_3 U8 ( .A(B[7]), .X(n26) );
  SAEDRVT14_INV_S_8 U9 ( .A(A[1]), .X(n33) );
  SAEDRVT14_NR2_MM_1 U10 ( .A1(n19), .A2(n29), .X(\ab[5][0] ) );
  SAEDRVT14_INV_S_1 U11 ( .A(A[3]), .X(n31) );
  SAEDRVT14_EO2_2 U12 ( .A1(\CARRYB[7][0] ), .A2(\SUMB[7][1] ), .X(\A1[6] ) );
  SAEDRVT14_NR2_MM_1 U13 ( .A1(n27), .A2(n19), .X(\ab[7][0] ) );
  SAEDRVT14_AN2_MM_1 U14 ( .A1(\ab[0][7] ), .A2(\ab[1][6] ), .X(n2) );
  SAEDRVT14_AN2_MM_1 U15 ( .A1(\ab[0][6] ), .A2(\ab[1][5] ), .X(n3) );
  SAEDRVT14_AN2_MM_1 U16 ( .A1(\ab[0][5] ), .A2(\ab[1][4] ), .X(n4) );
  SAEDRVT14_AN2_MM_1 U17 ( .A1(\ab[0][4] ), .A2(\ab[1][3] ), .X(n5) );
  SAEDRVT14_AN2_MM_1 U18 ( .A1(\ab[0][3] ), .A2(\ab[1][2] ), .X(n6) );
  SAEDRVT14_AN2_MM_1 U19 ( .A1(\ab[0][2] ), .A2(\ab[1][1] ), .X(n7) );
  SAEDRVT14_AN2_MM_1 U20 ( .A1(\ab[0][1] ), .A2(\ab[1][0] ), .X(n8) );
  SAEDRVT14_AN2_MM_1 U21 ( .A1(\CARRYB[7][6] ), .A2(\ab[7][7] ), .X(n9) );
  SAEDRVT14_INV_2 U22 ( .A(A[2]), .X(n32) );
  SAEDRVT14_INV_S_20 U23 ( .A(A[6]), .X(n28) );
  SAEDRVT14_NR2_MM_1 U24 ( .A1(n19), .A2(n28), .X(\ab[6][0] ) );
  SAEDRVT14_NR2_MM_0P5 U25 ( .A1(n27), .A2(n26), .X(\ab[7][7] ) );
  SAEDRVT14_NR2_MM_0P5 U26 ( .A1(n27), .A2(n25), .X(\ab[7][6] ) );
  SAEDRVT14_NR2_MM_0P5 U27 ( .A1(n27), .A2(n24), .X(\ab[7][5] ) );
  SAEDRVT14_NR2_MM_0P5 U28 ( .A1(n27), .A2(n23), .X(\ab[7][4] ) );
  SAEDRVT14_NR2_MM_0P5 U29 ( .A1(n27), .A2(n22), .X(\ab[7][3] ) );
  SAEDRVT14_EO2_2 U30 ( .A1(\ab[0][1] ), .A2(\ab[1][0] ), .X(PRODUCT[1]) );
  SAEDRVT14_NR2_MM_1 U31 ( .A1(n19), .A2(n30), .X(\ab[4][0] ) );
  SAEDRVT14_INV_S_20 U32 ( .A(A[4]), .X(n30) );
  SAEDRVT14_NR2_MM_0P5 U33 ( .A1(n20), .A2(n30), .X(\ab[4][1] ) );
  SAEDRVT14_NR2_MM_0P5 U34 ( .A1(n21), .A2(n30), .X(\ab[4][2] ) );
  SAEDRVT14_NR2_MM_0P5 U35 ( .A1(n22), .A2(n30), .X(\ab[4][3] ) );
  SAEDRVT14_NR2_MM_0P5 U36 ( .A1(n23), .A2(n30), .X(\ab[4][4] ) );
  SAEDRVT14_NR2_MM_0P5 U37 ( .A1(n24), .A2(n30), .X(\ab[4][5] ) );
  SAEDRVT14_NR2_MM_0P5 U38 ( .A1(n25), .A2(n30), .X(\ab[4][6] ) );
  SAEDRVT14_NR2_MM_0P5 U39 ( .A1(n26), .A2(n30), .X(\ab[4][7] ) );
  SAEDRVT14_INV_2 U40 ( .A(A[2]), .X(n12) );
  SAEDRVT14_NR2_MM_1 U41 ( .A1(n19), .A2(n33), .X(\ab[1][0] ) );
  SAEDRVT14_NR2_MM_0P5 U42 ( .A1(n21), .A2(n33), .X(\ab[1][2] ) );
  SAEDRVT14_NR2_MM_0P5 U43 ( .A1(n20), .A2(n33), .X(\ab[1][1] ) );
  SAEDRVT14_NR2_MM_0P5 U44 ( .A1(n26), .A2(n33), .X(\ab[1][7] ) );
  SAEDRVT14_NR2_MM_0P5 U45 ( .A1(n25), .A2(n33), .X(\ab[1][6] ) );
  SAEDRVT14_NR2_MM_0P5 U46 ( .A1(n24), .A2(n33), .X(\ab[1][5] ) );
  SAEDRVT14_NR2_MM_0P5 U47 ( .A1(n23), .A2(n33), .X(\ab[1][4] ) );
  SAEDRVT14_NR2_MM_0P5 U48 ( .A1(n22), .A2(n33), .X(\ab[1][3] ) );
  SAEDRVT14_NR2_MM_0P5 U49 ( .A1(n26), .A2(n11), .X(\ab[3][7] ) );
  SAEDRVT14_NR2_MM_0P5 U50 ( .A1(n25), .A2(n11), .X(\ab[3][6] ) );
  SAEDRVT14_NR2_MM_0P5 U51 ( .A1(n25), .A2(n10), .X(\ab[5][6] ) );
  SAEDRVT14_NR2_MM_0P5 U52 ( .A1(n26), .A2(n28), .X(\ab[6][7] ) );
  SAEDRVT14_NR2_MM_0P5 U53 ( .A1(n26), .A2(n29), .X(\ab[5][7] ) );
  SAEDRVT14_INV_3 U54 ( .A(B[0]), .X(n19) );
  SAEDRVT14_EO2_1 U55 ( .A1(\CARRYB[7][1] ), .A2(\SUMB[7][2] ), .X(\A1[7] ) );
  SAEDRVT14_EO2_1 U56 ( .A1(\CARRYB[7][6] ), .A2(\ab[7][7] ), .X(\A1[12] ) );
  SAEDRVT14_EO2_1 U57 ( .A1(\CARRYB[7][2] ), .A2(\SUMB[7][3] ), .X(\A1[8] ) );
  SAEDRVT14_EO2_1 U58 ( .A1(\CARRYB[7][4] ), .A2(\SUMB[7][5] ), .X(\A1[10] )
         );
  SAEDRVT14_EO2_1 U59 ( .A1(\CARRYB[7][3] ), .A2(\SUMB[7][4] ), .X(\A1[9] ) );
  SAEDRVT14_EO2_1 U60 ( .A1(\CARRYB[7][5] ), .A2(\SUMB[7][6] ), .X(\A1[11] )
         );
  SAEDRVT14_AN2_MM_1 U61 ( .A1(\CARRYB[7][0] ), .A2(\SUMB[7][1] ), .X(n13) );
  SAEDRVT14_AN2_MM_1 U62 ( .A1(\CARRYB[7][5] ), .A2(\SUMB[7][6] ), .X(n14) );
  SAEDRVT14_AN2_MM_1 U63 ( .A1(\CARRYB[7][1] ), .A2(\SUMB[7][2] ), .X(n15) );
  SAEDRVT14_AN2_MM_1 U64 ( .A1(\CARRYB[7][3] ), .A2(\SUMB[7][4] ), .X(n16) );
  SAEDRVT14_AN2_MM_1 U65 ( .A1(\CARRYB[7][2] ), .A2(\SUMB[7][3] ), .X(n17) );
  SAEDRVT14_AN2_MM_1 U66 ( .A1(\CARRYB[7][4] ), .A2(\SUMB[7][5] ), .X(n18) );
  SAEDRVT14_EO2_1 U67 ( .A1(\ab[1][1] ), .A2(\ab[0][2] ), .X(\SUMB[1][1] ) );
  SAEDRVT14_NR2_MM_1 U68 ( .A1(n19), .A2(n32), .X(\ab[2][0] ) );
  SAEDRVT14_EO2_0P5 U69 ( .A1(\ab[1][6] ), .A2(\ab[0][7] ), .X(\SUMB[1][6] )
         );
  SAEDRVT14_EO2_0P5 U70 ( .A1(\ab[1][5] ), .A2(\ab[0][6] ), .X(\SUMB[1][5] )
         );
  SAEDRVT14_EO2_0P5 U71 ( .A1(\ab[1][4] ), .A2(\ab[0][5] ), .X(\SUMB[1][4] )
         );
  SAEDRVT14_EO2_0P5 U72 ( .A1(\ab[1][3] ), .A2(\ab[0][4] ), .X(\SUMB[1][3] )
         );
  SAEDRVT14_EO2_0P5 U73 ( .A1(\ab[1][2] ), .A2(\ab[0][3] ), .X(\SUMB[1][2] )
         );
  SAEDRVT14_INV_3 U74 ( .A(B[2]), .X(n21) );
  SAEDRVT14_INV_3 U75 ( .A(B[1]), .X(n20) );
  SAEDRVT14_INV_3 U76 ( .A(B[4]), .X(n23) );
  SAEDRVT14_INV_3 U77 ( .A(B[3]), .X(n22) );
  SAEDRVT14_INV_3 U78 ( .A(B[6]), .X(n25) );
  SAEDRVT14_INV_3 U79 ( .A(B[5]), .X(n24) );
  SAEDRVT14_NR2_1 U80 ( .A1(n27), .A2(n21), .X(\ab[7][2] ) );
  SAEDRVT14_NR2_1 U81 ( .A1(n27), .A2(n20), .X(\ab[7][1] ) );
  SAEDRVT14_NR2_1 U82 ( .A1(n25), .A2(n28), .X(\ab[6][6] ) );
  SAEDRVT14_NR2_1 U83 ( .A1(n24), .A2(n28), .X(\ab[6][5] ) );
  SAEDRVT14_NR2_1 U84 ( .A1(n23), .A2(n28), .X(\ab[6][4] ) );
  SAEDRVT14_NR2_1 U85 ( .A1(n22), .A2(n28), .X(\ab[6][3] ) );
  SAEDRVT14_NR2_1 U86 ( .A1(n21), .A2(n28), .X(\ab[6][2] ) );
  SAEDRVT14_NR2_1 U87 ( .A1(n20), .A2(n28), .X(\ab[6][1] ) );
  SAEDRVT14_NR2_1 U88 ( .A1(n24), .A2(n10), .X(\ab[5][5] ) );
  SAEDRVT14_NR2_1 U89 ( .A1(n23), .A2(n10), .X(\ab[5][4] ) );
  SAEDRVT14_NR2_1 U90 ( .A1(n22), .A2(n29), .X(\ab[5][3] ) );
  SAEDRVT14_NR2_1 U91 ( .A1(n21), .A2(n10), .X(\ab[5][2] ) );
  SAEDRVT14_NR2_1 U92 ( .A1(n20), .A2(n29), .X(\ab[5][1] ) );
  SAEDRVT14_NR2_1 U93 ( .A1(n24), .A2(n11), .X(\ab[3][5] ) );
  SAEDRVT14_NR2_1 U94 ( .A1(n23), .A2(n11), .X(\ab[3][4] ) );
  SAEDRVT14_NR2_1 U95 ( .A1(n22), .A2(n11), .X(\ab[3][3] ) );
  SAEDRVT14_NR2_1 U96 ( .A1(n21), .A2(n11), .X(\ab[3][2] ) );
  SAEDRVT14_NR2_1 U97 ( .A1(n20), .A2(n11), .X(\ab[3][1] ) );
  SAEDRVT14_NR2_1 U98 ( .A1(n19), .A2(n31), .X(\ab[3][0] ) );
  SAEDRVT14_NR2_1 U99 ( .A1(n26), .A2(n12), .X(\ab[2][7] ) );
  SAEDRVT14_NR2_1 U100 ( .A1(n25), .A2(n12), .X(\ab[2][6] ) );
  SAEDRVT14_NR2_1 U101 ( .A1(n24), .A2(n12), .X(\ab[2][5] ) );
  SAEDRVT14_NR2_1 U102 ( .A1(n23), .A2(n12), .X(\ab[2][4] ) );
  SAEDRVT14_NR2_1 U103 ( .A1(n22), .A2(n12), .X(\ab[2][3] ) );
  SAEDRVT14_NR2_1 U104 ( .A1(n21), .A2(n12), .X(\ab[2][2] ) );
  SAEDRVT14_NR2_1 U105 ( .A1(n20), .A2(n12), .X(\ab[2][1] ) );
  SAEDRVT14_NR2_1 U106 ( .A1(n26), .A2(n34), .X(\ab[0][7] ) );
  SAEDRVT14_NR2_1 U107 ( .A1(n25), .A2(n34), .X(\ab[0][6] ) );
  SAEDRVT14_NR2_1 U108 ( .A1(n24), .A2(n34), .X(\ab[0][5] ) );
  SAEDRVT14_NR2_1 U109 ( .A1(n23), .A2(n34), .X(\ab[0][4] ) );
  SAEDRVT14_NR2_1 U110 ( .A1(n22), .A2(n34), .X(\ab[0][3] ) );
  SAEDRVT14_NR2_1 U111 ( .A1(n21), .A2(n34), .X(\ab[0][2] ) );
  SAEDRVT14_NR2_1 U112 ( .A1(n20), .A2(n34), .X(\ab[0][1] ) );
  SAEDRVT14_NR2_1 U113 ( .A1(n19), .A2(n34), .X(PRODUCT[0]) );
endmodule


module gf256_mult_1 ( a, b, result );
  input [7:0] a;
  input [7:0] b;
  output [7:0] result;
  wire   n1, n2, n3, n4, n5, n13, n14, n15, n16, n17, n18, n19, n20;
  wire   [15:0] temp_mult;

  SAEDRVT14_EO4_2 U10 ( .A1(n3), .A2(temp_mult[13]), .A3(n16), .A4(
        temp_mult[12]), .X(result[2]) );
  gf256_mult_1_DW02_mult_0_DW02_mult_1 mult_121 ( .A(a), .B(b), .TC(n1), 
        .PRODUCT(temp_mult) );
  SAEDRVT14_TIE0_V1_2 U1 ( .X(n1) );
  SAEDRVT14_EO2_V1_1P5 U2 ( .A1(temp_mult[5]), .A2(temp_mult[8]), .X(n2) );
  SAEDRVT14_EN3_3 U3 ( .A1(n17), .A2(n4), .A3(temp_mult[10]), .X(result[3]) );
  SAEDRVT14_EN3_3 U4 ( .A1(n15), .A2(temp_mult[12]), .A3(n5), .X(result[1]) );
  SAEDRVT14_EN3_3 U5 ( .A1(n18), .A2(n3), .A3(n5), .X(result[4]) );
  SAEDRVT14_EO3_4 U6 ( .A1(temp_mult[9]), .A2(n2), .A3(temp_mult[12]), .X(
        result[5]) );
  SAEDRVT14_EN3_3 U7 ( .A1(n20), .A2(n5), .A3(temp_mult[10]), .X(result[7]) );
  SAEDRVT14_EN3_3 U8 ( .A1(n19), .A2(n4), .A3(n13), .X(result[6]) );
  SAEDRVT14_EO4_2 U9 ( .A1(n5), .A2(n13), .A3(n14), .A4(temp_mult[0]), .X(
        result[0]) );
  SAEDRVT14_INV_S_1 U11 ( .A(temp_mult[13]), .X(n4) );
  SAEDRVT14_INV_S_0P5 U12 ( .A(temp_mult[10]), .X(n13) );
  SAEDRVT14_INV_S_1 U13 ( .A(temp_mult[11]), .X(n5) );
  SAEDRVT14_INV_S_1 U14 ( .A(temp_mult[14]), .X(n3) );
  SAEDRVT14_EO4_1 U15 ( .A1(temp_mult[14]), .A2(temp_mult[12]), .A3(
        temp_mult[7]), .A4(temp_mult[15]), .X(n14) );
  SAEDRVT14_EN3_1 U16 ( .A1(temp_mult[6]), .A2(temp_mult[9]), .A3(temp_mult[8]), .X(n19) );
  SAEDRVT14_EN3_1 U17 ( .A1(temp_mult[3]), .A2(temp_mult[15]), .A3(n3), .X(n17) );
  SAEDRVT14_EN3_1 U18 ( .A1(temp_mult[8]), .A2(temp_mult[4]), .A3(
        temp_mult[15]), .X(n18) );
  SAEDRVT14_EN3_1 U19 ( .A1(temp_mult[9]), .A2(temp_mult[2]), .A3(
        temp_mult[15]), .X(n16) );
  SAEDRVT14_EN3_1 U20 ( .A1(n3), .A2(temp_mult[9]), .A3(temp_mult[7]), .X(n20)
         );
  SAEDRVT14_EN3_1 U21 ( .A1(temp_mult[8]), .A2(temp_mult[1]), .A3(n4), .X(n15)
         );
endmodule


module rs_encoder_10_8 ( clk, rst_n, start, data_in, code_out, valid_out );
  input [63:0] data_in;
  output [79:0] code_out;
  input clk, rst_n, start;
  output valid_out;
  wire   \*Logic1* , \state[0] , N80, N81, N82, N83, N85, N86, N98, N99, N100,
         N101, N102, N103, N104, N105, n28, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n49, n52, n55, n57,
         n58, n59, n60, n62, n64, n69, n70, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n176, n177, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203,
         n204, n205, n206, n207, n208, n209, n210, n211, n212, n213, n214,
         n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n225,
         n226, n227, n228, n229, n230, n231, n232, n233, n234, n235, n236,
         n237, n238, n239, n240, n241;
  wire   [7:0] mult_a1;
  wire   [7:0] mult_result1;
  wire   [7:0] mult_a2;
  wire   [7:0] mult_result2;
  wire   [2:0] encode_cnt;
  assign code_out[79] = data_in[63];
  assign code_out[78] = data_in[62];
  assign code_out[77] = data_in[61];
  assign code_out[76] = data_in[60];
  assign code_out[75] = data_in[59];
  assign code_out[74] = data_in[58];
  assign code_out[73] = data_in[57];
  assign code_out[72] = data_in[56];
  assign code_out[71] = data_in[55];
  assign code_out[70] = data_in[54];
  assign code_out[69] = data_in[53];
  assign code_out[68] = data_in[52];
  assign code_out[67] = data_in[51];
  assign code_out[66] = data_in[50];
  assign code_out[65] = data_in[49];
  assign code_out[64] = data_in[48];
  assign code_out[63] = data_in[47];
  assign code_out[62] = data_in[46];
  assign code_out[61] = data_in[45];
  assign code_out[60] = data_in[44];
  assign code_out[59] = data_in[43];
  assign code_out[58] = data_in[42];
  assign code_out[57] = data_in[41];
  assign code_out[56] = data_in[40];
  assign code_out[55] = data_in[39];
  assign code_out[54] = data_in[38];
  assign code_out[53] = data_in[37];
  assign code_out[52] = data_in[36];
  assign code_out[51] = data_in[35];
  assign code_out[50] = data_in[34];
  assign code_out[49] = data_in[33];
  assign code_out[48] = data_in[32];
  assign code_out[47] = data_in[31];
  assign code_out[46] = data_in[30];
  assign code_out[45] = data_in[29];
  assign code_out[44] = data_in[28];
  assign code_out[43] = data_in[27];
  assign code_out[42] = data_in[26];
  assign code_out[41] = data_in[25];
  assign code_out[40] = data_in[24];
  assign code_out[39] = data_in[23];
  assign code_out[38] = data_in[22];
  assign code_out[37] = data_in[21];
  assign code_out[36] = data_in[20];
  assign code_out[35] = data_in[19];
  assign code_out[34] = data_in[18];
  assign code_out[33] = data_in[17];
  assign code_out[32] = data_in[16];
  assign code_out[31] = data_in[15];
  assign code_out[30] = data_in[14];
  assign code_out[29] = data_in[13];
  assign code_out[28] = data_in[12];
  assign code_out[27] = data_in[11];
  assign code_out[26] = data_in[10];
  assign code_out[25] = data_in[9];
  assign code_out[24] = data_in[8];
  assign code_out[23] = data_in[7];
  assign code_out[22] = data_in[6];
  assign code_out[21] = data_in[5];
  assign code_out[20] = data_in[4];
  assign code_out[19] = data_in[3];
  assign code_out[18] = data_in[2];
  assign code_out[17] = data_in[1];
  assign code_out[16] = data_in[0];

  SAEDRVT14_NR2_MM_8 U65 ( .A1(n60), .A2(n219), .X(mult_a1[7]) );
  SAEDRVT14_FDPRBQ_V2_4 \encode_cnt_reg[1]  ( .D(n87), .CK(clk), .RD(rst_n), 
        .Q(encode_cnt[1]) );
  gf256_mult_0 mult1 ( .a(mult_a1), .b({valid_out, valid_out, valid_out, 
        valid_out, valid_out, valid_out, \*Logic1* , valid_out}), .result(
        mult_result1) );
  gf256_mult_1 mult2 ( .a(mult_a2), .b({valid_out, valid_out, valid_out, 
        valid_out, valid_out, valid_out, valid_out, \*Logic1* }), .result(
        mult_result2) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[0][0]  ( .D(n77), .CK(clk), .RD(
        rst_n), .Q(code_out[0]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[0][1]  ( .D(n76), .CK(clk), .RD(
        rst_n), .Q(code_out[1]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[0][2]  ( .D(n75), .CK(clk), .RD(
        rst_n), .Q(code_out[2]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[0][3]  ( .D(n74), .CK(clk), .RD(
        rst_n), .Q(code_out[3]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[0][4]  ( .D(n73), .CK(clk), .RD(
        rst_n), .Q(code_out[4]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[0][5]  ( .D(n72), .CK(clk), .RD(
        rst_n), .Q(code_out[5]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[0][6]  ( .D(n71), .CK(clk), .RD(
        rst_n), .Q(code_out[6]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[0][7]  ( .D(n70), .CK(clk), .RD(
        rst_n), .Q(code_out[7]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[1][1]  ( .D(n84), .CK(clk), .RD(
        rst_n), .Q(code_out[9]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[1][0]  ( .D(n85), .CK(clk), .RD(
        rst_n), .Q(code_out[8]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[1][3]  ( .D(n82), .CK(clk), .RD(
        rst_n), .Q(code_out[11]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[1][2]  ( .D(n83), .CK(clk), .RD(
        rst_n), .Q(code_out[10]) );
  SAEDRVT14_FDPRBQ_V2LP_1 \parity_symbols_reg[1][5]  ( .D(n80), .CK(clk), .RD(
        rst_n), .Q(code_out[13]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[1][4]  ( .D(n81), .CK(clk), .RD(
        rst_n), .Q(code_out[12]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[1][6]  ( .D(n79), .CK(clk), .RD(
        rst_n), .Q(code_out[14]) );
  SAEDRVT14_FDPRBQ_V2_1 \parity_symbols_reg[1][7]  ( .D(n78), .CK(clk), .RD(
        rst_n), .Q(code_out[15]) );
  SAEDRVT14_FDPRB_V3_2 \encode_cnt_reg[2]  ( .D(n86), .CK(clk), .RD(rst_n), 
        .Q(n140), .QN(n141) );
  SAEDRVT14_FDPRBQ_V2_1 \encode_cnt_reg[0]  ( .D(n88), .CK(clk), .RD(rst_n), 
        .Q(encode_cnt[0]) );
  SAEDRVT14_FDPRBQ_V2_1 \state_reg[0]  ( .D(n89), .CK(clk), .RD(rst_n), .Q(
        \state[0] ) );
  SAEDRVT14_TIE0_V1_2 U110 ( .X(valid_out) );
  SAEDRVT14_AO22_4 U111 ( .A1(code_out[46]), .A2(n105), .B1(code_out[30]), 
        .B2(n90), .X(n207) );
  SAEDRVT14_AO221_1 U112 ( .A1(code_out[56]), .A2(n121), .B1(code_out[72]), 
        .B2(n101), .C(n151), .X(n154) );
  SAEDRVT14_INV_6 U113 ( .A(n105), .X(n103) );
  SAEDRVT14_INV_6 U114 ( .A(n123), .X(n125) );
  SAEDRVT14_AN2B_MM_4 U115 ( .B(n146), .A(n223), .X(mult_a1[2]) );
  SAEDRVT14_AN2B_MM_6 U116 ( .B(n145), .A(n223), .X(mult_a1[4]) );
  SAEDRVT14_BUF_16 U117 ( .A(n212), .X(n90) );
  SAEDRVT14_BUF_12 U118 ( .A(n212), .X(n91) );
  SAEDRVT14_BUF_12 U119 ( .A(n212), .X(n92) );
  SAEDRVT14_AO22_4 U120 ( .A1(n164), .A2(n115), .B1(n163), .B2(n116), .X(N83)
         );
  SAEDRVT14_AO221_2 U121 ( .A1(code_out[59]), .A2(n124), .B1(code_out[75]), 
        .B2(n95), .C(n161), .X(n164) );
  SAEDRVT14_INV_12 U122 ( .A(n102), .X(n93) );
  SAEDRVT14_INV_S_7 U123 ( .A(n214), .X(n94) );
  SAEDRVT14_INV_S_5 U124 ( .A(n94), .X(n95) );
  SAEDRVT14_INV_6 U125 ( .A(n94), .X(n96) );
  SAEDRVT14_INV_S_3 U126 ( .A(n94), .X(n97) );
  SAEDRVT14_INV_12 U127 ( .A(n93), .X(n98) );
  SAEDRVT14_INV_S_16 U128 ( .A(n98), .X(n99) );
  SAEDRVT14_INV_S_5 U129 ( .A(n98), .X(n100) );
  SAEDRVT14_INV_S_8 U130 ( .A(n98), .X(n101) );
  SAEDRVT14_INV_4 U131 ( .A(n214), .X(n102) );
  SAEDRVT14_EN2_4 U132 ( .A1(n227), .A2(n109), .X(n146) );
  SAEDRVT14_OAI22_4 U133 ( .A1(n127), .A2(n114), .B1(n128), .B2(n115), .X(n109) );
  SAEDRVT14_AN2B_MM_8 U134 ( .B(n147), .A(n224), .X(mult_a2[5]) );
  SAEDRVT14_AO22_4 U135 ( .A1(code_out[34]), .A2(n108), .B1(code_out[18]), 
        .B2(n90), .X(n160) );
  SAEDRVT14_AO22_4 U136 ( .A1(code_out[45]), .A2(n108), .B1(code_out[29]), 
        .B2(n91), .X(n204) );
  SAEDRVT14_BUF_S_6 U137 ( .A(n104), .X(n108) );
  SAEDRVT14_NR2_ECO_2 U138 ( .A1(n140), .A2(n216), .X(n214) );
  SAEDRVT14_INV_S_1 U139 ( .A(n117), .X(n118) );
  SAEDRVT14_AO22_0P5 U140 ( .A1(code_out[35]), .A2(n105), .B1(code_out[19]), 
        .B2(n91), .X(n162) );
  SAEDRVT14_ND2_MM_6 U141 ( .A1(n136), .A2(n137), .X(n55) );
  SAEDRVT14_ND2_2 U142 ( .A1(n112), .A2(N101), .X(n137) );
  SAEDRVT14_AO22_0P5 U143 ( .A1(code_out[42]), .A2(n107), .B1(code_out[26]), 
        .B2(n91), .X(n192) );
  SAEDRVT14_OR3_2 U144 ( .A1(n130), .A2(n131), .A3(n173), .X(n174) );
  SAEDRVT14_AO2BB2_V1_1 U145 ( .A1(n129), .A2(n103), .B1(code_out[22]), .B2(
        n91), .X(n173) );
  SAEDRVT14_AN2_MM_1 U146 ( .A1(code_out[54]), .A2(n119), .X(n130) );
  SAEDRVT14_AO221_2 U147 ( .A1(code_out[53]), .A2(n119), .B1(code_out[69]), 
        .B2(n97), .C(n170), .X(n171) );
  SAEDRVT14_ND2_2 U148 ( .A1(n229), .A2(n135), .X(n136) );
  SAEDRVT14_INV_4 U149 ( .A(N101), .X(n135) );
  SAEDRVT14_AO221_0P5 U150 ( .A1(code_out[60]), .A2(n119), .B1(code_out[76]), 
        .B2(n96), .C(n165), .X(n168) );
  SAEDRVT14_BUF_S_6 U151 ( .A(n104), .X(n106) );
  SAEDRVT14_AO22_0P5 U152 ( .A1(code_out[40]), .A2(n105), .B1(code_out[24]), 
        .B2(n91), .X(n184) );
  SAEDRVT14_AO221_0P5 U153 ( .A1(code_out[48]), .A2(n118), .B1(code_out[64]), 
        .B2(n97), .C(n185), .X(n186) );
  SAEDRVT14_NR2_MM_4 U154 ( .A1(n64), .A2(n223), .X(mult_a1[3]) );
  SAEDRVT14_AN2B_MM_6 U155 ( .B(n148), .A(n221), .X(mult_a1[0]) );
  SAEDRVT14_NR2_MM_6 U156 ( .A1(mult_result2[2]), .A2(n221), .X(n35) );
  SAEDRVT14_INV_S_8 U157 ( .A(n111), .X(n224) );
  SAEDRVT14_AO221_0P5 U158 ( .A1(code_out[51]), .A2(n124), .B1(code_out[67]), 
        .B2(n99), .C(n197), .X(n198) );
  SAEDRVT14_INV_3 U159 ( .A(n123), .X(n124) );
  SAEDRVT14_INV_6 U160 ( .A(n120), .X(n122) );
  SAEDRVT14_NR2_5 U161 ( .A1(n59), .A2(n223), .X(mult_a2[0]) );
  SAEDRVT14_AO22_4 U162 ( .A1(n175), .A2(n113), .B1(n174), .B2(n114), .X(N80)
         );
  SAEDRVT14_AO221_2 U163 ( .A1(code_out[58]), .A2(n121), .B1(code_out[74]), 
        .B2(n97), .C(n192), .X(n195) );
  SAEDRVT14_INV_S_5 U164 ( .A(n120), .X(n121) );
  SAEDRVT14_AO221_4 U165 ( .A1(code_out[50]), .A2(n125), .B1(code_out[66]), 
        .B2(n95), .C(n193), .X(n194) );
  SAEDRVT14_AO221_2 U166 ( .A1(code_out[63]), .A2(n125), .B1(code_out[79]), 
        .B2(n95), .C(n176), .X(n180) );
  SAEDRVT14_AO32_4 U167 ( .A1(n111), .A2(n239), .A3(mult_result2[6]), .B1(
        code_out[6]), .B2(n31), .X(n71) );
  SAEDRVT14_NR2_MM_3 U168 ( .A1(mult_result2[6]), .A2(n221), .X(n31) );
  SAEDRVT14_AO221_4 U169 ( .A1(code_out[49]), .A2(n124), .B1(code_out[65]), 
        .B2(n100), .C(n189), .X(n190) );
  SAEDRVT14_AOI221_1 U170 ( .A1(code_out[55]), .A2(n119), .B1(code_out[71]), 
        .B2(n99), .C(n213), .X(n132) );
  SAEDRVT14_AO22_2 U171 ( .A1(code_out[39]), .A2(n106), .B1(code_out[23]), 
        .B2(n91), .X(n213) );
  SAEDRVT14_AO22_2 U172 ( .A1(code_out[47]), .A2(n105), .B1(code_out[31]), 
        .B2(n92), .X(n211) );
  SAEDRVT14_AO22_2 U173 ( .A1(code_out[39]), .A2(n105), .B1(code_out[23]), 
        .B2(n90), .X(n178) );
  SAEDRVT14_INV_S_10 U174 ( .A(n181), .X(n123) );
  SAEDRVT14_BUF_16 U175 ( .A(n104), .X(n105) );
  SAEDRVT14_AO221_4 U176 ( .A1(code_out[52]), .A2(n181), .B1(code_out[68]), 
        .B2(n100), .C(n166), .X(n167) );
  SAEDRVT14_AO221_4 U177 ( .A1(code_out[61]), .A2(n122), .B1(code_out[77]), 
        .B2(n96), .C(n169), .X(n172) );
  SAEDRVT14_EO2_3 U178 ( .A1(n232), .A2(N98), .X(n52) );
  SAEDRVT14_AO2BB2_V1_4 U179 ( .A1(n132), .A2(n115), .B1(n113), .B2(n215), .X(
        N98) );
  SAEDRVT14_AOI221_1 U180 ( .A1(code_out[61]), .A2(n118), .B1(code_out[77]), 
        .B2(n96), .C(n204), .X(n126) );
  SAEDRVT14_AO221_4 U181 ( .A1(code_out[63]), .A2(n118), .B1(code_out[79]), 
        .B2(n96), .C(n211), .X(n215) );
  SAEDRVT14_BUF_16 U182 ( .A(n177), .X(n104) );
  SAEDRVT14_BUF_S_6 U183 ( .A(n104), .X(n107) );
  SAEDRVT14_NR2_ECO_2 U184 ( .A1(n216), .A2(n141), .X(n177) );
  SAEDRVT14_NR2_MM_8 U185 ( .A1(n52), .A2(n224), .X(mult_a2[7]) );
  SAEDRVT14_AO22_2 U186 ( .A1(n172), .A2(n115), .B1(n171), .B2(n116), .X(N81)
         );
  SAEDRVT14_AN2B_MM_8 U187 ( .B(n142), .A(n223), .X(mult_a1[6]) );
  SAEDRVT14_AN2B_MM_6 U188 ( .B(n139), .A(n223), .X(mult_a1[1]) );
  SAEDRVT14_AN2B_MM_4 U189 ( .B(n150), .A(n224), .X(mult_a2[3]) );
  SAEDRVT14_INV_S_1 U190 ( .A(code_out[38]), .X(n129) );
  SAEDRVT14_BUF_CDC_2 U191 ( .A(n143), .X(n181) );
  SAEDRVT14_AO221_0P5 U192 ( .A1(code_out[55]), .A2(n125), .B1(code_out[71]), 
        .B2(n101), .C(n178), .X(n179) );
  SAEDRVT14_AO221_0P5 U193 ( .A1(code_out[49]), .A2(n122), .B1(code_out[65]), 
        .B2(n96), .C(n156), .X(n157) );
  SAEDRVT14_AO2BB2_V1_1 U194 ( .A1(n126), .A2(n116), .B1(n206), .B2(n114), .X(
        N100) );
  SAEDRVT14_OR2_MM_2 U195 ( .A1(n133), .A2(n134), .X(N101) );
  SAEDRVT14_AN2_MM_1 U196 ( .A1(n203), .A2(n113), .X(n133) );
  SAEDRVT14_AN2_MM_1 U197 ( .A1(n202), .A2(n116), .X(n134) );
  SAEDRVT14_NR2_MM_4 U198 ( .A1(n57), .A2(n219), .X(mult_a2[2]) );
  SAEDRVT14_BUF_S_4 U199 ( .A(n220), .X(n223) );
  SAEDRVT14_INV_S_1 U200 ( .A(code_out[15]), .X(n232) );
  SAEDRVT14_INV_S_1 U201 ( .A(code_out[14]), .X(n231) );
  SAEDRVT14_NR2_4 U202 ( .A1(mult_result1[5]), .A2(n222), .X(n40) );
  SAEDRVT14_AO32_1 U203 ( .A1(n111), .A2(n240), .A3(mult_result2[7]), .B1(
        code_out[7]), .B2(n28), .X(n70) );
  SAEDRVT14_NR2_MM_1 U204 ( .A1(mult_result2[7]), .A2(n110), .X(n28) );
  SAEDRVT14_NR2_MM_3 U205 ( .A1(mult_result2[0]), .A2(n221), .X(n37) );
  SAEDRVT14_AO32_2 U206 ( .A1(n218), .A2(n229), .A3(mult_result1[4]), .B1(
        code_out[12]), .B2(n41), .X(n81) );
  SAEDRVT14_NR2_MM_3 U207 ( .A1(n58), .A2(n224), .X(mult_a2[1]) );
  SAEDRVT14_EO2_2 U208 ( .A1(n226), .A2(N104), .X(n58) );
  SAEDRVT14_NR2_MM_6 U209 ( .A1(n140), .A2(n138), .X(n143) );
  SAEDRVT14_NR2_MM_8 U210 ( .A1(mult_result2[5]), .A2(n221), .X(n32) );
  SAEDRVT14_INV_4 U211 ( .A(n181), .X(n120) );
  SAEDRVT14_CLKSPLT_1 U212 ( .CK(\state[0] ), .CKOUTB(n110), .CKOUT(n111) );
  SAEDRVT14_INV_4 U213 ( .A(n143), .X(n117) );
  SAEDRVT14_INV_4 U214 ( .A(n117), .X(n119) );
  SAEDRVT14_CLKSPLT_1 U215 ( .CK(code_out[12]), .CKOUTB(n229), .CKOUT(n112) );
  SAEDRVT14_AOI22_1P5 U216 ( .A1(n115), .A2(n180), .B1(n179), .B2(n114), .X(
        n144) );
  SAEDRVT14_AO22_2 U217 ( .A1(n158), .A2(n113), .B1(n157), .B2(n114), .X(N85)
         );
  SAEDRVT14_INV_S_10 U218 ( .A(n216), .X(n138) );
  SAEDRVT14_NR2_MM_8 U219 ( .A1(mult_result2[3]), .A2(n221), .X(n34) );
  SAEDRVT14_AN2B_MM_8 U220 ( .B(n149), .A(n110), .X(mult_a2[6]) );
  SAEDRVT14_EO2_3 U221 ( .A1(n230), .A2(N81), .X(n62) );
  SAEDRVT14_EO2_3 U222 ( .A1(n228), .A2(N83), .X(n64) );
  SAEDRVT14_AO32_2 U223 ( .A1(n217), .A2(n234), .A3(mult_result2[1]), .B1(
        code_out[1]), .B2(n36), .X(n76) );
  SAEDRVT14_NR2_MM_10 U224 ( .A1(mult_result2[1]), .A2(n221), .X(n36) );
  SAEDRVT14_CLKSPLT_8 U225 ( .CK(encode_cnt[0]), .CKOUTB(n113), .CKOUT(n114)
         );
  SAEDRVT14_CLKSPLT_8 U226 ( .CK(encode_cnt[0]), .CKOUTB(n115), .CKOUT(n116)
         );
  SAEDRVT14_AO221_4 U227 ( .A1(code_out[62]), .A2(n119), .B1(code_out[78]), 
        .B2(n99), .C(n207), .X(n175) );
  SAEDRVT14_AO32_2 U228 ( .A1(n218), .A2(n235), .A3(mult_result2[2]), .B1(
        code_out[2]), .B2(n35), .X(n75) );
  SAEDRVT14_NR2_ECO_2 U229 ( .A1(n222), .A2(mult_result1[0]), .X(n45) );
  SAEDRVT14_AO32_2 U230 ( .A1(n218), .A2(n225), .A3(mult_result1[0]), .B1(
        code_out[8]), .B2(n45), .X(n85) );
  SAEDRVT14_AOI221_0P5 U231 ( .A1(code_out[58]), .A2(n119), .B1(code_out[74]), 
        .B2(n101), .C(n159), .X(n127) );
  SAEDRVT14_AOI221_0P5 U232 ( .A1(code_out[50]), .A2(n122), .B1(code_out[66]), 
        .B2(n99), .C(n160), .X(n128) );
  SAEDRVT14_AN2_MM_1 U233 ( .A1(code_out[70]), .A2(n101), .X(n131) );
  SAEDRVT14_NR2_MM_10 U234 ( .A1(mult_result1[7]), .A2(n221), .X(n38) );
  SAEDRVT14_INV_S_20 U235 ( .A(n241), .X(n216) );
  SAEDRVT14_AO221_4 U236 ( .A1(code_out[57]), .A2(n119), .B1(code_out[73]), 
        .B2(n100), .C(n188), .X(n191) );
  SAEDRVT14_NR2_5 U237 ( .A1(n138), .A2(n141), .X(n212) );
  SAEDRVT14_AO32_2 U238 ( .A1(n218), .A2(n237), .A3(mult_result2[4]), .B1(
        code_out[4]), .B2(n33), .X(n73) );
  SAEDRVT14_NR2_MM_10 U239 ( .A1(mult_result2[4]), .A2(n221), .X(n33) );
  SAEDRVT14_INV_12 U240 ( .A(encode_cnt[1]), .X(n241) );
  SAEDRVT14_AO32_2 U241 ( .A1(n217), .A2(n230), .A3(mult_result1[5]), .B1(
        code_out[13]), .B2(n40), .X(n80) );
  SAEDRVT14_AO32_2 U242 ( .A1(n111), .A2(n238), .A3(mult_result2[5]), .B1(
        code_out[5]), .B2(n32), .X(n72) );
  SAEDRVT14_AO32_2 U243 ( .A1(n217), .A2(n226), .A3(mult_result1[1]), .B1(
        code_out[9]), .B2(n44), .X(n84) );
  SAEDRVT14_NR2_MM_4 U244 ( .A1(mult_result1[1]), .A2(n222), .X(n44) );
  SAEDRVT14_NR2_MM_8 U245 ( .A1(mult_result1[6]), .A2(n222), .X(n39) );
  SAEDRVT14_NR2_MM_6 U246 ( .A1(mult_result1[4]), .A2(n222), .X(n41) );
  SAEDRVT14_AO32_2 U247 ( .A1(n218), .A2(mult_result1[2]), .A3(n227), .B1(
        code_out[10]), .B2(n43), .X(n83) );
  SAEDRVT14_NR2_MM_8 U248 ( .A1(mult_result1[2]), .A2(n222), .X(n43) );
  SAEDRVT14_EN2_3 U249 ( .A1(n226), .A2(N85), .X(n139) );
  SAEDRVT14_NR2_MM_6 U250 ( .A1(n62), .A2(n223), .X(mult_a1[5]) );
  SAEDRVT14_AO221_1 U251 ( .A1(code_out[59]), .A2(n181), .B1(code_out[75]), 
        .B2(n95), .C(n196), .X(n199) );
  SAEDRVT14_NR2_MM_8 U252 ( .A1(n55), .A2(n224), .X(mult_a2[4]) );
  SAEDRVT14_AO32_1 U253 ( .A1(n218), .A2(n233), .A3(mult_result2[0]), .B1(
        code_out[0]), .B2(n37), .X(n77) );
  SAEDRVT14_AO32_U_0P5 U254 ( .A1(n114), .A2(n138), .A3(n217), .B1(n49), .B2(
        encode_cnt[1]), .X(n87) );
  SAEDRVT14_AO32_2 U255 ( .A1(n217), .A2(n228), .A3(mult_result1[3]), .B1(
        code_out[11]), .B2(n42), .X(n82) );
  SAEDRVT14_NR2_MM_10 U256 ( .A1(mult_result1[3]), .A2(n222), .X(n42) );
  SAEDRVT14_AO22_4 U257 ( .A1(n195), .A2(n113), .B1(n194), .B2(n116), .X(N103)
         );
  SAEDRVT14_AO32_1 U258 ( .A1(n217), .A2(n236), .A3(mult_result2[3]), .B1(
        code_out[3]), .B2(n34), .X(n74) );
  SAEDRVT14_EN2_3 U259 ( .A1(n231), .A2(N80), .X(n142) );
  SAEDRVT14_EN2_4 U260 ( .A1(n232), .A2(n144), .X(n60) );
  SAEDRVT14_AO32_2 U261 ( .A1(n217), .A2(n232), .A3(mult_result1[7]), .B1(
        code_out[15]), .B2(n38), .X(n78) );
  SAEDRVT14_BUF_S_6 U262 ( .A(n219), .X(n221) );
  SAEDRVT14_NR2_1 U263 ( .A1(n116), .A2(n222), .X(n49) );
  SAEDRVT14_NR2_1 U264 ( .A1(encode_cnt[0]), .A2(n222), .X(n88) );
  SAEDRVT14_BUF_3 U265 ( .A(n219), .X(n222) );
  SAEDRVT14_BUF_S_1 U266 ( .A(n224), .X(n220) );
  SAEDRVT14_BUF_S_1 U267 ( .A(n224), .X(n219) );
  SAEDRVT14_EN2_1 U268 ( .A1(n229), .A2(N82), .X(n145) );
  SAEDRVT14_EN2_1 U269 ( .A1(n230), .A2(N100), .X(n147) );
  SAEDRVT14_EN2_1 U270 ( .A1(n225), .A2(N86), .X(n148) );
  SAEDRVT14_EN2_1 U271 ( .A1(n231), .A2(N99), .X(n149) );
  SAEDRVT14_EN2_1 U272 ( .A1(n228), .A2(N102), .X(n150) );
  SAEDRVT14_EO2_1 U273 ( .A1(n227), .A2(N103), .X(n57) );
  SAEDRVT14_EO2_1 U274 ( .A1(n225), .A2(N105), .X(n59) );
  SAEDRVT14_INV_2 U275 ( .A(n110), .X(n217) );
  SAEDRVT14_INV_2 U276 ( .A(n110), .X(n218) );
  SAEDRVT14_INV_S_1 U277 ( .A(code_out[0]), .X(n233) );
  SAEDRVT14_AO32_1 U278 ( .A1(n218), .A2(n231), .A3(mult_result1[6]), .B1(
        code_out[14]), .B2(n39), .X(n79) );
  SAEDRVT14_INV_S_1 U279 ( .A(code_out[5]), .X(n238) );
  SAEDRVT14_INV_S_1 U280 ( .A(code_out[6]), .X(n239) );
  SAEDRVT14_AO22_0P5 U281 ( .A1(code_out[44]), .A2(n107), .B1(code_out[28]), 
        .B2(n92), .X(n165) );
  SAEDRVT14_INV_S_1 U282 ( .A(code_out[3]), .X(n236) );
  SAEDRVT14_INV_S_1 U283 ( .A(code_out[4]), .X(n237) );
  SAEDRVT14_INV_S_1 U284 ( .A(code_out[2]), .X(n235) );
  SAEDRVT14_INV_S_1 U285 ( .A(code_out[7]), .X(n240) );
  SAEDRVT14_INV_S_1 U286 ( .A(code_out[1]), .X(n234) );
  SAEDRVT14_INV_S_1 U287 ( .A(code_out[13]), .X(n230) );
  SAEDRVT14_INV_S_1 U288 ( .A(code_out[10]), .X(n227) );
  SAEDRVT14_INV_S_1 U289 ( .A(code_out[11]), .X(n228) );
  SAEDRVT14_INV_S_1 U290 ( .A(code_out[8]), .X(n225) );
  SAEDRVT14_INV_S_1 U291 ( .A(code_out[9]), .X(n226) );
  SAEDRVT14_OAI21_0P5 U292 ( .A1(n141), .A2(n46), .B(n47), .X(n86) );
  SAEDRVT14_AOI21_0P5 U293 ( .A1(n111), .A2(n138), .B(n49), .X(n46) );
  SAEDRVT14_OR4_1 U294 ( .A1(n138), .A2(n223), .A3(n140), .A4(n115), .X(n47)
         );
  SAEDRVT14_EN2_1 U295 ( .A1(n69), .A2(n223), .X(n89) );
  SAEDRVT14_AN2B_MM_1 U296 ( .B(start), .A(n111), .X(n69) );
  SAEDRVT14_TIE1_4 U297 ( .X(\*Logic1* ) );
  SAEDRVT14_AO22_0P5 U298 ( .A1(code_out[40]), .A2(n106), .B1(code_out[24]), 
        .B2(n90), .X(n151) );
  SAEDRVT14_AO22_0P5 U299 ( .A1(code_out[32]), .A2(n105), .B1(code_out[16]), 
        .B2(n91), .X(n152) );
  SAEDRVT14_AO221_0P5 U300 ( .A1(code_out[48]), .A2(n125), .B1(code_out[64]), 
        .B2(n96), .C(n152), .X(n153) );
  SAEDRVT14_AO22_0P5 U301 ( .A1(n154), .A2(n115), .B1(n153), .B2(n116), .X(N86) );
  SAEDRVT14_AO22_0P5 U302 ( .A1(code_out[41]), .A2(n106), .B1(code_out[25]), 
        .B2(n90), .X(n155) );
  SAEDRVT14_AO22_0P5 U303 ( .A1(code_out[33]), .A2(n107), .B1(code_out[17]), 
        .B2(n92), .X(n156) );
  SAEDRVT14_AO22_0P5 U304 ( .A1(code_out[42]), .A2(n105), .B1(code_out[26]), 
        .B2(n91), .X(n159) );
  SAEDRVT14_AO22_0P5 U305 ( .A1(code_out[43]), .A2(n106), .B1(code_out[27]), 
        .B2(n91), .X(n161) );
  SAEDRVT14_AO221_0P5 U306 ( .A1(code_out[51]), .A2(n122), .B1(code_out[67]), 
        .B2(n100), .C(n162), .X(n163) );
  SAEDRVT14_AO22_0P5 U307 ( .A1(code_out[36]), .A2(n108), .B1(code_out[20]), 
        .B2(n91), .X(n166) );
  SAEDRVT14_AO22_0P5 U308 ( .A1(n168), .A2(n115), .B1(n167), .B2(n116), .X(N82) );
  SAEDRVT14_AO22_0P5 U309 ( .A1(code_out[45]), .A2(n106), .B1(code_out[29]), 
        .B2(n92), .X(n169) );
  SAEDRVT14_AO22_0P5 U310 ( .A1(code_out[37]), .A2(n108), .B1(code_out[21]), 
        .B2(n92), .X(n170) );
  SAEDRVT14_OR3_1 U311 ( .A1(n183), .A2(n182), .A3(n155), .X(n158) );
  SAEDRVT14_AN2_MM_1 U312 ( .A1(code_out[73]), .A2(n95), .X(n182) );
  SAEDRVT14_AN2_MM_1 U313 ( .A1(code_out[57]), .A2(n118), .X(n183) );
  SAEDRVT14_AO22_1 U314 ( .A1(code_out[47]), .A2(n105), .B1(code_out[31]), 
        .B2(n92), .X(n176) );
  SAEDRVT14_AO221_0P5 U315 ( .A1(code_out[56]), .A2(n121), .B1(code_out[72]), 
        .B2(n101), .C(n184), .X(n187) );
  SAEDRVT14_AO22_0P5 U316 ( .A1(code_out[32]), .A2(n108), .B1(code_out[16]), 
        .B2(n92), .X(n185) );
  SAEDRVT14_AO22_0P5 U317 ( .A1(n187), .A2(n115), .B1(n186), .B2(n114), .X(
        N105) );
  SAEDRVT14_AO22_0P5 U318 ( .A1(code_out[41]), .A2(n107), .B1(code_out[25]), 
        .B2(n91), .X(n188) );
  SAEDRVT14_AO22_0P5 U319 ( .A1(code_out[33]), .A2(n106), .B1(code_out[17]), 
        .B2(n90), .X(n189) );
  SAEDRVT14_AO22_0P5 U320 ( .A1(n191), .A2(n115), .B1(n190), .B2(n116), .X(
        N104) );
  SAEDRVT14_AO22_0P5 U321 ( .A1(code_out[34]), .A2(n105), .B1(code_out[18]), 
        .B2(n92), .X(n193) );
  SAEDRVT14_AO22_0P5 U322 ( .A1(code_out[43]), .A2(n106), .B1(code_out[27]), 
        .B2(n92), .X(n196) );
  SAEDRVT14_AO22_0P5 U323 ( .A1(code_out[35]), .A2(n107), .B1(code_out[19]), 
        .B2(n90), .X(n197) );
  SAEDRVT14_AO22_0P5 U324 ( .A1(n199), .A2(n113), .B1(n198), .B2(n116), .X(
        N102) );
  SAEDRVT14_AO22_0P5 U325 ( .A1(code_out[44]), .A2(n105), .B1(code_out[28]), 
        .B2(n90), .X(n200) );
  SAEDRVT14_AO221_0P5 U326 ( .A1(code_out[60]), .A2(n121), .B1(code_out[76]), 
        .B2(n100), .C(n200), .X(n203) );
  SAEDRVT14_AO22_0P5 U327 ( .A1(code_out[36]), .A2(n105), .B1(code_out[20]), 
        .B2(n92), .X(n201) );
  SAEDRVT14_AO221_0P5 U328 ( .A1(code_out[52]), .A2(n119), .B1(code_out[68]), 
        .B2(n97), .C(n201), .X(n202) );
  SAEDRVT14_AO22_0P5 U329 ( .A1(code_out[37]), .A2(n105), .B1(code_out[21]), 
        .B2(n90), .X(n205) );
  SAEDRVT14_AO221_0P5 U330 ( .A1(code_out[53]), .A2(n124), .B1(code_out[69]), 
        .B2(n97), .C(n205), .X(n206) );
  SAEDRVT14_AO221_0P5 U331 ( .A1(code_out[62]), .A2(n119), .B1(code_out[78]), 
        .B2(n95), .C(n207), .X(n210) );
  SAEDRVT14_AO22_0P5 U332 ( .A1(code_out[38]), .A2(n107), .B1(code_out[22]), 
        .B2(n90), .X(n208) );
  SAEDRVT14_AO221_0P5 U333 ( .A1(code_out[54]), .A2(n122), .B1(code_out[70]), 
        .B2(n99), .C(n208), .X(n209) );
  SAEDRVT14_AO22_0P5 U334 ( .A1(n210), .A2(n115), .B1(n209), .B2(n116), .X(N99) );
endmodule


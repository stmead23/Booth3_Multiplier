module booth3_mult16(input  logic [15:0] x, y,
					 output logic [31:0] result);
	logic [21:0] mid_partial0, final_partial0;
	logic [20:0] final_partial1, final_partial2, final_partial3, carry0, carry1, carry2;
	logic [19:0] final_partial4, carry3;
	logic [18:0] multiplier;
	logic [17:0] multiplicand_x3, first_partials0, first_partials1, first_partials2, first_partials3, first_partials4, sum0, sum1, sum2;
	logic [16:0] sum3, first_partials5, final_partial5, carry4;
	logic [4:0]  s, s_not; 
	
	// Create partial products using Booth algorithm
	assign multiplier = {2'b00, y, 1'b0};
	// Create the multiplicand * 3 for the Booth algorithm
	mult_x3 mx3(x,multiplicand_x3);
	partial_product3 p_prod0(multiplier[3:0], x, multiplicand_x3, first_partials0, s[0], s_not[0]);
	partial_product3 p_prod1(multiplier[6:3], x, multiplicand_x3, first_partials1, s[1], s_not[1]);
	partial_product3 p_prod2(multiplier[9:6], x, multiplicand_x3, first_partials2, s[2], s_not[2]);
	partial_product3 p_prod3(multiplier[12:9], x, multiplicand_x3, first_partials3, s[3], s_not[3]);
	partial_product3 p_prod4(multiplier[15:12], x, multiplicand_x3, first_partials4, s[4], s_not[4]);
	partial_product3_final p_prod5(multiplier[18:15], x, first_partials5);
	
	// Add sign bits and padding from Booth algorithm
	assign mid_partial0 = {s_not[0], s[0], s[0], s[0], first_partials0};
	assign final_partial1 = {2'b11, s_not[1], first_partials1};
	assign final_partial2 = {2'b11, s_not[2], first_partials2};
	assign final_partial3 = {2'b11, s_not[3], first_partials3};
	assign final_partial4 = {1'b1, s_not[4], first_partials4};
	assign final_partial5 = first_partials5;
	
	// Add the sign bit for the first partial for 2s complement
	add_s s0(mid_partial0, s[0], final_partial0);
	
	// All summation for the final result
	assign result[0] = final_partial0[0];
	assign result[1] = final_partial0[1];
	assign result[2] = final_partial0[2];
	
	fa fa2(final_partial0[3], final_partial1[0], s[1], result[3], carry0[0]);
	fa fa3(final_partial0[4], final_partial1[1], carry0[0], result[4], carry0[1]);
	fa fa4(final_partial0[5], final_partial1[2], carry0[1], result[5], carry0[2]);
	fa fa5(final_partial0[6], final_partial1[3], carry0[2], sum0[0], carry0[3]);
	fa fa6(final_partial0[7], final_partial1[4], carry0[3], sum0[1], carry0[4]);
	fa fa7(final_partial0[8], final_partial1[5], carry0[4], sum0[2], carry0[5]);
	fa fa8(final_partial0[9], final_partial1[6], carry0[5], sum0[3], carry0[6]);
	fa fa9(final_partial0[10], final_partial1[7], carry0[6], sum0[4], carry0[7]);
	fa fa10(final_partial0[11], final_partial1[8], carry0[7], sum0[5], carry0[8]);
	fa fa11(final_partial0[12], final_partial1[9], carry0[8], sum0[6], carry0[9]);
	fa fa12(final_partial0[13], final_partial1[10], carry0[9], sum0[7], carry0[10]);
	fa fa13(final_partial0[14], final_partial1[11], carry0[10], sum0[8], carry0[11]);
	fa fa14(final_partial0[15], final_partial1[12], carry0[11], sum0[9], carry0[12]);
	fa fa15(final_partial0[16], final_partial1[13], carry0[12], sum0[10], carry0[13]);
	fa fa16(final_partial0[17], final_partial1[14], carry0[13], sum0[11], carry0[14]);
	fa fa17(final_partial0[18], final_partial1[15], carry0[14], sum0[12], carry0[15]);
	fa fa18(final_partial0[19], final_partial1[16], carry0[15], sum0[13], carry0[16]);
	fa fa19(final_partial0[20], final_partial1[17], carry0[16], sum0[14], carry0[17]);
	fa fa20(final_partial0[21], final_partial1[18], carry0[17], sum0[15], carry0[18]);
	ha ha5(final_partial1[19], carry0[18], sum0[16], carry0[19]);
	ha ha6(final_partial1[20], carry0[19], sum0[17], carry0[20]);
	
	fa fa21(sum0[0], final_partial2[0], s[2], result[6], carry1[0]);
	fa fa22(sum0[1], final_partial2[1], carry1[0], result[7], carry1[1]);
	fa fa23(sum0[2], final_partial2[2], carry1[1], result[8], carry1[2]);
	fa fa24(sum0[3], final_partial2[3], carry1[2], sum1[0], carry1[3]);
	fa fa25(sum0[4], final_partial2[4], carry1[3], sum1[1], carry1[4]);
	fa fa26(sum0[5], final_partial2[5], carry1[4], sum1[2], carry1[5]);
	fa fa27(sum0[6], final_partial2[6], carry1[5], sum1[3], carry1[6]);
	fa fa28(sum0[7], final_partial2[7], carry1[6], sum1[4], carry1[7]);
	fa fa29(sum0[8], final_partial2[8], carry1[7], sum1[5], carry1[8]);
	fa fa30(sum0[9], final_partial2[9], carry1[8], sum1[6], carry1[9]);
	fa fa31(sum0[10], final_partial2[10], carry1[9], sum1[7], carry1[10]);
	fa fa33(sum0[11], final_partial2[11], carry1[10], sum1[8], carry1[11]);
	fa fa34(sum0[12], final_partial2[12], carry1[11], sum1[9], carry1[12]);
	fa fa35(sum0[13], final_partial2[13], carry1[12], sum1[10], carry1[13]);
	fa fa36(sum0[14], final_partial2[14], carry1[13], sum1[11], carry1[14]);
	fa fa37(sum0[15], final_partial2[15], carry1[14], sum1[12], carry1[15]);
	fa fa38(sum0[16], final_partial2[16], carry1[15], sum1[13], carry1[16]);
	fa fa39(sum0[17], final_partial2[17], carry1[16], sum1[14], carry1[17]);
	fa fa40(carry0[20], final_partial2[18], carry1[17], sum1[15], carry1[18]);
	ha ha7(final_partial2[19], carry1[18], sum1[16], carry1[19]);
	ha ha8(final_partial2[20], carry1[19], sum1[17], carry1[20]);
	
	fa fa41(sum1[0], final_partial3[0], s[3], result[9], carry2[0]);
	fa fa42(sum1[1], final_partial3[1], carry2[0], result[10], carry2[1]);
	fa fa43(sum1[2], final_partial3[2], carry2[1], result[11], carry2[2]);
	fa fa44(sum1[3], final_partial3[3], carry2[2], sum2[0], carry2[3]);
	fa fa45(sum1[4], final_partial3[4], carry2[3], sum2[1], carry2[4]);
	fa fa46(sum1[5], final_partial3[5], carry2[4], sum2[2], carry2[5]);
	fa fa47(sum1[6], final_partial3[6], carry2[5], sum2[3], carry2[6]);
	fa fa48(sum1[7], final_partial3[7], carry2[6], sum2[4], carry2[7]);
	fa fa49(sum1[8], final_partial3[8], carry2[7], sum2[5], carry2[8]);
	fa fa50(sum1[9], final_partial3[9], carry2[8], sum2[6], carry2[9]);
	fa fa51(sum1[10], final_partial3[10], carry2[9], sum2[7], carry2[10]);
	fa fa52(sum1[11], final_partial3[11], carry2[10], sum2[8], carry2[11]);
	fa fa53(sum1[12], final_partial3[12], carry2[11], sum2[9], carry2[12]);
	fa fa54(sum1[13], final_partial3[13], carry2[12], sum2[10], carry2[13]);
	fa fa55(sum1[14], final_partial3[14], carry2[13], sum2[11], carry2[14]);
	fa fa56(sum1[15], final_partial3[15], carry2[14], sum2[12], carry2[15]);
	fa fa57(sum1[16], final_partial3[16], carry2[15], sum2[13], carry2[16]);
	fa fa58(sum1[17], final_partial3[17], carry2[16], sum2[14], carry2[17]);
	fa fa59(carry1[20], final_partial3[18], carry2[17], sum2[15], carry2[18]);
	ha ha9(final_partial3[19], carry2[18], sum2[16], carry2[19]);
	ha ha10(final_partial3[20], carry2[19], sum2[17], carry2[20]);
	
	fa fa60(sum2[0], final_partial4[0], s[4], result[12], carry3[0]);
	fa fa61(sum2[1], final_partial4[1], carry3[0], result[13], carry3[1]);
	fa fa62(sum2[2], final_partial4[2], carry3[1], result[14], carry3[2]);
	fa fa63(sum2[3], final_partial4[3], carry3[2], sum3[0], carry3[3]);
	fa fa64(sum2[4], final_partial4[4], carry3[3], sum3[1], carry3[4]);
	fa fa65(sum2[5], final_partial4[5], carry3[4], sum3[2], carry3[5]);
	fa fa66(sum2[6], final_partial4[6], carry3[5], sum3[3], carry3[6]);
	fa fa67(sum2[7], final_partial4[7], carry3[6], sum3[4], carry3[7]);
	fa fa68(sum2[8], final_partial4[8], carry3[7], sum3[5], carry3[8]);
	fa fa69(sum2[9], final_partial4[9], carry3[8], sum3[6], carry3[9]);
	fa fa70(sum2[10], final_partial4[10], carry3[9], sum3[7], carry3[10]);
	fa fa71(sum2[11], final_partial4[11], carry3[10], sum3[8], carry3[11]);
	fa fa72(sum2[12], final_partial4[12], carry3[11], sum3[9], carry3[12]);
	fa fa73(sum2[13], final_partial4[13], carry3[12], sum3[10], carry3[13]);
	fa fa74(sum2[14], final_partial4[14], carry3[13], sum3[11], carry3[14]);
	fa fa75(sum2[15], final_partial4[15], carry3[14], sum3[12], carry3[15]);
	fa fa76(sum2[16], final_partial4[16], carry3[15], sum3[13], carry3[16]);
	fa fa77(sum2[17], final_partial4[17], carry3[16], sum3[14], carry3[17]);
	fa fa78(carry2[20], final_partial4[18], carry3[17], sum3[15], carry3[18]);
	ha ha11(final_partial4[19], carry3[18], sum3[16], carry3[19]);
	
	ha ha12(sum3[0], final_partial5[0], result[15], carry4[0]);
	fa fa79(sum3[1], final_partial5[1], carry4[0], result[16], carry4[1]);
	fa fa80(sum3[2], final_partial5[2], carry4[1], result[17], carry4[2]);
	fa fa81(sum3[3], final_partial5[3], carry4[2], result[18], carry4[3]);
	fa fa82(sum3[4], final_partial5[4], carry4[3], result[19], carry4[4]);
	fa fa83(sum3[5], final_partial5[5], carry4[4], result[20], carry4[5]);
	fa fa84(sum3[6], final_partial5[6], carry4[5], result[21], carry4[6]);
	fa fa85(sum3[7], final_partial5[7], carry4[6], result[22], carry4[7]);
	fa fa86(sum3[8], final_partial5[8], carry4[7], result[23], carry4[8]);
	fa fa87(sum3[9], final_partial5[9], carry4[8], result[24], carry4[9]);
	fa fa88(sum3[10], final_partial5[10], carry4[9], result[25], carry4[10]);
	fa fa89(sum3[11], final_partial5[11], carry4[10], result[26], carry4[11]);
	fa fa90(sum3[12], final_partial5[12], carry4[11], result[27], carry4[12]);
	fa fa91(sum3[13], final_partial5[13], carry4[12], result[28], carry4[13]);
	fa fa92(sum3[14], final_partial5[14], carry4[13], result[29], carry4[14]);
	fa fa93(sum3[15], final_partial5[15], carry4[14], result[30], carry4[15]);
	fa fa94(sum3[16], final_partial5[16], carry4[15], result[31], carry4[16]);
endmodule

// Create the multiplicand * 3 value. For most of the output, it is multiplicand[i] + multiplicand[i-1] + carry
module mult_x3(input  logic [15:0] multiplicand,
			   output logic [17:0] result);
	logic carry[16:2];
	assign result[0] = multiplicand[0];
	ha ha1(multiplicand[1], multiplicand[0], result[1], carry[2]); 
	generate
		genvar i;
		for(i = 2; i < 16; i=i+1) begin
			fa fa1(multiplicand[i], multiplicand[i-1], carry[i], result[i], carry[i+1]);
		end 
	endgenerate
	ha ha2(multiplicand[15], carry[16], result[16], result[17]);
endmodule

// Create partial product. Decodes the multiplier for x1, x2, x3, and x4, then select the appropriate value and check the sign bit. 
// Also returns the sign and the inverse of the sign.
module partial_product3(input  logic [3:0]  multiplier,
						input  logic [15:0] multiplicand,
						input  logic [17:0] mult_3x,
						output logic [17:0] partial,
						output logic        s, s_not);
	logic [4:1]  select_m;
	logic [15:2] mult1_i, mult2_i, mult3_i, mult4_i, selection_i;
	logic		 mult1_0, mult1_1, mult2_1, mult2_16, mult3_0, mult3_1, mult3_16, mult3_17, mult4_16, mult4_17;
	logic		 selection_0, selection_1, selection_16, selection_17;
	
	booth_decoder3 decode(multiplier, select_m);
	
	assign mult1_0 = multiplicand[0] & select_m[1];
	assign mult3_0 = mult_3x[0] & select_m[3];
	assign selection_0 = mult1_0 | mult3_0;
	assign partial[0] = (~selection_0 & multiplier[3]) | (selection_0 & ~multiplier[3]);
	
	assign mult1_1 = multiplicand[1] & select_m[1];
	assign mult2_1 = multiplicand[0] & select_m[2];
	assign mult3_1 = mult_3x[1] & select_m[3];
	assign selection_1 = mult1_1 | mult2_1 | mult3_1;
	assign partial[1] = (~selection_1 & multiplier[3]) | (selection_1 & ~multiplier[3]);
	
	generate
		genvar i;
		for(i = 2; i < 16; i=i+1) begin
			assign mult1_i[i] = multiplicand[i] & select_m[1];
			assign mult2_i[i] = multiplicand[i-1] & select_m[2];
			assign mult3_i[i] = mult_3x[i] & select_m[3];
			assign mult4_i[i] = multiplicand[i-2] & select_m[4];
			assign selection_i[i] = mult1_i[i] | mult2_i[i] | mult3_i[i] | mult4_i[i];
			assign partial[i] = (~selection_i[i] & multiplier[3]) | (selection_i[i] & ~multiplier[3]);
		end
	endgenerate
	
	assign mult2_16 = multiplicand[15] & select_m[2];
	assign mult3_16 = mult_3x[16] & select_m[3];
	assign mult4_16 = multiplicand[14] & select_m[4];
	assign selection_16 = mult2_16 | mult3_16 | mult4_16;
	assign partial[16] = (~selection_16 & multiplier[3]) | (selection_16 & ~multiplier[3]);
	
	assign mult3_17 = mult_3x[17] & select_m[3];
	assign mult4_17 = multiplicand[15] & select_m[4];
	assign selection_17 = mult3_17 | mult4_17;
	assign partial[17] = (~selection_17 & multiplier[3]) | (selection_17 & ~multiplier[3]);
	
	assign s = multiplier[3];
	assign s_not = ~multiplier[3];
endmodule

//For the final partial. The value can only be x1 and x2, so simplify the algorithm
module partial_product3_final(input  logic [3:0]  multiplier,
							  input  logic [15:0] multiplicand,
							  output logic [16:0] partial);
	logic [2:1] select_m;
	booth_decoder2 decode1(multiplier[1:0], select_m);
	assign partial[0] = multiplicand[0] & select_m[1];
	generate
		genvar i;
		for(i = 1; i < 16; i=i+1) begin
			assign partial[i] = (multiplicand[i] & select_m[1]) | (multiplicand[i-1] & select_m[2]);
		end
	endgenerate
	assign partial[16] = multiplicand[15] & select_m[2];
endmodule

// The formula for the decoder
module booth_decoder3(input  logic [3:0] multiplier,
					 output logic [4:1] select_m);
	assign select_m[1] = ~((multiplier[3] ^ multiplier[2]) | ~(multiplier[1] ^ multiplier[0]));
	assign select_m[2] = ~(~(multiplier[1] ^ multiplier[2]) | (multiplier[1] ^ multiplier[0]));
	assign select_m[3] = ~(~(multiplier[3] ^ multiplier[2]) | ~(multiplier[1] ^ multiplier[0]));
	assign select_m[4] = ~(~(multiplier[3] ^ multiplier[2]) | (multiplier[1] ^ multiplier[0]) | (multiplier[2] ^ multiplier[1]));
endmodule

// The formula for the final decoder
module booth_decoder2(input  logic [1:0] multiplier,
					 output logic [2:1] select_m);
	assign select_m[1] = multiplier[0] ^ multiplier[1];
	assign select_m[2] = multiplier[0] & multiplier[1];
endmodule

// Adds the sign for the first partial
module add_s (input  logic [21:0] partial,
			  input  logic		  s,
			  output logic [21:0] final_part);
	logic carry[22:1];
	
	ha ha3(partial[0], s, final_part[0], carry[1]);
	generate
		genvar i;
		for(i = 1; i < 22; i=i+1) begin
			ha ha4(partial[i], carry[i], final_part[i], carry[i+1]);
		end
	endgenerate
endmodule

// Logic for the half adder.
module ha(input logic a, b,
		  output logic z, c_out);
	assign z = (~(a & b)) & (a | b);
	assign c_out = a & b;
endmodule

// Logic for the full adder.
module fa(input logic a, b, c_in,
		  output logic z, c_out);
	logic part1, part2, part3;
	assign part1 = a & b;
	assign part2 = (~part1) & (a | b);
	assign part3 = part2 & c_in;
	assign z = (~part3) & (part2 | c_in);
	assign c_out = part1 | part3;
endmodule




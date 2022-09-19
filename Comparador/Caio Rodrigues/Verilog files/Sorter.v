`include "Sort2.v"
`include "Sort4.v"
`include "Register.v"
`include "RegisterSeries.v"

module Sorter(input [71:0] sortIn, 
			  input clk, enable,
			  output reg [71:0] sortOut);
	
	wire [7:0] Group1A[3:0], Group1B[3:0], Group1C[3:0], Group1D[3:0],
			   Group2A[3:0], Group2B[3:0], Carry2[1:0],
			   Group3A[3:0], Group3B[3:0], Carry3[3:0],
			   FinalGroup[3:0], CarryF[5:0],
			   Result1[8:0], Result2[8:0], Result3[8:0], FinalResult[8:0],
			   Trash, Num[8:0];

	assign Num[0] = sortIn[7:0];
	assign Num[1] = sortIn[15:8];
	assign Num[2] = sortIn[23:16];
	assign Num[3] = sortIn[31:24];
	assign Num[4] = sortIn[39:32];
	assign Num[5] = sortIn[47:40];
	assign Num[6] = sortIn[55:48];
	assign Num[7] = sortIn[63:56];
	assign Num[8] = sortIn[71:64];

	// Grouping 1 (2,2,2,3) (4 Clocks)
	Sort4 s1 (.clk(clk), .Num({Num[0],Num[1],16'b0}), .Out({Group1A[0],Group1A[1],Group1A[2],Group1A[3]}));
	Sort4 s2 (.clk(clk), .Num({Num[2],Num[3],16'b0}), .Out({Group1B[0],Group1B[1],Group1B[2],Group1B[3]}));
	Sort4 s3 (.clk(clk), .Num({Num[4],Num[5],16'b0}), .Out({Group1C[0],Group1C[1],Group1C[2],Group1C[3]}));
	Sort4 s4 (.clk(clk), .Num({Num[6],Num[7],Num[8],8'b0}), .Out({Group1D[0],Group1D[1],Group1D[2],Group1D[3]}));

	// Comparing Grouping 1 (4 Clocks)
	Sort4 s5 (.clk(clk), .Num({Group1A[0],Group1B[0],Group1C[0],Group1D[0]}), .Out({Result1[0],Result1[1],Result1[2],Result1[3]}));
	Sort4 s6 (.clk(clk), .Num({Group1A[1],Group1B[1],Group1C[1],Group1D[2]}), .Out({Result1[5],Result1[6],Result1[7],Result1[8]}));
	RegisterSeries reg4S1 (.clk(clk), .enable(1'b1), .reg_in(Group1D[1]), .reg_out(Result1[4]));

	// Grouping 2 (4,3) (4 Clocks)
	Sort4 s7 (.clk(clk), .Num({Result1[1],Result1[2],Result1[3],Result1[4]}), .Out({Group2A[0],Group2A[1],Group2A[2],Group2A[3]}));
	Sort4 s8 (.clk(clk), .Num({Result1[5],Result1[6],Result1[7], 8'b0}), .Out({Group2B[0],Group2B[1],Group2B[2],Group2B[3]}));

	RegisterSeries reg4S2 (.clk(clk), .enable(1'b1), .reg_in(Result1[0]), .reg_out(Carry2[0])); // Carrying the 1st
	RegisterSeries reg4S3 (.clk(clk), .enable(1'b1), .reg_in(Result1[8]), .reg_out(Carry2[1])); // Carrying the 9th

	// Comparing Grouping 2 (1 Clock)
	Sort2 s9 (.clk(clk), .Num1(Group2A[0]), .Num2(Group2B[0]), .Out1(Result2[1]), .Out2(Result2[2]));
	Sort2 s10 (.clk(clk), .Num1(Group2A[3]), .Num2(Group2B[2]), .Out1(Result2[6]), .Out2(Result2[7]));
	Register reg1 (.clk(clk), .enable(1'b1), .reg_in(Group2A[1]), .reg_out(Result2[3]));
	Register reg2 (.clk(clk), .enable(1'b1), .reg_in(Group2A[2]), .reg_out(Result2[4]));
	Register reg3 (.clk(clk), .enable(1'b1), .reg_in(Group2B[1]), .reg_out(Result2[5]));

	Register reg4 (.clk(clk), .enable(1'b1), .reg_in(Carry2[0]), .reg_out(Result2[0])); // Carrying the 1st
	Register reg5 (.clk(clk), .enable(1'b1), .reg_in(Carry2[1]), .reg_out(Result2[8])); // Carrying the 9th

	// Grouping 3 (3,2) (4 Clocks)
	Sort4 s11 (.clk(clk), .Num({Result2[2], Result2[3], Result2[4], 8'b0}), .Out({Group3A[0],Group3A[1],Group3A[2],Group3A[3]}));
	Sort4 s12 (.clk(clk), .Num({Result2[5], Result2[6], 16'b0}), .Out({Group3B[0],Group3B[1],Group3B[2],Group3B[3]}));

	RegisterSeries reg4S4 (.clk(clk), .enable(1'b1), .reg_in(Result2[0]), .reg_out(Carry3[0])); // Carrying the 1st
	RegisterSeries reg4S5 (.clk(clk), .enable(1'b1), .reg_in(Result2[1]), .reg_out(Carry3[1])); // Carrying the 2nd
	RegisterSeries reg4S6 (.clk(clk), .enable(1'b1), .reg_in(Result2[7]), .reg_out(Carry3[2])); // Carrying the 8th
	RegisterSeries reg4S7 (.clk(clk), .enable(1'b1), .reg_in(Result2[8]), .reg_out(Carry3[3])); // Carrying the 9th

	// Comparing Grouping 3 (1 Clock)
	Sort2 s13 (.clk(clk), .Num1(Group3A[0]), .Num2(Group3B[0]), .Out1(Result3[2]), .Out2(Result3[3]));
	Sort2 s14 (.clk(clk), .Num1(Group3A[2]), .Num2(Group3B[1]), .Out1(Result3[5]), .Out2(Result3[6]));
	Register reg6 (.clk(clk), .enable(1'b1), .reg_in(Group3A[1]), .reg_out(Result3[4]));

	Register reg7 (.clk(clk), .enable(1'b1), .reg_in(Carry3[0]), .reg_out(Result3[0])); // Carrying the 1st
	Register reg8 (.clk(clk), .enable(1'b1), .reg_in(Carry3[1]), .reg_out(Result3[1])); // Carrying the 2nd
	Register reg9 (.clk(clk), .enable(1'b1), .reg_in(Carry3[2]), .reg_out(Result3[7])); // Carrying the 8th
	Register reg10 (.clk(clk), .enable(1'b1), .reg_in(Carry3[3]), .reg_out(Result3[8])); // Carrying the 9th

	// Determination (4 Clocks + 1 Clock)
	Sort4 s15 (.clk(clk), .Num({Result3[3], Result3[4], Result3[5] , 8'b0}), .Out({FinalGroup[0],FinalGroup[1],FinalGroup[2],FinalGroup[3]}));

	RegisterSeries reg4S8 (.clk(clk), .enable(1'b1), .reg_in(Result3[0]), .reg_out(CarryF[0])); // Carrying the 1st
	RegisterSeries reg4S9 (.clk(clk), .enable(1'b1), .reg_in(Result3[1]), .reg_out(CarryF[1])); // Carrying the 2nd
	RegisterSeries reg4S10 (.clk(clk), .enable(1'b1), .reg_in(Result3[2]), .reg_out(CarryF[2])); // Carrying the 3rd
	RegisterSeries reg4S11 (.clk(clk), .enable(1'b1), .reg_in(Result3[6]), .reg_out(CarryF[3])); // Carrying the 7th
	RegisterSeries reg4S12 (.clk(clk), .enable(1'b1), .reg_in(Result3[7]), .reg_out(CarryF[4])); // Carrying the 8th
	RegisterSeries reg4S13 (.clk(clk), .enable(1'b1), .reg_in(Result3[8]), .reg_out(CarryF[5])); // Carrying the 9th

	Register reg11 (.clk(clk), .enable(1'b1), .reg_in(CarryF[0]), .reg_out(FinalResult[0]));
	Register reg12 (.clk(clk), .enable(1'b1), .reg_in(CarryF[1]), .reg_out(FinalResult[1]));
	Register reg13 (.clk(clk), .enable(1'b1), .reg_in(CarryF[2]), .reg_out(FinalResult[2]));
	Register reg14 (.clk(clk), .enable(1'b1), .reg_in(FinalGroup[0]), .reg_out(FinalResult[3]));
	Register reg15 (.clk(clk), .enable(1'b1), .reg_in(FinalGroup[1]), .reg_out(FinalResult[4]));
	Register reg16 (.clk(clk), .enable(1'b1), .reg_in(FinalGroup[2]), .reg_out(FinalResult[5]));
	Register reg17 (.clk(clk), .enable(1'b1), .reg_in(CarryF[3]), .reg_out(FinalResult[6]));
	Register reg18 (.clk(clk), .enable(1'b1), .reg_in(CarryF[4]), .reg_out(FinalResult[7]));
	Register reg19 (.clk(clk), .enable(1'b1), .reg_in(CarryF[5]), .reg_out(FinalResult[8]));

	always@(posedge clk)begin
		if(enable==1) begin
			sortOut[7:0] <= FinalResult[0];
			sortOut[15:8] <= FinalResult[1];
			sortOut[23:16] <= FinalResult[2];
			sortOut[31:24] <= FinalResult[3];
			sortOut[39:32] <= FinalResult[4];
			sortOut[47:40] <= FinalResult[5];
			sortOut[55:48] <= FinalResult[6];
			sortOut[63:56] <= FinalResult[7];
			sortOut[71:64] <= FinalResult[8];
		end
	end

endmodule // Clocks = 24

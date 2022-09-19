`timescale 1 ns/1 ns

// `include "Sorter.v"

module Sorter_tb();

	reg [71:0] inset;
	reg clk, enable;	
    wire [71:0] outset;
	
	reg [7:0] num[8:0];
	
	Sorter srt(.sortIn(inset),.clk(clk),.enable(enable),.sortOut(outset));
		
	initial
		begin
			enable = 1;
			clk = 0;

			#2 inset = 72'h01_09_12_5a_18_04_05_06_11;
			#2 inset = 72'h32_39_32_35_48_04_1a_56_03;
			#2 inset = 72'h3f_f9_f2_f5_f8_f4_1c_86_33;
			#2 inset = 72'h3d_90_fe_e5_e4_f4_44_d6_43;
			#2 inset = 72'h01_09_12_5a_18_04_05_06_11;
			#2 inset = 72'h32_39_32_35_48_04_1a_56_03;
			#2 inset = 72'h3f_f9_f2_f5_f8_f4_1c_86_33;
			#2 inset = 72'h3d_90_fe_e5_e4_f4_44_d6_43;
			#60 $stop;
		end
		
	 initial
	    	begin
				$display("Hello world");
          		$monitor("time = %g, inset = %h, outset = %h, clk = %d", $time, inset, outset, clk);
         		$dumpfile("Sorter.vcd");
         		$dumpvars(0,srt);
	    	end
		
	always #1 clk = ~clk;

endmodule
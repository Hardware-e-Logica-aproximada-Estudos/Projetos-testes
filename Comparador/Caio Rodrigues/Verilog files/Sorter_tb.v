`timescale 1 ns/1 ns

`include "Sorter.v"

module Sorter_tb();

	reg [63:0] inset;
	reg clk;	
   wire [63:0] outset;
	
	reg [7:0] num1, num2, num3, num4, num5, num6, num7, num8;
	
	Sorter srt(.sortIn(inset),.clk(clk),.sortOut(outset));
		
	initial
		begin
			num1 = $urandom%256;
			num2 = $urandom%256;
			num3 = $urandom%256;
			num4 = $urandom%256;
			num5 = $urandom%256;
			num6 = $urandom%256;
			num7 = $urandom%256;
			num8 = $urandom%256;
			
			inset[7:0] = num1;
			inset[15:8] = num2;
			inset[23:16] = num3;
			inset[31:24] = num4;
			inset[39:32] = num5;
			inset[47:40] = num6;
			inset[55:48] = num7;
			inset[63:56] = num8;
			
			clk = 0;
			#15 $stop;
		end
		
	 initial
	    	begin
			$display("Hello world");
          		$monitor("time = %g, inset = %d, outset = %d, clk = %d", $time, inset, outset, clk);
         		$dumpfile("Sorter.vcd");
         		$dumpvars(0,srt);
	    	end
		
	always begin
		#2 clk = ~clk;
	end

endmodule

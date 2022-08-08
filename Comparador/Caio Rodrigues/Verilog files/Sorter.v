module Sorter(input [63:0] sortIn, 
			  input clk, enable,
			  output reg [63:0] sortOut);

	reg [63:0] data;
	reg [7:0] regIn [7:0];
	reg [7:0] keep;
	integer i, j;
	
	always @(posedge clk) begin
		data <= sortIn;
	end

	always @(*) begin
		
			regIn[0] = data[7:0];
			regIn[1] = data[15:8];
			regIn[2] = data[23:16];
			regIn[3] = data[31:24];
			regIn[4] = data[39:32];
			regIn[5] = data[47:40];
			regIn[6] = data[55:48];
			regIn[7] = data[63:56];
		
			for(i=0; i < 7; i = i+1) begin
			for(j=0; j < 7; j = j+1) begin
				
					if(regIn[j] < regIn[j+1]) begin
						keep = regIn[j];
						regIn[j] = regIn[j+1];
						regIn[j+1] = keep;
					end
					
				end
			end
	end
	
	always@(*) begin
		sortOut[7:0] <= regIn[0];
		sortOut[15:8] <= regIn[1];
		sortOut[23:16] <= regIn[2];
		sortOut[31:24] <= regIn[3];
		sortOut[39:32] <= regIn[4];
		sortOut[47:40] <= regIn[5];
		sortOut[55:48] <= regIn[6];
		sortOut[63:56] <= regIn[7];
	end

endmodule

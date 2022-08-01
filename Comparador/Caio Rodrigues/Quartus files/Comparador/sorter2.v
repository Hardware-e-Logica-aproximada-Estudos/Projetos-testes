module sorter2 (input [3:0] InA, InB, output reg [3:0] OutA, OutB);

	always @(*) begin	
		if (InA >= InB) begin
			OutA = InA;
			OutB = InB;
		end
		
		else begin
			OutA = InB;
			OutB = InA;
		end
			
	end

endmodule
module sorter4 (
					input [3:0] InA, InB, InC, InD,
					output [3:0] OutA, OutB, OutC, OutD);
	
	wire [7:0]  w1, w2, w3;
	
	// Comparing pairs
	sorter2(.InA(InA), .InB(InB), .OutA(w1[3:0]), .OutB(w1[7:4]));
	sorter2(.InA(InC), .InB(InD), .OutA(w2[3:0]), .OutB(w2[7:4]));
	
	// Sorting
	sorter2(.InA(w1[3:0]), .InB(w2[3:0]), .OutA(OutA), .OutB(w3[3:0]));
	sorter2(.InA(w1[7:4]), .InB(w2[7:4]), .OutA(w3[7:4]), .OutB(OutD));
	sorter2(.InA(w3[3:0]), .InB(w3[7:4]), .OutA(OutB), .OutB(OutC));
					
endmodule
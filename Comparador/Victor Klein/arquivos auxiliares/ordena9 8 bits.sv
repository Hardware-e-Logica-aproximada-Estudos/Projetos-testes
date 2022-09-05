
module ordena2_8bit(
	input reset, clk,
	input [7:0] a, b, 
  	output reg [7:0] sa, sb
);
//

  always@(posedge clk or posedge reset)
	begin
    if (reset)begin
      sa = 0;
      sb = 0;
    end
      else
          begin
          if (a < b)
          begin
              sa = b;
              sb = a;
          end
          else
          begin
              sa = a;
              sb = b;
          end
        end
	end

endmodule

module ordena3_8bit(
	input reset, clk,
	input [7:0] a, b, c,
  	output reg [7:0] sa, sb, sc
);
//
  always@(posedge clk or posedge reset)
	begin
    if (reset)begin
      sa = 0;
      sb = 0;
      sc = 0;
    end
      else begin
		if (b > a)
		begin
			if (c > b)
			begin
				sa = c;
				sb = b;
				sc = a;
			end
			else if (c > a)
			begin
				sa = b;
				sb = c;
				sc = a;
			end
			else
			begin
				sa = b;
				sb = a;
				sc = c;				
			end
		end
		else
		begin
			if (c > a)
			begin
				sa = c;
				sb = a;
				sc = b;
			end
			else if (c > b)
			begin
				sa = a;
				sb = c;
				sc = b;
			end
			else
			begin
				sa = a;
				sb = b;
				sc = c;				
			end
		end
      end
	end

endmodule

module ordena9_8bit(
	input reset, clock, H,
	input [7:0] entrada [8:0],
  	output [7:0] saida [8:0],
  	output flag
);
//
	wire [7:0] aux0 [8:0], aux1[6:0], aux2 [3:0];
	wire clk;
	assign clk = clock & H;
  
  reg [2:0] cont;
  always@(posedge H)
  begin
  	cont = 0;
  end
  always@ (posedge clk)
  begin
    cont = cont + 1;
  end
  assign flag = (cont == 3'd4)? 1 : 0;
	
  ordena3_8bit ord00(reset, clk, entrada[8], entrada[7], entrada[6], aux0[8], aux0[7], aux0[6]);
	ordena3_8bit ord01(reset, clk, entrada[5], entrada[4], entrada[3], aux0[5], aux0[4], aux0[3]);
	ordena3_8bit ord02(reset, clk, entrada[2], entrada[1], entrada[0], aux0[2], aux0[1], aux0[0]);
	
	ordena3_8bit ord10(reset, clk, aux0[8], aux0[5], aux0[2], saida[8], aux1[6], aux1[5]);
	ordena3_8bit ord11(reset, clk, aux0[7], aux0[4], aux0[1], aux1[4], aux1[3], aux1[2]);
	ordena3_8bit ord12(reset, clk, aux0[6], aux0[3], aux0[0], aux1[1], aux1[0], saida[0]);
	
	ordena2_8bit ord20(reset, clk, aux1[6], aux1[4], saida[7], aux2[3]);
	ordena3_8bit ord21(reset, clk, aux1[5], aux1[3], aux1[1], aux2[2], saida[4], aux2[1]);
	ordena2_8bit ord22(reset, clk, aux1[2], aux1[0], aux2[0], saida[1]);

	ordena2_8bit ord30(reset, clk, aux2[3], aux2[2], saida[6], saida[5]);
	ordena2_8bit ord31(reset, clk, aux2[1], aux2[0], saida[3], saida[2]);

endmodule

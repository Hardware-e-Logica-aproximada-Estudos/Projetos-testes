module memoriaIn9_8bit(
  input reset, clock, we,
  input [2:0] wa,
  input [7:0] entrada,
  output reg [7:0] saida [8:0]
);
//  
  always@(posedge clock or posedge reset)
    begin
      if (reset)
        begin
          saida[0] = 0;
          saida[1] = 0;
          saida[2] = 0;
          saida[3] = 0;
          saida[4] = 0;
          saida[5] = 0;
          saida[6] = 0;
          saida[7] = 0;
          saida[8] = 0;
        end
      else
        begin
        if (we)
          saida[wa] = entrada;
        end
    end
  
endmodule

module memoriaOut9_8bit(
  input reset, clock, we,
  input [2:0] ra,
  input [7:0] entrada [8:0],
  output reg [7:0] saida
);
//
  reg [7:0] memoria [8:0];
  
  always@(posedge clock or posedge reset)
    begin
      if (reset)
        begin
          memoria[0] = 0;
          memoria[1] = 0;
          memoria[2] = 0;
          memoria[3] = 0;
          memoria[4] = 0;
          memoria[5] = 0;
          memoria[6] = 0;
          memoria[7] = 0;
          memoria[8] = 0;
        end
      else
        begin
          if (we)
        	memoria = entrada;
        end
    end
  
  always@(posedge clock)
    begin
      saida = memoria[ra];
    end
  
  
endmodule

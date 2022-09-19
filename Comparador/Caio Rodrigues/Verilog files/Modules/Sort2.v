module Sort2(input clk,
                input [7:0] Num1, Num2,
                output reg [7:0] Out1, Out2);

always@(posedge clk) begin

    if(Num1 >= Num2) begin
        Out1 <= Num1;
        Out2 <= Num2;
    end
    else begin
        Out1 <= Num2;
        Out2 <= Num1;
    end
end

endmodule // Clocks = 1
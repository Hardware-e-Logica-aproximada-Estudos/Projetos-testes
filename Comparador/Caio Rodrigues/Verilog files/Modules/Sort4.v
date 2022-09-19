module Sort4(input clk,
             input [31:0] Num,
             output reg [31:0] Out);

    wire [7:0] Doubles [3:0], p [1:0], number[3:0], rest [1:0], first, last;
    reg [7:0] r [1:0];

    assign number[0] = Num[7:0];
    assign number[1] = Num[15:8];
    assign number[2] = Num[23:16];
    assign number[3] = Num[31:24];

    // Doubles
    Sort2 s1 (.clk(clk), .Num1(number[0]), .Num2(number[1]), .Out1(Doubles[0]), .Out2(Doubles[2]));
    Sort2 s2 (.clk(clk), .Num1(number[2]), .Num2(number[3]), .Out1(Doubles[1]), .Out2(Doubles[3]));

    // 1st and 4th
    Sort2 s3 (.clk(clk), .Num1(Doubles[0]), .Num2(Doubles[1]), .Out1(first), .Out2(rest[0]));
    Sort2 s4 (.clk(clk), .Num1(Doubles[2]), .Num2(Doubles[3]), .Out1(rest[1]), .Out2(last));

    // 2nd and 3rd
    Sort2 s5 (.clk(clk), .Num1(rest[0]), .Num2(rest[1]), .Out1(p[0]), .Out2(p[1]));

    always@(posedge clk) begin
        r[0] <= first;
        r[1] <= last;

        Out[31:24] <= r[0];
        Out[23:16] <= p[0];
        Out[15:8] <= p[1];
        Out[7:0] <= r[1];
    end

endmodule // Clocks = 4
module RegisterSeries(input clk, enable,
                input [7:0] reg_in,
                output reg [7:0] reg_out);
            
    reg [7:0] Carry [2:0];

    always@(posedge clk) begin
        if(enable==1)
            Carry[0] <= reg_in;
            Carry[1] <= Carry[0];
            Carry[2] <= Carry[1];
            reg_out <= Carry[2];
    end

endmodule
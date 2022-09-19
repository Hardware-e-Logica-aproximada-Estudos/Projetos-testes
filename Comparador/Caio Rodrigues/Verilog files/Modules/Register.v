module Register(input clk, enable,
                input [7:0] reg_in,
                output reg [7:0] reg_out);

    always@(posedge clk) begin
        if(enable==1)
            reg_out <= reg_in;
    end

endmodule
module dataMemory(input logic clk, enable, reset;
                  input logic [63:0] inmem
                  output logic [63:0] outmem
);

logic [63:0] Memory [7:0]

always@(posedge clk) begin
    if(enable==1) begin
        Memory[0] <= inmen;
        Memory[1] <= Memory[0];
        Memory[2] <= Memory[1];
        Memory[3] <= Memory[2];
        Memory[4] <= Memory[3];
        Memory[5] <= Memory[4];
        Memory[6] <= Memory[5];
        Memory[7] <= Memory[6];
    end
end

endmodule
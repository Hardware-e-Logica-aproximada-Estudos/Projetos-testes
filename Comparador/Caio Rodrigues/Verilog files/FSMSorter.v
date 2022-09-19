// Code your design here

`include "dataMemory.v"
`include "Sorter.v"

module fsm(input logic [63:0] in,
          input logic clk,
          input logic rst,
          output logic y);
  
  
  parameter IDLE = 2'b00;
  parameter MEM_READ = 2'b01;
  parameter SORTING = 2'b10;
  parameter MEM_WRITE = 2'b11;
  
  logic [3:0] counter;
  logic [1:0] current_state, next_state;
  logic enable;

  wire [63:0] inMem_input, inMem_output, outMem_input, outMem_output;

  dataMemory inputMem(.clk(clk), .enable(1), .reset(rst), .inmem(inMem_input), .outmen(inMem_output));
  dataMemory outputMem(.clk(clk), .enable(1), .reset(rst), .inmem(outMem_input), .outmen(outMem_output));


  //Next State Logic
  always@(current_state)
  begin
    case(current_state)
      IDLE: begin
        inMem_input = in;
        counter = counter + 3'd1;

        if(counter == 3'd7) begin
          next_state = MEM_READ;
          counter = 3'd0;
        end
      end
      
      MEM_READ: begin 

        next_state = SORTING;
      end
      SORTING: begin  
        next_state = MEM_WRITE;
      end
      MEM_WRITE: begin 
        next_state = MEM_READ;
      end
      default: begin
        next_state = IDLE;
      end
    endcase
  end
  
  //Update State Register
  always@(posedge clk)
    begin
      current_state <= rst == 0 ? IDLE : next_state;
      if(rst == 1)
        counter = 3'b0;
    end
  
  //Output Logic
  always@(current_state)
    begin
      case(current_state)
        SORTING: enable = 1;
        default: enable = 0;
      endcase
    end
  
endmodule
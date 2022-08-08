// Code your design here

`include "Sorter.v"

module fsm(input logic [2:0] in,
          input logic clk,
          input logic rst,
          output logic y);
  
  
  parameter IDLE = 2'b00;
  parameter MEM_READ = 2'b01;
  parameter PROCESSING = 2'b10;
  parameter MEM_WRITE = 2'b11;
  
  logic [1:0] current_state, next_state;
  logic enable;

  combinational salt_and_pepper_filter(in[2], in[1], in[0], enable, y);

  
  //Next State Logic
  always@(current_state)
  begin
    case(current_state)
      IDLE: next_state = MEM_READ;
      MEM_READ: next_state = PROCESSING;
      PROCESSING: next_state = MEM_WRITE;
      MEM_WRITE: next_state = MEM_READ;
      default: next_state = IDLE;
    endcase
  end
  
  //Update State Register
  always@(posedge clk)
    begin
      current_state <= rst == 0 ? IDLE : next_state;
    end
  
  //Output Logic
  always@(current_state)
    begin
      case(current_state)
        PROCESSING: enable = 1;
        default: enable = 0;
      endcase
    end
  
endmodule
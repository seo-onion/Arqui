`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2025 04:10:52 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top(input [4:0] a, b, input [2:0] ALUControl, output [4:0] Result, output wire [3:0] ALUFlags, input [1:0] shift_input, input direction);
    
    wire [4:0] shiftOutput;
    
    shift shift(b, shift_input, direction, shiftOutput);
  
    alu alu(a, shiftOutput, ALUControl, Result, ALUFlags);

endmodule

module shift(input[4:0] a_input, input [1:0] shift, input direction, output reg [4:0] a_output);
    always @(*)
  begin
    casex (direction)
        1'b0: a_output = a_input << shift;
        1'b1: a_output = a_input >> shift;
    endcase
    end    
    
endmodule


module alu(input [4:0] a, b, input [2:0] ALUControl, output reg [4:0] Result, output wire [3:0] ALUFlags);
  wire neg, zero, carry, overflow;
  wire [4:0] condinvb;
  wire [5:0] sum;
  reg [4:0] convert; 
  
  assign condinvb = ALUControl[0] ? ~b : b;
assign sum = a + condinvb + ALUControl[0];
always @(*)
begin
casex (ALUControl)
  3'b0??: Result = sum;
  3'b010: Result = a & b;
  3'b011: Result = a | b;
  3'b100: Result = a ^ b;
  
  3'b101: begin
    if (a[4] == 1'b1) begin

      convert = ~a + 1'b1; // Invertimos los bits y sumamos 1 para obtener el valor absoluto
      Result = {a[4], convert[3:0]};  // Extendemos el signo correctamente
    end else begin

        Result = a;
    end
	end

  
endcase
end
assign neg = Result[4];
assign zero = (Result == 5'b0);
assign carry = (ALUControl[1] ==
1'b0)
& sum[5];
assign overflow = (ALUControl[1] ==
1'b0)
& ~(a[4] ^ b[4] ^
ALUControl[0]) &
(a[4]
^ sum[4]);
assign ALUFlags = {neg, zero, carry,
overflow};
endmodule
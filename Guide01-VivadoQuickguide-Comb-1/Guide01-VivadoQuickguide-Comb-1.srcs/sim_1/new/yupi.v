`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2025 05:43:12 PM
// Design Name: 
// Module Name: yupi
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


module alu_tb;
    reg [31:0] a, b;
    reg [1:0] ALUControl;
    wire [31:0] Result;
    wire [3:0] ALUFlags;
    
    alu uut (
        .a(a), 
        .b(b), 
        .ALUControl(ALUControl), 
        .Result(Result), 
        .ALUFlags(ALUFlags)
    );
    
    initial begin
        a = 32'h00000000; b = 32'h00000000; ALUControl = 2'b00;
        #10 a = 32'h00000001; b = 32'h00000001; ALUControl = 2'b00;
        #10 a = 32'h00000001; b = 32'h00000000; ALUControl = 2'b00;
        #10 a = 32'hFFFFFFFF; b = 32'h00000001; ALUControl = 2'b00;
        #10 a = 32'h80000000; b = 32'h80000000; ALUControl = 2'b00;
        #10 a = 32'h00000001; b = 32'h00000001; ALUControl = 2'b10;
        #10 a = 32'h00000001; b = 32'h00000001; ALUControl = 2'b11;
        #10 a = 32'hFFFFFFFF; b = 32'h00000000; ALUControl = 2'b11;
        #10 a = 32'h00000000; b = 32'hFFFFFFFF; ALUControl = 2'b11;
        #10 $finish;
    end
endmodule

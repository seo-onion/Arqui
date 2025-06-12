`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 04:24:13 PM
// Design Name: 
// Module Name: module_desing
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

module mux2(a, b, s, f);
    input s,a, b;
    output f;
    wire not_s_out, and_a_out, and_b_out;
    
    not not_s(not_s_out, s);
    and nd_a(and_a_out, a, not_s_out);
    and and_b(and_b_out, b, s);
    or or_out_mux(f, and_a_out, and_b_out);
    
endmodule
    
    

module mux8(a, b, c, d, e, f, g, h, s, y);
    input a, b, c, d, e, f, g, h;
    input wire [2:0] s;
    output wire y;
    
    wire mux_out0, mux_out1, mux_out2, mux_out3;
    wire mux_out4, mux_out5;
    
    
    // FIRST CAPE
    mux2 mux0(.a(a), .b(b), .s(s[0]), .f(mux_out0));
    mux2 mux1(.a(c), .b(d), .s(s[0]), .f(mux_out1));
    mux2 mux2(.a(e), .b(f), .s(s[0]), .f(mux_out2));
    mux2 mux3(.a(g), .b(h), .s(s[0]), .f(mux_out3));
    
    // SECOND CAPE
    
    mux2 mux4(.a(mux_out0), .b(mux_out1), .s(s[1]), .f(mux_out4));
    mux2 mux5(.a(mux_out2), .b(mux_out3), .s(s[1]), .f(mux_out5));
    
    // THIRD CAPE
    
    mux2 mux6(.a(mux_out4), .b(mux_out5), .s(s[2]), .f(y));
endmodule
    
    
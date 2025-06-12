`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2025 05:05:58 PM
// Design Name: 
// Module Name: today_ds
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


module today_ds(

    );
endmodule

module mux_combinacional(input a, b, input [1:0] sel, output f);
wire entrada1 = a&b;
wire entrada2 = 
wire entrada3;
wire entrada4 = 1'b1;
// usar assign o instanciar compuertas para cada entrada...
// and and_1 (entrada1, a, b);
// Hacer un MUX 4:1 usando MUX 2:1
// o puedes instanciar tu modulo de MUX 4:1 si ya lo tienes
wire f1, f2;
mux2_1 mux1(...);
mux2_1 mux2(???);
mux2_1 mux_final(###);
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/09/2025 05:34:30 PM
// Design Name:
// Module Name: m4
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



module mux21(input a,b, input[1:0] sel, output f);
    wire w1,w2;
   
    and and1(w1, a, ~sel);
    and and2(w2,b,sel);
   
    or orr(f, w1,w2);
endmodule


module mux41(input a,b,c,d, input[1:0] sel1, output f);
    wire w1, w2;
   
   
    mux21 m21_0(a,b, sel1[0],w1 );
    mux21 m21_1(c,d, sel1[0],w2);
    mux21 m21_2(w1, w2, sel1[1],f);
endmodule



module mux_combinacional(input a, b, input [1:0] sel, output f);

    wire entrada1, entrada2, entrada3, entrada4;
   
    assign entrada1 = a & b;
    assign entrada2 = ~(a | b);
    assign entrada3 = a;
    assign entrada4 = 1'b1;
   

    mux41 mux_final(entrada1,entrada2,entrada3,entrada4,sel, f);
   
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/09/2025 05:35:26 PM
// Design Name:
// Module Name: simulation
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



module simulation;

// Definir las señales de prueba
reg a, b;
reg [1:0] sel;
wire f;

// Instanciar el módulo MUX 4:1
mux_combinacional mux1(.a(a), .b(b), .sel(sel), .f(f));

// Generar las señales de entrada
integer i, j;
initial begin
for (i = 0; i < 4; i = i + 1) begin
    {a, b} = i; // pasar por los 4 casos de a, b
        for (j = 0; j < 4; j = j + 1) begin
            sel = j; // pasar por los 4 casos de sel[1:0]
            #10;
        end
        #10;
    end
$finish;
end


initial begin
    $monitor("a = %b, b = %b, sel = %b, salida = %b", a, b, sel, f);
end

endmodule

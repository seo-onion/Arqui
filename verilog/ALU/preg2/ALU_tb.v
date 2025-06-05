`timescale 1ns/1ps

module alu_tb;

  reg [4:0] a, b;
  reg [1:0] ALUControl;
  wire [4:0] Result;
  wire [3:0] ALUFlags;

  // Instancia de la ALU (ajustar la conexión Result para 5 bits)
  alu uut (
    .a({27'b0, a}),             // extender a 32 bits con ceros a la izquierda
    .b({27'b0, b}),
    .ALUControl(ALUControl),
    .Result(),                 // señal completa 32 bits
    .ALUFlags(ALUFlags)
  );

  // Solo tomamos los 5 bits menos significativos de Result
  assign Result = uut.Result[4:0];

  initial begin
    // Caso 1: 3 + 5
    a = 5'b00011;   // 3 decimal
    b = 5'b00101;   // 5 decimal
    ALUControl = 2'b00; // Suma
    #10;

    // Caso 2: 2 - 5
    a = 5'b00010;   // 2 decimal
    b = 5'b00101;   // 5 decimal
    ALUControl = 2'b01; // Resta
    #10;

    // Caso 3: 8 and 1
    a = 5'b01000;   // 8 decimal
    b = 5'b00001;   // 1 decimal
    ALUControl = 2'b10; // AND
    #10;

    // Caso 4: 5 or 7
    a = 5'b00101;   // 5 decimal
    b = 5'b00111;   // 7 decimal
    ALUControl = 2'b11; // OR
    #10;

    $finish;
  end

  initial begin
    $monitor("Time=%0t | a=%b b=%b ALUControl=%b Result=%b Flags={N,Z,C,V}=%b",
             $time, a, b, ALUControl, Result, ALUFlags);
  end

endmodule

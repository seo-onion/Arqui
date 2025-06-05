`timescale 1ns/1ps

module alu_tb;

  reg [4:0] a, b;
  reg [2:0] ALUControl;    // Cambiado a 3 bits
  wire [4:0] Result;
  wire [3:0] ALUFlags;

  // Instancia de la ALU
  alu uut (
    .a(a),
    .b(b),
    .ALUControl(ALUControl),
    .Result(Result),
    .ALUFlags(ALUFlags)
  );

  initial begin
    // Caso 1: 3 + 5
    a = 5'b00011;   // 3 decimal
    b = 5'b00101;   // 5 decimal
    ALUControl = 3'b000; // Suma (bit 2=0, bit1 & 0 don't care)
    #10;

    // Caso 2: 2 - 5
    a = 5'b00010;   // 2 decimal
    b = 5'b00101;   // 5 decimal
    ALUControl = 3'b001; // Resta (bit0=1 for subtract)
    #10;

    // Caso 3: 8 and 1
    a = 5'b01000;   // 8 decimal
    b = 5'b00001;   // 1 decimal
    ALUControl = 3'b010; // AND
    #10;

    // Caso 4: 5 or 7
    a = 5'b00101;   // 5 decimal
    b = 5'b00111;   // 7 decimal
    ALUControl = 3'b011; // OR
    #10;

    // Caso 5: 9 xor 6
    a = 5'b01001;   // 9 decimal
    b = 5'b00110;   // 6 decimal
    ALUControl = 3'b100; // XOR
    #10;

    $finish;
  end

  initial begin
    $monitor("Time=%0t | a=%b b=%b ALUControl=%b Result=%b Flags={N,Z,C,V}=%b",
             $time, a, b, ALUControl, Result, ALUFlags);
  end

endmodule

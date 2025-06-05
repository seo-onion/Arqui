`timescale 1ns/1ps

module alu_tb;

  reg [4:0] a, b;
  reg [2:0] ALUControl;   
  wire [4:0] Result;
  wire [3:0] ALUFlags;
  
  reg [1:0] shift;
  reg direction;

 
  top duut(
    .a(a),
    .b(b),
    .ALUControl(ALUControl),
    .Result(Result),
    .ALUFlags(ALUFlags),
    .shift_input(shift),
    .direction(direction)

  );


  initial begin
    shift = 2'b01;
    direction = 1'b1;
    // Caso 1: 3 + 5
    a = 5'b00011;    
    b = 5'b00101;  
    ALUControl = 3'b000; 
    #10;
    
    
    // Caso 2: 5 - 5
    a = 5'b00101;   
    b = 5'b00101;    
    ALUControl = 3'b001;  
    #10;
    

    // Caso 3: 8 and 1
    a = 5'b01000;   
    b = 5'b00001;   
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
	
    
    // Caso 6: Two's complement a Sign extension (pasar de complemento a dos a señal)
    a = 5'b11001;   // Número en complemento a dos (esto es -7 en decimal)
    b = 5'b00000;   // No importa, ya que estamos usando sólo el operando a
    ALUControl = 3'b101; // Control para operar el cambio de complemento a dos (asumido según tu código)
    #10;

    $finish;
  end

  initial begin
    $monitor("Time=%0t | a=%b b=%b ALUControl=%b Result=%b Flags={N,Z,C,V}=%b",
             $time, a, b, ALUControl, Result, ALUFlags);
  end

endmodule

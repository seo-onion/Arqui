.global _start
_start:
	MOV R0, #10
	MOV R1, R0, LSL #1 @ Multiplica por 2 a R0 y luego R1 apunta hacia su direccion
	
	ROR R1,	
	@ LSL R0, #1
	@ LSR R0, #2
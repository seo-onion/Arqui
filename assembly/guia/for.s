.bss
	array: .space 160

.text
	.global _start

_start:	
	
	LDR R0, =array
	MOV R1, #0

	for:
	CMP	R1, #40
	BGT end
	
	STR R1, [R0, R1, LSL #2] @Guardo en memoria lo que está en R1 en la posición [R0 + R1], pero R1 es rotado hacia la izquierda 4 bites (Multiplicación 2²)
	
	ADD R1, R1, #1
	B for
	
end:
	SWI 0

	
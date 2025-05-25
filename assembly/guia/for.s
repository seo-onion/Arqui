.global _start

_start:
	
	LDR R1, =array
	MOV R2, #0 
	
	for:

		CMP R2, #40
		BGE endfor @Si es mayor o igual anda a endfor

		ADD R2, R2, #1

		STR R2, [R1, R2, LSL #2] // Guardamos R2 en R1 + R2*4
		@str copia un valor de un registro a la memoria
		ADD R2, R2, #1
		B for
	endfor:
		SWI 0

.data
	array: 	2,4,345,4,3,
	
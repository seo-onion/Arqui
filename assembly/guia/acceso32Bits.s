.global _start

_start:
	MOV R0, #0x10000000          @ dirección base del array
	ORR R0, R0, #0x00aa0000
	ORR R0, R0, #0x0000ff00
	ORR R0, R0, #0x00000030      @ R0 = 0x10aaff30

	MOV R1, #0                   @ i = 0

	MOV R1, #0 // R1 = i
	
	loop32:
		CMP R1, 10 // completar usando el ejemplo del FOR previo como
		BGE end32
		
		ADD R2, R1, #3             @ R2 = i + 3
    	STR R2, [R0, R1, LSL #2]   @ arr[i] = i + 3
		ADD R1, R1, #1             @ i++
		B loop32
	
	end32:
		SWI 0
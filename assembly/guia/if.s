.global _start

_start:
	MOV R0, #4 // x = 4
	CMP R0, #10
	BGE else 
	
	MOV R1, #1
	B endif
	else:
		MOV R1, #2
		B end
	endif:
		SWI 0
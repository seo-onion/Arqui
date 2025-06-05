.text
	.global main
	.global sumar
	
	sumar:
	
	ADD R0, R0, R1
	MOV PC, LR
	
	main:
	MOV R0, #13
	MOV R1, #20
	BL sumar
	B end

	end:
	b end
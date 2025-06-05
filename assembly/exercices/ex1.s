/home/seodos/Descargas/ex2.s.text
	.global _start
	_start:
		
		MOV R0, #0 @retorno
		MOV R1, #0 @Iterador
		
		for:
		CMP R1, #10
		BGT end
		
		ADD R0, R0, R1
		ADD R1, R1, #1	
		
		B for
		
		end:
		B end
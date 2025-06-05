.data
	array: .word 12, 54, 3, 4, 5

.text
	.global _start
_start:
	MOV R0, #0          @ Inicialización (no usada ahora)
	MOV R1, #0          @ Iterador i = 0
	LDR R2, =array      @ R2 = dirección base del array
	MOV R3, #0          @ Registro para resultado (ejemplo)

for:
	CMP R1, #5          @ Comparar i con tamaño array
	BGE end             @ Si i >= 5, salir

	LDR R4, [R2], #4    @ Cargar array[i] en R4 y avanzar puntero R2

	ADD R1, R1, #1      @ i++

	LSL R3, R4, #1      @ R3 = R4 * 2 (puedes usar o guardar este resultado)

	B for               @ Repetir

end:
	B end               @ Bucle infinito para detener ejecución

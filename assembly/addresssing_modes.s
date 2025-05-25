.global _start
_start:
    MOV R0, #13 @Asignar 13 al registro 0
	LDR R0, =list @Asignar la direccion al primer elemento de la lista al registro 0
	LDR R1, [R0, #8]! @Asignar la primera direccion +8 bits (tercera direccion) al registro 1
	
.data
list:
	.word 4,5,-9,1,0,2,-3
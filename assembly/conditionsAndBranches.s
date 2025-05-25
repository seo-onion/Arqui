.global _start
_start:
    MOV R0, #3
    MOV R1, #2

    CMP R0, R1
    BGT greater         @ Si R0 > R1, salta a 'greater'
    BAL default         @ Si no, salta a 'default'

greater:
    MOV R2, #1
    B end               @ ← AGREGAR ESTO para evitar caer en default

default:
    MOV R2, #2

end:
    MOV R7, #1
    MOV R0, #0
    SWI 0

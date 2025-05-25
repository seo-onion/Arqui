.global _start
_start:
    @ --- Cargar número A (64 bits)
    LDR R0, =0xFFFFFFFF     @ A low
    LDR R1, =0x00000001     @ A high

    @ --- Cargar número B (64 bits)
    LDR R2, =0x00000001     @ B low
    LDR R3, =0x00000002     @ B high

    @ --- Sumar partes bajas
    ADD R4, R0, R2          @ R4 = A_low + B_low

    @ --- Sumar partes altas con acarreo
    ADC R5, R1, R3          @ R5 = A_high + B_high + Carry

    @ Resultado completo (64 bits):
    @ Parte baja → R4
    @ Parte alta → R5

    @ (En sistemas reales pondrías una syscall o loop infinito)
 
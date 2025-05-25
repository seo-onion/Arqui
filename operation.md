# Operaciones en ARM Assembly

## Palabras clave
- **Rn (Register n):** primer operando o registro base.  
- **Rm (Register m):** segundo registro, a veces usado para shifts/rotates.  
- **Rd (Register d):** registro destino.  
- **Operand2:** segundo operando, puede ser un registro (con shift) o un inmediato.  
- **C (Carry flag):** acarreo, parte del CPSR.

---

## Flags (CPSR)
Las flags son bits de estado que reflejan el resultado de la **última** operación aritmética o lógica que actualizó el CPSR.
- **N (Negative):** se pone a 1 si el bit 31 del resultado es 1 (resultado negativo en dos complementos).  
- **Z (Zero):** se pone a 1 si el resultado es cero.  
- **C (Carry):** en sumas/RESTAS indica acarreo/borrow; en shifts indica el último bit desplazado.  
- **V (Overflow):** se pone a 1 si ocurrió un desbordamiento aritmético con signo.

---

## Operaciones Aritméticas y de Acarreo

| Instrucción | Sintaxis               | Operación                   | Flags actualizadas | Descripción                                           |
|-------------|------------------------|-----------------------------|--------------------|-------------------------------------------------------|
| **ADD**     | `ADD{S} Rd, Rn, Op2`   | `Rd ← Rn + Op2`             | S → N, Z, C, V     | Suma simple. Con `S`: actualiza flags.                |
| **ADC**     | `ADC{S} Rd, Rn, Op2`   | `Rd ← Rn + Op2 + C`         | S → N, Z, C, V     | Suma con acarreo (para cadenas > 32 bits).            |
| **SUB**     | `SUB{S} Rd, Rn, Op2`   | `Rd ← Rn - Op2`             | S → N, Z, C, V     | Resta simple.                                        |
| **SBC**     | `SBC{S} Rd, Rn, Op2`   | `Rd ← Rn - Op2 + C - 1`     | S → N, Z, C, V     | Resta con “borrow” inverso.                          |
| **RSB**     | `RSB{S} Rd, Rn, Op2`   | `Rd ← Op2 - Rn`             | S → N, Z, C, V     | Resta invertida.                                     |
| **RSC**     | `RSC{S} Rd, Rn, Op2`   | `Rd ← Op2 - Rn + C - 1`     | S → N, Z, C, V     | Resta invertida con borrow inverso.                 |

---

## Operaciones Lógicas y de Prueba de Flags

| Instrucción | Sintaxis            | Operación       | Flags actualizadas  | Descripción                                            |
|-------------|---------------------|-----------------|---------------------|--------------------------------------------------------|
| **AND**     | `AND{S} Rd, Rn, Op2`| `Rd ← Rn & Op2` | S → N, Z, C (no V)  | AND bit a bit. Con `S` actualiza flags.                |
| **ORR**     | `ORR{S} Rd, Rn, Op2`| `Rd ← Rn \| Op2` | S → N, Z, C (no V)  | OR bit a bit. Con `S` actualiza flags.                 |
| **EOR**     | `EOR{S} Rd, Rn, Op2`| `Rd ← Rn ^ Op2` | S → N, Z, C (no V)  | XOR bit a bit. Con `S` actualiza flags.                |

---

## Comparaciones y Test de Flags

| Instrucción | Sintaxis       | Operación         | Flags actualizadas  | Descripción                                          |
|-------------|----------------|-------------------|---------------------|------------------------------------------------------|
| **TST**     | `TST Rn, Op2`  | — (Rn & Op2)      | N, Z, C (no V)      | AND bit a bit y descarta resultado; solo flags.      |
| **TEQ**     | `TEQ Rn, Op2`  | — (Rn ^ Op2)      | N, Z, C (no V)      | XOR bit a bit y descarta resultado; solo flags.      |
| **CMP**     | `CMP Rn, Op2`  | — (Rn − Op2)      | N, Z, C, V          | Resta y descarta resultado; solo flags.              |
| **CMN**     | `CMN Rn, Op2`  | — (Rn + Op2)      | N, Z, C, V          | Suma y descarta resultado; solo flags.               |

---

## Operaciones de Memoria

| Instrucción | Sintaxis                | Descripción                                    |
|-------------|-------------------------|-----------------------------------------------|
| **LDR**     | `LDR Rt, [Rn, #offset]` | Carga un word (32 bits) desde memoria a `Rt`.   |
| **STR**     | `STR Rt, [Rn, #offset]` | Almacena un word (32 bits) desde `Rt` a memoria.|

---

## Operaciones de comparación

| Sufijo | Descripción             | Condición       |
| ------ | ----------------------- | --------------- |
| BEQ    | Branch if equal         | Z == 1          |
| BNE    | Branch if not equal     | Z == 0          |
| BGT    | Branch if greater than  | Z == 0 y N == V |
| BLT    | Branch if less than     | N != V          |
| ADDGE  | ADD if greater or equal | N == V          |
| SUBVS  | SUB if overflow set     | V == 1          |
| EORMI  | EOR/XOR if negative     | N == 1          |
| ANDPL  | AND if positive         | N == 0          |

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

## Shift
| Tipo de Shift                    | Descripción                                                                       | Sintaxis ARM Assembly | Ejemplo          | Efecto en bits                      |
| -------------------------------- | --------------------------------------------------------------------------------- | --------------------- | ---------------- | ----------------------------------- |
| **LSL (Logical Shift Left)**     | Desplaza bits hacia la izquierda, llenando con ceros a la derecha                 | `LSL #n`              | `LSL R1, R1, #2` | Multiplica por 2ⁿ                   |
| **LSR (Logical Shift Right)**    | Desplaza bits hacia la derecha, llenando con ceros a la izquierda                 | `LSR #n`              | `LSR R1, R1, #3` | Divide por 2ⁿ (sin signo)           |
| **ASR (Arithmetic Shift Right)** | Desplaza bits hacia la derecha, llenando con el bit de signo (bit 31)             | `ASR #n`              | `ASR R1, R1, #1` | División con signo (preserva signo) |
| **ROR (Rotate Right)**           | Rota bits a la derecha, los bits que salen por la derecha entran por la izquierda | `ROR #n`              | `ROR R1, R1, #4` | Rotación circular                   |
| **RRX (Rotate Right Extended)**  | Rota a la derecha un bit con carry (shift right con carry)                        | `RRX`                 | `RRX R1, R1`     | Desplaza 1 bit, introduce bit carry |

| Forma de acceso    | Significado                      | Equivalente C |
| ------------------ | -------------------------------- | ------------- |
| `[R0]`             | Dirección exacta                 | `*R0`         |
| `[R0, #4]`         | R0 + 4                           | `*(R0 + 4)`   |
| `[R0, R1]`         | R0 + R1                          | `*(R0 + R1)`  |
| `[R0, R1, LSL #2]` | R0 + (R1 × 4)                    | `array[i]`    |
| `[R0], #4`         | Post-indexado (usa y luego suma) | `*ptr++`      |
| `[R0, #4]!`        | Pre-indexado (suma y luego usa)  | `++ptr; *ptr` |



## Secciones y Directivas

### Secciones
Organizan el código y datos en memoria y en el ejecutable

**.text** Código ejecutable en forma de instruciones

**.data** Datos inicializados

**.bss** Datos no inicializados

**.rodata** Datos solo para lectura (CONSTANTES)

Directivas
| Directiva | Sección típica        | Uso principal                                              | Ejemplo                                                 |
| --------- | --------------------- | ---------------------------------------------------------- | ------------------------------------------------------- |
| `.text`   | Código                | Inicia la sección de código ejecutable                     | `.text`<br>`_start:`<br>`MOV R0, #0`                    |
| `.data`   | Datos inicializados   | Inicia la sección de variables inicializadas               | `.data`<br>`var: .word 42`                              |
| `.bss`    | Datos sin inicializar | Reserva espacio para variables sin valor inicial           | `.bss`<br>`buffer: .space 20`                           |
| `.global` | Cualquier sección     | Hace un símbolo visible para el linker                     | `.global _start`                                        |
| `.word`   | `.data` o `.bss`      | Reserva o define una palabra (4 bytes)                     | `.word 0x1234ABCD`                                      |
| `.space`  | `.bss`                | Reserva bits sin inicializar                            | `.space 32`                                             |
| `.align`  | `.text`, `.data`      | Alinea la siguiente dirección (por ejemplo a 4 o 16 bytes) | `.align 4`                                              |
| `.equ`    | Cualquier sección     | Define una constante simbólica                             | `.equ SIZE, 10`                                         |
| `.macro`  | `.text` o `.data`     | Define una macro (bloque reutilizable)                     | `.macro INC_REG reg`<br>`ADD \reg, \reg, #1`<br>`.endm` |

## Registros
| Registro | Nombre alternativo   | Uso típico / Función                                         | Notas                                                       |
| -------- | -------------------- | ------------------------------------------------------------ | ----------------------------------------------------------- |
| R0       | -                    | Registro para **argumento 1** y **resultado de función**     | Caller-saved (temporal)                                     |
| R1       | -                    | Registro para argumento 2                                    | Caller-saved                                                |
| R2       | -                    | Registro para argumento 3                                    | Caller-saved                                                |
| R3       | -                    | Registro para argumento 4                                    | Caller-saved                                                |
| R4       | -                    | Registro de uso general, **callee-saved**                    | Debe ser preservado por la función llamada                  |
| R5       | -                    | Registro de uso general, **callee-saved**                    |                                                             |
| R6       | -                    | Registro de uso general, **callee-saved**                    |                                                             |
| R7       | FP (Frame Pointer)   | Generalmente usado como **frame pointer** en ABI antiguos    | Puede ser usado para apuntar stack frame                    |
| R8       | -                    | Registro de uso general, **callee-saved**                    |                                                             |
| R9       | SB (Static Base)     | Usado como base estática para ciertas aplicaciones           | Puede usarse como callee-saved o reservado según plataforma |
| R10      | SL (Stack Limit)     | Usado como puntero a límite del stack o datos estáticos      | Callee-saved                                                |
| R11      | FP (Frame Pointer)   | Frame pointer en ABI modernos                                | Callee-saved                                                |
| R12      | IP (Intra-Procedure) | Registro temporal para llamadas internas (scratch)           | Caller-saved                                                |
| R13      | SP (Stack Pointer)   | Puntero de pila (stack pointer)                              | Siempre apunta al tope del stack                            |
| R14      | LR (Link Register)   | Registro de enlace, guarda la dirección de retorno           | Usado automáticamente por llamadas BL                       |
| R15      | PC (Program Counter) | Contador de programa, apunta a la instrucción que se ejecuta | Siempre apunta a la próxima instrucción                     |

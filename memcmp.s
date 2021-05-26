.data
.balign 4
str1: .fill 100, 1, 0
.balign 4
str2: .fill 100, 1, 0
.balign 4
scanInt:    .asciz "%d"
.balign 4
n: .word 0
.balign 4
inputReq: .asciz "Insert string 1 -> "
.balign 4
inputReq2: .asciz "Insert string 2 -> "
.balign 4
inputIntReq: .asciz "Insert value of n (first n bytes) -> "
.balign 4
memcmp_out: .asciz "memcmp: true[0]/false[1]: %d\n"
.balign 4
funcDesc: .asciz "[ MEMCMP ] -> Compares the first n bytes of str1 and str2 \n"

.section .text
.global main
.global printf
.global fgets
.global stdin 
.arm

main:
    LDR R0, =funcDesc   @ descrição da função
    BL printf

    LDR R0, =inputReq   @ pedido de input
    BL printf

    LDR R0, =str1     @ local de memória para str1
    MOV R1, #100        @ número máximo de chars que são lidos
    LDR R2, =stdin      @ leitura de STDIN
    LDR R2, [R2]        @ colheita de valor literal da string
    BL fgets            @ lê o valor na stream

    LDR R0, =inputReq2 @ pedido de input 2
    BL printf
    
    LDR R0, =str2     @ local de memória para str2
    MOV R1, #100        @ número máximo de chars que são lidos
    LDR R2, =stdin      @ Leitura de STDIN
    LDR R2, [R2]        @ colheita de valor literal da string
    BL fgets            @ lê o valor na stream

    LDR R0, =inputIntReq
    BL printf
    LDR R0, =scanInt
    LDR R1, =n
    BL scanf
    LDR R2, =n
    LDR R2, [R2]  @ (size_t n)

    LDR R0, =str1  
    LDR R1, =str2
    BL my_memcmp
    MOV R1, R0
    LDR R0, =memcmp_out
    BL printf

    B _exit

my_memcmp:
    MOV R3, #0 @ indice da string

my_memcmp_loop:
    LDRB R4, [R0, R3] @Loads which char of str1 it's at to R4
    LDRB R5, [R1, R3] @Loads which char of str2 it's at to R5
    CMP R4, R5 @ Checks if byte is different
        MOVNE R0, #1 @ If byte not equals return 1, for false
        BNE my_memcmp_end @Leave function
    CMP R3, R2 @ Checks if byte count has reached limit
        MOVGT R0, #1
        BGT my_memcmp_end
        MOVEQ R0, #0
        BEQ my_memcmp_end @Leave function
    ADD R3, #1 @Adds +1 to counter
    B my_memcmp_loop

my_memcmp_end:
    BX LR

_exit:
    MOV R7, #1 @ R7 = syscall number for 'exit'
    SVC #0 @ invoke syscall

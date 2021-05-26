.data
.balign 4
str1: .fill 100, 1, 0
.balign 4
strlen_out: .asciz "strlen: %d \n"
.balign 4
inputReq: .asciz "Insert string -> "
.balign 4
funcDesc: .asciz "[ STRLEN ] -> Calculates length of a string \n"

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

    LDR R0, =str1 @ string para verificar tamanho
    BL my_strlen
    MOV R1, R0
    LDR R0, =strlen_out @print do resultado
    BL printf

    B _exit

my_strlen:
    MOV R3, #0 @ Index/Counter Register

my_strlen_loop:
    LDRB R4, [R0,R3] @ Loads byte indexed by R3 from R0 address
    CMP R4, #0 @ Checks if loop has reached end of string char ("\0")
        SUBEQ R3, #1
        MOVEQ R0, R3 @ Place value in return Register (R0)
        BEQ my_strlen_end @ Exit function
    ADD R3, #1 @ Increments counter/index register
    B my_strlen_loop

my_strlen_end:
    BX LR

_exit:
    MOV R7, #1 @ R7 = syscall number for 'exit'
    SVC #0 @ invoke syscall


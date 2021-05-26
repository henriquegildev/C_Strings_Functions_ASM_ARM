@ Função: strrchr
@ Descrição: Procura a ultima ocorrencia de um caractere
@ Autores: Gabriel Gomes | Henrique Gil
@ Input:
@   R2 -> str1_strrchr
@   R1 -> '1'

.data
.balign 4
str1_strrchr: .asciz "F1nd this char1.com"
.balign 4
str2_strrchr: .ascii "1"
.balign 4
out_1_strrchr: .asciz "strrchr: Mem. Address: %x\n"
.balign 4
out_2_strrchr: .asciz "strrchr: String in Mem. Address: %s\n"
.balign 4
inputstr: .fill 100,1,0

.section .text
.global main
.arm

main:
    LDR R2, =str1_strrchr
    MOV R1, #'1'
    BL my_strrchr @Returns value of R0, the return register

    MOV R1, R0
    MOV R4, R0
    LDR R0, =out_1_strrchr
    BL printf
    MOV R1, R4
    LDR R0, =out_2_strrchr
    BL printf

    B _exit

my_strrchr:
    PUSH {LR}
    BL my_strlen
    POP {LR}
    MOV R6, R0
    MOV R0, #0
    MOV R3, #0 @ indice da string
    MOV R4, #0
    LDR R5, =inputstr

    my_strrchr_loop:
        LDRB R4, [R2, R6] @Loads which char of str1 it's at to R4
        CMP R4, R1 @ compara o valor de R4 com R1
            ADDEQ R6, #1 @ adiciona 1 a R6 caso a condição se verifique
            ADDEQ R0, R2, R6 @ adiciona a R0 a soma de R2 com R6 caso a condição se verifique
            BEQ my_strrchr_end @Leave function 
        SUB R6, #1 @ subtrai 1 a R6
    B my_strrchr_loop @ executa o loop atual de novamente

    my_strrchr_end:
        BX LR @ sair do loop

my_strlen:
    MOV R3, #0 @ contador global
    my_strlen_loop:
        LDRB R4, [R2, R3]@ carrega o caractere atual da string para R4
        CMP R4, #0@ compara o caractere da string com null
            MOVEQ R0, R3 @ passa o conteudo de R3 para R0 caso a condição se verifique
            BEQ my_strlen_end @ sai do loop caso condição se verifique
        ADD R3, #1 @ incrementa o valor do contador
        B my_strlen_loop @ executa o loop atual de novamente

        my_strlen_end:
            BX LR @ sair do loop

_exit:
    MOV R7, #1 @ R7 = número syscall para sair
    SVC #0 @ invocar syscall

    
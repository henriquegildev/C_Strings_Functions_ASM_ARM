@ Função: strpbrk
@ Descrição: Procura a primeira ocorrencia de um charactere especifico
@ Autores: Gabriel Gomes | Henrique Gil
@ Input:
@   R1 -> str1_strpbrk
@   R1 -> str2_strpbrk

.data
.balign 4
str1_strpbrk: .asciz "blfadec"
.balign 4
str2_strpbrk: .asciz "caf"
.balign 4
out_strpbrk: .asciz "strpbrk: %c\n"

.section .text
.global main
.arm

main:
    LDR R1, =str1_strpbrk @ carrega str1_strpbrk para R1
    LDR R2, =str2_strpbrk @ carrega str2_strpbrk para R2

    BL my_strpbrk @ executa a função my_strpbrk
    
    MOV R1, R0 @ move o valor contido em R0 para R1
    LDR R0, =out_strpbrk @ carrega o valor da out_strpbrk para o registo R0
    BL printf @ mostra o resultado

    B _exit @ para a execução do script

my_strpbrk:
    MOV R3, #0 @contador do loop 1
    my_strpbrk_loop_1:
        MOV R3, #0 @reset no contador
        LDRB R6, [R1], #1 @ carrega para R6 o primeiro caracter de R1
        CMP R6, #0 @ compara o caractere da string com null
            BEQ my_strpbrk_end @ sai do loop caso condição se verifique
            BNE my_strpbrk_loop_2 @ executa o loop 2 caso condição se verifique
    B my_strpbrk_loop_1 @ executa o loop atual de novamente

    my_strpbrk_loop_2:
        LDRB R4, [R2, R3] @ carrega o caractere atual de R2 para R4
        CMP R4, #0 @ compara o caractere da string com null
            BEQ my_strpbrk_loop_1 @ executa o loop 1 caso condição se verifique
        CMP R4, R6 @ compara R4 com R6
            MOVEQ R0, R4  @ move R4 para R0 caso condição se verifique
            BEQ my_strpbrk_end @ sai do loop caso condição se verifique
        ADD R3, #1 @ incrementa o valor do contador
    B my_strpbrk_loop_2 @ executa o loop atual de novamente

    my_strpbrk_end:
        BX LR @ sai do loop

_exit:
    MOV R7, #1 @ R7 = número syscall para sair
    SVC #0 @ invocar syscall



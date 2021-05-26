@ Função: strcmp
@ Descrição: Compara duas strings
@ Autores: Gabriel Gomes | Henrique Gil
@ Input:
@   R0 -> str1_memcpy
@   R1 -> str2_memcpy

.data
.balign 4
str1_strcmp: .asciz "abc"
str2_strcmp: .asciz "cba"
out_strcmp: .asciz "strcmp: true[0]/false[1]: %d\n"

.section .text
.global main
.arm

main:
    LDR R0, =str1_strcmp @ atribui o valor do str1_strcmp ao registo R1
    LDR R1, =str2_strcmp @ atribui o valor do str1_strcmp ao registo R2
    BL my_strcmp @
    
    MOV R1, R0
    LDR R0, =out_strcmp
    BL printf @ mostra o resultado
    B _exit @ para a execução do script

my_strcmp:
    MOV R3, #0 @contador global
    my_strcmp_loop:
        LDRB R4, [R0, R3] @ carrega o caractere atual de R0 para R4
        LDRB R5, [R1, R3] @ carrega o caractere atual de R1 para R5
        CMP R4, #0 @ compara o caractere da string com null
            MOVEQ R0, #0 @ move o 0 para R0 caso a condição se verifique
            BEQ my_strcmp_end @ sai do loop caso condição se verifique
        CMP R4, R5 @ compara o valor de R4 com R5
            MOVNE R0, #1 @ move 1 para R0 caso a condição não se verifique
            BNE my_strcmp_end @ sai do loop caso condição se verifique
        ADD R3, #1 @ incrementa o valor do contador
    B my_strcmp_loop @ executa o loop atual de novamente

    my_strcmp_end:
        BX LR @ sair do loop

_exit:
    MOV R7, #1 @ R7 = número syscall para sair
    SVC #0 @ invocar syscall


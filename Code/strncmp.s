@ Função: strncmp
@ Descrição: Compara duas strings
@ Autores: Gabriel Gomes | Henrique Gil
@ Input:
@   R0 -> str1_strncmp
@   R1 -> str2_strncmp
@   R3 -> '2'

.data
.balign 4
str1_strncmp: .asciz "abcdas"
.balign 4
str2_strncmp: .asciz "abcced"
.balign 4
out_strncmp: .asciz "strncmp: true[0]/false[1]: %d\n"

.section .text
.global main
.arm

main:
    LDR R0, =str1_strncmp @ atribui o valor do str1_strncmp ao registo R0
    LDR R1, =str2_strncmp @ atribui o valor do str2_strncmp ao registo R0
    MOV R2, #2
    BL my_strncmp @ executa a função my_strncmp
    
    MOV R1, R0 @ move o valor contido em R0 para R1
    LDR R0, =out_strncmp @ carrega o valor da string out_strncmp para o registo R0
    BL printf @ mostra o resultado

    B _exit @ para a execução do script

my_strncmp:
    MOV R3, #0 @contador global
    my_strncmp_loop:
        LDRB R4, [R0, R3] @ carrega o caractere atual de R0 para R4
        LDRB R5, [R1, R3] @ carrega o caractere atual de R1 para R5
        CMP R4, R5 @ compara R4 com R5
            MOVNE R0, #1 @ move 1 para R0 caso a condição não se verique
            BNE my_strncmp_end @ sai do loop caso condição não se verifique
        CMP R3, R2 @ compara R3 com R2
            MOVEQ R0, #0 @ move 0 para R0 caso a condição se verifique
            BEQ my_strncmp_end @ sai do loop caso condição se verifique
        CMP R4, #0 @compara o caractere da string com null
            MOVEQ R0, #0 @ move 0 para R0 caso a condição se verifique
            BEQ my_strncmp_end @ sai do loop caso condição se verifique
        ADD R3, #1 @ incrementa o valor do contador
    B my_strncmp_loop

    my_strncmp_end:
        BX LR @ sai do loop

_exit:
    MOV R7, #1 @ R7 = número syscall para sair
    SVC #0 @ invocar syscall



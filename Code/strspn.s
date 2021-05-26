@ Função: strspn
@ Descrição: Calcula o comprimento do segmento inicial de str1_strspn que consiste inteiramente em caracteres em str2_strspn_strspn
@ Autores: Gabriel Gomes | Henrique Gil
@ Input:
@   R0 -> str1_strspn
@   R1 -> str2_strspn

.data
.balign 4
str1_strspn: .asciz "ABCDEFGH"
.balign 4
str2_strspn: .asciz "ABCD"
.balign 4
out_strspn: .asciz "strspn: %d\n"
.balign 4
funcDesc: .asciz "[ STRSPN ] -> Calculates the length of the initial segment of str1_strspn which consists entirely of characters in str2_strspn \n"

.section .text
.global main
.global printf
.arm

main:
    LDR R0, =funcDesc @ descrição da função
    BL printf


    LDR R0, =str1_strspn @ carrega str1_strspn para R0
    LDR R1, =str2_strspn @ carrega str2_strspn para R1
    BL my_strspn 
    MOV R1, R0          
    LDR R0, =out_strspn
    BL printf
    B _exit

my_strspn:
    MOV R3, #0 
    MOV R5, #0
    my_strpsn_loop:
        LDRB R2, [R0, R3] @ carrega o caractere atual de R0 para R2
        LDRB R4, [R1, R3] @ carrega o caractere atual de R1 para R4
        CMP R4, #0 @ compara o caractere da string com null
            MOVEQ R0, R5 @ passa o conteudo de R5 para R0 caso a condição se verifique
            BEQ my_strspn_end @ sai do loop caso condição se verifique
        CMP R4, R2 @ compara o valor de R4 com R2
            ADDEQ R5, #1 @ incrementa o valor do contador
            MOVNE R0, R5 @ passa o conteudo de R5 para R0 caso a condição se verifique
            BNE my_strspn_end @ sai do loop caso condição se verifique
        ADD R3, #1 @ incrementa o valor do contador
    B my_strpsn_loop @ executa o loop atual de novamente

    my_strspn_end:
        BX LR @ sair do loop

_exit:
    MOV R7, #1 @ R7 = número syscall para sair
    SVC #0 @ invocar syscall


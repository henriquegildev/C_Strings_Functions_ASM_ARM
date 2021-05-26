@ Função: strncat
@ Descrição: Realiza a junção de duas strings com limite de caracteres
@ Autores: Gabriel Gomes | Henrique Gil
@ Input:
@   R0 -> result
@   R1 -> str1
@   R2 -> str2
@   R8 -> 9 (qualquer valor dentro do range)

.data
.balign 4
str1_strncat: .asciz "ABCDEFG" @ define o valor da string 1
.balign 4
str2_strncat: .asciz "HIJKMLP" @ define o valor da string 2 
.balign 4
result_strncat: .fill 100,1,0  @ define o valor inicial do resultado
.balign 4 
out_strncat: .asciz "strncat: %s\n" @ define o valor do printf

.section .text
.global main
.arm

main:
    LDR R0, =result_strncat  @ atribui o valor do result ao registo R0
    LDR R1, =str1_strncat @ atribui o valor do str1_strncat ao registo R1
    LDR R2, =str2_strncat @ atribui o valor do str2_strncat ao registo R2
    MOV R8, #9 @ atribui o valor 9 ao registo R2
    BL my_strncat @ executa a função my_strncat
    
    MOV R1, R0 @ move o valor contido em R0 para R1
    LDR R0, =out_strncat @ carrega o valor da string out_strncat para o registo R0
    BL printf @ mostra o resultado
    B _exit @ para a execução do script

my_strncat:
    MOV R5, #0 @contador global
    MOV R3, #0 @contador este loop 1
    my_strncat_loop_str1:
        LDRB R4, [R1, R3]  @ carrega o caractere atual da string para R4
        CMP R4, #0 @ compara o caractere da string com null
            MOVEQ R3, #0 @ da reset ao contador local caso condição se verifique
            BEQ my_strncat_loop_str2 @ executa o loop 2 caso condição se verifique
        STRB R4, [R0, R5] @ guarda o caracter atual no endereço R0 no index R5
        ADD R5, #1@ incrementa o valor do contador global
        ADD R3, #1 @ incrementa o valor do contador local
    B my_strncat_loop_str1 @ executa o loop atual de novamente

    my_strncat_loop_str2:
        LDRB R4, [R2, R3] @ carrega o caractere atual da string para R4
        CMP R4, #0 @compara o caractere da string com null
            BEQ my_strncat_loop_end @ sai do loop caso condição se verifique
        STRB R4, [R0, R5] @ guarda o caracter no R0
        CMP R5, R8 @compara o valor de R5 com R8
            BEQ my_strncat_loop_end @ sai do loop caso condição se verifique
        ADD R5, #1 @ incrementa o valor do contador global
        ADD R3, #1 @ incrementa o valor do contador local
    B my_strncat_loop_str2 @ executa o loop atual de novamente

my_strncat_loop_end:
    BX LR @ sair do loop

_exit:
    MOV R7, #1 @ R7 = número syscall para sair
    SVC #0 @ invocar syscall


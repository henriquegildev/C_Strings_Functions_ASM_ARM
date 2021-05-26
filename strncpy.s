@ Função: strncpy
@ Descrição: copia n caracteres de uma string para outra
@ Autores: Gabriel Gomes | Henrique Gil
@ Input:
@   R0 -> result
@   R1 -> str1_strncpy
@   R2 -> str2_strncpy
@   R5 -> 3 (qualquer valor dentro do range)

.data
.balign 4
str1_strncpy: .asciz "abcdefg" @ define o valor da string 1
.balign 4
str2_strncpy: .asciz "0123456" @ define o valor da string 2
.balign 4
out_strncpy: .asciz "strncpy: %s\n" @ define o valor do printf

.section .text
.global main
.arm

main:
    LDR R1, =str1_strncpy @ atribui o valor do str1_strncpy ao registo R1
    LDR R2, =str2_strncpy @ atribui o valor do str2_strncpy ao registo R2
    MOV R5, #3 @ atribui o valor 3 ao registo R5
    BL my_strncpy @ executa a função my_strncpy
    
    MOV R1, R0 @ move o valor contido em R0 para R1
    LDR R0, =out_strncpy @ carrega o valor da string out_strncpy para o registo R0
    BL printf @ mostra o resultado
    B _exit @ para a execução do script

my_strncpy:
    MOV R3, #0 @ contador global
    LDRB R4, [R1, #0] @ carrega o primeiro caractere da string R1 para R4
    
    my_strncpy_loop: 
        CMP R4, #0 @ compara o caractere da string com null
            MOVEQ R0, R2 @ passa o conteudo de R2 para R0 caso a condição se verifique
            BEQ my_strncpy_loop_end @ sai do loop caso condição se verifique
        CMP R3, R5 @ compara o valor do contador com o valor de n
            MOVEQ R0, R2 @ passa o conteudo de R2 para R0 caso a condição se verifique
            BEQ my_strncpy_loop_end @ sai do loop caso condição se verifique
        LDRB R4, [R1, R3] @ carrega o valor de R1(indice R3) para R4
        STRB R4, [R2, R3] @ guarda o valor de R4 no R2(indice R3)
        ADD R3, #1 @ incrementa o valor do contador
    B my_strncpy_loop @ executa o loop atual de novamente

    my_strncpy_loop_end:
        BX LR @ sair do loop

_exit:
    MOV R7, #1 @ R7 = número syscall para sair
    SVC #0 @ invocar syscall


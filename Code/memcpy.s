@ Função: memcpy
@ Descrição: Copia uma string para outra string~
@ Autores: Gabriel Gomes | Henrique Gil
@ Input:
@   R0 -> result_memcpy
@   R1 -> str1_memcpy
@   R2 -> str2_memcpy
@   R5 -> 9 (qualquer valor dentro do range)

.data
.balign 4
str1_memcpy: .asciz "http://www.tutorialspoint.com\n" @ define o valor da string 1
.balign 4
str2_memcpy: .asciz "HELLO!!!!\n" @ define o valor da string 2
.balign 4
result_memcpy: .fill 100,1,0
.balign 4
out_memcpy: .asciz "memcpy: %s" @ define o valor do printf

.section .text
.global main
.arm

main:
    LDR R0, =result_memcpy @ atribui o valor do result_memcpy ao registo R0
    LDR R1, =str1_memcpy @ atribui o valor do str1_memcpy ao registo R1
    LDR R2, =str2_memcpy @ atribui o valor do str2_memcpy ao registo R2
    MOV R5, #9 @ atribui o valor 9 ao registo R2
    BL my_memcpy @ executa a função my_memcpy

    MOV R1, R0 @ move o valor contido em R0 para R1
    LDR R0, =out_memcpy @ carrega o valor da string out_strncpy para o registo R0
    BL printf @ mostra o resultado
    B _exit @ para a execução do script

    my_memcpy:
        MOV R3, #0 @ contador global
        my_memcpy_loop:   
            LDRB R4, [R1, R3] @ carrega o caractere atual de R1 para R4
            STRB R4, [R2, R3] @ guarda o valor de R4 no registo R2 no indice R3
            CMP R4, #0 @ compara o caractere da string com null
                MOVEQ R0, R2 @ move o conteudo de R2 para R0 caso a condição se verifique
                BEQ my_memcpy_end @ sai do loop caso condição se verifique
            CMP R1, R5 @ compara o valor de R1 com R5
                BEQ my_memcpy_end @ sai do loop caso condição se verifique
            ADD R3, #1 @ incrementa o valor do contador
        B my_memcpy_loop @ executa o loop atual de novamente
    
    my_memcpy_end:
        BX LR @ sair do loop

_exit:
    MOV R7, #1 @ R7 = número syscall para sair
    SVC #0 @ invocar syscall

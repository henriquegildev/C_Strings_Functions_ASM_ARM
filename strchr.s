@ Função: strchr
@ Descrição: Encontra a primeira ocorrencia de caractere
@ Autores: Gabriel Gomes | Henrique Gil
@ Input:
@   R0 -> result_strcat
@   R1 -> str1_strchr
@   R2 -> str2_strchr

.data
.balign 4
str1_strchr: .asciz "ThisString.restsuponthee" @ define o valor da string 1
.balign 4  
str2_strchr: .ascii "." @ define o valor da string 2
.balign 4
out_strchr: .asciz "strchr: %s \n" @ define o valor inicial do resultado
.balign 4
funcDesc: .asciz "[ STRCHR ] -> Searches for the first occurrence of a character in the string pointed to by the argument str \n"


.section .text
.global main
.global printf
.arm

main:
    LDR R0, =funcDesc
    BL printf

    LDR R1, =str1_strchr @ atribui o valor do str1_strcat ao registo R1
    LDR R2, =str2_strchr @ atribui o valor do str2_strcat ao registo R2
    LDRB R2, [R2]

    BL my_strchr @ executa a função my_strchr
    MOV R1, R0 @ move o valor contido em R0 para R1
    LDR R0, =out_strchr @ carrega o valor da out_strchr para o registo R0
    BL printf @ mostra o resultado

    B _exit @ para a execução do script

my_strchr:
    MOV R3, #0 @contador global
    my_strchr_loop:
        LDRB R4, [R1, R3] @ carrega o caractere atual da string para R4
        CMP R4, R2 @ compara R4 com R2
            ADDEQ R0, R1, R3 @ coloca a soma de R1 com R3 em R0 caso a condição se verifique
            BEQ my_strchr_end @ sai do loop caso condição se verifique
        ADD R3, #1 @ incrementa o valor do contador 
    B my_strchr_loop @ executa o loop atual de novamente

    my_strchr_end:
        BX LR @ sai do loop

_exit:
    MOV R7, #1 @ R7 = número syscall para sair
    SVC #0 @ invocar syscall

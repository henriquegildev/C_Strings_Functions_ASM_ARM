@ Função: strstr
@ Descrição: Encontra a primeira ocorrencia de uma string numa string
@ Autores: Gabriel Gomes | Henrique Gil
@ Input:
@   R1 -> str1_strstr
@   R2 -> str2_strstr

.data
.balign 4
str1_strstr: .asciz "F1nd word1 word1.com" @ define o valor da string 1
.balign 4
str2_strstr: .asciz "word1"  @ define o valor da string 2 
.balign 4
out_strstr: .asciz "strstr: %s\n" @ define o output


.section .text
.global main
.arm

main: 
    LDR R1, =str1_strstr @ atribui o valor do str1_strncpy ao registo R1
    LDR R2, =str2_strstr @ atribui o valor do str2_strncpy ao registo R2
    BL my_strstr @ executa a função my_strstr

    MOV R1, R0 @ move o valor contido em R0 para R1
    LDR R0, =out_strstr @ carrega o valor da string out_strncpy para o registo R0
    BL printf @ mostra o resultado
    B _exit @ para a execução do script

my_strstr:
    LDRB R4, [R2]
    MOV R8, #0 
    strstr_loop:
        LDRB R3, [R1, R8] 
        CMP R3, #0 
            MOVEQ R0, #0
            BEQ strstr_loop_end 
        CMP R3, R4 
            BEQ strstr_found
        ADD R8, #1
    B strstr_loop @ executa o loop atual de novamente

strstr_found:
    MOV R10, #0 
    MOV R9, R8
    strstr_loop2:
        LDRB R6, [R2, R10]
        LDRB R3, [R1, R9]
        CMP R6, #0 
            ADDEQ R8, R1 
            MOVEQ R0, R8 
            BEQ strstr_loop_end  
        CMP R3, R6 
            ADDNE R8, #1 
            BNE strstr_loop   
        ADD R10, #1 
        ADD R9, #1 
    B strstr_loop2 @ executa o loop atual de novamente
        
    strstr_loop_end:
        BX LR @ sai do loop

_exit:
    MOV R7, #1 @ R7 = número syscall para sair
    SVC #0 @ invocar syscall


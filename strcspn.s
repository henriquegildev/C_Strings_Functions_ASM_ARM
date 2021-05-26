@ Função: strcspn
@ Descrição: Encontra um dos caracteres numa string
@ Autores: Gabriel Gomes | Henrique Gil
@ Input:
@   R1 -> str1_strcspn
@   R2 -> str2_strcspn

.data
.balign 4
str1_strcspn: .asciz "ABCDEF4960910"
.balign 4
str2_strcspn: .asciz "013"
.balign 4
out_strcspn: .asciz "strcspn: %d\n"

.section .text
.global main
.arm

main:
    LDR R1, =str1_strcspn
    LDR R2, =str2_strcspn
    BL my_strcspn
    
    MOV R1, R0
    LDR R0, =out_strcspn
    BL printf

    B _exit

my_strcspn:
    MOV R3, #0 @ dar reset ao contador
    my_strcspn_loop:
        MOV R5, #0 @ dar reset ao contador  
        LDRB R4, [R2, R3] @ carrega o caractere atual de R2 para R4
        CMP R4, #0 @ compara o caractere da string com null
            BEQ my_strcspn_loop_end @ sai do loop caso condição se verifique
            BNE my_strcspn_check_value_loop @ executa o loop 2 caso a condição não se verifique
        ADD R3, #1 @ incrementa o valor do contador
    B my_strcspn_loop  @ executa o loop atual de novamente

    my_strcspn_check_value_loop:
        LDRB R6, [R1, R5] @ carrega o caractere atual de R1 para R6
        CMP R6, #0 @ compara o caractere da string com null
            MOVEQ R0, #0 @ reset a R0 caso a condição se verifique
            BEQ my_strcspn_loop_end @ sai do loop caso condição se verifique
        CMP R4, R6 @ compara o valor de R4 com R6
            MOVEQ R0, R5 @ passa o conteudo de R5 para R0 caso a condição se verifique
            BEQ my_strcspn_loop_end @ sai do loop caso condição se verifique
        ADD R5, #1 @ incrementa o valor do contador
    B my_strcspn_check_value_loop @ executa o loop atual de novamente

    my_strcspn_loop_end:
        BX LR @ sair do loop

_exit:
    MOV R7, #1 @ R7 = número syscall para sair
    SVC #0 @ invocar syscall

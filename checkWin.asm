; NASM, x86_64 Windows Assembly
; checkWin.asm


global checkWin

extern board
extern player1
extern player2
extern TerminateProcess

section .data

section .rdata

section .bss

section .text

checkWin: ; void checkWin(void)
    push r11
    push r12
    push r13
    push rsi
    push rdi
    push rbx

    lea rsi, [rel player1]
    lea rdi, [rel player2]
    mov sil, byte [rsi]
    mov dil, byte [rdi]

    lea r11, [rel board]

    mov rbx, 0 ; i = 0

firstRow:
    cmp rbx, 3 
    jae failRow ; if (i < 3) continue; else goto failRow

    mov r12, 0 ; give offset along files 
    mov r13, rbx ; preserves rbx
    lea r13, [r13*2 + r13] ; gives offset along lines
    add r12, r13 ; computes full offset
    add r12, r11 ; computes memory adress 
    cmp byte [r12], sil
    jne failRow
    
    mov r12, 1 ; give offset along files
    mov r13, rbx ; preserves rbx
    lea r13, [r13*2 + r13] ; gives offset along lines
    add r12, r13 ; computes full offset
    add r12, r11 ; computes memory adress
    cmp byte [r12], sil
    jne failRow
     
    mov r12, 2 ; give offset along files
    mov r13, rbx ; preserves rbx
    lea r13, [r13*2 + r13] ; gives offset along lines
    add r12, r13 ; computes full offset
    add r12, r11 ; computes memory adress
    cmp byte [r12], sil
    jne failRow

    add rbx, 1

    jmp firstRow

failRow:
    pop r11
    pop r12
    pop r13
    pop rsi
    pop rdi
    pop rbx

    xor eax, eax
    ret
endif:
    call TerminateProcess


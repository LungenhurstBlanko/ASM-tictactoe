; NASM, x86_64 Windows Assembly
; main.asm


extern printf
extern getchar
extern fetchUserInput
extern printBoard
extern clearConsole
extern gameLoop

global main
global board
global player1
global player2

section .rdata

section .data
board:
    db ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0
player1:
    db 'X'
player2:    
    db 'O'

section .text

main:
return:
    sub rsp, 40
    mov rcx, 'X'
    mov rdx, 'O'
    call gameLoop
    add rsp, 40
    xor eax, eax
    ret

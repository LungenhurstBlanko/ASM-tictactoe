; NASM, x86_64 Windows Assembly
; userinput.asm

global gameLoop

extern fetchUserInput
extern printBoard
extern clearConsole
extern board
extern printf


section .rdata


section .bss


section .data


section .text

gameLoop: ; void gameLoop(char firstPlayer, char secondPlayer)
    push r12
    push r13
    mov r12, rcx
    mov r13, rdx
repeat:
    sub rsp, 40
    call printBoard
    mov rcx, r12
    call fetchUserInput
    add rsp, 40
    xor eax, eax
    pop r13
    pop r12
    ret

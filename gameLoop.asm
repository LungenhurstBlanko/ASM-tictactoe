; NASM, x86_64 Windows Assembly
; gameLoop.asm

global gameLoop

extern fetchUserInput
extern printBoard
extern clearConsole
extern board
extern printf



section .text

gameLoop: ; void gameLoop(char firstPlayer, char secondPlayer)
    push r12
    push r13
    mov r12, rcx
    mov r13, rdx
repeat:
    sub rsp, 40

    call printBoard ; prints board

    mov rcx, r12
    call fetchUserInput ; prints board with prompt

    call printBoard ; prints board

    mov rcx, r13
    call fetchUserInput ; prints board with prompt

    call printBoard

    add rsp, 40

    jmp repeat

    pop r13
    pop r12

    mov eax, eax
    ret


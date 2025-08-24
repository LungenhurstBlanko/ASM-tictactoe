; NASM, x86_64 Windows Assembly
; clearScreen.asm


extern printf

global clearConsole

section .rdata

format:
    db "%s", 
clearScreen:
    db 0x1B, "[3J", 0x1B, "[2J", 0x1B, "[H", 0

section .text

clearConsole: ; void clearConsole(void)
    lea rcx, [rel format]
    lea rdx, [rel clearScreen] ; load string pointers into registers
    sub rsp, 40 ; make windows abi shadow space
    call printf
    add rsp, 40 ; restore shadow space
    xor eax, eax
    ret ; return

; NASM, x86_64 Windows Assembly
; printboard.asm


extern clearConsole
extern printf
extern board

global printBoard

section .rdata

    line db "-----------", 10, 0
    boardPrint db " %c | %c | %c ", 10, 0

section .data

section .text

printBoard: ; void printBoard(void)


  ; push r10
  ; push r11
     
    push rsi
    push rbx
    push r12
    push r13
    push r14
    push r15 ; save registers
    
    sub rsp, 40 
    call clearConsole
    add rsp, 40

    lea rsi, [rel boardPrint] ; makes format string adressible, visual
    lea rbx, [rel board] ; makes raw board char array adressible, functional
    lea r12, [rel line] ; makes line adressible, visual
    mov r13, rbx
    mov r14, rbx
    mov r15, rbx

    sub rsp, 40 ; makes shadow space for windows abi

  ; add r13, 0
    add r14, 1
    add r15, 2 ; puts each register at offset so it accesses the first 3 cells of board
    mov rcx, rsi
    movzx rdx, byte [r13]
    movzx r8, byte [r14]
    movzx r9, byte [r15] ; prints entire line
    call printf

    mov rcx, r12 ; print ------ line
    call printf

    add r13, 3
    add r14, 3 ; moves each register to the new line
    add r15, 3
    mov rcx, rsi
    movzx rdx, byte [r13]
    movzx r8, byte [r14]
    movzx r9, byte [r15]
    call printf 

    mov rcx, r12
    call printf

    add r13, 3
    add r14, 3
    add r15, 3
    mov rcx, rsi
    movzx rdx, byte [r13]
    movzx r8, byte [r14]
    movzx r9, byte [r15]
    call printf

    add rsp, 40

    pop r15 ; restore saved registers in order
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rsi

    xor eax, eax ; return zero
    ret
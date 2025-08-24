; NASM, x86_64 Windows Assembly
; userinput.asm


global fetchUserInput

extern getchar
extern printf
extern clearConsole
extern printBoard
extern board



section .rdata

    outOfRangePrompt db "Invalid Statement, please choose a valid Number. (1-9)", 10, 0
    debugIndexLog db "%i", 0
    userPrompt db "Player %c, please cast your move. (1-9)", 10, 0

section .data
    
section .text

fetchUserInput: ; void fetchUserInput(char player)
    push rcx
    sub rsp, 40
    call printBoard ; reprint board
    add rsp, 40
failed:
    pop rcx ; moves player into rcx
    mov rdx, rcx ; loads player into scond argument of printf
    push rcx ; pushes rcx for later use
    lea rcx, [rel userPrompt] ; loads up first argument of prinf
    sub rsp, 40
    call printf ; prints user prompt
    call getchar ; fetch one UTF-8 character from the console
    add rsp, 40
    cmp rax, 'q'
    je quit
    sub rax, '0' ; normalises UTF-8 to decimal

    cmp rax, 1
    jb false
    cmp rax, 9
    ja false

true:
    ; changes board index fetched to rcx (1st argument, a char)
    pop rcx
    lea r10, [rel board]
    sub rax, 1 ; makes numbers indexing friendly
    add r10, rax
    mov byte [r10], cl ; changes char in the board array with char in the 1st argument
    jmp endif ; makes sure that fail doesnt execute

false:
    sub rsp, 40 
    call printBoard
    add rsp, 40
    lea rcx, [rel outOfRangePrompt]
    sub rsp, 40
    call printf ; emit user prompt
    add rsp, 40
    jmp failed ; retry function
quit:
    pop rcx
    mov eax, 1
    ret
endif:
    xor eax, eax
    ret
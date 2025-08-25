; NASM, x86_64 Windows Assembly
; userinput.asm


global fetchUserInput

extern getchar
extern printf
extern clearConsole
extern printBoard
extern board
extern ExitProcess



section .rdata

    outOfRangePrompt db "Invalid Statement, please choose a valid Number. (1-9)", 10, 0
    debugIndexLog db "%i", 0
    userPrompt db "Player %c, please cast your move. (1-9)", 10, 0

section .data
    
section .text

fetchUserInput: ; void fetchUserInput(char player)
    push rbx

    mov rbx, rcx
    sub rsp, 40
    call printBoard ; reprint board
    add rsp, 40

failed:

    mov rdx, rbx ; loads player into second argument of printf
    lea rcx, [rel userPrompt] ; loads up first argument of prinf

    sub rsp, 40

    call printf ; prints user prompt

    add rsp, 40

read_char:
    sub rsp, 40

    call getchar

    add rsp, 40

    cmp rax, 13 ; \r
    je read_char

    cmp rax, 10 ; \n
    je read_char

    cmp rax, 'q'
    je quit ; jumps to quit when q is detected

    sub rax, '0' ; normalises UTF-8 to decimal

    cmp rax, 1
    jb false

    cmp rax, 9
    ja false

true:
    ; changes board index fetched to rcx (1st argument, a char)
    lea r10, [rel board]
    sub rax, 1 ; makes numbers indexing friendly
    add r10, rax

    cmp byte [r10], ' '
    jne false

    mov byte [r10], bl; changes char in the board array with char in the 1st argument
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
    pop rbx

    sub rsp, 40

    call clearConsole

    mov rcx, 0
    call ExitProcess

    add rsp, 40

    xor eax, eax

    ret
endif:
    pop rbx

    xor eax, eax
    
    ret 
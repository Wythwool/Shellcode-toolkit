BITS 64
GLOBAL _start
_start:
    call    payload
payload:
    pop     rsi
    mov     rdx, [rsi]
    mov     bl,  [rsi+8]
    lea     rsi, [rsi+16]

    mov     eax, 9
    xor     edi, edi
    mov     rsi, rdx
    mov     edx, 7
    mov     r10d, 0x22
    mov     r8d, -1
    xor     r9d, r9d
    syscall

    mov     rdi, rax
.copy:
    test    rdx, rdx
    jz      .go
    mov     al, [rsi]
    xor     al, bl
    mov     [rdi], al
    inc     rsi
    inc     rdi
    dec     rdx
    jmp     .copy
.go:
    jmp     rax

PAYLOAD:
    incbin  "build/payload.pack"

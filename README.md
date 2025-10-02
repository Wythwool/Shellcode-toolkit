# Shellcode Toolkit — exec / reverse TCP / in‑memory loader (x86_64 Linux)

Pure NASM shellcode with tiny C harness. Minimal comments. For lab VMs.

## Build
```bash
make
```

## Run
```bash
./build/runner build/execve_sh.bin
# edit IP/PORT in shellcode/rev_tcp.asm, then:
make build/rev_tcp.bin && ./build/runner build/rev_tcp.bin
make run_loader
```

## Layout
- `shellcode/execve_sh.asm` — `/bin/sh`
- `shellcode/rev_tcp.asm` — reverse TCP → `/bin/sh`
- `shellcode/memloader.asm` — mmap RWX + XOR decode + jump (expects `build/payload.pack`)
- `harness/h_exec.c` — simple runner
- `tools/pack_payload.py` — packs payload
- `Makefile`

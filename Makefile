NASM=nasm
NASMFLAGS=-f bin -O2 -w+orphan-labels
CC=gcc
CFLAGS=-O2 -fno-stack-protector -z execstack -no-pie

BUILD=build
$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/execve_sh.bin: shellcode/execve_sh.asm | $(BUILD)
	$(NASM) $(NASMFLAGS) $< -o $@

$(BUILD)/rev_tcp.bin: shellcode/rev_tcp.asm | $(BUILD)
	$(NASM) $(NASMFLAGS) $< -o $@

$(BUILD)/payload.pack: $(BUILD)/execve_sh.bin | $(BUILD)
	python3 tools/pack_payload.py -k 0 $< $@

$(BUILD)/memloader.bin: shellcode/memloader.asm $(BUILD)/payload.pack | $(BUILD)
	$(NASM) $(NASMFLAGS) $< -o $@

$(BUILD)/runner: harness/h_exec.c | $(BUILD)
	$(CC) $(CFLAGS) $< -o $@

all: $(BUILD)/execve_sh.bin $(BUILD)/rev_tcp.bin $(BUILD)/memloader.bin $(BUILD)/runner

run_exec: all
	./build/runner build/execve_sh.bin

run_rev: all
	./build/runner build/rev_tcp.bin

run_loader: all
	./build/runner build/memloader.bin

clean:
	rm -rf $(BUILD)

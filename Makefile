AS=nasm
EMU=qemu-system-i386

all: boot


folder: 
	mkdir -p bin

boot: src/x86/boot.asm folder
	$(AS) -f bin src/x86/boot.asm -o bin/boot

run: boot
	$(EMU) -drive format=raw,file=bin/boot

clean:
	rm bin/boot


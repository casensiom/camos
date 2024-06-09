AS=nasm
EMU=qemu-system-i386

all: boot

boot: boot/x86/boot.asm
	$(AS) -f bin boot/x86/boot.asm -o boot/x86/boot

run: boot
	$(EMU) -drive format=raw,file=boot/x86/boot

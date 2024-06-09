[org 0x7C00] ; set the base memory address

mov [BOOT_DRIVE], dl 

mov bp, 0x8000
mov sp, bp

call println

mov  bx, 0x2D
mov  cx, 25
call print_repeat
call println

mov  bx, WELCOME_MSG
call print
call println

mov  bx, 0x2D
mov  cx, 25
call print_repeat
call println


; --- READ ---

mov bx, 0x9000
mov dh, 2
;mov dl, [BOOT_DRIVE]
call disk_read

mov dx, [0x9000]
call print_hex
call println

mov dx, [0x9000 + 512]
call print_hex
call println



jmp  $  ; infinite loop

%include "boot/x86/print.asm"
%include "boot/x86/disk.asm"

WELCOME_MSG: db ' Welcome to CamOS system', 0
BOOT_DRIVE: db 0

times 510 - ($ - $$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface


; bx - [in] value to print
print:
    pusha
    mov ah, 0x0E          ; BIOS function to print character
print_string_loop:
    mov al, [bx]          ; Grab the next char
    cmp al, 0             ; Compare AL with 0 (end of string)
    je print_string_done  ; If 0, end of string
    int 0x10              ; Call BIOS interrupt
    add bx, 1
    jmp print_string_loop ; Repeat for the next character
print_string_done:
    popa
    ret

println:
    pusha
    mov ah, 0x0E          ; BIOS function to print character
    mov al, 0x0D
    int 0x10              ; Call BIOS interrupt
    mov al, 0x0A
    int 0x10              ; Call BIOS interrupt
    popa
    ret

; bl - [in] value to print
; cx - [in] number of repeats
print_repeat:
    pusha
    mov ah, 0x0E          ; BIOS function to print character
print_space_loop:
    mov al, bl
    int 0x10              ; Call BIOS interrupt
    sub cx, 1
    jnz print_space_loop
    popa
    ret

; dx - [in] value to print
print_hex:
    pusha
    mov cx, 0
print_hex_loop:
    cmp cx, 4
    je print_hex_end

    mov ax, dx
    and ax, 0x000F
    shr dx, 4

    add ax, 0x30
    cmp ax, 0x39
    jle print_hex_dump
    add ax, 7

print_hex_dump:
    mov bx, HEX_CONTAINER + 5
    sub bx, cx
    mov [bx], al

    add cx, 1
    jmp print_hex_loop

print_hex_end:
    mov bx, HEX_CONTAINER
    call print

    popa
    ret

HEX_CONTAINER: db '0x0000', 0

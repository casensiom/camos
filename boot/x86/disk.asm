disk_read:
    pusha

    push dx

    mov ah, 0x02 ; BIOS instruction to read disk
    mov al, dh   ; read count
    mov cl, 0x02 ; sector (sector 2)
    mov ch, 0x00 ; cylinder (cyl 0)
    mov dh, 0x00 ; track (head 0)
    ; mov dl, 0 ; drive

    int 0x13

    jc disk_read_error

    pop dx
    cmp al, dh ; check we read the required
    jne disk_read_sector_error
    popa
    ret

    disk_read_error:
    mov bx, DISK_ERROR_MSG
    call print
    call println
    mov dh, ah
    call print_hex
    jmp disk_read_done

    disk_read_sector_error:
    mov bx, SECTOR_ERROR_MSG
    call print

disk_read_done:
    jmp $

DISK_ERROR_MSG: db "Cant read", 0
SECTOR_ERROR_MSG: db "Incorrect number of sectors read", 0

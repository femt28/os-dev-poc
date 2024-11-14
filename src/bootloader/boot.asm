org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main

;
; puts = put string
;   - print string to screen
;   - ds:si points to string
;
puts:
    ; save registers to be modified
    push si
    push ax

.loop: 
    lodsb               ; loads next char in al
    or al, al           ; check null
    jz .done

    mov ah, 0x0e        ; bios interrupt
    int 0x10

    jmp .loop

.done:
    pop ax
    pop si
    ret


main:
    ; setup data segments
    mov ax, 0
    mov ds, ax
    mov es, ax

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00      ;stack grows downwards from memory

    ; print message
    mov si, msg_hello
    call puts

    hlt

.halt:
    jmp .halt


msg_hello: db 'Hello World', ENDL,  0

times 510-($-$$) db 0
dw 0AA55h
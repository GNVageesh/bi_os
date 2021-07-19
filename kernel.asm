[bits 16]                           ;assembler to use 16bits
[org 0x7c00]                        ;address of the bootloader

start:
    xor ax, ax
    mov ds, ax
    mov es, ax                      ;these 3 lines clears the ax, ds, es registry
    mov bx, 0x8000                  ;start address

    mov si, hello_world             ;source index points
    call print_string               ;calling function

    hello_world db 'This is the operating system made by GN Vageesh',13,0      ;string define


;function
print_string:
    mov ah, 0x0E                    ;interrupt handler

.repeat_next_char:

    lodsb                           ;load first character of hello world string
    cmp al, 0
    je .done_print
    int 0x10                        ;call BIOS video interrupt
    jmp .repeat_next_char

.done_print:
    ret

times (510 - ($ - $$)) db 0x00       ;512 bytes
dw 0xAA55                           ;boot signature - tells bios abt the boot components
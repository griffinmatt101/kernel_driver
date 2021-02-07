mov ah, 0x0e ; tty mode
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10 ; don't need to put back in register, just repeat 'l'
mov al, 'o'
int 0x10

jmp $ ; jump to current address -> infinite loop

; padding and magic number 0xaa55
times 510 - ($-$$) db 0
dw 0xaa55

; main file

[org 0x7c00] ; tell assembler offset is bootsector code

; main routine makes sure the parameters are ready then calls function
mov bx, HELLO
call print

call print_nl

mov bx, GOODBYE
call print

call print_nl

mov dx, 0x12fe
call print_hex

; boot hang
jmp $

; include subroutines below hang
%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"

; data
HELLO: 
  db 'Hello, World' , 0

GOODBYE:
  db 'Goodbye', 0

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55

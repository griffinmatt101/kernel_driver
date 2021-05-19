; special registers: cs, ds, ss, es ->
; code, data, stack, and extra

mov ah, 0x0e ; tty mode

mov al, [the_secret]
int 0x10 ; won't work

mov bx, 0x7c0 ; segment is automatically << 4
mov ds, bx
; WARNING: from now on all memory references will be offset by ds implicitly
mov al, [the_secret]
int 0x10

mov al, [es:the_secret]
int 0x10 ; not right, es is currently 0x000

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10

jmp $ ; hang

the_secret:
  db "X"

times 510 - ($$-$) db 0
dw 0xaa55

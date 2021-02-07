[org 0x7c00]
mov ah, 0x0e

; attempt 1
; fails again, still addressing the pointer
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; attempt 2
; this works now because of org
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; attempt 3
; not going to work because that 0x7c00 is added twice
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; attempt 4
; still works because there are no memory references to pointers,
; org mode never applies. Directl addressing memory by counting bytes
; is always going to work, but it's inconvenient
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10

jmp $ ; infinite loop

the_secret:
	; ASCII code 0x58 ('X') is stored just before the zero padding
	db "X"

; zero padding and magic number for bios
times 510-($-$$) db 0
dw 0xaa55

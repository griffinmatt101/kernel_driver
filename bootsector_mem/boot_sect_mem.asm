mov ah, 0x0e

; attempt 1
; Fails because it tries to print the memory address (pointer), not the contents
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; attempt 2
; It tries to print the memory address of 'the_secret' which is the correct way
; However, BIOS places our bootsector binary at adress 0x7c00
; so it needs to be padded
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; attempt 3
; Add BIOS starting offset 0x7c00 to mem address of the X
; and then dereference the contents of that pointer.
; Need help of different register 'bx' because 'mov al, [ax]' is illegal.
; A register can't be used as source and destination for the same command
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; attempt 4
; shortcut attempt since we know X is stored at byte 0x2d in our binary
; smart but ineffective, we don't want to be recounting label offsets each time we change code
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

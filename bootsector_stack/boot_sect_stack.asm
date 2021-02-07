mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; address far away from 0x7c00 so we don't get overwritten
mov sp, bp ; if the stack is empty then sp points to the top

push 'A'
push 'B'
push 'C'

; shows how the stack grows downward
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10

; trying to access [0x8000 now won't work
; can only access top of stack, which at this point is 0x7ffe
mov al, [0x8000]
int 0x10

; recover chars using 'pop'
; can only pop full words so auxilary register is needed
; to manipulate the lower byte
pop bx
mov al, bl
int 0x10 ; prints C

pop bx
mov al, bl
int 0x10 ; prints B

pop bx
mov al, bl
int 0x10 ; prints A

; print object after popping everything off the stack
pop bx
mov al, bl
int 0x10

; data that has been pop'd from stack is garbage now
mov al, [0x8000]
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55

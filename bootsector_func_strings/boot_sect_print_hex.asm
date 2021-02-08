; subroutine

; receiving the data in 'dx'
; example: assume dx=0x1234
print_hex:
  pusha

  mov cx, 0 ; index var

; strategy: get last char of 'dx', convert to ASCII
; Numeric ascii values; '0' (ASCII 0x30) to '9' (ASCII 0x39)
; add 0x30 to byte N
; for alphabetic chars A-F: 'A' (ASCII 0x41) to 'F' (0x46) we'll add 0x40
; move the ASCII byte to correct position on resulting string
hex_loop:
  cmp cx, 4 ; loop 4 times (for int cx = 0; cx < 4; cx++)
  je end

  ; 1) convert last char of 'dx' to ASCII
  mov ax, dx ; use ax as working register
  and ax, 0x000f ; 0x1234 -> 0x0004 by masking first 3 to zeros (and = bitwise)
  add al, 0x30 ; add 0x30 to N to convert it to ASCII "N"
  cmp al, 0x39 ; if > 9, add extra 8 to represent 'A' to 'F'
  jle step2 ; jmp to step2 if cmp is less than
  add al, 7 ; 'A' is ASCII 65 instead of 58, need to add 7

step2:
  ; 2) get correct position of string to place ASCII char
  ; bx <- base address + string length - index of char
  mov bx, HEX_OUT + 5 ; base + length
  sub bx, cx ; index var
  mov [bx], al ; copy ASCII char on 'al' to pos pointed by 'bx'
  ror dx, 4 ; right rotate dx 4 times
            ; 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

  add cx, 1
  jmp hex_loop

end: 
  ; prepare the parameter and call the function
  ; remember that print receieves parameter in 'bx'
  mov bx, HEX_OUT
  call print

  popa
  ret

HEX_OUT:
  db '0x0000', 0 ; reserve memory for our new string

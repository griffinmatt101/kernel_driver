[org 0x7c00] ; offset
  mov bp, 0x8000 ; set stack safely away from us
  mov sp, bp

  mov bx, 0x9000 ; es:bx = 0x0000:0x9000 = 0x09000
  mov dh, 2 ; read 2 sectors
  ; the bios sets 'dl' from our boot disk number
  ; might need to use '-fda' flag
  call disk_load

  mov dx, [0x9000] ; retrieve the first loaded word, 0xdada
  call print_hex

  call print_nl

  mov dx, [0x9000 + 512] ; first word from second loaded sector, 0xface
  call print_hex

  jmp $

%include "../bootsector_func_strings/boot_sect_print.asm"
%include "../bootsector_func_strings/boot_sect_print_hex.asm"
%include "boot_sect_disk.asm"

; magic num
times 510 - ($$-$) db 0
dw 0xaa55

; boot sector = sector 1 of cyl 0 of head 0 of hdd 0
; from now on = sector 2
times 256 dw 0xdada ; sector 2 = 512 bytes
times 256 dw 0xface ; sector 3 = 512 bytes

[org 0x7c00] ; bootsector offset
KERNEL_OFFSET equ 0x1000 ; same one used when linking the kernel

	mov [BOOT_DRIVE], dl ; bios sets us the boot drive in 'dl' on boot
	mov bp, 0x9000
	mov sp, bp

	mov bx, MSG_REAL_MODE
	call print
	call print_nl

	call load_kernel ; read kernel from disk
	call switch_to_pm ; disable interrupts, load gdt, etc
	; finally jumps to 'BEGIN_PM'
	jmp $ ; never executed

%include "../bootsector_func_strings/boot_sect_print.asm"
%include "../bootsector_func_strings/boot_sect_print_hex.asm"
%include "../bootsector_disk/boot_sect_disk.asm"
%include "../32bit-gdt/32bit-gdt.asm"
%include "../32bit-print/32bit-print.asm"
%include "../32bit-switch/32bit-switch.asm"

[bits 16]
load_kernel:
	mov bx, MSG_LOAD_KERNEL
	call print
	call print_nl

	mov bx, KERNEL_OFFSET ; read from disk and store in 0x1000
	mov dh, 2
	mov dl, [BOOT_DRIVE]
	call disk_load
	ret

[bits 32]
BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call print_string_pm
	call KERNEL_OFFSET ; give control to kernel
	jmp $ ; stay here when kernel returns control

BOOT_DRIVE db 0 ; store in memory, 'dl' may get overwritten
MSG_REAL_MODE db "Started in 16 bit Real Mode", 0
MSG_PROT_MODE db "Landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

; padding
times 510 - ($-$$) db 0
dw 0xaa55

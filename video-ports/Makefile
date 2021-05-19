# $@ = target file
# $< = first dependency
# $^ = all dependencies 

# first rule is the one executed when no params are fed into makefile
all: run

# dependencies built as needed
kernel.bin: kernel_entry.0 kernel.0
	ld -m elf_i386 -o $@ -Ttext 0x0 --oformat binary $^ --entry main

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	gcc -m32 -fno-pie --ffreestanding -c $< -o $@

# Rule to disassemble the kernel for debugging
kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

bootsect.bin: bootsect.asm
	nasm $< -f bin -o $@

os-image.bin: bootsect.bin kernel.bin
	cat $^ > $@

run: os-image.bin
	qemu-system-i386 -fda $<

clean:
	rm *.bin *.o *.dis

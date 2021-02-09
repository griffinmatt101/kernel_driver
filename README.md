# Kernel Driver/Kernel Development
### Practice
- Removed sample c code
- Began Kernel Development course
- Created branch for OS development

# OS Development
### Building and Running
- For assembly code: `nasm -fbin assembly_code.asm -o output_file.bin`
- Display output: `qemu-system-x86_64 output_file.bin`
  - On Windows: `qemu-system-x86_64 --nographic --curses output_file.bin`
### Bootsector
- Created a file that's interpreted as a bootable disk by the BIOS
- Worked on bootsector print, memory, stack, and function strings
- Need to review printing hex values
- Need to review segmentation, don't understand
- Might need to test on laptop

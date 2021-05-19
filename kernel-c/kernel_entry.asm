[bits 32]
[extern main] ; define calling point. Must have same name as kernel.c 'main' func
call main ; calls c function. linker will know where it's placed in memory
jmp $

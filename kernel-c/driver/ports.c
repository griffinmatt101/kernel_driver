/**
 * Read a byte from a specified port
 */

unsigned char port_byte_in (unsigned short port) 
{
	unsigned char result;
	/* Inline assembler syntax
 * source and destination registers are switched from nasm
 *
 * '"=a" (result)': set '=' the c variable '(result)' to the value of register eax
 * '"d" (port)': map c variable '(port)' into edx register
 *
 * inputs and outputs are separated by colons
 */

	__asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
	return result;
}

void port_byte_out (unsigned short port, unsigned char data)
{
	/* both registers are mapped to C variables
 * nothing is returned -> no equals '=' in the asm syntax
 * there is a comma since there are two vars in the input area
 * no input vars in return area
 */

	__asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}

unsigned short port_word_in (unsigned short port)
{
	unsigned short result;
	__asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
	return result;
}

void unsigned short port_word_out (unsigned short port, unsigned short data)
{
	__asm("out %%ax, %%dx" : : "a" (data), "d" (port));
}

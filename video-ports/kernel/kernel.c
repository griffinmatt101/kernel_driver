/* force create kernel entry function instead of jumping to kernel.c:0x00 */
void dummy_test_entrypoint() {}

void main()
{
	char* video_memory = (char*) 0xb8000;
	*video_memory = 'X';
}

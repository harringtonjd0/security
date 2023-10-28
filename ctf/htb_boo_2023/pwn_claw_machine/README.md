# Claw Machine (medium pwn)
This binary has NX and stack canaries, and is PIE.  There's a stack overflow vuln and a read_flag() function that will give you the flag, but you need to leak a stack canary and the base address of the executable to successfully exploit. 

There's a format string bug right before the overflow, so leak canary and exe base address with the format string "%21$p%23$p", then overflow to win.

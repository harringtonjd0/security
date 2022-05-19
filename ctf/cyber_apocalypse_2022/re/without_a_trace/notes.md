
- uses ptrace(0), which returns 0 normally but 0xfffffff when being debugged

- uses this val to decode password, so patch binary to remove call to ptrace 

- decoded flag will be stored in local var

x/s $rbp-0x30
0x7fffffffdec0:	"HTB{tr4c3_m3_up_b4_u_g0g0}"


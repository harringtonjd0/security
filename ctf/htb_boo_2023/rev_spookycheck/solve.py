#!/usr/bin/python3.11
import dis

CHECK = bytearray(b'\xe9\xef\xc0V\x8d\x8a\x05\xbe\x8ek\xd9yX\x8b\x89\xd3\x8c\xfa\xdexu\xbe\xdf1\xde\xb6\\')
KEY = b'SUP3RS3CR3TK3Y'

def transform(flag):
    return [(((f+24 & 255)  ^ KEY[i % len(KEY )]) - 74) & 255 for i,f in enumerate(flag)]

#dis.dis(transform)
#print(transform(flag.encode()))

print([int(x) for x in CHECK])

ans = [ chr((((f + 74) & 255) ^ KEY[i % len(KEY)]) - 24) for i,f in enumerate(CHECK)]
print(''.join(ans))

# HTB{mod3rn_pyth0n_byt3c0d3}

#!/usr/bin/python3

from binascii import unhexlify
encoded = '2e313f2702184c5a0b1e321205550e03261b094d5c171f56011904'
encoded = unhexlify(encoded)
known = 'CHTB{'

#key = [encoded[i]^ord(known[i]) for i in range(5)]
key = 'mykey'
length = len(encoded)
print(''.join([chr(encoded[i]^ord(key[i%5])) for i in range(length)]))

# CHTB{u51ng_kn0wn_pl41nt3xt}

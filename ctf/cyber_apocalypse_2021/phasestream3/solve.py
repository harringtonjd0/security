#!/usr/bin/python3

from binascii import unhexlify

#from Crypto.Cipher import AES
#from Crypto.Util import Counter
#import os

#KEY = os.urandom(16)

#def encrypt(plaintext):
#    cipher = AES.new(KEY, AES.MODE_CTR, counter=Counter.new(128))
#    ciphertext = cipher.encrypt(plaintext)
#    return ciphertext.hex()


p1 = "No right of private conversation was enumerated in the Constitution. I don't suppose it occurred to anyone at the time that it could be prevented."

c1 = '464851522838603926f4422a4ca6d81b02f351b454e6f968a324fcc77da30cf979eec57c8675de3bb92f6c21730607066226780a8d4539fcf67f9f5589d150a6c7867140b5a63de2971dc209f480c270882194f288167ed910b64cf627ea6392456fa1b648afd0b239b59652baedc595d4f87634cf7ec4262f8c9581d7f56dc6f836cfe696518ce434ef4616431d4d1b361c'

c2 = '4b6f25623a2d3b3833a8405557e7e83257d360a054c2ea'

# XOR p1 and c1 to get keystream, then xor keystream with c2
p1 = [ ord(p1[i]) for i in range(len(p1))]
c1 = unhexlify(c1)
c2 = unhexlify(c2)

stream = [p1[i]^c1[i] for i in range(len(p1))]

test = [chr(stream[i] ^ c2[i]) for i in range(len(c2))]
print(''.join(test))
# CHTB{r3u53d_k3Y_4TT4cK}


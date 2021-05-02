#!/usr/bin/python3
from Crypto.Cipher import AES
from Crypto.Util import Counter
import os

KEY = os.urandom(16)


def encrypt(plaintext):
    cipher = AES.new(KEY, AES.MODE_CTR, counter=Counter.new(128))
    import pdb;pdb.set_trace()
    ciphertext = cipher.encrypt(plaintext)
    return ciphertext.hex()


test = b"No right of private conversation was enumerated in the Constitution. I don't suppose it occurred to anyone at the time that it could be prevented."
print(encrypt(test))
# 464851522838603926f4422a4ca6d81b02f351b454e6f968a324fcc77da30cf979eec57c8675de3bb92f6c21730607066226780a8d4539fcf67f9f5589d150a6c7867140b5a63de2971dc209f480c270882194f288167ed910b64cf627ea6392456fa1b648afd0b239b59652baedc595d4f87634cf7ec4262f8c9581d7f56dc6f836cfe696518ce434ef4616431d4d1b361c

with open('flag.txt', 'rb') as f:
    flag = f.read().strip()
print(encrypt(flag))
#4b6f25623a2d3b3833a8405557e7e83257d360a054c2ea



#!/usr/bin/env python3
from Crypto.Util.number import getPrime, inverse
import random

def main():
    p = getPrime(512)
    q = getPrime(512)
    N = p*q
    phi = (p - 1) * (q - 1)
    e = 0x10001
    d = inverse(e, phi)
    print({'e': e, 'd': d, 'N': N})
    #d2 = int(input("> "))
    d2 = 0
    assert d2 != d
    assert 0 <= d2 < phi
    with open("flag.txt") as f:
        flag = f.read()
    random.seed(str(d2) + flag)
    for _ in range(50):
        m = random.randrange(N)
        print({'m':m})
        c = pow(m, e, N)
        print({'c':c})
        assert m == pow(c, d2, N)
    print(flag)

if __name__ == "__main__":
    import os
    os.chdir(os.path.abspath(os.path.dirname(__file__)))
    main()

#!/usr/bin/python3
from sys import exit
from binascii import unhexlify

with open('output.txt', 'r') as fp:
    # Read line and convert to bytes
    #for line_num in range(10000):
    for line_num in range(10000):
        line = fp.readline().strip()
        first5 = unhexlify(line[:10])
        
        # get single byte xor key
        # xor first 5 bytes of each line with a single byte key
        for key in range(255):
            print(f"[+] Decoding line {line_num}")
            decode = ''.join([ chr(first5[i]^key) for i in range(5) ])
            if decode == 'CHTB{':
                # get key and line of success, then do the full line
                print(f"FOUND IT\nLine {line_num}, xor key {key}")
                line = unhexlify(line)
                flag = ''.join([ chr(line[i]^key) for i in range(len(line)) ])
                print(flag)
                exit()




# CHTB{n33dl3_1n_4_h4yst4ck}

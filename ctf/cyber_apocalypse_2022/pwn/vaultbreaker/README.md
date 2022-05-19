- generates random key with /dev/urandom

- when option 2 is selected, it reads flag.txt and prints out each byte xor'ed with random key byte by byte

- can generate new key of lenght between 0-31, then strcpy is used to copy new key onto old one

- strcpy places a null byte after new key is copied, so the xor doesn't change the original value

- so you can recover the key byte-by-byte with successive connections

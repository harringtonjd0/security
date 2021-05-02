#!/usr/bin/python3

import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server = ('138.68.168.137', 31915)

print("[+] Connecting")

sock.connect(server)
data = sock.recv(1024)
sock.send(b"2")
data = sock.recv(512)
print(data)


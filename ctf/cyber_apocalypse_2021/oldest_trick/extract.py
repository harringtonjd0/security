#!/usr/bin/python3

from scapy.all import *

pcap = rdpcap('icmp_older_trick.pcap')
ping_data = b''

for packet in pcap:
    if packet['IP'].proto == 1:
        if packet['ICMP'].type == 8:
            print(packet.load[16:32])
            ping_data += packet.load[16:32]

with open('extracted_data_no_leading_bytes', 'wb') as fp:
    fp.write(ping_data)


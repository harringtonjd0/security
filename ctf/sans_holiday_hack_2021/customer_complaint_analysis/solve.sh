#!/bin/bash

# The Evil Bit:   a joke from RFC 3514
# Packets with the Reserved bit in the IPv4 header (MSB of ip[6]) set should be considered evil

# In this scenario, all compliant packets have the evil bit set.. any that don't are considered non-compliant
# Print out all packets that don't have the "evil bit" set 
tcpdump -r jackfrosttower-network.pcap "ip[6] & 0x80 != 0x80" -vvnnX

# Grep for packets about 'Room 1024', which is the room number discovered with the first command 
tcpdump -vnnr jackfrosttower-network.pcap | grep name | grep 1024


- identified weird desktop.png which is actually powershell file
- analyzed powershell file, figured out commands and shit
- decrypt text records to get commands and part 1 as net user password

echo -n "JHBhcnQxPSdIVEJ7eTB1X2M0b18n" | base64 -d
$part1='HTB{y0u_c4o_'

- wrote modified powershell script to decrypt domain names
- collected domain names into file 

tcpdump -nnv -r capture.pcap 'udp and dst port 53 and udp[10:2] = 0x0100' | grep windowsliveupdater > filtered_domains.txt

- wrote bash script to consolidate names into output
- decrypted with powershell

$part1='HTB{y0u_c4o_'
$part2=4utom4t3_but_y0u_c4nt_h1de}

//HTB{y0u_c4n_4utom4t3_but_y0u_c4nt_h1de}


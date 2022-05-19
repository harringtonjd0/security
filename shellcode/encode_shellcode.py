
import binascii 

# XOR key to encode shellcode
key = 0xaa

# Read binary shellcode from file
with open('shellcode.bin', 'rb') as fp:
	sc = fp.read()

# Convert to hex string for easier xor
sc = binascii.hexlify(sc)

# Get each byte, convert to int, then xor with key
encoded = [int(sc[i:i+2], 16)^key for i in range(0, len(sc), 2)]

# Convert from int to hex, remove '0x' prefix
encoded = [hex(encoded[i])[2:] for i in range(len(encoded))]

# Add leading zero to any single-digit bytes
for i in range(len(encoded)):
	if len(encoded[i]) != 2:
		encoded[i] = '0' + encoded[i]

# Print to stdout with '\x' prefix for easy pasting into testing.c
print 'Shellcode encoded with key ' + str(key) + ':\n'
print '\"\\x' + '\\x'.join(encoded) + '\";'
print "\nLength: " + str(len(encoded))


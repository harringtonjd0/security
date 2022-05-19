- Takes input from stdin into stack buffer 
- Overflow this buffer and overwrite the last byte admin_panel() return address
- Overwrite with byte 0x12 to redirect to 0x400b12, which calls system(cat flag*)



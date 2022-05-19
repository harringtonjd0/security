- Given 'chall.pyc', which can be decompiled with the tool uncompyle6

- Original script uses marshal.loads to instantiate several lambda functions with Python bytecode

- You can use the dis library to disassemble the bytecode for these functions

- The function a3 contains the flag.  You can see this in the bytecode or by calling the function - it takes an integer argument and returns a character from the flag of index n/5


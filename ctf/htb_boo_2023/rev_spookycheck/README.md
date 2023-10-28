# Spooky Check (medium reversing)

This was a fun one, you were provided a 'check.pyc' file that takes a flag as input, encodes it, and checks against a static value in the script to verify the flag is correct. 

The pyc is compiled with Python 3.11, so none of the usual python decompilers will be able to recover the source.  To solve, you had to:

1. Install python 3.11
2. Disassemble the bytecode from the pyc
  - I did this by dropping into a python3.11 repl, importing check.pyc, reading the file header, then reading in the actual bytecode, then disassembling the module with dis.dis

3. Manually recover the source by reading through the bytecode, writing a separate script to match it, then disassembling the solver script to make sure they match.  

4. Once you have the source worked out, walk backwards through the encoding algo to recover the original flag

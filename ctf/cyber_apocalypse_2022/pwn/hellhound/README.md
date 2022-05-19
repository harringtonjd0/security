
- Option 1 prints address of stack buffer, Option 2 writes to a ptr stored on the stack, Option 3 reads data from heap buffer and moves it to the stack

- So get the stack addr, then calculate the location of the main function's return address (stack addr + 0x50)

- Write this address to the heap buffer pointed to by a stack pointer, appended to 8 bytes of filler 

- Option 3 to move this address from the heap to the stack, overwriting the heap ptr with the ptr to the return address

- Option 2 to write to the pointer, which will overwrite the return address

- Overwrite with the addr to berserk_mode_off(), which calls sytem()

- Append a null pointer to this address and then use option 3 to overwrite the ptr to the return addr with a null pointer, so when free() is called it doesn't do anything

- Use option 69 to execute free(NULL) and then return to berserk_mode_off()

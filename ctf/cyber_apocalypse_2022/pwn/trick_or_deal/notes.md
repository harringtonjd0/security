- PIE is enabled, but you can leak base of the exe in the same way as sp_retribution (option 2)

- option 1 (print weaponry) will execute the function pointer located at the end of the original heap buffer (use after free)

- so free the heap buffer allocated at startup, then alloc a slightly larger buffer 

- write to the new buffer and overwrite the original function pointer with a pointer to unlock_storage(), which calls system()

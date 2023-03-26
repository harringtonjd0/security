
void:     file format elf64-x86-64


Disassembly of section .interp:

00000000004002a8 <.interp>:
  4002a8:	2e 2f                	cs (bad) 
  4002aa:	67 6c                	ins    BYTE PTR es:[edi],dx
  4002ac:	69 62 63 2f 6c 64 2d 	imul   esp,DWORD PTR [rdx+0x63],0x2d646c2f
  4002b3:	6c                   	ins    BYTE PTR es:[rdi],dx
  4002b4:	69 6e 75 78 2d 78 38 	imul   ebp,DWORD PTR [rsi+0x75],0x38782d78
  4002bb:	36 2d 36 34 2e 73    	ss sub eax,0x732e3436
  4002c1:	6f                   	outs   dx,DWORD PTR ds:[rsi]
  4002c2:	2e 32 00             	xor    al,BYTE PTR cs:[rax]

Disassembly of section .note.gnu.build-id:

00000000004002c8 <.note.gnu.build-id>:
  4002c8:	04 00                	add    al,0x0
  4002ca:	00 00                	add    BYTE PTR [rax],al
  4002cc:	14 00                	adc    al,0x0
  4002ce:	00 00                	add    BYTE PTR [rax],al
  4002d0:	03 00                	add    eax,DWORD PTR [rax]
  4002d2:	00 00                	add    BYTE PTR [rax],al
  4002d4:	47                   	rex.RXB
  4002d5:	4e 55                	rex.WRX push rbp
  4002d7:	00 a5 a2 9f 47 fb    	add    BYTE PTR [rbp-0x4b8605e],ah
  4002dd:	ee                   	out    dx,al
  4002de:	ef                   	out    dx,eax
  4002df:	f8                   	clc    
  4002e0:	63 52 2a             	movsxd edx,DWORD PTR [rdx+0x2a]
  4002e3:	cf                   	iret   
  4002e4:	f8                   	clc    
  4002e5:	38 63 6b             	cmp    BYTE PTR [rbx+0x6b],ah
  4002e8:	57                   	push   rdi
  4002e9:	d1 c2                	rol    edx,1
  4002eb:	13                   	.byte 0x13

Disassembly of section .note.ABI-tag:

00000000004002ec <.note.ABI-tag>:
  4002ec:	04 00                	add    al,0x0
  4002ee:	00 00                	add    BYTE PTR [rax],al
  4002f0:	10 00                	adc    BYTE PTR [rax],al
  4002f2:	00 00                	add    BYTE PTR [rax],al
  4002f4:	01 00                	add    DWORD PTR [rax],eax
  4002f6:	00 00                	add    BYTE PTR [rax],al
  4002f8:	47                   	rex.RXB
  4002f9:	4e 55                	rex.WRX push rbp
  4002fb:	00 00                	add    BYTE PTR [rax],al
  4002fd:	00 00                	add    BYTE PTR [rax],al
  4002ff:	00 03                	add    BYTE PTR [rbx],al
  400301:	00 00                	add    BYTE PTR [rax],al
  400303:	00 02                	add    BYTE PTR [rdx],al
  400305:	00 00                	add    BYTE PTR [rax],al
  400307:	00 00                	add    BYTE PTR [rax],al
  400309:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .gnu.hash:

0000000000400310 <.gnu.hash>:
  400310:	01 00                	add    DWORD PTR [rax],eax
  400312:	00 00                	add    BYTE PTR [rax],al
  400314:	01 00                	add    DWORD PTR [rax],eax
  400316:	00 00                	add    BYTE PTR [rax],al
  400318:	01 00                	add    DWORD PTR [rax],eax
	...

Disassembly of section .dynsym:

0000000000400330 <.dynsym>:
	...
  400348:	01 00                	add    DWORD PTR [rax],eax
  40034a:	00 00                	add    BYTE PTR [rax],al
  40034c:	12 00                	adc    al,BYTE PTR [rax]
	...
  40035e:	00 00                	add    BYTE PTR [rax],al
  400360:	06                   	(bad)  
  400361:	00 00                	add    BYTE PTR [rax],al
  400363:	00 12                	add    BYTE PTR [rdx],dl
	...
  400375:	00 00                	add    BYTE PTR [rax],al
  400377:	00 37                	add    BYTE PTR [rdi],dh
  400379:	00 00                	add    BYTE PTR [rax],al
  40037b:	00 20                	add    BYTE PTR [rax],ah
	...

Disassembly of section .dynstr:

0000000000400390 <.dynstr>:
  400390:	00 72 65             	add    BYTE PTR [rdx+0x65],dh
  400393:	61                   	(bad)  
  400394:	64 00 5f 5f          	add    BYTE PTR fs:[rdi+0x5f],bl
  400398:	6c                   	ins    BYTE PTR es:[rdi],dx
  400399:	69 62 63 5f 73 74 61 	imul   esp,DWORD PTR [rdx+0x63],0x6174735f
  4003a0:	72 74                	jb     400416 <_init-0xbea>
  4003a2:	5f                   	pop    rdi
  4003a3:	6d                   	ins    DWORD PTR es:[rdi],dx
  4003a4:	61                   	(bad)  
  4003a5:	69 6e 00 6c 69 62 63 	imul   ebp,DWORD PTR [rsi+0x0],0x6362696c
  4003ac:	2e 73 6f             	cs jae 40041e <_init-0xbe2>
  4003af:	2e 36 00 47 4c       	cs add BYTE PTR ss:[rdi+0x4c],al
  4003b4:	49                   	rex.WB
  4003b5:	42                   	rex.X
  4003b6:	43 5f                	rex.XB pop r15
  4003b8:	32 2e                	xor    ch,BYTE PTR [rsi]
  4003ba:	32 2e                	xor    ch,BYTE PTR [rsi]
  4003bc:	35 00 2e 2f 67       	xor    eax,0x672f2e00
  4003c1:	6c                   	ins    BYTE PTR es:[rdi],dx
  4003c2:	69 62 63 2f 00 5f 5f 	imul   esp,DWORD PTR [rdx+0x63],0x5f5f002f
  4003c9:	67 6d                	ins    DWORD PTR es:[edi],dx
  4003cb:	6f                   	outs   dx,DWORD PTR ds:[rsi]
  4003cc:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  4003cd:	5f                   	pop    rdi
  4003ce:	73 74                	jae    400444 <_init-0xbbc>
  4003d0:	61                   	(bad)  
  4003d1:	72 74                	jb     400447 <_init-0xbb9>
  4003d3:	5f                   	pop    rdi
  4003d4:	5f                   	pop    rdi
	...

Disassembly of section .gnu.version:

00000000004003d6 <.gnu.version>:
  4003d6:	00 00                	add    BYTE PTR [rax],al
  4003d8:	02 00                	add    al,BYTE PTR [rax]
  4003da:	02 00                	add    al,BYTE PTR [rax]
  4003dc:	01 00                	add    DWORD PTR [rax],eax

Disassembly of section .gnu.version_r:

00000000004003e0 <.gnu.version_r>:
  4003e0:	01 00                	add    DWORD PTR [rax],eax
  4003e2:	01 00                	add    DWORD PTR [rax],eax
  4003e4:	18 00                	sbb    BYTE PTR [rax],al
  4003e6:	00 00                	add    BYTE PTR [rax],al
  4003e8:	10 00                	adc    BYTE PTR [rax],al
  4003ea:	00 00                	add    BYTE PTR [rax],al
  4003ec:	00 00                	add    BYTE PTR [rax],al
  4003ee:	00 00                	add    BYTE PTR [rax],al
  4003f0:	75 1a                	jne    40040c <_init-0xbf4>
  4003f2:	69 09 00 00 02 00    	imul   ecx,DWORD PTR [rcx],0x20000
  4003f8:	22 00                	and    al,BYTE PTR [rax]
  4003fa:	00 00                	add    BYTE PTR [rax],al
  4003fc:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .rela.dyn:

0000000000400400 <.rela.dyn>:
  400400:	f0 31 40 00          	lock xor DWORD PTR [rax+0x0],eax
  400404:	00 00                	add    BYTE PTR [rax],al
  400406:	00 00                	add    BYTE PTR [rax],al
  400408:	06                   	(bad)  
  400409:	00 00                	add    BYTE PTR [rax],al
  40040b:	00 02                	add    BYTE PTR [rdx],al
	...
  400415:	00 00                	add    BYTE PTR [rax],al
  400417:	00 f8                	add    al,bh
  400419:	31 40 00             	xor    DWORD PTR [rax+0x0],eax
  40041c:	00 00                	add    BYTE PTR [rax],al
  40041e:	00 00                	add    BYTE PTR [rax],al
  400420:	06                   	(bad)  
  400421:	00 00                	add    BYTE PTR [rax],al
  400423:	00 03                	add    BYTE PTR [rbx],al
	...

Disassembly of section .rela.plt:

0000000000400430 <.rela.plt>:
  400430:	18 40 40             	sbb    BYTE PTR [rax+0x40],al
  400433:	00 00                	add    BYTE PTR [rax],al
  400435:	00 00                	add    BYTE PTR [rax],al
  400437:	00 07                	add    BYTE PTR [rdi],al
  400439:	00 00                	add    BYTE PTR [rax],al
  40043b:	00 01                	add    BYTE PTR [rcx],al
	...

Disassembly of section .init:

0000000000401000 <_init>:
  401000:	48 83 ec 08          	sub    rsp,0x8
  401004:	48 8b 05 ed 21 00 00 	mov    rax,QWORD PTR [rip+0x21ed]        # 4031f8 <__gmon_start__@Base>
  40100b:	48 85 c0             	test   rax,rax
  40100e:	74 02                	je     401012 <_init+0x12>
  401010:	ff d0                	call   rax
  401012:	48 83 c4 08          	add    rsp,0x8
  401016:	c3                   	ret    

Disassembly of section .plt:

0000000000401020 <read@plt-0x10>:
  401020:	ff 35 e2 2f 00 00    	push   QWORD PTR [rip+0x2fe2]        # 404008 <_GLOBAL_OFFSET_TABLE_+0x8>
  401026:	ff 25 e4 2f 00 00    	jmp    QWORD PTR [rip+0x2fe4]        # 404010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40102c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401030 <read@plt>:
  401030:	ff 25 e2 2f 00 00    	jmp    QWORD PTR [rip+0x2fe2]        # 404018 <read@GLIBC_2.2.5>
  401036:	68 00 00 00 00       	push   0x0
  40103b:	e9 e0 ff ff ff       	jmp    401020 <_init+0x20>

Disassembly of section .text:

0000000000401040 <_start>:
  401040:	31 ed                	xor    ebp,ebp
  401042:	49 89 d1             	mov    r9,rdx
  401045:	5e                   	pop    rsi
  401046:	48 89 e2             	mov    rdx,rsp
  401049:	48 83 e4 f0          	and    rsp,0xfffffffffffffff0
  40104d:	50                   	push   rax
  40104e:	54                   	push   rsp
  40104f:	49 c7 c0 c0 11 40 00 	mov    r8,0x4011c0
  401056:	48 c7 c1 60 11 40 00 	mov    rcx,0x401160
  40105d:	48 c7 c7 43 11 40 00 	mov    rdi,0x401143
  401064:	ff 15 86 21 00 00    	call   QWORD PTR [rip+0x2186]        # 4031f0 <__libc_start_main@GLIBC_2.2.5>
  40106a:	f4                   	hlt    
  40106b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]

0000000000401070 <_dl_relocate_static_pie>:
  401070:	c3                   	ret    
  401071:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  401078:	00 00 00 
  40107b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]

0000000000401080 <deregister_tm_clones>:
  401080:	b8 30 40 40 00       	mov    eax,0x404030
  401085:	48 3d 30 40 40 00    	cmp    rax,0x404030
  40108b:	74 13                	je     4010a0 <deregister_tm_clones+0x20>
  40108d:	b8 00 00 00 00       	mov    eax,0x0
  401092:	48 85 c0             	test   rax,rax
  401095:	74 09                	je     4010a0 <deregister_tm_clones+0x20>
  401097:	bf 30 40 40 00       	mov    edi,0x404030
  40109c:	ff e0                	jmp    rax
  40109e:	66 90                	xchg   ax,ax
  4010a0:	c3                   	ret    
  4010a1:	66 66 2e 0f 1f 84 00 	data16 nop WORD PTR cs:[rax+rax*1+0x0]
  4010a8:	00 00 00 00 
  4010ac:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

00000000004010b0 <register_tm_clones>:
  4010b0:	be 30 40 40 00       	mov    esi,0x404030
  4010b5:	48 81 ee 30 40 40 00 	sub    rsi,0x404030
  4010bc:	48 89 f0             	mov    rax,rsi
  4010bf:	48 c1 ee 3f          	shr    rsi,0x3f
  4010c3:	48 c1 f8 03          	sar    rax,0x3
  4010c7:	48 01 c6             	add    rsi,rax
  4010ca:	48 d1 fe             	sar    rsi,1
  4010cd:	74 11                	je     4010e0 <register_tm_clones+0x30>
  4010cf:	b8 00 00 00 00       	mov    eax,0x0
  4010d4:	48 85 c0             	test   rax,rax
  4010d7:	74 07                	je     4010e0 <register_tm_clones+0x30>
  4010d9:	bf 30 40 40 00       	mov    edi,0x404030
  4010de:	ff e0                	jmp    rax
  4010e0:	c3                   	ret    
  4010e1:	66 66 2e 0f 1f 84 00 	data16 nop WORD PTR cs:[rax+rax*1+0x0]
  4010e8:	00 00 00 00 
  4010ec:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

00000000004010f0 <__do_global_dtors_aux>:
  4010f0:	80 3d 39 2f 00 00 00 	cmp    BYTE PTR [rip+0x2f39],0x0        # 404030 <__TMC_END__>
  4010f7:	75 17                	jne    401110 <__do_global_dtors_aux+0x20>
  4010f9:	55                   	push   rbp
  4010fa:	48 89 e5             	mov    rbp,rsp
  4010fd:	e8 7e ff ff ff       	call   401080 <deregister_tm_clones>
  401102:	c6 05 27 2f 00 00 01 	mov    BYTE PTR [rip+0x2f27],0x1        # 404030 <__TMC_END__>
  401109:	5d                   	pop    rbp
  40110a:	c3                   	ret    
  40110b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  401110:	c3                   	ret    
  401111:	66 66 2e 0f 1f 84 00 	data16 nop WORD PTR cs:[rax+rax*1+0x0]
  401118:	00 00 00 00 
  40111c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401120 <frame_dummy>:
  401120:	eb 8e                	jmp    4010b0 <register_tm_clones>

0000000000401122 <vuln>:
  401122:	55                   	push   rbp
  401123:	48 89 e5             	mov    rbp,rsp
  401126:	48 83 ec 40          	sub    rsp,0x40
  40112a:	48 8d 45 c0          	lea    rax,[rbp-0x40]
  40112e:	ba c8 00 00 00       	mov    edx,0xc8
  401133:	48 89 c6             	mov    rsi,rax
  401136:	bf 00 00 00 00       	mov    edi,0x0
  40113b:	e8 f0 fe ff ff       	call   401030 <read@plt>
  401140:	90                   	nop
  401141:	c9                   	leave  
  401142:	c3                   	ret    

0000000000401143 <main>:
  401143:	55                   	push   rbp
  401144:	48 89 e5             	mov    rbp,rsp
  401147:	48 83 ec 10          	sub    rsp,0x10
  40114b:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
  40114e:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
  401152:	e8 cb ff ff ff       	call   401122 <vuln>
  401157:	b8 00 00 00 00       	mov    eax,0x0
  40115c:	c9                   	leave  
  40115d:	c3                   	ret    
  40115e:	66 90                	xchg   ax,ax

0000000000401160 <__libc_csu_init>:
  401160:	41 57                	push   r15
  401162:	4c 8d 3d 97 1e 00 00 	lea    r15,[rip+0x1e97]        # 403000 <__frame_dummy_init_array_entry>
  401169:	41 56                	push   r14
  40116b:	49 89 d6             	mov    r14,rdx
  40116e:	41 55                	push   r13
  401170:	49 89 f5             	mov    r13,rsi
  401173:	41 54                	push   r12
  401175:	41 89 fc             	mov    r12d,edi
  401178:	55                   	push   rbp
  401179:	48 8d 2d 88 1e 00 00 	lea    rbp,[rip+0x1e88]        # 403008 <__do_global_dtors_aux_fini_array_entry>
  401180:	53                   	push   rbx
  401181:	4c 29 fd             	sub    rbp,r15
  401184:	48 83 ec 08          	sub    rsp,0x8
  401188:	e8 73 fe ff ff       	call   401000 <_init>
  40118d:	48 c1 fd 03          	sar    rbp,0x3
  401191:	74 1b                	je     4011ae <__libc_csu_init+0x4e>
  401193:	31 db                	xor    ebx,ebx
  401195:	0f 1f 00             	nop    DWORD PTR [rax]
  401198:	4c 89 f2             	mov    rdx,r14
  40119b:	4c 89 ee             	mov    rsi,r13
  40119e:	44 89 e7             	mov    edi,r12d
  4011a1:	41 ff 14 df          	call   QWORD PTR [r15+rbx*8]
  4011a5:	48 83 c3 01          	add    rbx,0x1
  4011a9:	48 39 dd             	cmp    rbp,rbx
  4011ac:	75 ea                	jne    401198 <__libc_csu_init+0x38>
  4011ae:	48 83 c4 08          	add    rsp,0x8
  4011b2:	5b                   	pop    rbx
  4011b3:	5d                   	pop    rbp
  4011b4:	41 5c                	pop    r12
  4011b6:	41 5d                	pop    r13
  4011b8:	41 5e                	pop    r14
  4011ba:	41 5f                	pop    r15
  4011bc:	c3                   	ret    
  4011bd:	0f 1f 00             	nop    DWORD PTR [rax]

00000000004011c0 <__libc_csu_fini>:
  4011c0:	c3                   	ret    

Disassembly of section .fini:

00000000004011c4 <_fini>:
  4011c4:	48 83 ec 08          	sub    rsp,0x8
  4011c8:	48 83 c4 08          	add    rsp,0x8
  4011cc:	c3                   	ret    

Disassembly of section .rodata:

0000000000402000 <_IO_stdin_used>:
  402000:	01 00                	add    DWORD PTR [rax],eax
  402002:	02 00                	add    al,BYTE PTR [rax]

Disassembly of section .eh_frame_hdr:

0000000000402004 <__GNU_EH_FRAME_HDR>:
  402004:	01 1b                	add    DWORD PTR [rbx],ebx
  402006:	03 3b                	add    edi,DWORD PTR [rbx]
  402008:	40 00 00             	add    BYTE PTR [rax],al
  40200b:	00 07                	add    BYTE PTR [rdi],al
  40200d:	00 00                	add    BYTE PTR [rax],al
  40200f:	00 1c f0             	add    BYTE PTR [rax+rsi*8],bl
  402012:	ff                   	(bad)  
  402013:	ff 9c 00 00 00 3c f0 	call   FWORD PTR [rax+rax*1-0xfc40000]
  40201a:	ff                   	(bad)  
  40201b:	ff 5c 00 00          	call   FWORD PTR [rax+rax*1+0x0]
  40201f:	00 6c f0 ff          	add    BYTE PTR [rax+rsi*8-0x1],ch
  402023:	ff 88 00 00 00 1e    	dec    DWORD PTR [rax+0x1e000000]
  402029:	f1                   	icebp  
  40202a:	ff                   	(bad)  
  40202b:	ff c4                	inc    esp
  40202d:	00 00                	add    BYTE PTR [rax],al
  40202f:	00 3f                	add    BYTE PTR [rdi],bh
  402031:	f1                   	icebp  
  402032:	ff                   	(bad)  
  402033:	ff e4                	jmp    rsp
  402035:	00 00                	add    BYTE PTR [rax],al
  402037:	00 5c f1 ff          	add    BYTE PTR [rcx+rsi*8-0x1],bl
  40203b:	ff 04 01             	inc    DWORD PTR [rcx+rax*1]
  40203e:	00 00                	add    BYTE PTR [rax],al
  402040:	bc f1 ff ff 4c       	mov    esp,0x4cfffff1
  402045:	01 00                	add    DWORD PTR [rax],eax
	...

Disassembly of section .eh_frame:

0000000000402048 <__FRAME_END__-0x11c>:
  402048:	14 00                	adc    al,0x0
  40204a:	00 00                	add    BYTE PTR [rax],al
  40204c:	00 00                	add    BYTE PTR [rax],al
  40204e:	00 00                	add    BYTE PTR [rax],al
  402050:	01 7a 52             	add    DWORD PTR [rdx+0x52],edi
  402053:	00 01                	add    BYTE PTR [rcx],al
  402055:	78 10                	js     402067 <__GNU_EH_FRAME_HDR+0x63>
  402057:	01 1b                	add    DWORD PTR [rbx],ebx
  402059:	0c 07                	or     al,0x7
  40205b:	08 90 01 07 10 10    	or     BYTE PTR [rax+0x10100701],dl
  402061:	00 00                	add    BYTE PTR [rax],al
  402063:	00 1c 00             	add    BYTE PTR [rax+rax*1],bl
  402066:	00 00                	add    BYTE PTR [rax],al
  402068:	d8 ef                	fsubr  st,st(7)
  40206a:	ff                   	(bad)  
  40206b:	ff 2b                	jmp    FWORD PTR [rbx]
  40206d:	00 00                	add    BYTE PTR [rax],al
  40206f:	00 00                	add    BYTE PTR [rax],al
  402071:	00 00                	add    BYTE PTR [rax],al
  402073:	00 14 00             	add    BYTE PTR [rax+rax*1],dl
  402076:	00 00                	add    BYTE PTR [rax],al
  402078:	00 00                	add    BYTE PTR [rax],al
  40207a:	00 00                	add    BYTE PTR [rax],al
  40207c:	01 7a 52             	add    DWORD PTR [rdx+0x52],edi
  40207f:	00 01                	add    BYTE PTR [rcx],al
  402081:	78 10                	js     402093 <__GNU_EH_FRAME_HDR+0x8f>
  402083:	01 1b                	add    DWORD PTR [rbx],ebx
  402085:	0c 07                	or     al,0x7
  402087:	08 90 01 00 00 10    	or     BYTE PTR [rax+0x10000001],dl
  40208d:	00 00                	add    BYTE PTR [rax],al
  40208f:	00 1c 00             	add    BYTE PTR [rax+rax*1],bl
  402092:	00 00                	add    BYTE PTR [rax],al
  402094:	dc ef                	fsub   st(7),st
  402096:	ff                   	(bad)  
  402097:	ff 01                	inc    DWORD PTR [rcx]
  402099:	00 00                	add    BYTE PTR [rax],al
  40209b:	00 00                	add    BYTE PTR [rax],al
  40209d:	00 00                	add    BYTE PTR [rax],al
  40209f:	00 24 00             	add    BYTE PTR [rax+rax*1],ah
  4020a2:	00 00                	add    BYTE PTR [rax],al
  4020a4:	30 00                	xor    BYTE PTR [rax],al
  4020a6:	00 00                	add    BYTE PTR [rax],al
  4020a8:	78 ef                	js     402099 <__GNU_EH_FRAME_HDR+0x95>
  4020aa:	ff                   	(bad)  
  4020ab:	ff 20                	jmp    QWORD PTR [rax]
  4020ad:	00 00                	add    BYTE PTR [rax],al
  4020af:	00 00                	add    BYTE PTR [rax],al
  4020b1:	0e                   	(bad)  
  4020b2:	10 46 0e             	adc    BYTE PTR [rsi+0xe],al
  4020b5:	18 4a 0f             	sbb    BYTE PTR [rdx+0xf],cl
  4020b8:	0b 77 08             	or     esi,DWORD PTR [rdi+0x8]
  4020bb:	80 00 3f             	add    BYTE PTR [rax],0x3f
  4020be:	1a 3b                	sbb    bh,BYTE PTR [rbx]
  4020c0:	2a 33                	sub    dh,BYTE PTR [rbx]
  4020c2:	24 22                	and    al,0x22
  4020c4:	00 00                	add    BYTE PTR [rax],al
  4020c6:	00 00                	add    BYTE PTR [rax],al
  4020c8:	1c 00                	sbb    al,0x0
  4020ca:	00 00                	add    BYTE PTR [rax],al
  4020cc:	58                   	pop    rax
  4020cd:	00 00                	add    BYTE PTR [rax],al
  4020cf:	00 52 f0             	add    BYTE PTR [rdx-0x10],dl
  4020d2:	ff                   	(bad)  
  4020d3:	ff 21                	jmp    QWORD PTR [rcx]
  4020d5:	00 00                	add    BYTE PTR [rax],al
  4020d7:	00 00                	add    BYTE PTR [rax],al
  4020d9:	41 0e                	rex.B (bad) 
  4020db:	10 86 02 43 0d 06    	adc    BYTE PTR [rsi+0x60d4302],al
  4020e1:	5c                   	pop    rsp
  4020e2:	0c 07                	or     al,0x7
  4020e4:	08 00                	or     BYTE PTR [rax],al
  4020e6:	00 00                	add    BYTE PTR [rax],al
  4020e8:	1c 00                	sbb    al,0x0
  4020ea:	00 00                	add    BYTE PTR [rax],al
  4020ec:	78 00                	js     4020ee <__GNU_EH_FRAME_HDR+0xea>
  4020ee:	00 00                	add    BYTE PTR [rax],al
  4020f0:	53                   	push   rbx
  4020f1:	f0 ff                	lock (bad) 
  4020f3:	ff 1b                	call   FWORD PTR [rbx]
  4020f5:	00 00                	add    BYTE PTR [rax],al
  4020f7:	00 00                	add    BYTE PTR [rax],al
  4020f9:	41 0e                	rex.B (bad) 
  4020fb:	10 86 02 43 0d 06    	adc    BYTE PTR [rsi+0x60d4302],al
  402101:	56                   	push   rsi
  402102:	0c 07                	or     al,0x7
  402104:	08 00                	or     BYTE PTR [rax],al
  402106:	00 00                	add    BYTE PTR [rax],al
  402108:	44 00 00             	add    BYTE PTR [rax],r8b
  40210b:	00 98 00 00 00 50    	add    BYTE PTR [rax+0x50000000],bl
  402111:	f0 ff                	lock (bad) 
  402113:	ff 5d 00             	call   FWORD PTR [rbp+0x0]
  402116:	00 00                	add    BYTE PTR [rax],al
  402118:	00 42 0e             	add    BYTE PTR [rdx+0xe],al
  40211b:	10 8f 02 49 0e 18    	adc    BYTE PTR [rdi+0x180e4902],cl
  402121:	8e 03                	mov    es,WORD PTR [rbx]
  402123:	45 0e                	rex.RB (bad) 
  402125:	20 8d 04 45 0e 28    	and    BYTE PTR [rbp+0x280e4504],cl
  40212b:	8c 05 44 0e 30 86    	mov    WORD PTR [rip+0xffffffff86300e44],es        # ffffffff86702f75 <_end+0xffffffff862fef3d>
  402131:	06                   	(bad)  
  402132:	48 0e                	rex.W (bad) 
  402134:	38 83 07 47 0e 40    	cmp    BYTE PTR [rbx+0x400e4707],al
  40213a:	6a 0e                	push   0xe
  40213c:	38 41 0e             	cmp    BYTE PTR [rcx+0xe],al
  40213f:	30 41 0e             	xor    BYTE PTR [rcx+0xe],al
  402142:	28 42 0e             	sub    BYTE PTR [rdx+0xe],al
  402145:	20 42 0e             	and    BYTE PTR [rdx+0xe],al
  402148:	18 42 0e             	sbb    BYTE PTR [rdx+0xe],al
  40214b:	10 42 0e             	adc    BYTE PTR [rdx+0xe],al
  40214e:	08 00                	or     BYTE PTR [rax],al
  402150:	10 00                	adc    BYTE PTR [rax],al
  402152:	00 00                	add    BYTE PTR [rax],al
  402154:	e0 00                	loopne 402156 <__GNU_EH_FRAME_HDR+0x152>
  402156:	00 00                	add    BYTE PTR [rax],al
  402158:	68 f0 ff ff 01       	push   0x1fffff0
  40215d:	00 00                	add    BYTE PTR [rax],al
  40215f:	00 00                	add    BYTE PTR [rax],al
  402161:	00 00                	add    BYTE PTR [rax],al
	...

0000000000402164 <__FRAME_END__>:
  402164:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .init_array:

0000000000403000 <__frame_dummy_init_array_entry>:
  403000:	20 11                	and    BYTE PTR [rcx],dl
  403002:	40 00 00             	add    BYTE PTR [rax],al
  403005:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .fini_array:

0000000000403008 <__do_global_dtors_aux_fini_array_entry>:
  403008:	f0 10 40 00          	lock adc BYTE PTR [rax+0x0],al
  40300c:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .dynamic:

0000000000403010 <_DYNAMIC>:
  403010:	01 00                	add    DWORD PTR [rax],eax
  403012:	00 00                	add    BYTE PTR [rax],al
  403014:	00 00                	add    BYTE PTR [rax],al
  403016:	00 00                	add    BYTE PTR [rax],al
  403018:	18 00                	sbb    BYTE PTR [rax],al
  40301a:	00 00                	add    BYTE PTR [rax],al
  40301c:	00 00                	add    BYTE PTR [rax],al
  40301e:	00 00                	add    BYTE PTR [rax],al
  403020:	1d 00 00 00 00       	sbb    eax,0x0
  403025:	00 00                	add    BYTE PTR [rax],al
  403027:	00 2e                	add    BYTE PTR [rsi],ch
  403029:	00 00                	add    BYTE PTR [rax],al
  40302b:	00 00                	add    BYTE PTR [rax],al
  40302d:	00 00                	add    BYTE PTR [rax],al
  40302f:	00 0c 00             	add    BYTE PTR [rax+rax*1],cl
  403032:	00 00                	add    BYTE PTR [rax],al
  403034:	00 00                	add    BYTE PTR [rax],al
  403036:	00 00                	add    BYTE PTR [rax],al
  403038:	00 10                	add    BYTE PTR [rax],dl
  40303a:	40 00 00             	add    BYTE PTR [rax],al
  40303d:	00 00                	add    BYTE PTR [rax],al
  40303f:	00 0d 00 00 00 00    	add    BYTE PTR [rip+0x0],cl        # 403045 <_DYNAMIC+0x35>
  403045:	00 00                	add    BYTE PTR [rax],al
  403047:	00 c4                	add    ah,al
  403049:	11 40 00             	adc    DWORD PTR [rax+0x0],eax
  40304c:	00 00                	add    BYTE PTR [rax],al
  40304e:	00 00                	add    BYTE PTR [rax],al
  403050:	19 00                	sbb    DWORD PTR [rax],eax
  403052:	00 00                	add    BYTE PTR [rax],al
  403054:	00 00                	add    BYTE PTR [rax],al
  403056:	00 00                	add    BYTE PTR [rax],al
  403058:	00 30                	add    BYTE PTR [rax],dh
  40305a:	40 00 00             	add    BYTE PTR [rax],al
  40305d:	00 00                	add    BYTE PTR [rax],al
  40305f:	00 1b                	add    BYTE PTR [rbx],bl
  403061:	00 00                	add    BYTE PTR [rax],al
  403063:	00 00                	add    BYTE PTR [rax],al
  403065:	00 00                	add    BYTE PTR [rax],al
  403067:	00 08                	add    BYTE PTR [rax],cl
  403069:	00 00                	add    BYTE PTR [rax],al
  40306b:	00 00                	add    BYTE PTR [rax],al
  40306d:	00 00                	add    BYTE PTR [rax],al
  40306f:	00 1a                	add    BYTE PTR [rdx],bl
  403071:	00 00                	add    BYTE PTR [rax],al
  403073:	00 00                	add    BYTE PTR [rax],al
  403075:	00 00                	add    BYTE PTR [rax],al
  403077:	00 08                	add    BYTE PTR [rax],cl
  403079:	30 40 00             	xor    BYTE PTR [rax+0x0],al
  40307c:	00 00                	add    BYTE PTR [rax],al
  40307e:	00 00                	add    BYTE PTR [rax],al
  403080:	1c 00                	sbb    al,0x0
  403082:	00 00                	add    BYTE PTR [rax],al
  403084:	00 00                	add    BYTE PTR [rax],al
  403086:	00 00                	add    BYTE PTR [rax],al
  403088:	08 00                	or     BYTE PTR [rax],al
  40308a:	00 00                	add    BYTE PTR [rax],al
  40308c:	00 00                	add    BYTE PTR [rax],al
  40308e:	00 00                	add    BYTE PTR [rax],al
  403090:	f5                   	cmc    
  403091:	fe                   	(bad)  
  403092:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
  403095:	00 00                	add    BYTE PTR [rax],al
  403097:	00 10                	add    BYTE PTR [rax],dl
  403099:	03 40 00             	add    eax,DWORD PTR [rax+0x0]
  40309c:	00 00                	add    BYTE PTR [rax],al
  40309e:	00 00                	add    BYTE PTR [rax],al
  4030a0:	05 00 00 00 00       	add    eax,0x0
  4030a5:	00 00                	add    BYTE PTR [rax],al
  4030a7:	00 90 03 40 00 00    	add    BYTE PTR [rax+0x4003],dl
  4030ad:	00 00                	add    BYTE PTR [rax],al
  4030af:	00 06                	add    BYTE PTR [rsi],al
  4030b1:	00 00                	add    BYTE PTR [rax],al
  4030b3:	00 00                	add    BYTE PTR [rax],al
  4030b5:	00 00                	add    BYTE PTR [rax],al
  4030b7:	00 30                	add    BYTE PTR [rax],dh
  4030b9:	03 40 00             	add    eax,DWORD PTR [rax+0x0]
  4030bc:	00 00                	add    BYTE PTR [rax],al
  4030be:	00 00                	add    BYTE PTR [rax],al
  4030c0:	0a 00                	or     al,BYTE PTR [rax]
  4030c2:	00 00                	add    BYTE PTR [rax],al
  4030c4:	00 00                	add    BYTE PTR [rax],al
  4030c6:	00 00                	add    BYTE PTR [rax],al
  4030c8:	46 00 00             	rex.RX add BYTE PTR [rax],r8b
  4030cb:	00 00                	add    BYTE PTR [rax],al
  4030cd:	00 00                	add    BYTE PTR [rax],al
  4030cf:	00 0b                	add    BYTE PTR [rbx],cl
  4030d1:	00 00                	add    BYTE PTR [rax],al
  4030d3:	00 00                	add    BYTE PTR [rax],al
  4030d5:	00 00                	add    BYTE PTR [rax],al
  4030d7:	00 18                	add    BYTE PTR [rax],bl
  4030d9:	00 00                	add    BYTE PTR [rax],al
  4030db:	00 00                	add    BYTE PTR [rax],al
  4030dd:	00 00                	add    BYTE PTR [rax],al
  4030df:	00 15 00 00 00 00    	add    BYTE PTR [rip+0x0],dl        # 4030e5 <_DYNAMIC+0xd5>
	...
  4030ed:	00 00                	add    BYTE PTR [rax],al
  4030ef:	00 03                	add    BYTE PTR [rbx],al
	...
  4030f9:	40                   	rex
  4030fa:	40 00 00             	add    BYTE PTR [rax],al
  4030fd:	00 00                	add    BYTE PTR [rax],al
  4030ff:	00 02                	add    BYTE PTR [rdx],al
  403101:	00 00                	add    BYTE PTR [rax],al
  403103:	00 00                	add    BYTE PTR [rax],al
  403105:	00 00                	add    BYTE PTR [rax],al
  403107:	00 18                	add    BYTE PTR [rax],bl
  403109:	00 00                	add    BYTE PTR [rax],al
  40310b:	00 00                	add    BYTE PTR [rax],al
  40310d:	00 00                	add    BYTE PTR [rax],al
  40310f:	00 14 00             	add    BYTE PTR [rax+rax*1],dl
  403112:	00 00                	add    BYTE PTR [rax],al
  403114:	00 00                	add    BYTE PTR [rax],al
  403116:	00 00                	add    BYTE PTR [rax],al
  403118:	07                   	(bad)  
  403119:	00 00                	add    BYTE PTR [rax],al
  40311b:	00 00                	add    BYTE PTR [rax],al
  40311d:	00 00                	add    BYTE PTR [rax],al
  40311f:	00 17                	add    BYTE PTR [rdi],dl
  403121:	00 00                	add    BYTE PTR [rax],al
  403123:	00 00                	add    BYTE PTR [rax],al
  403125:	00 00                	add    BYTE PTR [rax],al
  403127:	00 30                	add    BYTE PTR [rax],dh
  403129:	04 40                	add    al,0x40
  40312b:	00 00                	add    BYTE PTR [rax],al
  40312d:	00 00                	add    BYTE PTR [rax],al
  40312f:	00 07                	add    BYTE PTR [rdi],al
	...
  403139:	04 40                	add    al,0x40
  40313b:	00 00                	add    BYTE PTR [rax],al
  40313d:	00 00                	add    BYTE PTR [rax],al
  40313f:	00 08                	add    BYTE PTR [rax],cl
  403141:	00 00                	add    BYTE PTR [rax],al
  403143:	00 00                	add    BYTE PTR [rax],al
  403145:	00 00                	add    BYTE PTR [rax],al
  403147:	00 30                	add    BYTE PTR [rax],dh
  403149:	00 00                	add    BYTE PTR [rax],al
  40314b:	00 00                	add    BYTE PTR [rax],al
  40314d:	00 00                	add    BYTE PTR [rax],al
  40314f:	00 09                	add    BYTE PTR [rcx],cl
  403151:	00 00                	add    BYTE PTR [rax],al
  403153:	00 00                	add    BYTE PTR [rax],al
  403155:	00 00                	add    BYTE PTR [rax],al
  403157:	00 18                	add    BYTE PTR [rax],bl
  403159:	00 00                	add    BYTE PTR [rax],al
  40315b:	00 00                	add    BYTE PTR [rax],al
  40315d:	00 00                	add    BYTE PTR [rax],al
  40315f:	00 fe                	add    dh,bh
  403161:	ff                   	(bad)  
  403162:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
  403165:	00 00                	add    BYTE PTR [rax],al
  403167:	00 e0                	add    al,ah
  403169:	03 40 00             	add    eax,DWORD PTR [rax+0x0]
  40316c:	00 00                	add    BYTE PTR [rax],al
  40316e:	00 00                	add    BYTE PTR [rax],al
  403170:	ff                   	(bad)  
  403171:	ff                   	(bad)  
  403172:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
  403175:	00 00                	add    BYTE PTR [rax],al
  403177:	00 01                	add    BYTE PTR [rcx],al
  403179:	00 00                	add    BYTE PTR [rax],al
  40317b:	00 00                	add    BYTE PTR [rax],al
  40317d:	00 00                	add    BYTE PTR [rax],al
  40317f:	00 f0                	add    al,dh
  403181:	ff                   	(bad)  
  403182:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
  403185:	00 00                	add    BYTE PTR [rax],al
  403187:	00 d6                	add    dh,dl
  403189:	03 40 00             	add    eax,DWORD PTR [rax+0x0]
	...

Disassembly of section .got:

00000000004031f0 <.got>:
	...

Disassembly of section .got.plt:

0000000000404000 <_GLOBAL_OFFSET_TABLE_>:
  404000:	10 30                	adc    BYTE PTR [rax],dh
  404002:	40 00 00             	add    BYTE PTR [rax],al
	...
  404015:	00 00                	add    BYTE PTR [rax],al
  404017:	00 36                	add    BYTE PTR [rsi],dh
  404019:	10 40 00             	adc    BYTE PTR [rax+0x0],al
  40401c:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .data:

0000000000404020 <__data_start>:
	...

0000000000404028 <__dso_handle>:
	...

Disassembly of section .bss:

0000000000404030 <completed.0>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	47                   	rex.RXB
   1:	43                   	rex.XB
   2:	43 3a 20             	rex.XB cmp spl,BYTE PTR [r8]
   5:	28 44 65 62          	sub    BYTE PTR [rbp+riz*2+0x62],al
   9:	69 61 6e 20 31 30 2e 	imul   esp,DWORD PTR [rcx+0x6e],0x2e303120
  10:	32 2e                	xor    ch,BYTE PTR [rsi]
  12:	31 2d 36 29 20 31    	xor    DWORD PTR [rip+0x31202936],ebp        # 3120294e <_end+0x30dfe916>
  18:	30 2e                	xor    BYTE PTR [rsi],ch
  1a:	32 2e                	xor    ch,BYTE PTR [rsi]
  1c:	31 20                	xor    DWORD PTR [rax],esp
  1e:	32 30                	xor    dh,BYTE PTR [rax]
  20:	32 31                	xor    dh,BYTE PTR [rcx]
  22:	30 31                	xor    BYTE PTR [rcx],dh
  24:	31 30                	xor    DWORD PTR [rax],esi
	...

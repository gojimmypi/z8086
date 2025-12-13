
80186_tests/interrupt.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	ba 00 00             	mov    $0x0,%dx         // dx=0
       3:	8e da                	mov    %dx,%ds          // ds=0  
       5:	bc 00 10             	mov    $0x1000,%sp      // sp=0x1000
       8:	8c d4                	mov    %ss,%sp          // sp=ss=0
       a:	c7 06 34 00 e0 eb    	movw   $0xebe0,0x34     // [0x34]=0xebe0
      10:	c7 06 36 00 42 e3    	movw   $0xe342,0x36     // [0x36]=0xe342
      16:	b8 ff 0e             	mov    $0xeff,%ax       // ax=0xeff
      19:	50                   	push   %ax              
      1a:	9d                   	popf                    // F=0xfeff
      1b:	c6 06 00 00 00       	movb   $0x0,0x0         // [0]=0
      20:	cd 0d                	int    $0xd             // E342:EBE0=F2000
      22:	c6 06 02 00 02       	movb   $0x2,0x2         // [2]=2
      27:	ff e0                	jmp    *%ax

     cd7:	c6 06 03 00 03       	movb   $0x3,0x3
     cdc:	9c                   	pushf
     cdd:	5b                   	pop    %bx
     cde:	c7 06 0c 00 e0 eb    	movw   $0xebe0,0xc
     ce4:	c7 06 0e 00 42 e3    	movw   $0xe342,0xe
     cea:	cd 03                	int    $0x3
     cec:	c6 06 04 00 04       	movb   $0x4,0x4
     cf1:	c7 06 10 00 01 30    	movw   $0x3001,0x10
     cf7:	c7 06 12 00 00 f0    	movw   $0xf000,0x12
     cfd:	ce                   	into
     cfe:	f4                   	hlt

    2000:	c6 06 01 00 01          movb   $0x1,0x1
    2005:	9c                      pushf 
    2006:   58                      pop    %ax
    2007:   f8                      clc
    2008:	cf                   	iret
	
    3001:	c6 06 05 00 05       	movb   $0x5,0x5
    3006:	59                   	pop    %cx
    3007:	b9 02 40             	mov    $0x4002,%cx
    300a:	51                   	push   %cx
    300b:	cf                   	iret
	...
    4000:	00 00                	add    %al,(%bx,%si)
    4002:	c6 06 06 00 06       	movb   $0x6,0x6
    4007:	ba ff 04             	mov    $0x4ff,%dx
    400a:	52                   	push   %dx
    400b:	9d                   	popf
    400c:	c7 06 10 00 00 50    	movw   $0x5000,0x10
    4012:	ce                   	into
    4013:	a3 08 00             	mov    %ax,0x8
    4016:	89 1e 0a 00          	mov    %bx,0xa
    401a:	89 0e 0c 00          	mov    %cx,0xc
    401e:	89 16 0e 00          	mov    %dx,0xe
    4022:	89 26 10 00          	mov    %sp,0x10
    4026:	f4                   	hlt
	...
    4fff:	00 f4                	add    %dh,%ah
	...
    ffed:	00 00                	add    %al,(%bx,%si)
    ffef:	00 eb                	add    %ch,%bl
    fff1:	0e                   	push   %cs
	...
    fffe:	00 ff                	add    %bh,%bh

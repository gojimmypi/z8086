
80186_tests/datatrnf.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	b4 ed                	mov    $0xed,%ah     // ah=0xed
       2:	9e                   	sahf                 // 
       3:	9f                   	lahf                 // AH := {SF:ZF:0:AF:0:PF:1:CF} = 0xc7
       4:	88 26 00 00          	mov    %ah,0x0       // [0]=0xc7
       8:	88 e0                	mov    %ah,%al       // AL=0xc7
       a:	b8 b7 00             	mov    $0xb7,%ax     // ax=0x00b7
       d:	89 c2                	mov    %ax,%dx       // dx=0x00b7
       f:	b4 a5                	mov    $0xa5,%ah     // ax=0xa5b7
      11:	b0 c7                	mov    $0xc7,%al     // ax=0xa5c7
      13:	a3 02 00             	mov    %ax,0x2       // [2]=0xa5c7
      16:	9e                   	sahf                 
      17:	9f                   	lahf                 // ah = 0x87
      18:	a3 20 00             	mov    %ax,0x20      // [0x20]=0x87c7
      1b:	b8 52 f7             	mov    $0xf752,%ax   // ax=0xf752
      1e:	89 c3                	mov    %ax,%bx       // bx=0xf752
      20:	b8 c7 87             	mov    $0x87c7,%ax   // ax=0x87c7
      23:	93                   	xchg   %ax,%bx       // bx=0x87c7, ax=0xf752
      24:	8e d8                	mov    %ax,%ds       // ds=0xf752
      26:	c5 b7 0d 03          	lds    0x30d(%bx),%si // ds=0x5678, si=0x1234
      2a:	b8 00 00             	mov    $0x0,%ax      // ax=0x0
      2d:	8c db                	mov    %ds,%bx       // bx=0x5678
      2f:	8e d8                	mov    %ax,%ds       // ds=0x0
      31:	89 1e 04 00          	mov    %bx,0x4       // [4]=0x5678
      35:	89 36 06 00          	mov    %si,0x6       // [6]=0x1234
      39:	8e db                	mov    %bx,%ds       // ds=0x5678
      3b:	bb ff ff             	mov    $0xffff,%bx   // bx=0xffff
      3e:	b8 00 10             	mov    $0x1000,%ax   // 
      41:	b8 98 57             	mov    $0x5798,%ax   // 
      44:	8e d0                	mov    %ax,%ss       // ss=0x5798
      46:	bc 09 00             	mov    $0x9,%sp      // sp=0x0009
      49:	b9 cd ab             	mov    $0xabcd,%cx   // 
      4c:	51                   	push   %cx           // push cx=0xabcd
      4d:	b9 f1 8c             	mov    $0x8cf1,%cx
      50:	8e c1                	mov    %cx,%es
      52:	06                   	push   %es           // push es=0x8cf1
      53:	9d                   	popf                 // F=0xcd3
      54:	c4 78 d2             	les    -0x2e(%bx,%si),%di    // di=0x8cf1, es=0xabcd
      57:	8d b3 3c fe          	lea    -0x1c4(%bp,%di),%si   // si=0x8b2d
      5b:	9c                   	pushf
      5c:	b8 00 00             	mov    $0x0,%ax
      5f:	8e d8                	mov    %ax,%ds
      61:	89 3e 08 00          	mov    %di,0x8
      65:	8c c0                	mov    %es,%ax
      67:	a3 0a 00             	mov    %ax,0xa
      6a:	89 36 0c 00          	mov    %si,0xc
      6e:	b8 00 10             	mov    $0x1000,%ax        // ax=0x1000
      71:	8e d8                	mov    %ax,%ds            // ds=0x1000
      73:	8f 44 01             	pop    0x1(%si)           // pop flag to [si+1]
      76:	87 78 02             	xchg   %di,0x2(%bx,%si)   // di=0x0cd3, got 0xfcd3
                                                              // bx=0xffff, so this is [si+1]
      79:	ff 70 02             	push   0x2(%bx,%si)       // 
      7c:	07                   	pop    %es
      7d:	8c c2                	mov    %es,%dx
      
      
      7f:	8c d8                	mov    %ds,%ax        // ax=0x1000
      81:	b9 00 00             	mov    $0x0,%cx       // cx=0
      84:	8e d9                	mov    %cx,%ds        // ds=0x0
      86:	89 3e 0e 00          	mov    %di,0xe        // <-- expect 0x0cd3, got 0xfcd3
      8a:	89 16 10 00          	mov    %dx,0x10       // dx=[0x10]=0x8cf1
      8e:	8e d8                	mov    %ax,%ds        // ds=0x1000
      90:	5a                   	pop    %dx
      91:	52                   	push   %dx
      92:	8f c1                	pop    %cx
      94:	87 cb                	xchg   %cx,%bx
      96:	8c d8                	mov    %ds,%ax        // ax=0x1000
      98:	ba 00 00             	mov    $0x0,%dx
      9b:	8e da                	mov    %dx,%ds
      9d:	89 1e 12 00          	mov    %bx,0x12       // bx=[0x12]=0xabcd
      a1:	89 0e 14 00          	mov    %cx,0x14       // cx=[0x14]=0xffff
      a5:	8e d8                	mov    %ax,%ds        // ds=0x1000
      a7:	8c 01                	mov    %es,(%bx,%di)  // [ds:bx+di]=[0x1000:0xabcd+0xcd3]=[0x1b8a0]=0x8cf1
      a9:	bb 00 b8             	mov    $0xb800,%bx    // bx=0xb800
      ac:	b8 a1 a0             	mov    $0xa0a1,%ax    // ax=0xa0a1
      af:	d7                   	xlat   %ds:(%bx)      // AL=8c
      b0:	86 e0                	xchg   %ah,%al        // ax=0x8ca0
      b2:	d7                   	xlat   %ds:(%bx)      // ax=0x8cf1
      b3:	ba 00 00             	mov    $0x0,%dx
      b6:	8e da                	mov    %dx,%ds
      b8:	a3 16 00             	mov    %ax,0x16          // expect 8cf1, got 0
      bb:	ba b7 00             	mov    $0xb7,%dx
      be:	b0 ff                	mov    $0xff,%al
      c0:	b0 f1                	mov    $0xf1,%al
      c2:	a3 18 00             	mov    %ax,0x18          // expect 0x8cf1, got 0x00f1
      c5:	f4                   	hlt
	...
    ffee:	00 00                	add    %al,(%bx,%si)
    fff0:	eb 0e                	jmp    0x10000
    fff2:	00 00                	add    %al,(%bx,%si)
    fff4:	34 12                	xor    $0x12,%al
    fff6:	78 56                	js     0x1004e
    fff8:	00 00                	add    %al,(%bx,%si)
    fffa:	00 00                	add    %al,(%bx,%si)
    fffc:	00 00                	add    %al,(%bx,%si)
    fffe:	00 ff                	add    %bh,%bh

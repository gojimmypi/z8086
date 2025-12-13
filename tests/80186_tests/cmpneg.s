
80186_tests/cmpneg.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	bc 60 00             	mov    $0x60,%sp
       3:	b8 01 00             	mov    $0x1,%ax
       6:	bb 02 00             	mov    $0x2,%bx
       9:	39 d8                	cmp    %bx,%ax
       b:	a3 00 00             	mov    %ax,0x0
       e:	89 1e 02 00          	mov    %bx,0x2
      12:	9c                   	pushf                   // 5e
      13:	ba ff ff             	mov    $0xffff,%dx
      16:	c7 06 04 00 ff ff    	movw   $0xffff,0x4
      1c:	39 16 04 00          	cmp    %dx,0x4
      20:	89 16 06 00          	mov    %dx,0x6
      24:	9c                   	pushf                   // 5c
      25:	b9 ff ff             	mov    $0xffff,%cx
      28:	c7 06 08 00 01 00    	movw   $0x1,0x8
      2e:	39 0e 08 00          	cmp    %cx,0x8
      32:	89 0e 0a 00          	mov    %cx,0xa
      36:	9c                   	pushf                   // 5a
      37:	b8 00 80             	mov    $0x8000,%ax
      3a:	83 f8 01             	cmp    $0x1,%ax
      3d:	a3 0c 00             	mov    %ax,0xc
      40:	9c                   	pushf                   // 58
      41:	bd 00 80             	mov    $0x8000,%bp
      44:	83 fd ff             	cmp    $0xffff,%bp
      47:	89 2e 0e 00          	mov    %bp,0xe
      4b:	9c                   	pushf                   // 56
      4c:	be 81 7f             	mov    $0x7f81,%si
      4f:	81 fe 3c 90          	cmp    $0x903c,%si
      53:	89 36 10 00          	mov    %si,0x10
      57:	9c                   	pushf                   // 54
      58:	c7 06 12 00 c3 ef    	movw   $0xefc3,0x12
      5e:	81 3e 12 00 64 c6    	cmpw   $0xc664,0x12
      64:	9c                   	pushf                   // 52
      65:	c7 06 14 00 33 e9    	movw   $0xe933,0x14
      6b:	83 3e 14 00 64       	cmpw   $0x64,0x14
      70:	9c                   	pushf                   // 50
      71:	c6 06 16 00 01       	movb   $0x1,0x16
      76:	80 3e 16 00 02       	cmpb   $0x2,0x16
      7b:	9c                   	pushf                   // 4e
      7c:	b6 ff                	mov    $0xff,%dh
      7e:	80 fe ff             	cmp    $0xff,%dh
      81:	89 16 17 00          	mov    %dx,0x17
      85:	9c                   	pushf                   // 4c
      86:	b0 ff                	mov    $0xff,%al
      88:	3c 01                	cmp    $0x1,%al
      8a:	a3 19 00             	mov    %ax,0x19
      8d:	9c                   	pushf                   // 4a
      8e:	c6 06 1b 00 80       	movb   $0x80,0x1b
      93:	b5 01                	mov    $0x1,%ch
      95:	3a 2e 1b 00          	cmp    0x1b,%ch
      99:	89 0e 1c 00          	mov    %cx,0x1c
      9d:	9c                   	pushf                   // 48
      9e:	b3 80                	mov    $0x80,%bl
      a0:	c6 06 1e 00 7f       	movb   $0x7f,0x1e
      a5:	38 1e 1e 00          	cmp    %bl,0x1e
      a9:	89 1e 1f 00          	mov    %bx,0x1f
      ad:	9c                   	pushf                   // 46
      ae:	b0 bc                	mov    $0xbc,%al
      b0:	b4 8e                	mov    $0x8e,%ah
      b2:	38 c4                	cmp    %al,%ah
      b4:	a3 21 00             	mov    %ax,0x21
      b7:	9c                   	pushf                   // 44
      b8:	b9 00 00             	mov    $0x0,%cx
      bb:	f7 d9                	neg    %cx
      bd:	89 0e 22 00          	mov    %cx,0x22
      c1:	9c                   	pushf                   // 42
      c2:	c7 06 24 00 ff 7f    	movw   $0x7fff,0x24
      c8:	f7 1e 24 00          	negw   0x24
      cc:	9c                   	pushf                   // 40
      cd:	bd 00 80             	mov    $0x8000,%bp
      d0:	f7 dd                	neg    %bp
      d2:	89 2e 26 00          	mov    %bp,0x26
      d6:	9c                   	pushf                   // 3e
      d7:	c7 06 28 00 e9 ac    	movw   $0xace9,0x28
      dd:	f7 1e 28 00          	negw   0x28
      e1:	9c                   	pushf                   // 3c
      e2:	b4 00                	mov    $0x0,%ah
      e4:	f6 dc                	neg    %ah
      e6:	a3 2a 00             	mov    %ax,0x2a
      e9:	9c                   	pushf                   // 3a
      ea:	c6 06 2c 00 7f       	movb   $0x7f,0x2c
      ef:	f6 1e 2c 00          	negb   0x2c
      f3:	9c                   	pushf                   // 38
      f4:	b1 c9                	mov    $0xc9,%cl
      f6:	f6 d9                	neg    %cl
      f8:	89 0e 2d 00          	mov    %cx,0x2d
      fc:	9c                   	pushf                   // 36
      fd:	c6 06 2f 00 80       	movb   $0x80,0x2f
     102:	f6 1e 2f 00          	negb   0x2f
     106:	9c                   	pushf                   // 34
     107:	f4                   	hlt
	...
    fff0:	eb 0e                	jmp    0x10000
	...
    fffe:	00 ff                	add    %bh,%bh


80186_tests/bitwise.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	b8 59 76             	mov    $0x7659,%ax
       3:	bb b8 4b             	mov    $0x4bb8,%bx
       6:	b9 84 3c             	mov    $0x3c84,%cx
       9:	c7 06 00 00 76 1b    	movw   $0x1b76,0x0
       f:	c7 06 02 00 0b 24    	movw   $0x240b,0x2
      15:	bc 00 01             	mov    $0x100,%sp
      18:	21 c3                	and    %ax,%bx
      1a:	9c                   	pushf
      1b:	89 1e 20 00          	mov    %bx,0x20
      1f:	23 0e 02 00          	and    0x2,%cx
      23:	9c                   	pushf
      24:	89 0e 22 00          	mov    %cx,0x22
      28:	21 0e 00 00          	and    %cx,0x0
      2c:	9c                   	pushf
      2d:	25 71 45             	and    $0x4571,%ax
      30:	9c                   	pushf
      31:	a3 24 00             	mov    %ax,0x24
      34:	81 e3 e9 27          	and    $0x27e9,%bx
      38:	9c                   	pushf
      39:	89 1e 26 00          	mov    %bx,0x26
      3d:	81 26 02 00 49 35    	andw   $0x3549,0x2
      43:	9c                   	pushf
      44:	20 c4                	and    %al,%ah
      46:	9c                   	pushf
      47:	88 26 28 00          	mov    %ah,0x28
      4b:	22 0e 01 00          	and    0x1,%cl
      4f:	9c                   	pushf
      50:	88 0e 29 00          	mov    %cl,0x29
      54:	20 2e 03 00          	and    %ch,0x3
      58:	9c                   	pushf
      59:	24 46                	and    $0x46,%al
      5b:	9c                   	pushf
      5c:	a2 2a 00             	mov    %al,0x2a
      5f:	80 e3 2d             	and    $0x2d,%bl
      62:	9c                   	pushf
      63:	88 1e 2b 00          	mov    %bl,0x2b
      67:	80 26 02 00 c6       	andb   $0xc6,0x2
      6c:	9c                   	pushf
      6d:	b8 e3 05             	mov    $0x5e3,%ax
      70:	bb 77 f8             	mov    $0xf877,%bx
      73:	b9 e8 4a             	mov    $0x4ae8,%cx
      76:	ba 69 3b             	mov    $0x3b69,%dx
      79:	c7 06 04 00 c0 30    	movw   $0x30c0,0x4
      7f:	c7 06 06 00 75 57    	movw   $0x5775,0x6
      85:	c7 06 08 00 66 fe    	movw   $0xfe66,0x8
      8b:	09 c3                	or     %ax,%bx
      8d:	9c                   	pushf
      8e:	89 1e 2c 00          	mov    %bx,0x2c
      92:	0b 0e 04 00          	or     0x4,%cx
      96:	9c                   	pushf
      97:	89 0e 2e 00          	mov    %cx,0x2e
      9b:	09 06 06 00          	or     %ax,0x6
      9f:	9c                   	pushf
      a0:	0d c3 41             	or     $0x41c3,%ax
      a3:	9c                   	pushf
      a4:	a3 30 00             	mov    %ax,0x30
      a7:	81 ca 5d b0          	or     $0xb05d,%dx
      ab:	9c                   	pushf
      ac:	89 16 32 00          	mov    %dx,0x32
      b0:	81 0e 08 00 4c 8d    	orw    $0x8d4c,0x8
      b6:	9c                   	pushf
      b7:	08 c4                	or     %al,%ah
      b9:	9c                   	pushf
      ba:	88 26 34 00          	mov    %ah,0x34
      be:	0a 0e 05 00          	or     0x5,%cl
      c2:	9c                   	pushf
      c3:	88 0e 35 00          	mov    %cl,0x35
      c7:	08 2e 06 00          	or     %ch,0x6
      cb:	9c                   	pushf
      cc:	0c 43                	or     $0x43,%al
      ce:	9c                   	pushf
      cf:	a2 36 00             	mov    %al,0x36
      d2:	80 cb 57             	or     $0x57,%bl
      d5:	9c                   	pushf
      d6:	88 1e 37 00          	mov    %bl,0x37
      da:	80 0e 07 00 54       	orb    $0x54,0x7
      df:	9c                   	pushf
      e0:	b8 b4 d0             	mov    $0xd0b4,%ax
      e3:	bb b8 1b             	mov    $0x1bb8,%bx
      e6:	b9 03 2b             	mov    $0x2b03,%cx
      e9:	ba e6 c3             	mov    $0xc3e6,%dx
      ec:	c7 06 0a 00 39 39    	movw   $0x3939,0xa
      f2:	c7 06 0c 00 4b 86    	movw   $0x864b,0xc
      f8:	c7 06 0e 00 87 85    	movw   $0x8587,0xe
      fe:	31 c3                	xor    %ax,%bx
     100:	9c                   	pushf
     101:	89 1e 38 00          	mov    %bx,0x38
     105:	33 0e 0a 00          	xor    0xa,%cx
     109:	9c                   	pushf
     10a:	89 0e 3a 00          	mov    %cx,0x3a
     10e:	31 06 0c 00          	xor    %ax,0xc
     112:	9c                   	pushf
     113:	35 03 3d             	xor    $0x3d03,%ax
     116:	9c                   	pushf
     117:	a3 3c 00             	mov    %ax,0x3c
     11a:	81 f2 2d 63          	xor    $0x632d,%dx
     11e:	9c                   	pushf
     11f:	89 16 3e 00          	mov    %dx,0x3e
     123:	81 36 0e 00 07 cf    	xorw   $0xcf07,0xe
     129:	9c                   	pushf
     12a:	30 c4                	xor    %al,%ah
     12c:	9c                   	pushf
     12d:	88 26 40 00          	mov    %ah,0x40
     131:	32 0e 0b 00          	xor    0xb,%cl
     135:	9c                   	pushf
     136:	88 0e 41 00          	mov    %cl,0x41
     13a:	30 2e 0c 00          	xor    %ch,0xc
     13e:	9c                   	pushf
     13f:	34 b6                	xor    $0xb6,%al
     141:	9c                   	pushf
     142:	a2 42 00             	mov    %al,0x42
     145:	80 f3 ae             	xor    $0xae,%bl
     148:	9c                   	pushf
     149:	88 1e 43 00          	mov    %bl,0x43
     14d:	80 36 0d 00 df       	xorb   $0xdf,0xd
     152:	9c                   	pushf
     153:	b8 37 4d             	mov    $0x4d37,%ax
     156:	bb e1 db             	mov    $0xdbe1,%bx
     159:	b9 49 65             	mov    $0x6549,%cx
     15c:	ba c4 5c             	mov    $0x5cc4,%dx
     15f:	c7 06 10 00 a8 a8    	movw   $0xa8a8,0x10
     165:	c7 06 12 00 f6 35    	movw   $0x35f6,0x12
     16b:	c7 06 14 00 00 4f    	movw   $0x4f00,0x14
     171:	85 c3                	test   %ax,%bx
     173:	9c                   	pushf
     174:	89 1e 44 00          	mov    %bx,0x44
     178:	85 0e 10 00          	test   %cx,0x10
     17c:	9c                   	pushf
     17d:	89 0e 46 00          	mov    %cx,0x46
     181:	85 06 12 00          	test   %ax,0x12
     185:	9c                   	pushf
     186:	a9 6f dc             	test   $0xdc6f,%ax
     189:	9c                   	pushf
     18a:	a3 48 00             	mov    %ax,0x48
     18d:	f7 c2 46 30          	test   $0x3046,%dx
     191:	9c                   	pushf
     192:	89 16 4a 00          	mov    %dx,0x4a
     196:	f7 06 14 00 e4 96    	testw  $0x96e4,0x14
     19c:	9c                   	pushf
     19d:	84 c4                	test   %al,%ah
     19f:	9c                   	pushf
     1a0:	88 26 4c 00          	mov    %ah,0x4c
     1a4:	84 0e 0f 00          	test   %cl,0xf
     1a8:	9c                   	pushf
     1a9:	88 0e 4d 00          	mov    %cl,0x4d
     1ad:	84 2e 10 00          	test   %ch,0x10
     1b1:	9c                   	pushf
     1b2:	a8 c0                	test   $0xc0,%al
     1b4:	9c                   	pushf
     1b5:	a2 4e 00             	mov    %al,0x4e
     1b8:	f6 c3 e0             	test   $0xe0,%bl
     1bb:	9c                   	pushf
     1bc:	88 1e 4f 00          	mov    %bl,0x4f
     1c0:	f6 06 11 00 bb       	testb  $0xbb,0x11
     1c5:	9c                   	pushf
     1c6:	ba a5 bf             	mov    $0xbfa5,%dx
     1c9:	c7 06 16 00 e6 4b    	movw   $0x4be6,0x16
     1cf:	c7 06 18 00 d2 e9    	movw   $0xe9d2,0x18
     1d5:	b8 b1 12             	mov    $0x12b1,%ax
     1d8:	50                   	push   %ax
     1d9:	9d                   	popf
     1da:	f7 d2                	not    %dx
     1dc:	9c                   	pushf                 ; 9e
     1dd:	89 16 50 00          	mov    %dx,0x50
     1e1:	f7 16 16 00          	notw   0x16
     1e5:	9c                   	pushf                 ; 9c
     1e6:	f6 d2                	not    %dl 
     1e8:	9c                   	pushf                 ; 9a
     1e9:	88 16 52 00          	mov    %dl,0x52
     1ed:	f6 16 18 00          	notb   0x18
     1f1:	9c                   	pushf                 ; 98: notb affects none
     1f2:	f4                   	hlt
	...
    ffef:	00 eb                	add    %ch,%bl
    fff1:	0e                   	push   %cs
	...
    fffe:	00 ff                	add    %bh,%bh

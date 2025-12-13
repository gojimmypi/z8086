
80186_tests/mul.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	bc c0 00             	mov    $0xc0,%sp
       3:	bb 03 00             	mov    $0x3,%bx
       6:	b8 07 00             	mov    $0x7,%ax
       9:	ba ff ff             	mov    $0xffff,%dx
       c:	f7 e3                	mul    %bx
       e:	a3 00 00             	mov    %ax,0x0
      11:	89 16 02 00          	mov    %dx,0x2
      15:	9c                   	pushf               ; be
      16:	ba 20 a3             	mov    $0xa320,%dx
      19:	b8 ff ff             	mov    $0xffff,%ax
      1c:	f7 e2                	mul    %dx
      1e:	a3 04 00             	mov    %ax,0x4
      21:	89 16 06 00          	mov    %dx,0x6
      25:	9c                   	pushf               ; bc
      26:	b8 ff ff             	mov    $0xffff,%ax
      29:	c7 06 08 00 01 00    	movw   $0x1,0x8
      2f:	f7 26 08 00          	mulw   0x8
      33:	a3 0a 00             	mov    %ax,0xa
      36:	89 16 0c 00          	mov    %dx,0xc
      3a:	9c                   	pushf               ; ba
      3b:	b8 ff ff             	mov    $0xffff,%ax
      3e:	c7 06 0e 00 ff ff    	movw   $0xffff,0xe
      44:	f7 26 0e 00          	mulw   0xe
      48:	a3 10 00             	mov    %ax,0x10
      4b:	89 16 12 00          	mov    %dx,0x12
      4f:	9c                   	pushf               ; b8
      50:	b8 db 46             	mov    $0x46db,%ax
      53:	bd 00 00             	mov    $0x0,%bp
      56:	f7 e5                	mul    %bp
      58:	89 2e 14 00          	mov    %bp,0x14
      5c:	a3 16 00             	mov    %ax,0x16
      5f:	89 16 18 00          	mov    %dx,0x18
      63:	9c                   	pushf               ; b6
      64:	b8 db 46             	mov    $0x46db,%ax
      67:	be eb ee             	mov    $0xeeeb,%si
      6a:	f7 e6                	mul    %si
      6c:	89 36 1a 00          	mov    %si,0x1a
      70:	a3 1c 00             	mov    %ax,0x1c
      73:	89 16 1e 00          	mov    %dx,0x1e
      77:	9c                   	pushf               ; b4
      78:	b3 14                	mov    $0x14,%bl
      7a:	b8 07 ff             	mov    $0xff07,%ax
      7d:	ba ff ff             	mov    $0xffff,%dx
      80:	f6 e3                	mul    %bl
      82:	a3 20 00             	mov    %ax,0x20
      85:	89 16 22 00          	mov    %dx,0x22
      89:	9c                   	pushf               ; b2
      8a:	b5 24                	mov    $0x24,%ch
      8c:	b8 ff 00             	mov    $0xff,%ax
      8f:	f6 e5                	mul    %ch
      91:	a3 24 00             	mov    %ax,0x24
      94:	89 16 26 00          	mov    %dx,0x26
      98:	9c                   	pushf               ; b0
      99:	b8 ff 00             	mov    $0xff,%ax
      9c:	c6 06 28 00 01       	movb   $0x1,0x28
      a1:	f6 26 28 00          	mulb   0x28
      a5:	a3 29 00             	mov    %ax,0x29
      a8:	89 16 2b 00          	mov    %dx,0x2b
      ac:	9c                   	pushf               ; ae
      ad:	b8 ff ff             	mov    $0xffff,%ax
      b0:	c6 06 2d 00 ff       	movb   $0xff,0x2d
      b5:	f6 26 2d 00          	mulb   0x2d
      b9:	a3 2e 00             	mov    %ax,0x2e
      bc:	89 16 2e 00          	mov    %dx,0x2e
      c0:	9c                   	pushf               ; ac
      c1:	b8 c5 00             	mov    $0xc5,%ax
      c4:	ba 00 00             	mov    $0x0,%dx
      c7:	f6 e2                	mul    %dl
      c9:	89 16 30 00          	mov    %dx,0x30
      cd:	a3 32 00             	mov    %ax,0x32
      d0:	9c                   	pushf               ; aa
      d1:	b0 b5                	mov    $0xb5,%al
      d3:	b6 f9                	mov    $0xf9,%dh
      d5:	f6 e6                	mul    %dh
      d7:	89 36 34 00          	mov    %si,0x34
      db:	a3 36 00             	mov    %ax,0x36
      de:	89 16 38 00          	mov    %dx,0x38
      e2:	9c                   	pushf               ; a8
      e3:	bb 03 00             	mov    $0x3,%bx
      e6:	b8 07 00             	mov    $0x7,%ax
      e9:	ba ff ff             	mov    $0xffff,%dx
      ec:	f7 eb                	imul   %bx
      ee:	a3 3c 00             	mov    %ax,0x3c
      f1:	89 16 3e 00          	mov    %dx,0x3e
      f5:	9c                   	pushf               ; a6
      f6:	ba 20 a3             	mov    $0xa320,%dx
      f9:	b8 ff ff             	mov    $0xffff,%ax
      fc:	f7 ea                	imul   %dx
      fe:	a3 40 00             	mov    %ax,0x40
     101:	89 16 42 00          	mov    %dx,0x42
     105:	9c                   	pushf               ; a4
     106:	b8 ff ff             	mov    $0xffff,%ax
     109:	c7 06 44 00 01 00    	movw   $0x1,0x44
     10f:	f7 2e 44 00          	imulw  0x44
     113:	a3 46 00             	mov    %ax,0x46
     116:	89 16 48 00          	mov    %dx,0x48
     11a:	9c                   	pushf               ; a2
     11b:	b8 ff ff             	mov    $0xffff,%ax
     11e:	c7 06 4a 00 ff ff    	movw   $0xffff,0x4a
     124:	f7 2e 4a 00          	imulw  0x4a
     128:	a3 4c 00             	mov    %ax,0x4c
     12b:	89 16 4e 00          	mov    %dx,0x4e
     12f:	9c                   	pushf               ; a0
     130:	b8 db 46             	mov    $0x46db,%ax
     133:	bd 00 00             	mov    $0x0,%bp
     136:	f7 ed                	imul   %bp
     138:	89 2e 50 00          	mov    %bp,0x50
     13c:	a3 52 00             	mov    %ax,0x52
     13f:	89 16 54 00          	mov    %dx,0x54
     143:	9c                   	pushf               ; 9e
     144:	b8 db 46             	mov    $0x46db,%ax
     147:	be eb ee             	mov    $0xeeeb,%si
     14a:	f7 ee                	imul   %si
     14c:	89 36 56 00          	mov    %si,0x56
     150:	a3 58 00             	mov    %ax,0x58
     153:	89 16 5a 00          	mov    %dx,0x5a
     157:	9c                   	pushf               ; 9c
     158:	b3 14                	mov    $0x14,%bl
     15a:	b8 07 ff             	mov    $0xff07,%ax
     15d:	ba ff ff             	mov    $0xffff,%dx
     160:	f6 eb                	imul   %bl
     162:	a3 5c 00             	mov    %ax,0x5c
     165:	89 16 5e 00          	mov    %dx,0x5e
     169:	9c                   	pushf               ; 9a
     16a:	b5 24                	mov    $0x24,%ch
     16c:	b8 ff 00             	mov    $0xff,%ax
     16f:	f6 ed                	imul   %ch
     171:	a3 60 00             	mov    %ax,0x60
     174:	89 16 62 00          	mov    %dx,0x62
     178:	9c                   	pushf               ; 98
     179:	b8 ff 00             	mov    $0xff,%ax
     17c:	c6 06 64 00 01       	movb   $0x1,0x64
     181:	f6 2e 64 00          	imulb  0x64
     185:	a3 65 00             	mov    %ax,0x65
     188:	89 16 67 00          	mov    %dx,0x67
     18c:	9c                   	pushf               ; 96
     18d:	b8 ff ff             	mov    $0xffff,%ax
     190:	c6 06 69 00 ff       	movb   $0xff,0x69
     195:	f6 2e 69 00          	imulb  0x69
     199:	a3 6a 00             	mov    %ax,0x6a
     19c:	89 16 6a 00          	mov    %dx,0x6a
     1a0:	9c                   	pushf               ; 94
     1a1:	b8 c5 00             	mov    $0xc5,%ax
     1a4:	ba 00 00             	mov    $0x0,%dx
     1a7:	f6 ea                	imul   %dl
     1a9:	89 16 6c 00          	mov    %dx,0x6c
     1ad:	a3 6e 00             	mov    %ax,0x6e
     1b0:	9c                   	pushf               ; 92
     1b1:	b0 b5                	mov    $0xb5,%al
     1b3:	b6 f9                	mov    $0xf9,%dh
     1b5:	f6 ee                	imul   %dh
     1b7:	89 36 70 00          	mov    %si,0x70
     1bb:	a3 72 00             	mov    %ax,0x72
     1be:	89 16 74 00          	mov    %dx,0x74
     1c2:	9c                   	pushf               ; 90
     1c3:	b8 00 ff             	mov    $0xff00,%ax
     1c6:	d5 0a                	aad    $0xa
     1c8:	a3 76 00             	mov    %ax,0x76
     1cb:	9c                   	pushf               ; 8e
     1cc:	b8 ff ff             	mov    $0xffff,%ax
     1cf:	d5 12                	aad    $0x12
     1d1:	a3 78 00             	mov    %ax,0x78
     1d4:	9c                   	pushf               ; 8c  xxx
     1d5:	b8 ff 00             	mov    $0xff,%ax
     1d8:	d5 ff                	aad    $0xff
     1da:	a3 7a 00             	mov    %ax,0x7a
     1dd:	9c                   	pushf               ; 8a
     1de:	b8 2d 53             	mov    $0x532d,%ax
     1e1:	d5 39                	aad    $0x39
     1e3:	a3 7c 00             	mov    %ax,0x7c
     1e6:	9c                   	pushf               ; 88  xxx
     1e7:	f4                   	hlt
	...
    fff0:	eb 0e                	jmp    0x10000
	...
    fffe:	00 ff                	add    %bh,%bh


80186_tests/rotate.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	b8 5e 3b             	mov    $0x3b5e,%ax
       3:	bb a7 c8             	mov    $0xc8a7,%bx
       6:	c7 06 00 00 72 20    	movw   $0x2072,0x0
       c:	c7 06 02 00 79 3e    	movw   $0x3e79,0x2
      12:	bc a0 00             	mov    $0xa0,%sp
      15:	d1 d0                	rcl    $1,%ax
      17:	9c                   	pushf                 ; 8e
      18:	a3 20 00             	mov    %ax,0x20
      1b:	d1 16 00 00          	rclw   $1,0x0
      1f:	9c                   	pushf                 ; 8c
      20:	b9 00 01             	mov    $0x100,%cx
      23:	d3 d3                	rcl    %cl,%bx
      25:	9c                   	pushf                 ; 8a
      26:	89 1e 22 00          	mov    %bx,0x22
      2a:	b9 ff ff             	mov    $0xffff,%cx
      2d:	89 da                	mov    %bx,%dx
      2f:	d3 d2                	rcl    %cl,%dx        ; on 80186 CL is masked to 5 bits
      31:	9c                   	pushf                 ; 88
      32:	89 16 24 00          	mov    %dx,0x24
      36:	b1 08                	mov    $0x8,%cl
      38:	d3 d3                	rcl    %cl,%bx
      3a:	9c                   	pushf                 ; 86
      3b:	89 1e 26 00          	mov    %bx,0x26
      3f:	b1 04                	mov    $0x4,%cl
      41:	d3 16 02 00          	rclw   %cl,0x2
      45:	9c                   	pushf                 ; 84
      46:	ba 04 59             	mov    $0x5904,%dx
      49:	b8 7c be             	mov    $0xbe7c,%ax
      4c:	c7 06 04 00 2f d6    	movw   $0xd62f,0x4
      52:	c7 06 06 00 d8 6f    	movw   $0x6fd8,0x6
      58:	d0 d4                	rcl    $1,%ah
      5a:	9c                   	pushf                 ; 82
      5b:	a3 28 00             	mov    %ax,0x28
      5e:	d0 16 05 00          	rclb   $1,0x5
      62:	9c                   	pushf                 ; 80
      63:	b1 07                	mov    $0x7,%cl
      65:	d2 d2                	rcl    %cl,%dl
      67:	9c                   	pushf                 ; 7e
      68:	89 16 2a 00          	mov    %dx,0x2a
      6c:	d2 16 06 00          	rclb   %cl,0x6
      70:	9c                   	pushf                 ; 7c
      71:	b8 d6 15             	mov    $0x15d6,%ax
      74:	bb 07 83             	mov    $0x8307,%bx
      77:	c7 06 08 00 b7 9a    	movw   $0x9ab7,0x8
      7d:	c7 06 0a 00 b6 28    	movw   $0x28b6,0xa
      83:	d1 d8                	rcr    $1,%ax
      85:	9c                   	pushf                 ; 7a
      86:	a3 2c 00             	mov    %ax,0x2c
      89:	d1 1e 08 00          	rcrw   $1,0x8
      8d:	9c                   	pushf                 ; 78
      8e:	b9 00 01             	mov    $0x100,%cx
      91:	d3 db                	rcr    %cl,%bx
      93:	9c                   	pushf                 ; 76
      94:	89 1e 2e 00          	mov    %bx,0x2e
      98:	b9 ff ff             	mov    $0xffff,%cx
      9b:	89 da                	mov    %bx,%dx
      9d:	d3 da                	rcr    %cl,%dx
      9f:	9c                   	pushf                 ; 74
      a0:	89 16 30 00          	mov    %dx,0x30
      a4:	b1 05                	mov    $0x5,%cl
      a6:	d3 db                	rcr    %cl,%bx
      a8:	9c                   	pushf                 ; 72
      a9:	89 1e 32 00          	mov    %bx,0x32
      ad:	b1 04                	mov    $0x4,%cl
      af:	d3 1e 0a 00          	rcrw   %cl,0xa
      b3:	9c                   	pushf                 ; 70
      b4:	ba aa 7e             	mov    $0x7eaa,%dx
      b7:	b8 8d 3a             	mov    $0x3a8d,%ax
      ba:	c7 06 0c 00 14 a4    	movw   $0xa414,0xc
      c0:	c7 06 0e 00 38 28    	movw   $0x2838,0xe
      c6:	d0 dc                	rcr    $1,%ah
      c8:	9c                   	pushf                 ; 6e
      c9:	a3 34 00             	mov    %ax,0x34
      cc:	d0 1e 0d 00          	rcrb   $1,0xd
      d0:	9c                   	pushf                 ; 6c
      d1:	b1 07                	mov    $0x7,%cl
      d3:	d2 da                	rcr    %cl,%dl
      d5:	9c                   	pushf                 ; 6a
      d6:	89 16 36 00          	mov    %dx,0x36
      da:	d2 1e 0e 00          	rcrb   %cl,0xe
      de:	9c                   	pushf
      df:	b8 0d 02             	mov    $0x20d,%ax
      e2:	bb 5a 8d             	mov    $0x8d5a,%bx
      e5:	c7 06 10 00 dd 28    	movw   $0x28dd,0x10
      eb:	c7 06 12 00 4a d7    	movw   $0xd74a,0x12
      f1:	d1 c0                	rol    $1,%ax
      f3:	9c                   	pushf
      f4:	a3 38 00             	mov    %ax,0x38
      f7:	d1 06 10 00          	rolw   $1,0x10
      fb:	9c                   	pushf
      fc:	b9 00 01             	mov    $0x100,%cx
      ff:	d3 c3                	rol    %cl,%bx
     101:	9c                   	pushf
     102:	89 1e 3a 00          	mov    %bx,0x3a
     106:	b9 ff ff             	mov    $0xffff,%cx
     109:	89 da                	mov    %bx,%dx
     10b:	d3 c2                	rol    %cl,%dx
     10d:	9c                   	pushf
     10e:	89 16 3c 00          	mov    %dx,0x3c
     112:	b1 04                	mov    $0x4,%cl
     114:	d3 c3                	rol    %cl,%bx
     116:	9c                   	pushf
     117:	89 1e 3e 00          	mov    %bx,0x3e
     11b:	b1 04                	mov    $0x4,%cl
     11d:	d3 06 12 00          	rolw   %cl,0x12
     121:	9c                   	pushf
     122:	ba 09 9d             	mov    $0x9d09,%dx
     125:	b8 48 c9             	mov    $0xc948,%ax
     128:	c7 06 14 00 80 0b    	movw   $0xb80,0x14
     12e:	c7 06 16 00 e8 48    	movw   $0x48e8,0x16
     134:	d0 c4                	rol    $1,%ah
     136:	9c                   	pushf
     137:	a3 40 00             	mov    %ax,0x40
     13a:	d0 06 15 00          	rolb   $1,0x15
     13e:	9c                   	pushf
     13f:	b1 07                	mov    $0x7,%cl
     141:	d2 c2                	rol    %cl,%dl
     143:	9c                   	pushf
     144:	89 16 42 00          	mov    %dx,0x42
     148:	d2 06 16 00          	rolb   %cl,0x16
     14c:	9c                   	pushf
     14d:	b8 5e f2             	mov    $0xf25e,%ax
     150:	bb b5 2e             	mov    $0x2eb5,%bx
     153:	c7 06 18 00 51 01    	movw   $0x151,0x18
     159:	c7 06 1a 00 37 72    	movw   $0x7237,0x1a
     15f:	d1 c8                	ror    $1,%ax
     161:	9c                   	pushf
     162:	a3 44 00             	mov    %ax,0x44
     165:	d1 0e 18 00          	rorw   $1,0x18
     169:	9c                   	pushf
     16a:	b9 00 01             	mov    $0x100,%cx
     16d:	d3 cb                	ror    %cl,%bx
     16f:	9c                   	pushf
     170:	89 1e 46 00          	mov    %bx,0x46
     174:	b9 ff ff             	mov    $0xffff,%cx
     177:	89 da                	mov    %bx,%dx
     179:	d3 ca                	ror    %cl,%dx
     17b:	9c                   	pushf
     17c:	89 16 48 00          	mov    %dx,0x48
     180:	b1 04                	mov    $0x4,%cl
     182:	d3 cb                	ror    %cl,%bx
     184:	9c                   	pushf
     185:	89 1e 4a 00          	mov    %bx,0x4a
     189:	b1 04                	mov    $0x4,%cl
     18b:	d3 0e 1a 00          	rorw   %cl,0x1a
     18f:	9c                   	pushf
     190:	ba 88 42             	mov    $0x4288,%dx
     193:	b8 ab 8b             	mov    $0x8bab,%ax
     196:	c7 06 1c 00 d9 5d    	movw   $0x5dd9,0x1c
     19c:	c7 06 1e 00 f7 c7    	movw   $0xc7f7,0x1e
     1a2:	d0 cc                	ror    $1,%ah
     1a4:	9c                   	pushf
     1a5:	a3 4c 00             	mov    %ax,0x4c
     1a8:	d0 0e 1d 00          	rorb   $1,0x1d
     1ac:	9c                   	pushf
     1ad:	b1 07                	mov    $0x7,%cl
     1af:	d2 ca                	ror    %cl,%dl
     1b1:	9c                   	pushf
     1b2:	89 16 4e 00          	mov    %dx,0x4e
     1b6:	d2 0e 1e 00          	rorb   %cl,0x1e
     1ba:	9c                   	pushf
     1bb:	f4                   	hlt
	...
    fff0:	eb 0e                	jmp    0x10000
	...
    fffe:	00 ff                	add    %bh,%bh

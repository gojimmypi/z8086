
80186_tests/shifts.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	b8 c5 6e             	mov    $0x6ec5,%ax
       3:	bb a8 b1             	mov    $0xb1a8,%bx
       6:	c7 06 00 00 38 53    	movw   $0x5338,0x0
       c:	c7 06 02 00 fe 31    	movw   $0x31fe,0x2
      12:	bc 80 00             	mov    $0x80,%sp
      15:	d1 e0                	shl    $1,%ax
      17:	9c                   	pushf                 ; 7e
      18:	a3 20 00             	mov    %ax,0x20
      1b:	d1 26 00 00          	shlw   $1,0x0
      1f:	9c                   	pushf                 ; 7c
      20:	b9 00 01             	mov    $0x100,%cx
      23:	d3 e3                	shl    %cl,%bx
      25:	9c                   	pushf                 ; 7a
      26:	89 1e 22 00          	mov    %bx,0x22
      2a:	b9 ff ff             	mov    $0xffff,%cx
      2d:	89 da                	mov    %bx,%dx
      2f:	d3 e2                	shl    %cl,%dx
      31:	9c                   	pushf                 ; 78
      32:	89 16 24 00          	mov    %dx,0x24
      36:	b1 08                	mov    $0x8,%cl
      38:	d3 e3                	shl    %cl,%bx
      3a:	9c                   	pushf                 ; 76
      3b:	89 1e 26 00          	mov    %bx,0x26
      3f:	b1 04                	mov    $0x4,%cl
      41:	d2 26 02 00          	shlb   %cl,0x2
      45:	9c                   	pushf                 ; 74
      46:	ba 6f 95             	mov    $0x956f,%dx
      49:	b8 93 42             	mov    $0x4293,%ax
      4c:	c7 06 04 00 c0 33    	movw   $0x33c0,0x4
      52:	c7 06 06 00 ff 64    	movw   $0x64ff,0x6
      58:	d0 e4                	shl    $1,%ah
      5a:	9c                   	pushf                 ; 72
      5b:	a3 28 00             	mov    %ax,0x28
      5e:	d0 26 05 00          	shlb   $1,0x5
      62:	9c                   	pushf                 ; 70
      63:	b1 07                	mov    $0x7,%cl
      65:	d2 e2                	shl    %cl,%dl
      67:	9c                   	pushf                 ; 6e
      68:	89 16 2a 00          	mov    %dx,0x2a
      6c:	d2 26 06 00          	shlb   %cl,0x6
      70:	9c                   	pushf                 ; 6c
      71:	b8 72 fb             	mov    $0xfb72,%ax
      74:	bb b9 df             	mov    $0xdfb9,%bx
      77:	c7 06 08 00 bb 1e    	movw   $0x1ebb,0x8
      7d:	c7 06 0a 00 2f 74    	movw   $0x742f,0xa
      83:	d1 f8                	sar    $1,%ax
      85:	9c                   	pushf                 ; 6a
      86:	a3 2c 00             	mov    %ax,0x2c
      89:	d1 3e 08 00          	sarw   $1,0x8
      8d:	9c                   	pushf                 ; 68
      8e:	b9 00 01             	mov    $0x100,%cx
      91:	d3 fb                	sar    %cl,%bx
      93:	9c                   	pushf                 ; 66
      94:	89 1e 2e 00          	mov    %bx,0x2e
      98:	b9 ff ff             	mov    $0xffff,%cx
      9b:	89 da                	mov    %bx,%dx
      9d:	d3 fa                	sar    %cl,%dx
      9f:	9c                   	pushf                 ; 64
      a0:	89 16 30 00          	mov    %dx,0x30
      a4:	b1 05                	mov    $0x5,%cl
      a6:	d3 fb                	sar    %cl,%bx
      a8:	9c                   	pushf                 ; 62
      a9:	89 1e 32 00          	mov    %bx,0x32
      ad:	b1 04                	mov    $0x4,%cl
      af:	d2 3e 0a 00          	sarb   %cl,0xa
      b3:	9c                   	pushf                 ; 60
      b4:	ba b8 93             	mov    $0x93b8,%dx
      b7:	b8 88 66             	mov    $0x6688,%ax
      ba:	c7 06 0c 00 d4 ca    	movw   $0xcad4,0xc
      c0:	c7 06 0e 00 c9 6e    	movw   $0x6ec9,0xe
      c6:	d0 fc                	sar    $1,%ah
      c8:	9c                   	pushf                 ; 5e
      c9:	a3 34 00             	mov    %ax,0x34
      cc:	d0 3e 0d 00          	sarb   $1,0xd
      d0:	9c                   	pushf                 ; 5c
      d1:	b1 07                	mov    $0x7,%cl
      d3:	d2 fa                	sar    %cl,%dl
      d5:	9c                   	pushf                 ; 5a
      d6:	89 16 36 00          	mov    %dx,0x36
      da:	d2 3e 0e 00          	sarb   %cl,0xe
      de:	9c                   	pushf                 ; 58
      df:	b8 a1 7b             	mov    $0x7ba1,%ax
      e2:	bb e8 54             	mov    $0x54e8,%bx
      e5:	c7 06 10 00 aa ba    	movw   $0xbaaa,0x10
      eb:	c7 06 12 00 31 34    	movw   $0x3431,0x12
      f1:	d1 e8                	shr    $1,%ax
      f3:	9c                   	pushf                 ; 56
      f4:	a3 38 00             	mov    %ax,0x38
      f7:	d1 2e 10 00          	shrw   $1,0x10
      fb:	9c                   	pushf                 ; 54
      fc:	b9 00 01             	mov    $0x100,%cx
      ff:	d3 eb                	shr    %cl,%bx
     101:	9c                   	pushf                 ; 52
     102:	89 1e 3a 00          	mov    %bx,0x3a
     106:	b9 ff ff             	mov    $0xffff,%cx
     109:	89 da                	mov    %bx,%dx
     10b:	d3 ea                	shr    %cl,%dx
     10d:	9c                   	pushf                 ; 50
     10e:	89 16 3c 00          	mov    %dx,0x3c
     112:	b1 04                	mov    $0x4,%cl
     114:	d3 eb                	shr    %cl,%bx
     116:	9c                   	pushf                 ; 4e
     117:	89 1e 3e 00          	mov    %bx,0x3e
     11b:	b1 04                	mov    $0x4,%cl
     11d:	d2 2e 12 00          	shrb   %cl,0x12
     121:	9c                   	pushf                 ; 4c
     122:	ba 10 04             	mov    $0x410,%dx
     125:	b8 28 16             	mov    $0x1628,%ax
     128:	c7 06 14 00 26 3b    	movw   $0x3b26,0x14
     12e:	c7 06 16 00 0d 8d    	movw   $0x8d0d,0x16
     134:	d0 ec                	shr    $1,%ah
     136:	9c                   	pushf                 ; 4a
     137:	a3 40 00             	mov    %ax,0x40
     13a:	d0 2e 15 00          	shrb   $1,0x15
     13e:	9c                   	pushf                 ; 48
     13f:	b1 07                	mov    $0x7,%cl
     141:	d2 ea                	shr    %cl,%dl
     143:	9c                   	pushf                 ; 46
     144:	89 16 42 00          	mov    %dx,0x42
     148:	d2 2e 16 00          	shrb   %cl,0x16
     14c:	9c                   	pushf                 ; 44
     14d:	f4                   	hlt
	...
    ffee:	00 00                	add    %al,(%bx,%si)
    fff0:	eb 0e                	jmp    0x10000
	...
    fffe:	00 ff                	add    %bh,%bh

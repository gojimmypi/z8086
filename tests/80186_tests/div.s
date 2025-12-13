
80186_tests/div.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	bc d0 00             	mov    $0xd0,%sp
       3:	c7 06 00 00 00 10    	movw   $0x1000,0x0
       9:	c7 06 02 00 00 f0    	movw   $0xf000,0x2
       f:	bd d0 00             	mov    $0xd0,%bp          // bp=0xd0
      12:	ba 00 00             	mov    $0x0,%dx
      15:	b8 14 00             	mov    $0x14,%ax
      18:	bb 05 00             	mov    $0x5,%bx
      1b:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)      // [0xd0]=2
      20:	f7 f3                	div    %bx
      22:	83 c5 02             	add    $0x2,%bp           // bp=0xd2
      25:	a3 80 00             	mov    %ax,0x80
      28:	89 1e 82 00          	mov    %bx,0x82
      2c:	89 16 04 00          	mov    %dx,0x4
      30:	9c                   	pushf                     // ce
      31:	ba 20 a3             	mov    $0xa320,%dx
      34:	b8 da c3             	mov    $0xc3da,%ax
      37:	c7 06 06 00 ff ff    	movw   $0xffff,0x6
      3d:	c7 46 00 04 00       	movw   $0x4,0x0(%bp)      // [0xd2]=4
      42:	f7 36 06 00          	divw   0x6
      46:	83 c5 02             	add    $0x2,%bp           // bp=0xd4
      49:	a3 08 00             	mov    %ax,0x8
      4c:	89 16 0a 00          	mov    %dx,0xa
      50:	9c                   	pushf                     // cc
      51:	ba ff ff             	mov    $0xffff,%dx        // dx=0xffff
      54:	b8 ff ff             	mov    $0xffff,%ax        // ax=0xffff
      57:	b9 01 00             	mov    $0x1,%cx           // cx=1
      5a:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)      // [0xd4]=2
      5f:	f7 f1                	div    %cx                // triggers int0, int0 handler at F000:1000
      61:	83 c5 02             	add    $0x2,%bp          
      64:	a3 0c 00             	mov    %ax,0xc            // [c]=0xffff
      67:	89 0e 0e 00          	mov    %cx,0xe
      6b:	89 16 10 00          	mov    %dx,0x10
      6f:	9c                   	pushf                     // ca
      70:	ba ff ff             	mov    $0xffff,%dx
      73:	b8 ff ff             	mov    $0xffff,%ax
      76:	c7 06 12 00 ff ff    	movw   $0xffff,0x12
      7c:	c7 46 00 04 00       	movw   $0x4,0x0(%bp)
      81:	f7 36 12 00          	divw   0x12
      85:	83 c5 02             	add    $0x2,%bp
      88:	a3 14 00             	mov    %ax,0x14
      8b:	89 16 16 00          	mov    %dx,0x16
      8f:	9c                   	pushf                     // c8
      90:	ba b4 fb             	mov    $0xfbb4,%dx
      93:	b8 da c3             	mov    $0xc3da,%ax
      96:	b9 8e ae             	mov    $0xae8e,%cx
      99:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
      9e:	f7 f1                	div    %cx
      a0:	83 c5 02             	add    $0x2,%bp
      a3:	a3 18 00             	mov    %ax,0x18
      a6:	89 0e 1a 00          	mov    %cx,0x1a
      aa:	89 16 1c 00          	mov    %dx,0x1c
      ae:	9c                   	pushf                     // c6
      af:	ba c9 25             	mov    $0x25c9,%dx
      b2:	b8 10 f1             	mov    $0xf110,%ax
      b5:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
      ba:	f7 f0                	div    %ax
      bc:	83 c5 02             	add    $0x2,%bp
      bf:	a3 1e 00             	mov    %ax,0x1e
      c2:	89 16 20 00          	mov    %dx,0x20
      c6:	9c                   	pushf                     // c4
      c7:	b8 14 00             	mov    $0x14,%ax
      ca:	bb 05 00             	mov    $0x5,%bx
      cd:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
      d2:	f6 f3                	div    %bl
      d4:	83 c5 02             	add    $0x2,%bp
      d7:	a3 22 00             	mov    %ax,0x22
      da:	89 1e 24 00          	mov    %bx,0x24
      de:	89 16 26 00          	mov    %dx,0x26
      e2:	9c                   	pushf                     // c2
      e3:	ba 20 a3             	mov    $0xa320,%dx
      e6:	b8 da c3             	mov    $0xc3da,%ax
      e9:	c7 06 28 00 ff 00    	movw   $0xff,0x28
      ef:	c7 46 00 04 00       	movw   $0x4,0x0(%bp)
      f4:	f6 36 28 00          	divb   0x28
      f8:	83 c5 02             	add    $0x2,%bp
      fb:	a3 2a 00             	mov    %ax,0x2a
      fe:	89 16 2c 00          	mov    %dx,0x2c
     102:	9c                   	pushf                     // c0
     103:	b8 ff ff             	mov    $0xffff,%ax
     106:	b6 01                	mov    $0x1,%dh
     108:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     10d:	f6 f6                	div    %dh
     10f:	83 c5 02             	add    $0x2,%bp
     112:	a3 2e 00             	mov    %ax,0x2e
     115:	89 16 30 00          	mov    %dx,0x30
     119:	9c                   	pushf                     // be
     11a:	b8 ff ff             	mov    $0xffff,%ax
     11d:	c7 06 32 00 ff ff    	movw   $0xffff,0x32
     123:	c7 46 00 04 00       	movw   $0x4,0x0(%bp)
     128:	f6 36 33 00          	divb   0x33
     12c:	83 c5 02             	add    $0x2,%bp
     12f:	a3 34 00             	mov    %ax,0x34
     132:	89 16 36 00          	mov    %dx,0x36
     136:	9c                   	pushf                     // bc
     137:	b8 8a 00             	mov    $0x8a,%ax
     13a:	b9 8e ae             	mov    $0xae8e,%cx
     13d:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     142:	f6 f1                	div    %cl
     144:	83 c5 02             	add    $0x2,%bp
     147:	a3 38 00             	mov    %ax,0x38
     14a:	89 0e 3a 00          	mov    %cx,0x3a
     14e:	9c                   	pushf                     // ba
     14f:	ba 69 06             	mov    $0x669,%dx
     152:	b8 f3 89             	mov    $0x89f3,%ax
     155:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     15a:	f6 f0                	div    %al
     15c:	83 c5 02             	add    $0x2,%bp
     15f:	a3 3c 00             	mov    %ax,0x3c
     162:	89 16 3e 00          	mov    %dx,0x3e
     166:	9c                   	pushf                     // b8
     167:	ba 00 00             	mov    $0x0,%dx
     16a:	b8 14 00             	mov    $0x14,%ax
     16d:	bb fa 00             	mov    $0xfa,%bx
     170:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     175:	f7 fb                	idiv   %bx
     177:	83 c5 02             	add    $0x2,%bp
     17a:	a3 40 00             	mov    %ax,0x40
     17d:	89 1e 42 00          	mov    %bx,0x42
     181:	89 16 44 00          	mov    %dx,0x44
     185:	9c                   	pushf                     // b6
     186:	ba 20 a3             	mov    $0xa320,%dx
     189:	b8 da c3             	mov    $0xc3da,%ax
     18c:	c7 06 46 00 ff ff    	movw   $0xffff,0x46
     192:	c7 46 00 04 00       	movw   $0x4,0x0(%bp)
     197:	f7 3e 46 00          	idivw  0x46
     19b:	83 c5 02             	add    $0x2,%bp
     19e:	a3 48 00             	mov    %ax,0x48
     1a1:	89 16 4a 00          	mov    %dx,0x4a
     1a5:	9c                   	pushf                     // b4
     1a6:	ba ff ff             	mov    $0xffff,%dx
     1a9:	b8 ff ff             	mov    $0xffff,%ax
     1ac:	b9 01 00             	mov    $0x1,%cx
     1af:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     1b4:	f7 f9                	idiv   %cx
     1b6:	83 c5 02             	add    $0x2,%bp
     1b9:	a3 4c 00             	mov    %ax,0x4c
     1bc:	89 0e 4e 00          	mov    %cx,0x4e
     1c0:	89 16 50 00          	mov    %dx,0x50
     1c4:	9c                   	pushf                     // b2
     1c5:	ba ff ff             	mov    $0xffff,%dx
     1c8:	b8 ff ff             	mov    $0xffff,%ax
     1cb:	c7 06 52 00 ff ff    	movw   $0xffff,0x52
     1d1:	c7 46 00 04 00       	movw   $0x4,0x0(%bp)
     1d6:	f7 3e 52 00          	idivw  0x52
     1da:	83 c5 02             	add    $0x2,%bp
     1dd:	a3 54 00             	mov    %ax,0x54
     1e0:	89 16 56 00          	mov    %dx,0x56
     1e4:	9c                   	pushf                     // b0
     1e5:	ba b4 fb             	mov    $0xfbb4,%dx
     1e8:	b8 da c3             	mov    $0xc3da,%ax
     1eb:	b9 8e ae             	mov    $0xae8e,%cx
     1ee:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     1f3:	f7 f9                	idiv   %cx
     1f5:	83 c5 02             	add    $0x2,%bp
     1f8:	a3 58 00             	mov    %ax,0x58
     1fb:	89 0e 5a 00          	mov    %cx,0x5a
     1ff:	89 16 5c 00          	mov    %dx,0x5c
     203:	9c                   	pushf                     // ae
     204:	ba c9 25             	mov    $0x25c9,%dx
     207:	b8 10 f1             	mov    $0xf110,%ax
     20a:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     20f:	f7 f8                	idiv   %ax
     211:	83 c5 02             	add    $0x2,%bp
     214:	a3 5e 00             	mov    %ax,0x5e
     217:	89 16 60 00          	mov    %dx,0x60
     21b:	9c                   	pushf                     // ac
     21c:	b8 14 00             	mov    $0x14,%ax
     21f:	bb 05 00             	mov    $0x5,%bx
     222:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     227:	f6 fb                	idiv   %bl
     229:	83 c5 02             	add    $0x2,%bp
     22c:	a3 62 00             	mov    %ax,0x62
     22f:	89 1e 64 00          	mov    %bx,0x64
     233:	89 16 66 00          	mov    %dx,0x66
     237:	9c                   	pushf                     // aa
     238:	ba 20 a3             	mov    $0xa320,%dx
     23b:	b8 da c3             	mov    $0xc3da,%ax
     23e:	c7 06 68 00 ff 00    	movw   $0xff,0x68
     244:	c7 46 00 04 00       	movw   $0x4,0x0(%bp)
     249:	f6 3e 68 00          	idivb  0x68
     24d:	83 c5 02             	add    $0x2,%bp
     250:	a3 6a 00             	mov    %ax,0x6a
     253:	89 16 6c 00          	mov    %dx,0x6c
     257:	9c                   	pushf                     // a8
     258:	b8 ff ff             	mov    $0xffff,%ax
     25b:	b6 01                	mov    $0x1,%dh
     25d:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     262:	f6 fe                	idiv   %dh
     264:	83 c5 02             	add    $0x2,%bp
     267:	a3 6e 00             	mov    %ax,0x6e
     26a:	89 16 70 00          	mov    %dx,0x70
     26e:	9c                   	pushf                     // a6
     26f:	b8 ff ff             	mov    $0xffff,%ax
     272:	c7 06 72 00 ff ff    	movw   $0xffff,0x72
     278:	c7 46 00 04 00       	movw   $0x4,0x0(%bp)
     27d:	f6 3e 73 00          	idivb  0x73
     281:	83 c5 02             	add    $0x2,%bp
     284:	a3 74 00             	mov    %ax,0x74
     287:	89 16 76 00          	mov    %dx,0x76
     28b:	9c                   	pushf                     // a4
     28c:	b8 8a 00             	mov    $0x8a,%ax
     28f:	b9 8e ae             	mov    $0xae8e,%cx
     292:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     297:	f6 f9                	idiv   %cl
     299:	83 c5 02             	add    $0x2,%bp
     29c:	a3 78 00             	mov    %ax,0x78
     29f:	89 0e 7a 00          	mov    %cx,0x7a
     2a3:	9c                   	pushf                     // a2
     2a4:	ba 69 06             	mov    $0x669,%dx
     2a7:	b8 f3 89             	mov    $0x89f3,%ax
     2aa:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     2af:	f6 f8                	idiv   %al
     2b1:	83 c5 02             	add    $0x2,%bp
     2b4:	a3 7c 00             	mov    %ax,0x7c
     2b7:	89 16 7e 00          	mov    %dx,0x7e
     2bb:	9c                   	pushf                     // a0
     2bc:	b8 ff ff             	mov    $0xffff,%ax
     2bf:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     2c4:	d4 00                	aam    $0x0
     2c6:	83 c5 02             	add    $0x2,%bp
     2c9:	a3 84 00             	mov    %ax,0x84
     2cc:	9c                   	pushf                     // 9e
     2cd:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     2d2:	d4 01                	aam    $0x1
     2d4:	83 c5 02             	add    $0x2,%bp
     2d7:	a3 86 00             	mov    %ax,0x86
     2da:	9c                   	pushf                     // 9c
     2db:	b8 ff ff             	mov    $0xffff,%ax
     2de:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     2e3:	d4 0a                	aam    $0xa
     2e5:	83 c5 02             	add    $0x2,%bp
     2e8:	a3 88 00             	mov    %ax,0x88
     2eb:	9c                   	pushf                     // 9a
     2ec:	b8 00 ff             	mov    $0xff00,%ax
     2ef:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     2f4:	d4 00                	aam    $0x0
     2f6:	83 c5 02             	add    $0x2,%bp
     2f9:	a3 8a 00             	mov    %ax,0x8a
     2fc:	9c                   	pushf                     // 98
     2fd:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     302:	d4 01                	aam    $0x1
     304:	83 c5 02             	add    $0x2,%bp
     307:	a3 8c 00             	mov    %ax,0x8c
     30a:	9c                   	pushf                     // 96
     30b:	b8 fb 3f             	mov    $0x3ffb,%ax
     30e:	c7 46 00 02 00       	movw   $0x2,0x0(%bp)
     313:	d4 0a                	aam    $0xa
     315:	83 c5 02             	add    $0x2,%bp
     318:	a3 8e 00             	mov    %ax,0x8e
     31b:	9c                   	pushf                     // 94
     31c:	f4                   	hlt
	...

    // this adjusts return IP by the amount in [ds:bp]
    // this is not necessary on the 8086 because return IP is the next instruction
    // so we remove instruction 1016 which overwrites the return IP
    1000:   50                      push   %ax              // [0xc4]=ax
    1001:   57             	        push   %di              // [0xc2]=di
    1002:	8b 46 00             	mov    0x0(%bp),%ax     // bp points to return IP delta, bp=0xd4
    1005:	89 e6                	mov    %sp,%si          // si=sp=0xc2
    1007:	83 c6 04             	add    $0x4,%si         // si=sp+4=0xc6   return IP
    100a:	8b 34                	mov    (%si),%si        // si=0x61
    100c:	89 76 00             	mov    %si,0x0(%bp)     // [bp]=old return address
    100f:	01 c6                	add    %ax,%si          // si=0x61+2=0x63
    1011:	89 e7                	mov    %sp,%di
    1013:	83 c7 04             	add    $0x4,%di         // di=0xc6   return IP
    1016:	89 35                	mov    %si,(%di)        // !! this overwrites the return IP 0x61 to 0x63
    1018:	5f                   	pop    %di
    1019:	58                   	pop    %ax
    101a:	cf                   	iret
	...
    ffef:	00 eb                	add    %ch,%bl
    fff1:	0e                   	push   %cs
	...
    fffe:	00 ff                	add    %bh,%bh

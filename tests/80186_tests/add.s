
add.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	bc a0 00             	mov    $0xa0,%sp
       3:	b8 ff ff             	mov    $0xffff,%ax
       6:	bb 01 00             	mov    $0x1,%bx
       9:	01 c3                	add    %ax,%bx
       b:	a3 00 00             	mov    %ax,0x0
       e:	89 1e 02 00          	mov    %bx,0x2
      12:	9c                   	pushf
      13:	ba ff ff             	mov    $0xffff,%dx
      16:	c7 06 04 00 ff ff    	movw   $0xffff,0x4
      1c:	01 16 04 00          	add    %dx,0x4
      20:	89 16 06 00          	mov    %dx,0x6
      24:	9c                   	pushf
      25:	b9 01 00             	mov    $0x1,%cx
      28:	c7 06 08 00 02 00    	movw   $0x2,0x8
      2e:	03 0e 08 00          	add    0x8,%cx
      32:	89 0e 0a 00          	mov    %cx,0xa
      36:	9c                   	pushf
      37:	b8 01 00             	mov    $0x1,%ax
      3a:	05 ff 7f             	add    $0x7fff,%ax
      3d:	a3 0c 00             	mov    %ax,0xc
      40:	9c                   	pushf
      41:	bd 00 80             	mov    $0x8000,%bp
      44:	83 c5 ff             	add    $0xffff,%bp
      47:	89 2e 0e 00          	mov    %bp,0xe
      4b:	9c                   	pushf
      4c:	be 83 c7             	mov    $0xc783,%si
      4f:	81 c6 2a eb          	add    $0xeb2a,%si
      53:	89 36 10 00          	mov    %si,0x10
      57:	9c                   	pushf
      58:	c7 06 12 00 60 89    	movw   $0x8960,0x12
      5e:	81 06 12 00 95 0a    	addw   $0xa95,0x12
      64:	9c                   	pushf
      65:	c7 06 14 00 e1 f1    	movw   $0xf1e1,0x14
      6b:	83 06 14 00 64       	addw   $0x64,0x14
      70:	9c                   	pushf
      71:	c6 06 16 00 01       	movb   $0x1,0x16
      76:	80 06 16 00 ff       	addb   $0xff,0x16
      7b:	9c                   	pushf
      7c:	b6 ff                	mov    $0xff,%dh
      7e:	80 c6 ff             	add    $0xff,%dh
      81:	89 16 17 00          	mov    %dx,0x17
      85:	9c                   	pushf
      86:	b0 01                	mov    $0x1,%al
      88:	04 02                	add    $0x2,%al
      8a:	a3 19 00             	mov    %ax,0x19
      8d:	9c                   	pushf
      8e:	c6 06 1b 00 7f       	movb   $0x7f,0x1b
      93:	b5 01                	mov    $0x1,%ch
      95:	02 2e 1b 00          	add    0x1b,%ch
      99:	89 0e 1c 00          	mov    %cx,0x1c
      9d:	9c                   	pushf
      9e:	b3 80                	mov    $0x80,%bl
      a0:	c6 06 1e 00 ff       	movb   $0xff,0x1e
      a5:	00 1e 1e 00          	add    %bl,0x1e
      a9:	89 1e 1f 00          	mov    %bx,0x1f
      ad:	9c                   	pushf
      ae:	b0 a6                	mov    $0xa6,%al
      b0:	b4 86                	mov    $0x86,%ah
      b2:	00 c4                	add    %al,%ah
      b4:	a3 21 00             	mov    %ax,0x21
      b7:	9c                   	pushf
      b8:	b8 ff ff             	mov    $0xffff,%ax
      bb:	bb 01 00             	mov    $0x1,%bx
      be:	11 c3                	adc    %ax,%bx
      c0:	a3 23 00             	mov    %ax,0x23
      c3:	89 1e 25 00          	mov    %bx,0x25
      c7:	9c                   	pushf
      c8:	ba ff ff             	mov    $0xffff,%dx
      cb:	c7 06 27 00 ff ff    	movw   $0xffff,0x27
      d1:	11 16 27 00          	adc    %dx,0x27
      d5:	89 16 29 00          	mov    %dx,0x29
      d9:	9c                   	pushf
      da:	b9 01 00             	mov    $0x1,%cx
      dd:	c7 06 2b 00 02 00    	movw   $0x2,0x2b
      e3:	13 0e 2b 00          	adc    0x2b,%cx
      e7:	89 0e 2d 00          	mov    %cx,0x2d
      eb:	9c                   	pushf
      ec:	b8 01 00             	mov    $0x1,%ax
      ef:	15 ff 7f             	adc    $0x7fff,%ax
      f2:	a3 2f 00             	mov    %ax,0x2f
      f5:	9c                   	pushf
      f6:	bd 00 80             	mov    $0x8000,%bp
      f9:	83 d5 ff             	adc    $0xffff,%bp
      fc:	89 2e 31 00          	mov    %bp,0x31
     100:	9c                   	pushf
     101:	be d3 77             	mov    $0x77d3,%si
     104:	81 d6 25 84          	adc    $0x8425,%si
     108:	89 36 33 00          	mov    %si,0x33
     10c:	9c                   	pushf
     10d:	c7 06 35 00 a0 eb    	movw   $0xeba0,0x35
     113:	81 16 35 00 c1 d3    	adcw   $0xd3c1,0x35
     119:	9c                   	pushf
     11a:	c7 06 37 00 50 7f    	movw   $0x7f50,0x37
     120:	83 16 37 00 f5       	adcw   $0xfff5,0x37
     125:	9c                   	pushf
     126:	c6 06 39 00 01       	movb   $0x1,0x39
     12b:	80 16 39 00 ff       	adcb   $0xff,0x39
     130:	9c                   	pushf
     131:	b6 ff                	mov    $0xff,%dh
     133:	80 d6 ff             	adc    $0xff,%dh
     136:	89 16 3a 00          	mov    %dx,0x3a
     13a:	9c                   	pushf
     13b:	b0 01                	mov    $0x1,%al
     13d:	14 02                	adc    $0x2,%al
     13f:	a3 3c 00             	mov    %ax,0x3c
     142:	9c                   	pushf
     143:	c6 06 3e 00 7f       	movb   $0x7f,0x3e
     148:	b5 01                	mov    $0x1,%ch
     14a:	12 2e 3e 00          	adc    0x3e,%ch
     14e:	89 0e 3f 00          	mov    %cx,0x3f
     152:	9c                   	pushf
     153:	b3 80                	mov    $0x80,%bl
     155:	c6 06 41 00 ff       	movb   $0xff,0x41
     15a:	10 1e 41 00          	adc    %bl,0x41
     15e:	89 1e 42 00          	mov    %bx,0x42
     162:	9c                   	pushf
     163:	b0 b9                	mov    $0xb9,%al
     165:	b4 d3                	mov    $0xd3,%ah
     167:	10 c4                	adc    %al,%ah
     169:	a3 44 00             	mov    %ax,0x44
     16c:	9c                   	pushf
     16d:	bf ff ff             	mov    $0xffff,%di
     170:	47                   	inc    %di
     171:	89 3e 46 00          	mov    %di,0x46
     175:	9c                   	pushf
     176:	bd ff 7f             	mov    $0x7fff,%bp
     179:	ff c5                	inc    %bp
     17b:	89 2e 48 00          	mov    %bp,0x48
     17f:	9c                   	pushf
     180:	c7 06 4a 00 12 74    	movw   $0x7412,0x4a
     186:	ff 06 4a 00          	incw   0x4a
     18a:	9c                   	pushf
     18b:	b2 7f                	mov    $0x7f,%dl
     18d:	fe c2                	inc    %dl
     18f:	89 16 4c 00          	mov    %dx,0x4c
     193:	9c                   	pushf
     194:	c6 06 4d 00 ff       	movb   $0xff,0x4d
     199:	fe 06 4d 00          	incb   0x4d
     19d:	9c                   	pushf
     19e:	c6 06 4e 00 b5       	movb   $0xb5,0x4e
     1a3:	fe 06 4e 00          	incb   0x4e
     1a7:	9c                   	pushf
     1a8:	f4                   	hlt
	...
    ffed:	00 00                	add    %al,(%bx,%si)
    ffef:	00 eb                	add    %ch,%bl
    fff1:	0e                   	push   %cs
	...
    fffe:	00 ff                	add    %bh,%bh

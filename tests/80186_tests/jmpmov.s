
80186_tests/jmpmov.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	eb 0c                	jmp    0xe
       2:	f4                   	hlt
	...
       b:	00 00                	add    %al,(%bx,%si)
       d:	00 bb 00 f0          	add    %bh,-0x1000(%bp,%di)
      11:	8e db                	mov    %bx,%ds
      13:	a1 f2 ff             	mov    0xfff2,%ax
      16:	ff e0                	jmp    *%ax
      18:	f4                   	hlt
	...
    128d:	00 00                	add    %al,(%bx,%si)
    128f:	00 ea                	add    %ch,%dl
    1291:	e0 eb                	loopne 0x127e
    1293:	42                   	inc    %dx
    1294:	e3 f4                	jcxz   0x128a
	...
    1ffe:	00 00                	add    %al,(%bx,%si)
    2000:	bb 00 10             	mov    $0x1000,%bx
    2003:	8e db                	mov    %bx,%ds
    2005:	b4 fb                	mov    $0xfb,%ah
    2007:	b0 e1                	mov    $0xe1,%al
    2009:	a3 01 25             	mov    %ax,0x2501
    200c:	c7 06 00 26 01 10    	movw   $0x1001,0x2600
    2012:	8e 16 00 26          	mov    0x2600,%ss
    2016:	8c 16 01 26          	mov    %ss,0x2601
    201a:	8a 16 01 26          	mov    0x2601,%dl
    201e:	b6 00                	mov    $0x0,%dh
    2020:	89 d7                	mov    %dx,%di
    2022:	bd 06 25             	mov    $0x2506,%bp
    2025:	ff 63 ea             	jmp    *-0x16(%bp,%di)
    2028:	f4                   	hlt
	...
    3001:	ba 00 f1             	mov    $0xf100,%dx
    3004:	b8 36 25             	mov    $0x2536,%ax
    3007:	ef                   	out    %ax,(%dx)
    3008:	c7 c0 01 40          	mov    $0x4001,%ax
    300c:	bb 01 25             	mov    $0x2501,%bx
    300f:	89 07                	mov    %ax,(%bx)
    3011:	bf 02 00             	mov    $0x2,%di
    3014:	c6 01 00             	movb   $0x0,(%bx,%di)
    3017:	b5 04                	mov    $0x4,%ch
    3019:	88 e9                	mov    %ch,%cl
    301b:	b5 00                	mov    $0x0,%ch
    301d:	89 ce                	mov    %cx,%si
    301f:	c6 40 ff f0          	movb   $0xf0,-0x1(%bx,%si)
    3023:	be 03 00             	mov    $0x3,%si
    3026:	ff 6a e8             	ljmp   *-0x18(%bp,%si)
    3029:	f4                   	hlt
	...
    3ffe:	00 00                	add    %al,(%bx,%si)
    4000:	00 8b 40 fd          	add    %cl,-0x2c0(%bp,%di)
    4004:	ba 00 00             	mov    $0x0,%dx
    4007:	8e da                	mov    %dx,%ds
    4009:	a3 00 00             	mov    %ax,0x0
    400c:	f4                   	hlt
	...
    ffed:	00 00                	add    %al,(%bx,%si)
    ffef:	00 eb                	add    %ch,%bl
    fff1:	0e                   	push   %cs
    fff2:	90                   	nop
    fff3:	12 00                	adc    (%bx,%si),%al
	...
    fffd:	00 ff                	add    %bh,%bh
    ffff:	ff                   	.byte 0xff

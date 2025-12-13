
80186_tests/bcdcnv.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	bb 01 00             	mov    $0x1,%bx
       3:	b9 00 00             	mov    $0x0,%cx
       6:	bc 90 00             	mov    $0x90,%sp
       9:	b8 0a 00             	mov    $0xa,%ax
       c:	37                   	aaa
       d:	a3 00 00             	mov    %ax,0x0
      10:	9c                   	pushf
      11:	b8 f9 ff             	mov    $0xfff9,%ax
      14:	37                   	aaa
      15:	a3 02 00             	mov    %ax,0x2
      18:	9c                   	pushf
      19:	53                   	push   %bx
      1a:	9d                   	popf
      1b:	b8 f9 ff             	mov    $0xfff9,%ax
      1e:	37                   	aaa
      1f:	a3 04 00             	mov    %ax,0x4
      22:	9c                   	pushf
      23:	b8 50 5d             	mov    $0x5d50,%ax
      26:	37                   	aaa
      27:	a3 06 00             	mov    %ax,0x6
      2a:	9c                   	pushf
      2b:	b8 26 47             	mov    $0x4726,%ax
      2e:	37                   	aaa
      2f:	a3 08 00             	mov    %ax,0x8
      32:	9c                   	pushf
      33:	b8 0a 00             	mov    $0xa,%ax
      36:	3f                   	aas
      37:	a3 0a 00             	mov    %ax,0xa
      3a:	9c                   	pushf
      3b:	b8 f9 ff             	mov    $0xfff9,%ax
      3e:	3f                   	aas
      3f:	a3 0c 00             	mov    %ax,0xc
      42:	9c                   	pushf
      43:	53                   	push   %bx
      44:	9d                   	popf
      45:	b8 f9 ff             	mov    $0xfff9,%ax
      48:	3f                   	aas
      49:	a3 0e 00             	mov    %ax,0xe
      4c:	9c                   	pushf
      4d:	b8 c0 dc             	mov    $0xdcc0,%ax
      50:	3f                   	aas
      51:	a3 10 00             	mov    %ax,0x10
      54:	9c                   	pushf
      55:	b8 fb 5f             	mov    $0x5ffb,%ax
      58:	3f                   	aas
      59:	a3 12 00             	mov    %ax,0x12
      5c:	9c                   	pushf
      5d:	b8 ac 00             	mov    $0xac,%ax
      60:	27                   	daa
      61:	a3 14 00             	mov    %ax,0x14
      64:	9c                   	pushf
      65:	b8 f9 ff             	mov    $0xfff9,%ax
      68:	27                   	daa
      69:	a3 16 00             	mov    %ax,0x16
      6c:	9c                   	pushf
      6d:	53                   	push   %bx
      6e:	9d                   	popf
      6f:	b8 f8 ff             	mov    $0xfff8,%ax
      72:	27                   	daa
      73:	a3 18 00             	mov    %ax,0x18
      76:	9c                   	pushf
      77:	51                   	push   %cx
      78:	9d                   	popf
      79:	b8 8b ff             	mov    $0xff8b,%ax
      7c:	27                   	daa
      7d:	a3 1a 00             	mov    %ax,0x1a
      80:	9c                   	pushf
      81:	51                   	push   %cx
      82:	9d                   	popf
      83:	b8 82 00             	mov    $0x82,%ax
      86:	27                   	daa
      87:	a3 1c 00             	mov    %ax,0x1c
      8a:	9c                   	pushf
      8b:	b8 3c cd             	mov    $0xcd3c,%ax
      8e:	27                   	daa
      8f:	a3 1e 00             	mov    %ax,0x1e
      92:	9c                   	pushf
      93:	b8 00 3f             	mov    $0x3f00,%ax
      96:	27                   	daa
      97:	a3 20 00             	mov    %ax,0x20
      9a:	9c                   	pushf
      9b:	b8 ac 00             	mov    $0xac,%ax
      9e:	2f                   	das
      9f:	a3 22 00             	mov    %ax,0x22
      a2:	9c                   	pushf
      a3:	b8 f9 ff             	mov    $0xfff9,%ax
      a6:	2f                   	das
      a7:	a3 24 00             	mov    %ax,0x24
      aa:	9c                   	pushf
      ab:	53                   	push   %bx
      ac:	9d                   	popf
      ad:	b8 f8 ff             	mov    $0xfff8,%ax
      b0:	2f                   	das
      b1:	a3 26 00             	mov    %ax,0x26
      b4:	9c                   	pushf
      b5:	51                   	push   %cx
      b6:	9d                   	popf
      b7:	b8 8b ff             	mov    $0xff8b,%ax
      ba:	2f                   	das
      bb:	a3 28 00             	mov    %ax,0x28
      be:	9c                   	pushf
      bf:	51                   	push   %cx
      c0:	9d                   	popf
      c1:	b8 82 00             	mov    $0x82,%ax
      c4:	2f                   	das
      c5:	a3 2a 00             	mov    %ax,0x2a
      c8:	9c                   	pushf
      c9:	b8 9a 05             	mov    $0x59a,%ax
      cc:	2f                   	das
      cd:	a3 2c 00             	mov    %ax,0x2c
      d0:	9c                   	pushf
      d1:	b8 f6 54             	mov    $0x54f6,%ax
      d4:	2f                   	das
      d5:	a3 2e 00             	mov    %ax,0x2e
      d8:	9c                   	pushf
      d9:	b8 7f ff             	mov    $0xff7f,%ax
      dc:	98                   	cbtw
      dd:	a3 30 00             	mov    %ax,0x30
      e0:	89 16 32 00          	mov    %dx,0x32
      e4:	9c                   	pushf
      e5:	b8 80 00             	mov    $0x80,%ax
      e8:	98                   	cbtw
      e9:	a3 34 00             	mov    %ax,0x34
      ec:	89 16 36 00          	mov    %dx,0x36
      f0:	9c                   	pushf
      f1:	b8 ed f1             	mov    $0xf1ed,%ax
      f4:	98                   	cbtw
      f5:	a3 38 00             	mov    %ax,0x38
      f8:	89 16 3a 00          	mov    %dx,0x3a
      fc:	9c                   	pushf
      fd:	b8 00 80             	mov    $0x8000,%ax
     100:	99                   	cwtd
     101:	a3 3c 00             	mov    %ax,0x3c
     104:	89 16 3e 00          	mov    %dx,0x3e
     108:	9c                   	pushf
     109:	b8 ff 7f             	mov    $0x7fff,%ax
     10c:	99                   	cwtd
     10d:	a3 40 00             	mov    %ax,0x40
     110:	89 16 42 00          	mov    %dx,0x42
     114:	9c                   	pushf
     115:	b8 f1 43             	mov    $0x43f1,%ax
     118:	99                   	cwtd
     119:	a3 44 00             	mov    %ax,0x44
     11c:	89 16 46 00          	mov    %dx,0x46
     120:	9c                   	pushf
     121:	f4                   	hlt
	...
    ffee:	00 00                	add    %al,(%bx,%si)
    fff0:	eb 0e                	jmp    0x10000
	...
    fffe:	00 ff                	add    %bh,%bh


80186_tests/control.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	b8 00 10             	mov    $0x1000,%ax
       3:	8e d0                	mov    %ax,%ss
       5:	bc 00 10             	mov    $0x1000,%sp
       8:	b9 ff fe             	mov    $0xfeff,%cx
       b:	51                   	push   %cx
       c:	9d                   	popf
       d:	f8                   	clc
       e:	fc                   	cld
       f:	fa                   	cli
      10:	90                   	nop
      11:	9c                   	pushf
      12:	58                   	pop    %ax
      13:	ba 01 00             	mov    $0x1,%dx
      16:	52                   	push   %dx
      17:	9d                   	popf
      18:	f5                   	cmc
      19:	f9                   	stc
      1a:	fd                   	std
      1b:	fb                   	sti
      1c:	9c                   	pushf
      1d:	5b                   	pop    %bx
      1e:	b9 00 00             	mov    $0x0,%cx
      21:	8e d9                	mov    %cx,%ds
      23:	a3 00 00             	mov    %ax,0x0
      26:	89 1e 02 00          	mov    %bx,0x2
      2a:	f4                   	hlt
	...
    ffef:	00 eb                	add    %ch,%bl
    fff1:	0e                   	push   %cs
	...
    fffe:	00 ff                	add    %bh,%bh

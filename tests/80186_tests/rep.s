
80186_tests/rep.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       // trivial cases. with cx=0, nothing is executed
       0:	f3 a4                	rep movsb %ds:(%si),%es:(%di)
       2:	f3 a4                	rep movsb %ds:(%si),%es:(%di)
       4:	f2 a4                	repnz movsb %ds:(%si),%es:(%di)
       6:	f3 a6                	repz cmpsb %es:(%di),%ds:(%si)
       8:	f3 a6                	repz cmpsb %es:(%di),%ds:(%si)
       a:	f2 a6                	repnz cmpsb %es:(%di),%ds:(%si)
       c:	f3 ae                	repz scas %es:(%di),%al
       e:	f3 ae                	repz scas %es:(%di),%al
      10:	f2 ae                	repnz scas %es:(%di),%al
      12:	f3 ac                	rep lods %ds:(%si),%al
      14:	f3 ac                	rep lods %ds:(%si),%al
      16:	f2 ac                	repnz lods %ds:(%si),%al
      18:	f3 aa                	rep stos %al,%es:(%di)
      1a:	f3 aa                	rep stos %al,%es:(%di)
      1c:	f2 aa                	repnz stos %al,%es:(%di)


      1e:	bb 40 00             	mov    $0x40,%bx
      21:	53                   	push   %bx
      22:	9d                   	popf              // F=0xF042  (ZF=1)

      // Now we have the zero flag set, nothing is executed because of cx
      23:	f3 a4                	rep movsb %ds:(%si),%es:(%di)
      25:	f2 a4                	repnz movsb %ds:(%si),%es:(%di)
      27:	f3 a6                	repz cmpsb %es:(%di),%ds:(%si)
      29:	f2 a6                	repnz cmpsb %es:(%di),%ds:(%si)
      2b:	f3 ae                	repz scas %es:(%di),%al
      2d:	f2 ae                	repnz scas %es:(%di),%al
      2f:	f3 ac                	rep lods %ds:(%si),%al
      31:	f2 ac                	repnz lods %ds:(%si),%al
      33:	f3 aa                	rep stos %al,%es:(%di)
      35:	f2 aa                	repnz stos %al,%es:(%di)


      37:	89 f8                	mov    %di,%ax
      39:	b4 10                	mov    $0x10,%ah
      3b:	ff e0                	jmp    *%ax            // jump to 0xf1000
      3d:	f4                   	hlt
	
     102:	e9 48 2f             	jmp    0x304d          // rep_stos_z
	
     607:	e9 25 2a             	jmp    0x302f          // rep_lods_nz

     800:	e9 01 28                jmp    0x3004          // rep_movs_nz
	
     ffc:	eb 10                	jmp    0x100e          // cont_n5
     ffe:	eb 07                	jmp    0x1007          // cont_n10

    // Prefixes do not affect normal instructions
    1000:	b9 00 00             	mov    $0x0,%cx
    1003:	f3 51                	repz push %cx          // sp=0xffe
    1005:	ff e4                	jmp    *%sp            // jumps to f000:0ffe

    cont_n10:
    1007:	b9 0a 11             	mov    $0x110a,%cx
    100a:	f3 51                	repz push %cx
    100c:	ff e4                	jmp    *%sp
    
    cont_n5:
    100e:	ff e1                	jmp    *%cx
	
    110a:	b9 05 00             	mov    $0x5,%cx

    110d:	ba 00 00             	mov    $0x0,%dx
    1110:	52                   	push   %dx
    1111:	9d                   	popf
    1112:	f2 59                	repnz pop %cx

    1114:	89 c8                	mov    %cx,%ax
    1116:	b4 20                	mov    $0x20,%ah
    1118:	ff e0                	jmp    *%ax          // jump to 0xf200a
	
    122c:	e9 01 2e             	jmp    0x4030        // repz_cmps_nz
    122f:	e9 f2 2d             	jmp    0x4024        // repz_scas
	
    // rep movs ZF=1
    200a:	53                   	push   %bx
    200b:	9d                   	popf
    200c:	b9 02 00             	mov    $0x2,%cx
    200f:	be 00 30             	mov    $0x3000,%si
    2012:	b8 00 f0             	mov    $0xf000,%ax
    2015:	8e d8                	mov    %ax,%ds
    2017:	b8 00 10             	mov    $0x1000,%ax
    201a:	8e c0                	mov    %ax,%es
    201c:	bf 00 00             	mov    $0x0,%di

    201f:	f3 a4                	rep movsb %ds:(%si),%es:(%di)

    2021:	8e d8                	mov    %ax,%ds
    2023:	a1 00 00             	mov    0x0,%ax
    2026:	89 fd                	mov    %di,%bp
    2028:	89 02                	mov    %ax,(%bp,%si)
    202a:	e3 01                	jcxz   0x202d
    202c:	f4                   	hlt
    202d:	ff 26 04 30          	jmp    *0x3004
	

    3000:	09
    3001:	08 07                
    3003:	06                   
    3004:	05 04 03             
    3007:	02 01                
    3009:	0a 0b                
    300b:	0c 0d                

    rep_movs_nz:
    300d:	b8 00 f0             	mov    $0xf000,%ax
    3010:	8e d8                	mov    %ax,%ds
    3012:	b9 01 00             	mov    $0x1,%cx
    3015:	b8 00 00             	mov    $0x0,%ax
    3018:	50                   	push   %ax
    3019:	9d                   	popf

    301a:	f3 a5                	rep movsw %ds:(%si),%es:(%di)

    301c:	b8 00 10             	mov    $0x1000,%ax
    301f:	8e d8                	mov    %ax,%ds
    3021:	a1 02 00             	mov    0x2,%ax
    3024:	89 fd                	mov    %di,%bp
    3026:	89 02                	mov    %ax,(%bp,%si)
    3028:	e3 01                	jcxz   0x302b
    302a:	f4                   	hlt
    302b:	ff 26 08 30          	jmp    *0x3008
    
    // rep lods ZF=0
    302f:	b8 00 f0             	mov    $0xf000,%ax
    3032:	8e d8                	mov    %ax,%ds
    3034:	b9 03 00             	mov    $0x3,%cx
    3037:	f3 ac                	rep lods %ds:(%si),%al

    3039:	ff e0                	jmp    *%ax
    303b:	f4                   	hlt

    // rep lods ZF=1
    303c:	bb 40 00             	mov    $0x40,%bx
    303f:	53                   	push   %bx
    3040:	9d                   	popf
    3041:	b8 00 f0             	mov    $0xf000,%ax
    3044:	8e d8                	mov    %ax,%ds
    3046:	b9 01 00             	mov    $0x1,%cx
    3049:	f3 ad                	rep lods %ds:(%si),%ax
    304b:	ff e0                	jmp    *%ax

    // rep stos ZF=1
    304d:	b9 02 00             	mov    $0x2,%cx
    3050:	b8 00 40             	mov    $0x4000,%ax
    3053:	f3 ab                	rep stos %ax,%es:(%di)
    3055:	b8 00 10             	mov    $0x1000,%ax
    3058:	8e d8                	mov    %ax,%ds
    305a:	ff 26 06 00          	jmp    *0x6
    305e:	f4                   	hlt

	// rep stos ZF=0
    4000:   bb 00 00          	    mov    $0x0,%bx
    4003:	53                   	push   %bx
    4004:	9d                   	popf
    4005:	b9 04 00             	mov    $0x4,%cx
    4008:	f3 ab                	rep stos %ax,%es:(%di)
    400a:	e3 01                	jcxz   0x400d
    400c:	f4                   	hlt

    // repz cmps ZF=1, but ZF=0 before cx=0
    400d:	bb 40 00             	mov    $0x40,%bx
    4010:	53                   	push   %bx
    4011:	9d                   	popf
    4012:	b9 34 12             	mov    $0x1234,%cx
    4015:	be 00 30             	mov    $0x3000,%si
    4018:	bf 00 00             	mov    $0x0,%di
    401b:	b8 00 f0             	mov    $0xf000,%ax
    401e:	8e d8                	mov    %ax,%ds
    4020:	f3 a6                	repz cmpsb %es:(%di),%ds:(%si)
    4022:	ff e1                	jmp    *%cx

    // repz scas ZF=1, but ZF=0 before cx=0
    4024:	bb 40 00             	mov    $0x40,%bx
    4027:	53                   	push   %bx
    4028:	9d                   	popf
    4029:	b8 40 00             	mov    $0x40,%ax
    402c:	f3 af                	repz scas %es:(%di),%ax
    402e:	ff e1                	jmp    *%cx

    // repz cmps scas ZF=0, they do only one iteration
    4030:	b8 07 06             	mov    $0x607,%ax
    4033:	b9 04 50             	mov    $0x5004,%cx
    4036:	f3 a7                	repz cmpsw %es:(%di),%ds:(%si)
    4038:	f3 af                	repz scas %es:(%di),%ax
    403a:	bb 40 00             	mov    $0x40,%bx
    403d:	53                   	push   %bx
    403e:	9d                   	popf
    403f:	be 00 30             	mov    $0x3000,%si
    4042:	bf 00 00             	mov    $0x0,%di

    // repnz cmps scas ZF=1, they do only one iteration
    4045:	f2 a7                	repnz cmpsw %es:(%di),%ds:(%si)
    4047:	f2 af                	repnz scas %es:(%di),%ax
    4049:	ff e1                	jmp    *%cx
    404b:	f4                   	hlt

    // repnz movs ZF=1 all iterations
    5000:	b9 02 00             	mov    $0x2,%cx
    5003:	f2 a4                	repnz movsb %ds:(%si),%es:(%di)
    5005:	e3 01                	jcxz   0x5008
    5007:	f4                   	hlt

    // repnz lods ZF=1 all iterations
    5008:	b9 02 00             	mov    $0x2,%cx
    500b:	f2 ac                	repnz lods %ds:(%si),%al
    500d:	e3 01                	jcxz   0x5010
    500f:	f4                   	hlt

    // repnz stos ZF=1 all iterations
    5010:	b9 02 00             	mov    $0x2,%cx
    5013:	f2 aa                	repnz stos %al,%es:(%di)
    5015:	e3 01                	jcxz   0x5018
    5017:	f4                   	hlt

    // repnz cmps ZF=0, but ZF=1 before cx=0
    5018:	bb 00 00             	mov    $0x0,%bx
    501b:	53                   	push   %bx
    501c:	9d                   	popf
    501d:	b9 23 60             	mov    $0x6023,%cx
    5020:	fd                   	std
    5021:	bf 06 00             	mov    $0x6,%di
    5024:	be 06 30             	mov    $0x3006,%si
    5027:	f2 a7                	repnz cmpsw %es:(%di),%ds:(%si)

    // repnz scas ZF=0, but ZF=1 before cx=0
    5029:	b8 00 10             	mov    $0x1000,%ax
    502c:	bb 00 00             	mov    $0x0,%bx
    502f:	53                   	push   %bx
    5030:	9d                   	popf
    5031:	fc                   	cld
    5032:	f2 af                	repnz scas %es:(%di),%ax
    5034:	ff e1                	jmp    *%cx
    5036:	f4                   	hlt
	

    601b:	ba 00 00             	mov    $0x0,%dx
    601e:	8e da                	mov    %dx,%ds
    6020:	c7 06 04 00 34 12    	movw   $0x1234,0x4         // final result, [4]=0x1234
    6026:	f4                   	hlt

    f003:	e9 36 40             	jmp    0x303c

    // reset
    fff0:	bc 00 10             	mov    $0x1000,%sp
    fff3:	8e d4                	mov    %sp,%ss
    fff5:	eb 09                	jmp    0x10000

    ffff:	ff                   	.byte 0xff

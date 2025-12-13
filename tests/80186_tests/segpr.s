
80186_tests/segpr.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	bb 00 f1             	mov    $0xf100,%bx
       3:	8e c3                	mov    %bx,%es          // es=0xf100

       5:	26 8b 1e 00 00       	mov    %es:0x0,%bx      // bx=[es:0]=0x1100
       a:	26 a1 02 00          	mov    %es:0x2,%ax      // ax=[es:2]=0xf000
       e:	a3 02 00             	mov    %ax,0x2          // [2]=0xf000
      11:	bc 02 00             	mov    $0x2,%sp         // sp=0x0002
      14:	26 53                	es push %bx             // [0]=0x1100

      16:	26 c4 16 00 00       	les    %es:0x0,%dx      // dx=0x1100, es=0x0f00
      1b:	89 16 04 00          	mov    %dx,0x4          // [4]=0x1100
      1f:	8c c2                	mov    %es,%dx          // dx=0x0f00
      21:	89 16 06 00          	mov    %dx,0x6          // [6]=0x0f00

      25:	bf 05 00             	mov    $0x5,%di         // di=0x0005
      28:	2e 8d 73 17          	lea    %cs:0x17(%bp,%di),%si  // si=0x001c
      2c:	89 36 08 00          	mov    %si,0x8          // [8]=0x001c

      30:	bb 05 00             	mov    $0x5,%bx         // bx=0x0005
      33:	b8 05 00             	mov    $0x5,%ax         // ax=0x0005
      36:	c7 06 0a 00 45 23    	movw   $0x2345,0xa      // [a]=0x2345
      3c:	ba 00 f1             	mov    $0xf100,%dx      // dx=0xf100
      3f:	8e c2                	mov    %dx,%es          // es=0xf100
      41:	26 d7                	xlat   %es:(%bx)        // al=
      43:	a3 0c 00             	mov    %ax,0xc          // [c]=0x0078
      
      // inc with segment
      46:	b8 01 00             	mov    $0x1,%ax         // ax=0x0001
      49:	8e d0                	mov    %ax,%ss          // ss=0x0001
      4b:	c7 06 10 00 06 00    	movw   $0x6,0x10        // [0x10]=0x0006
      51:	36 ff 06 00 00       	incw   %ss:0x0          // [0x10]=0x0007

      // div with interrupt
      56:	bc 20 00             	mov    $0x20,%sp        // sp=0x0020, ss=0x1
      59:	c7 06 12 00 00 00    	movw   $0x0,0x12        // [0x12]=0x0000
      5f:	36 f3 f7 36 02 00    	repz divw %ss:0x2       // div-by-0, int0 handler at f000:1100
      65:	83 ec 06             	sub    $0x6,%sp         // sp=0x001a

      68:	c7 06 14 00 00 12    	movw   $0x1200,0x14     // [0x14]=0x1200
      6e:	bb 05 00             	mov    $0x5,%bx         // bx=0x0005
      71:	be 03 00             	mov    $0x3,%si         // si=0x0003

      // repz call with segment
      74:	f3 36 ff 50 fc       	repz call *%ss:-0x4(%bx,%si) // call 0x1200

      79:	f4                   	hlt
	
    1000:	00 11   
    1002:	00 f0   

    100a:	78 56
	
    // int0 handler
    1100:	89 e6                	mov    %sp,%si          // si=sp
    1102:	36 8b 34             	mov    %ss:(%si),%si    // si=[sp] return IP
    1105:	89 36 0e 00          	mov    %si,0xe          // [e]=return IP
    1109:	83 c6 06             	add    $0x6,%si         // si=return IP + 6
    110c:	89 e7                	mov    %sp,%di          // di=sp
    110e:	36 89 35             	mov    %si,%ss:(%di)    // [sp]=return IP + 6
    1111:	cf                   	iret

    // routine
    1200:	b9 20 f1             	mov    $0xf120,%cx       // cx=0xf120
    1203:	8e c1                	mov    %cx,%es           // es=0xf120
    1205:	be 00 02             	mov    $0x200,%si        // si=0x0200
    1208:	bf 01 0e             	mov    $0xe01,%di        // di=0x0e01

    120b:	26 a6                	cmpsb  %es:(%di),%es:(%si)  // compare [f1400]=1 and [f2001]=2
    120d:	9c                   	pushf                    // sp=

    120e:	b8 01 00             	mov    $0x1,%ax
    1211:	8e c0                	mov    %ax,%es
    1213:	bf 06 00             	mov    $0x6,%di
    1216:	be 00 14             	mov    $0x1400,%si
    1219:	b9 06 00             	mov    $0x6,%cx

    // two prefixes
    121c:	f3 2e a4             	rep movsb %cs:(%si),%es:(%di)
    121f:	f4                   	hlt
	
    1400:	01 ff     
    1402:	ff 80 02 00
    1406:	c2 
	
    2001:	02 ff 
    2003:	01 01 
    2005:	01 80
	
    fff1:	eb 0e                   jmp start
    ffff:	ff

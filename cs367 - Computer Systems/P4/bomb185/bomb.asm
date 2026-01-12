
bomb:     file format elf64-x86-64


Disassembly of section .init:

0000000000400b00 <_init>:
  400b00:	f3 0f 1e fa          	endbr64 
  400b04:	48 83 ec 08          	sub    $0x8,%rsp
  400b08:	48 8b 05 e1 34 20 00 	mov    0x2034e1(%rip),%rax        # 603ff0 <__gmon_start__@Base>
  400b0f:	48 85 c0             	test   %rax,%rax
  400b12:	74 02                	je     400b16 <_init+0x16>
  400b14:	ff d0                	callq  *%rax
  400b16:	48 83 c4 08          	add    $0x8,%rsp
  400b1a:	c3                   	retq   

Disassembly of section .plt:

0000000000400b20 <.plt>:
  400b20:	ff 35 e2 34 20 00    	pushq  0x2034e2(%rip)        # 604008 <_GLOBAL_OFFSET_TABLE_+0x8>
  400b26:	ff 25 e4 34 20 00    	jmpq   *0x2034e4(%rip)        # 604010 <_GLOBAL_OFFSET_TABLE_+0x10>
  400b2c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400b30 <getenv@plt>:
  400b30:	ff 25 e2 34 20 00    	jmpq   *0x2034e2(%rip)        # 604018 <getenv@GLIBC_2.2.5>
  400b36:	68 00 00 00 00       	pushq  $0x0
  400b3b:	e9 e0 ff ff ff       	jmpq   400b20 <.plt>

0000000000400b40 <strcasecmp@plt>:
  400b40:	ff 25 da 34 20 00    	jmpq   *0x2034da(%rip)        # 604020 <strcasecmp@GLIBC_2.2.5>
  400b46:	68 01 00 00 00       	pushq  $0x1
  400b4b:	e9 d0 ff ff ff       	jmpq   400b20 <.plt>

0000000000400b50 <__errno_location@plt>:
  400b50:	ff 25 d2 34 20 00    	jmpq   *0x2034d2(%rip)        # 604028 <__errno_location@GLIBC_2.2.5>
  400b56:	68 02 00 00 00       	pushq  $0x2
  400b5b:	e9 c0 ff ff ff       	jmpq   400b20 <.plt>

0000000000400b60 <strcpy@plt>:
  400b60:	ff 25 ca 34 20 00    	jmpq   *0x2034ca(%rip)        # 604030 <strcpy@GLIBC_2.2.5>
  400b66:	68 03 00 00 00       	pushq  $0x3
  400b6b:	e9 b0 ff ff ff       	jmpq   400b20 <.plt>

0000000000400b70 <puts@plt>:
  400b70:	ff 25 c2 34 20 00    	jmpq   *0x2034c2(%rip)        # 604038 <puts@GLIBC_2.2.5>
  400b76:	68 04 00 00 00       	pushq  $0x4
  400b7b:	e9 a0 ff ff ff       	jmpq   400b20 <.plt>

0000000000400b80 <write@plt>:
  400b80:	ff 25 ba 34 20 00    	jmpq   *0x2034ba(%rip)        # 604040 <write@GLIBC_2.2.5>
  400b86:	68 05 00 00 00       	pushq  $0x5
  400b8b:	e9 90 ff ff ff       	jmpq   400b20 <.plt>

0000000000400b90 <printf@plt>:
  400b90:	ff 25 b2 34 20 00    	jmpq   *0x2034b2(%rip)        # 604048 <printf@GLIBC_2.2.5>
  400b96:	68 06 00 00 00       	pushq  $0x6
  400b9b:	e9 80 ff ff ff       	jmpq   400b20 <.plt>

0000000000400ba0 <alarm@plt>:
  400ba0:	ff 25 aa 34 20 00    	jmpq   *0x2034aa(%rip)        # 604050 <alarm@GLIBC_2.2.5>
  400ba6:	68 07 00 00 00       	pushq  $0x7
  400bab:	e9 70 ff ff ff       	jmpq   400b20 <.plt>

0000000000400bb0 <close@plt>:
  400bb0:	ff 25 a2 34 20 00    	jmpq   *0x2034a2(%rip)        # 604058 <close@GLIBC_2.2.5>
  400bb6:	68 08 00 00 00       	pushq  $0x8
  400bbb:	e9 60 ff ff ff       	jmpq   400b20 <.plt>

0000000000400bc0 <read@plt>:
  400bc0:	ff 25 9a 34 20 00    	jmpq   *0x20349a(%rip)        # 604060 <read@GLIBC_2.2.5>
  400bc6:	68 09 00 00 00       	pushq  $0x9
  400bcb:	e9 50 ff ff ff       	jmpq   400b20 <.plt>

0000000000400bd0 <fgets@plt>:
  400bd0:	ff 25 92 34 20 00    	jmpq   *0x203492(%rip)        # 604068 <fgets@GLIBC_2.2.5>
  400bd6:	68 0a 00 00 00       	pushq  $0xa
  400bdb:	e9 40 ff ff ff       	jmpq   400b20 <.plt>

0000000000400be0 <signal@plt>:
  400be0:	ff 25 8a 34 20 00    	jmpq   *0x20348a(%rip)        # 604070 <signal@GLIBC_2.2.5>
  400be6:	68 0b 00 00 00       	pushq  $0xb
  400beb:	e9 30 ff ff ff       	jmpq   400b20 <.plt>

0000000000400bf0 <gethostbyname@plt>:
  400bf0:	ff 25 82 34 20 00    	jmpq   *0x203482(%rip)        # 604078 <gethostbyname@GLIBC_2.2.5>
  400bf6:	68 0c 00 00 00       	pushq  $0xc
  400bfb:	e9 20 ff ff ff       	jmpq   400b20 <.plt>

0000000000400c00 <fprintf@plt>:
  400c00:	ff 25 7a 34 20 00    	jmpq   *0x20347a(%rip)        # 604080 <fprintf@GLIBC_2.2.5>
  400c06:	68 0d 00 00 00       	pushq  $0xd
  400c0b:	e9 10 ff ff ff       	jmpq   400b20 <.plt>

0000000000400c10 <strtol@plt>:
  400c10:	ff 25 72 34 20 00    	jmpq   *0x203472(%rip)        # 604088 <strtol@GLIBC_2.2.5>
  400c16:	68 0e 00 00 00       	pushq  $0xe
  400c1b:	e9 00 ff ff ff       	jmpq   400b20 <.plt>

0000000000400c20 <fflush@plt>:
  400c20:	ff 25 6a 34 20 00    	jmpq   *0x20346a(%rip)        # 604090 <fflush@GLIBC_2.2.5>
  400c26:	68 0f 00 00 00       	pushq  $0xf
  400c2b:	e9 f0 fe ff ff       	jmpq   400b20 <.plt>

0000000000400c30 <__isoc99_sscanf@plt>:
  400c30:	ff 25 62 34 20 00    	jmpq   *0x203462(%rip)        # 604098 <__isoc99_sscanf@GLIBC_2.7>
  400c36:	68 10 00 00 00       	pushq  $0x10
  400c3b:	e9 e0 fe ff ff       	jmpq   400b20 <.plt>

0000000000400c40 <memmove@plt>:
  400c40:	ff 25 5a 34 20 00    	jmpq   *0x20345a(%rip)        # 6040a0 <memmove@GLIBC_2.2.5>
  400c46:	68 11 00 00 00       	pushq  $0x11
  400c4b:	e9 d0 fe ff ff       	jmpq   400b20 <.plt>

0000000000400c50 <fopen@plt>:
  400c50:	ff 25 52 34 20 00    	jmpq   *0x203452(%rip)        # 6040a8 <fopen@GLIBC_2.2.5>
  400c56:	68 12 00 00 00       	pushq  $0x12
  400c5b:	e9 c0 fe ff ff       	jmpq   400b20 <.plt>

0000000000400c60 <gethostname@plt>:
  400c60:	ff 25 4a 34 20 00    	jmpq   *0x20344a(%rip)        # 6040b0 <gethostname@GLIBC_2.2.5>
  400c66:	68 13 00 00 00       	pushq  $0x13
  400c6b:	e9 b0 fe ff ff       	jmpq   400b20 <.plt>

0000000000400c70 <sprintf@plt>:
  400c70:	ff 25 42 34 20 00    	jmpq   *0x203442(%rip)        # 6040b8 <sprintf@GLIBC_2.2.5>
  400c76:	68 14 00 00 00       	pushq  $0x14
  400c7b:	e9 a0 fe ff ff       	jmpq   400b20 <.plt>

0000000000400c80 <exit@plt>:
  400c80:	ff 25 3a 34 20 00    	jmpq   *0x20343a(%rip)        # 6040c0 <exit@GLIBC_2.2.5>
  400c86:	68 15 00 00 00       	pushq  $0x15
  400c8b:	e9 90 fe ff ff       	jmpq   400b20 <.plt>

0000000000400c90 <connect@plt>:
  400c90:	ff 25 32 34 20 00    	jmpq   *0x203432(%rip)        # 6040c8 <connect@GLIBC_2.2.5>
  400c96:	68 16 00 00 00       	pushq  $0x16
  400c9b:	e9 80 fe ff ff       	jmpq   400b20 <.plt>

0000000000400ca0 <sleep@plt>:
  400ca0:	ff 25 2a 34 20 00    	jmpq   *0x20342a(%rip)        # 6040d0 <sleep@GLIBC_2.2.5>
  400ca6:	68 17 00 00 00       	pushq  $0x17
  400cab:	e9 70 fe ff ff       	jmpq   400b20 <.plt>

0000000000400cb0 <__ctype_b_loc@plt>:
  400cb0:	ff 25 22 34 20 00    	jmpq   *0x203422(%rip)        # 6040d8 <__ctype_b_loc@GLIBC_2.3>
  400cb6:	68 18 00 00 00       	pushq  $0x18
  400cbb:	e9 60 fe ff ff       	jmpq   400b20 <.plt>

0000000000400cc0 <socket@plt>:
  400cc0:	ff 25 1a 34 20 00    	jmpq   *0x20341a(%rip)        # 6040e0 <socket@GLIBC_2.2.5>
  400cc6:	68 19 00 00 00       	pushq  $0x19
  400ccb:	e9 50 fe ff ff       	jmpq   400b20 <.plt>

Disassembly of section .text:

0000000000400cd0 <_start>:
  400cd0:	f3 0f 1e fa          	endbr64 
  400cd4:	31 ed                	xor    %ebp,%ebp
  400cd6:	49 89 d1             	mov    %rdx,%r9
  400cd9:	5e                   	pop    %rsi
  400cda:	48 89 e2             	mov    %rsp,%rdx
  400cdd:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  400ce1:	50                   	push   %rax
  400ce2:	54                   	push   %rsp
  400ce3:	49 c7 c0 20 23 40 00 	mov    $0x402320,%r8
  400cea:	48 c7 c1 b0 22 40 00 	mov    $0x4022b0,%rcx
  400cf1:	48 c7 c7 b6 0d 40 00 	mov    $0x400db6,%rdi
  400cf8:	ff 15 ea 32 20 00    	callq  *0x2032ea(%rip)        # 603fe8 <__libc_start_main@GLIBC_2.2.5>
  400cfe:	f4                   	hlt    

0000000000400cff <.annobin_init.c>:
  400cff:	90                   	nop

0000000000400d00 <_dl_relocate_static_pie>:
  400d00:	f3 0f 1e fa          	endbr64 
  400d04:	c3                   	retq   

0000000000400d05 <.annobin__dl_relocate_static_pie.end>:
  400d05:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400d0c:	00 00 00 
  400d0f:	90                   	nop

0000000000400d10 <deregister_tm_clones>:
  400d10:	48 8d 3d 69 3a 20 00 	lea    0x203a69(%rip),%rdi        # 604780 <stdout@@GLIBC_2.2.5>
  400d17:	48 8d 05 62 3a 20 00 	lea    0x203a62(%rip),%rax        # 604780 <stdout@@GLIBC_2.2.5>
  400d1e:	48 39 f8             	cmp    %rdi,%rax
  400d21:	74 15                	je     400d38 <deregister_tm_clones+0x28>
  400d23:	48 8b 05 b6 32 20 00 	mov    0x2032b6(%rip),%rax        # 603fe0 <_ITM_deregisterTMCloneTable@Base>
  400d2a:	48 85 c0             	test   %rax,%rax
  400d2d:	74 09                	je     400d38 <deregister_tm_clones+0x28>
  400d2f:	ff e0                	jmpq   *%rax
  400d31:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  400d38:	c3                   	retq   
  400d39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000400d40 <register_tm_clones>:
  400d40:	48 8d 3d 39 3a 20 00 	lea    0x203a39(%rip),%rdi        # 604780 <stdout@@GLIBC_2.2.5>
  400d47:	48 8d 35 32 3a 20 00 	lea    0x203a32(%rip),%rsi        # 604780 <stdout@@GLIBC_2.2.5>
  400d4e:	48 29 fe             	sub    %rdi,%rsi
  400d51:	48 c1 fe 03          	sar    $0x3,%rsi
  400d55:	48 89 f0             	mov    %rsi,%rax
  400d58:	48 c1 e8 3f          	shr    $0x3f,%rax
  400d5c:	48 01 c6             	add    %rax,%rsi
  400d5f:	48 d1 fe             	sar    %rsi
  400d62:	74 14                	je     400d78 <register_tm_clones+0x38>
  400d64:	48 8b 05 8d 32 20 00 	mov    0x20328d(%rip),%rax        # 603ff8 <_ITM_registerTMCloneTable@Base>
  400d6b:	48 85 c0             	test   %rax,%rax
  400d6e:	74 08                	je     400d78 <register_tm_clones+0x38>
  400d70:	ff e0                	jmpq   *%rax
  400d72:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  400d78:	c3                   	retq   
  400d79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000400d80 <__do_global_dtors_aux>:
  400d80:	f3 0f 1e fa          	endbr64 
  400d84:	80 3d 1d 3a 20 00 00 	cmpb   $0x0,0x203a1d(%rip)        # 6047a8 <completed.7303>
  400d8b:	75 13                	jne    400da0 <__do_global_dtors_aux+0x20>
  400d8d:	55                   	push   %rbp
  400d8e:	48 89 e5             	mov    %rsp,%rbp
  400d91:	e8 7a ff ff ff       	callq  400d10 <deregister_tm_clones>
  400d96:	c6 05 0b 3a 20 00 01 	movb   $0x1,0x203a0b(%rip)        # 6047a8 <completed.7303>
  400d9d:	5d                   	pop    %rbp
  400d9e:	c3                   	retq   
  400d9f:	90                   	nop
  400da0:	c3                   	retq   
  400da1:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  400da8:	00 00 00 00 
  400dac:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400db0 <frame_dummy>:
  400db0:	f3 0f 1e fa          	endbr64 
  400db4:	eb 8a                	jmp    400d40 <register_tm_clones>

0000000000400db6 <main>:
  400db6:	53                   	push   %rbx
  400db7:	83 ff 01             	cmp    $0x1,%edi
  400dba:	0f 84 e8 00 00 00    	je     400ea8 <main+0xf2>
  400dc0:	48 89 f3             	mov    %rsi,%rbx
  400dc3:	83 ff 02             	cmp    $0x2,%edi
  400dc6:	0f 85 0a 01 00 00    	jne    400ed6 <main+0x120>
  400dcc:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
  400dd0:	be 50 23 40 00       	mov    $0x402350,%esi
  400dd5:	e8 76 fe ff ff       	callq  400c50 <fopen@plt>
  400dda:	48 89 05 cf 39 20 00 	mov    %rax,0x2039cf(%rip)        # 6047b0 <infile>
  400de1:	48 85 c0             	test   %rax,%rax
  400de4:	0f 84 d1 00 00 00    	je     400ebb <main+0x105>
  400dea:	e8 f0 05 00 00       	callq  4013df <initialize_bomb>
  400def:	bf d8 23 40 00       	mov    $0x4023d8,%edi
  400df4:	e8 77 fd ff ff       	callq  400b70 <puts@plt>
  400df9:	bf 18 24 40 00       	mov    $0x402418,%edi
  400dfe:	e8 6d fd ff ff       	callq  400b70 <puts@plt>
  400e03:	e8 0c 07 00 00       	callq  401514 <read_line>
  400e08:	48 89 c7             	mov    %rax,%rdi
  400e0b:	e8 e2 00 00 00       	callq  400ef2 <phase_1>
  400e10:	e8 04 09 00 00       	callq  401719 <phase_defused>
  400e15:	bf 48 24 40 00       	mov    $0x402448,%edi
  400e1a:	e8 51 fd ff ff       	callq  400b70 <puts@plt>
  400e1f:	e8 f0 06 00 00       	callq  401514 <read_line>
  400e24:	48 89 c7             	mov    %rax,%rdi
  400e27:	e8 e4 00 00 00       	callq  400f10 <phase_2>
  400e2c:	e8 e8 08 00 00       	callq  401719 <phase_defused>
  400e31:	bf 89 23 40 00       	mov    $0x402389,%edi
  400e36:	e8 35 fd ff ff       	callq  400b70 <puts@plt>
  400e3b:	e8 d4 06 00 00       	callq  401514 <read_line>
  400e40:	48 89 c7             	mov    %rax,%rdi
  400e43:	e8 10 01 00 00       	callq  400f58 <phase_3>
  400e48:	e8 cc 08 00 00       	callq  401719 <phase_defused>
  400e4d:	bf a7 23 40 00       	mov    $0x4023a7,%edi
  400e52:	e8 19 fd ff ff       	callq  400b70 <puts@plt>
  400e57:	e8 b8 06 00 00       	callq  401514 <read_line>
  400e5c:	48 89 c7             	mov    %rax,%rdi
  400e5f:	e8 e4 01 00 00       	callq  401048 <phase_4>
  400e64:	e8 b0 08 00 00       	callq  401719 <phase_defused>
  400e69:	bf 78 24 40 00       	mov    $0x402478,%edi
  400e6e:	e8 fd fc ff ff       	callq  400b70 <puts@plt>
  400e73:	e8 9c 06 00 00       	callq  401514 <read_line>
  400e78:	48 89 c7             	mov    %rax,%rdi
  400e7b:	e8 1f 02 00 00       	callq  40109f <phase_5>
  400e80:	e8 94 08 00 00       	callq  401719 <phase_defused>
  400e85:	bf b6 23 40 00       	mov    $0x4023b6,%edi
  400e8a:	e8 e1 fc ff ff       	callq  400b70 <puts@plt>
  400e8f:	e8 80 06 00 00       	callq  401514 <read_line>
  400e94:	48 89 c7             	mov    %rax,%rdi
  400e97:	e8 71 02 00 00       	callq  40110d <phase_6>
  400e9c:	e8 78 08 00 00       	callq  401719 <phase_defused>
  400ea1:	b8 00 00 00 00       	mov    $0x0,%eax
  400ea6:	5b                   	pop    %rbx
  400ea7:	c3                   	retq   
  400ea8:	48 8b 05 e1 38 20 00 	mov    0x2038e1(%rip),%rax        # 604790 <stdin@@GLIBC_2.2.5>
  400eaf:	48 89 05 fa 38 20 00 	mov    %rax,0x2038fa(%rip)        # 6047b0 <infile>
  400eb6:	e9 2f ff ff ff       	jmpq   400dea <main+0x34>
  400ebb:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  400ebf:	48 8b 33             	mov    (%rbx),%rsi
  400ec2:	bf 52 23 40 00       	mov    $0x402352,%edi
  400ec7:	e8 c4 fc ff ff       	callq  400b90 <printf@plt>
  400ecc:	bf 08 00 00 00       	mov    $0x8,%edi
  400ed1:	e8 aa fd ff ff       	callq  400c80 <exit@plt>
  400ed6:	48 8b 36             	mov    (%rsi),%rsi
  400ed9:	bf 6f 23 40 00       	mov    $0x40236f,%edi
  400ede:	b8 00 00 00 00       	mov    $0x0,%eax
  400ee3:	e8 a8 fc ff ff       	callq  400b90 <printf@plt>
  400ee8:	bf 08 00 00 00       	mov    $0x8,%edi
  400eed:	e8 8e fd ff ff       	callq  400c80 <exit@plt>

0000000000400ef2 <phase_1>:
  400ef2:	48 83 ec 08          	sub    $0x8,%rsp
  400ef6:	be a0 24 40 00       	mov    $0x4024a0,%esi
  400efb:	e8 77 04 00 00       	callq  401377 <strings_not_equal>
  400f00:	85 c0                	test   %eax,%eax
  400f02:	75 05                	jne    400f09 <phase_1+0x17>
  400f04:	48 83 c4 08          	add    $0x8,%rsp
  400f08:	c3                   	retq   
  400f09:	e8 d5 07 00 00       	callq  4016e3 <explode_bomb>
  400f0e:	eb f4                	jmp    400f04 <phase_1+0x12>

0000000000400f10 <phase_2>:
  400f10:	53                   	push   %rbx
  400f11:	48 83 ec 20          	sub    $0x20,%rsp
  400f15:	48 89 e6             	mov    %rsp,%rsi
  400f18:	e8 f9 03 00 00       	callq  401316 <read_six_numbers>
  400f1d:	83 3c 24 0d          	cmpl   $0xd,(%rsp)
  400f21:	75 07                	jne    400f2a <phase_2+0x1a>
  400f23:	bb 01 00 00 00       	mov    $0x1,%ebx
  400f28:	eb 16                	jmp    400f40 <phase_2+0x30>
  400f2a:	e8 b4 07 00 00       	callq  4016e3 <explode_bomb>
  400f2f:	eb f2                	jmp    400f23 <phase_2+0x13>
  400f31:	e8 ad 07 00 00       	callq  4016e3 <explode_bomb>
  400f36:	48 83 c3 01          	add    $0x1,%rbx
  400f3a:	48 83 fb 05          	cmp    $0x5,%rbx
  400f3e:	74 12                	je     400f52 <phase_2+0x42>
  400f40:	8b 04 9c             	mov    (%rsp,%rbx,4),%eax
  400f43:	2b 44 9c fc          	sub    -0x4(%rsp,%rbx,4),%eax
  400f47:	89 da                	mov    %ebx,%edx
  400f49:	0f af d3             	imul   %ebx,%edx
  400f4c:	39 d0                	cmp    %edx,%eax
  400f4e:	7d e6                	jge    400f36 <phase_2+0x26>
  400f50:	eb df                	jmp    400f31 <phase_2+0x21>
  400f52:	48 83 c4 20          	add    $0x20,%rsp
  400f56:	5b                   	pop    %rbx
  400f57:	c3                   	retq   

0000000000400f58 <phase_3>:
  400f58:	48 83 ec 18          	sub    $0x18,%rsp
  400f5c:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
  400f61:	48 8d 54 24 0c       	lea    0xc(%rsp),%rdx
  400f66:	be 4e 27 40 00       	mov    $0x40274e,%esi
  400f6b:	b8 00 00 00 00       	mov    $0x0,%eax
  400f70:	e8 bb fc ff ff       	callq  400c30 <__isoc99_sscanf@plt>
  400f75:	83 f8 01             	cmp    $0x1,%eax
  400f78:	7e 16                	jle    400f90 <phase_3+0x38>
  400f7a:	8b 44 24 08          	mov    0x8(%rsp),%eax
  400f7e:	83 7c 24 0c 07       	cmpl   $0x7,0xc(%rsp)
  400f83:	77 73                	ja     400ff8 <phase_3+0xa0>
  400f85:	8b 54 24 0c          	mov    0xc(%rsp),%edx
  400f89:	ff 24 d5 00 25 40 00 	jmpq   *0x402500(,%rdx,8)
  400f90:	e8 4e 07 00 00       	callq  4016e3 <explode_bomb>
  400f95:	eb e3                	jmp    400f7a <phase_3+0x22>
  400f97:	83 c0 01             	add    $0x1,%eax
  400f9a:	ba 10 00 00 00       	mov    $0x10,%edx
  400f9f:	eb 05                	jmp    400fa6 <phase_3+0x4e>
  400fa1:	ba 20 00 00 00       	mov    $0x20,%edx
  400fa6:	83 c0 01             	add    $0x1,%eax
  400fa9:	d1 fa                	sar    %edx
  400fab:	83 c0 01             	add    $0x1,%eax
  400fae:	d1 fa                	sar    %edx
  400fb0:	83 c0 01             	add    $0x1,%eax
  400fb3:	d1 fa                	sar    %edx
  400fb5:	83 c0 01             	add    $0x1,%eax
  400fb8:	d1 fa                	sar    %edx
  400fba:	83 c0 01             	add    $0x1,%eax
  400fbd:	d1 fa                	sar    %edx
  400fbf:	83 c0 01             	add    $0x1,%eax
  400fc2:	d1 fa                	sar    %edx
  400fc4:	3d a8 01 00 00       	cmp    $0x1a8,%eax
  400fc9:	75 32                	jne    400ffd <phase_3+0xa5>
  400fcb:	83 fa 01             	cmp    $0x1,%edx
  400fce:	75 2d                	jne    400ffd <phase_3+0xa5>
  400fd0:	48 83 c4 18          	add    $0x18,%rsp
  400fd4:	c3                   	retq   
  400fd5:	ba 20 00 00 00       	mov    $0x20,%edx
  400fda:	eb cf                	jmp    400fab <phase_3+0x53>
  400fdc:	ba 20 00 00 00       	mov    $0x20,%edx
  400fe1:	eb cd                	jmp    400fb0 <phase_3+0x58>
  400fe3:	ba 20 00 00 00       	mov    $0x20,%edx
  400fe8:	eb cb                	jmp    400fb5 <phase_3+0x5d>
  400fea:	ba 20 00 00 00       	mov    $0x20,%edx
  400fef:	eb c9                	jmp    400fba <phase_3+0x62>
  400ff1:	ba 20 00 00 00       	mov    $0x20,%edx
  400ff6:	eb c7                	jmp    400fbf <phase_3+0x67>
  400ff8:	e8 e6 06 00 00       	callq  4016e3 <explode_bomb>
  400ffd:	e8 e1 06 00 00       	callq  4016e3 <explode_bomb>
  401002:	eb cc                	jmp    400fd0 <phase_3+0x78>
  401004:	ba 20 00 00 00       	mov    $0x20,%edx
  401009:	eb b9                	jmp    400fc4 <phase_3+0x6c>

000000000040100b <func4>:
  40100b:	48 83 ec 08          	sub    $0x8,%rsp
  40100f:	89 d1                	mov    %edx,%ecx
  401011:	29 f1                	sub    %esi,%ecx
  401013:	89 c8                	mov    %ecx,%eax
  401015:	c1 e8 1f             	shr    $0x1f,%eax
  401018:	01 c8                	add    %ecx,%eax
  40101a:	d1 f8                	sar    %eax
  40101c:	01 f0                	add    %esi,%eax
  40101e:	39 f8                	cmp    %edi,%eax
  401020:	7f 0c                	jg     40102e <func4+0x23>
  401022:	7c 18                	jl     40103c <func4+0x31>
  401024:	b8 00 00 00 00       	mov    $0x0,%eax
  401029:	48 83 c4 08          	add    $0x8,%rsp
  40102d:	c3                   	retq   
  40102e:	8d 50 ff             	lea    -0x1(%rax),%edx
  401031:	e8 d5 ff ff ff       	callq  40100b <func4>
  401036:	8d 44 00 01          	lea    0x1(%rax,%rax,1),%eax
  40103a:	eb ed                	jmp    401029 <func4+0x1e>
  40103c:	8d 70 01             	lea    0x1(%rax),%esi
  40103f:	e8 c7 ff ff ff       	callq  40100b <func4>
  401044:	01 c0                	add    %eax,%eax
  401046:	eb e1                	jmp    401029 <func4+0x1e>

0000000000401048 <phase_4>:
  401048:	48 83 ec 18          	sub    $0x18,%rsp
  40104c:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
  401051:	48 8d 54 24 0c       	lea    0xc(%rsp),%rdx
  401056:	be 4e 27 40 00       	mov    $0x40274e,%esi
  40105b:	b8 00 00 00 00       	mov    $0x0,%eax
  401060:	e8 cb fb ff ff       	callq  400c30 <__isoc99_sscanf@plt>
  401065:	83 f8 02             	cmp    $0x2,%eax
  401068:	75 07                	jne    401071 <phase_4+0x29>
  40106a:	83 7c 24 0c 0e       	cmpl   $0xe,0xc(%rsp)
  40106f:	76 05                	jbe    401076 <phase_4+0x2e>
  401071:	e8 6d 06 00 00       	callq  4016e3 <explode_bomb>
  401076:	ba 0e 00 00 00       	mov    $0xe,%edx
  40107b:	be 00 00 00 00       	mov    $0x0,%esi
  401080:	8b 7c 24 0c          	mov    0xc(%rsp),%edi
  401084:	e8 82 ff ff ff       	callq  40100b <func4>
  401089:	83 f8 04             	cmp    $0x4,%eax
  40108c:	75 07                	jne    401095 <phase_4+0x4d>
  40108e:	83 7c 24 08 04       	cmpl   $0x4,0x8(%rsp)
  401093:	74 05                	je     40109a <phase_4+0x52>
  401095:	e8 49 06 00 00       	callq  4016e3 <explode_bomb>
  40109a:	48 83 c4 18          	add    $0x18,%rsp
  40109e:	c3                   	retq   

000000000040109f <phase_5>:
  40109f:	48 83 ec 18          	sub    $0x18,%rsp
  4010a3:	48 8d 4c 24 04       	lea    0x4(%rsp),%rcx
  4010a8:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
  4010ad:	be ee 24 40 00       	mov    $0x4024ee,%esi
  4010b2:	b8 00 00 00 00       	mov    $0x0,%eax
  4010b7:	e8 74 fb ff ff       	callq  400c30 <__isoc99_sscanf@plt>
  4010bc:	83 f8 01             	cmp    $0x1,%eax
  4010bf:	7e 45                	jle    401106 <phase_5+0x67>
  4010c1:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  4010c6:	83 e0 0f             	and    $0xf,%eax
  4010c9:	8b 34 85 40 25 40 00 	mov    0x402540(,%rax,4),%esi
  4010d0:	48 63 c6             	movslq %esi,%rax
  4010d3:	8b 04 85 40 25 40 00 	mov    0x402540(,%rax,4),%eax
  4010da:	48 63 d0             	movslq %eax,%rdx
  4010dd:	8b 0c 95 40 25 40 00 	mov    0x402540(,%rdx,4),%ecx
  4010e4:	48 63 d1             	movslq %ecx,%rdx
  4010e7:	01 f0                	add    %esi,%eax
  4010e9:	01 c8                	add    %ecx,%eax
  4010eb:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
  4010f0:	48 83 fa 03          	cmp    $0x3,%rdx
  4010f4:	75 06                	jne    4010fc <phase_5+0x5d>
  4010f6:	39 44 24 04          	cmp    %eax,0x4(%rsp)
  4010fa:	74 05                	je     401101 <phase_5+0x62>
  4010fc:	e8 e2 05 00 00       	callq  4016e3 <explode_bomb>
  401101:	48 83 c4 18          	add    $0x18,%rsp
  401105:	c3                   	retq   
  401106:	e8 d8 05 00 00       	callq  4016e3 <explode_bomb>
  40110b:	eb b4                	jmp    4010c1 <phase_5+0x22>

000000000040110d <phase_6>:
  40110d:	41 56                	push   %r14
  40110f:	41 55                	push   %r13
  401111:	41 54                	push   %r12
  401113:	55                   	push   %rbp
  401114:	53                   	push   %rbx
  401115:	48 83 ec 50          	sub    $0x50,%rsp
  401119:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
  40111e:	e8 f3 01 00 00       	callq  401316 <read_six_numbers>
  401123:	4c 8d 64 24 30       	lea    0x30(%rsp),%r12
  401128:	4d 8d 74 24 14       	lea    0x14(%r12),%r14
  40112d:	41 bd 01 00 00 00    	mov    $0x1,%r13d
  401133:	eb 28                	jmp    40115d <phase_6+0x50>
  401135:	e8 a9 05 00 00       	callq  4016e3 <explode_bomb>
  40113a:	eb 30                	jmp    40116c <phase_6+0x5f>
  40113c:	e8 a2 05 00 00       	callq  4016e3 <explode_bomb>
  401141:	48 83 c3 01          	add    $0x1,%rbx
  401145:	83 fb 05             	cmp    $0x5,%ebx
  401148:	7f 0b                	jg     401155 <phase_6+0x48>
  40114a:	8b 44 9c 30          	mov    0x30(%rsp,%rbx,4),%eax
  40114e:	39 45 00             	cmp    %eax,0x0(%rbp)
  401151:	75 ee                	jne    401141 <phase_6+0x34>
  401153:	eb e7                	jmp    40113c <phase_6+0x2f>
  401155:	49 83 c5 01          	add    $0x1,%r13
  401159:	49 83 c4 04          	add    $0x4,%r12
  40115d:	4c 89 e5             	mov    %r12,%rbp
  401160:	41 8b 04 24          	mov    (%r12),%eax
  401164:	83 e8 01             	sub    $0x1,%eax
  401167:	83 f8 05             	cmp    $0x5,%eax
  40116a:	77 c9                	ja     401135 <phase_6+0x28>
  40116c:	4d 39 f4             	cmp    %r14,%r12
  40116f:	74 05                	je     401176 <phase_6+0x69>
  401171:	4c 89 eb             	mov    %r13,%rbx
  401174:	eb d4                	jmp    40114a <phase_6+0x3d>
  401176:	be 00 00 00 00       	mov    $0x0,%esi
  40117b:	8b 4c b4 30          	mov    0x30(%rsp,%rsi,4),%ecx
  40117f:	ba f0 42 60 00       	mov    $0x6042f0,%edx
  401184:	83 f9 01             	cmp    $0x1,%ecx
  401187:	7e 15                	jle    40119e <phase_6+0x91>
  401189:	b8 01 00 00 00       	mov    $0x1,%eax
  40118e:	ba f0 42 60 00       	mov    $0x6042f0,%edx
  401193:	48 8b 52 08          	mov    0x8(%rdx),%rdx
  401197:	83 c0 01             	add    $0x1,%eax
  40119a:	39 c8                	cmp    %ecx,%eax
  40119c:	75 f5                	jne    401193 <phase_6+0x86>
  40119e:	48 89 14 f4          	mov    %rdx,(%rsp,%rsi,8)
  4011a2:	48 83 c6 01          	add    $0x1,%rsi
  4011a6:	48 83 fe 06          	cmp    $0x6,%rsi
  4011aa:	75 cf                	jne    40117b <phase_6+0x6e>
  4011ac:	48 8b 1c 24          	mov    (%rsp),%rbx
  4011b0:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  4011b5:	48 89 43 08          	mov    %rax,0x8(%rbx)
  4011b9:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  4011be:	48 89 50 08          	mov    %rdx,0x8(%rax)
  4011c2:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  4011c7:	48 89 42 08          	mov    %rax,0x8(%rdx)
  4011cb:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
  4011d0:	48 89 50 08          	mov    %rdx,0x8(%rax)
  4011d4:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  4011d9:	48 89 42 08          	mov    %rax,0x8(%rdx)
  4011dd:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  4011e4:	00 
  4011e5:	bd 05 00 00 00       	mov    $0x5,%ebp
  4011ea:	eb 09                	jmp    4011f5 <phase_6+0xe8>
  4011ec:	48 8b 5b 08          	mov    0x8(%rbx),%rbx
  4011f0:	83 ed 01             	sub    $0x1,%ebp
  4011f3:	74 11                	je     401206 <phase_6+0xf9>
  4011f5:	48 8b 43 08          	mov    0x8(%rbx),%rax
  4011f9:	8b 00                	mov    (%rax),%eax
  4011fb:	39 03                	cmp    %eax,(%rbx)
  4011fd:	7d ed                	jge    4011ec <phase_6+0xdf>
  4011ff:	e8 df 04 00 00       	callq  4016e3 <explode_bomb>
  401204:	eb e6                	jmp    4011ec <phase_6+0xdf>
  401206:	48 83 c4 50          	add    $0x50,%rsp
  40120a:	5b                   	pop    %rbx
  40120b:	5d                   	pop    %rbp
  40120c:	41 5c                	pop    %r12
  40120e:	41 5d                	pop    %r13
  401210:	41 5e                	pop    %r14
  401212:	c3                   	retq   

0000000000401213 <fun7>:
  401213:	48 85 ff             	test   %rdi,%rdi
  401216:	74 32                	je     40124a <fun7+0x37>
  401218:	48 83 ec 08          	sub    $0x8,%rsp
  40121c:	8b 07                	mov    (%rdi),%eax
  40121e:	39 f0                	cmp    %esi,%eax
  401220:	7f 0c                	jg     40122e <fun7+0x1b>
  401222:	b8 00 00 00 00       	mov    $0x0,%eax
  401227:	75 12                	jne    40123b <fun7+0x28>
  401229:	48 83 c4 08          	add    $0x8,%rsp
  40122d:	c3                   	retq   
  40122e:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
  401232:	e8 dc ff ff ff       	callq  401213 <fun7>
  401237:	01 c0                	add    %eax,%eax
  401239:	eb ee                	jmp    401229 <fun7+0x16>
  40123b:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
  40123f:	e8 cf ff ff ff       	callq  401213 <fun7>
  401244:	8d 44 00 01          	lea    0x1(%rax,%rax,1),%eax
  401248:	eb df                	jmp    401229 <fun7+0x16>
  40124a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  40124f:	c3                   	retq   

0000000000401250 <secret_phase>:
  401250:	53                   	push   %rbx
  401251:	e8 be 02 00 00       	callq  401514 <read_line>
  401256:	ba 0a 00 00 00       	mov    $0xa,%edx
  40125b:	be 00 00 00 00       	mov    $0x0,%esi
  401260:	48 89 c7             	mov    %rax,%rdi
  401263:	e8 a8 f9 ff ff       	callq  400c10 <strtol@plt>
  401268:	48 89 c3             	mov    %rax,%rbx
  40126b:	8d 40 ff             	lea    -0x1(%rax),%eax
  40126e:	3d e8 03 00 00       	cmp    $0x3e8,%eax
  401273:	77 22                	ja     401297 <secret_phase+0x47>
  401275:	89 de                	mov    %ebx,%esi
  401277:	bf 10 41 60 00       	mov    $0x604110,%edi
  40127c:	e8 92 ff ff ff       	callq  401213 <fun7>
  401281:	83 f8 03             	cmp    $0x3,%eax
  401284:	75 18                	jne    40129e <secret_phase+0x4e>
  401286:	bf c8 24 40 00       	mov    $0x4024c8,%edi
  40128b:	e8 e0 f8 ff ff       	callq  400b70 <puts@plt>
  401290:	e8 84 04 00 00       	callq  401719 <phase_defused>
  401295:	5b                   	pop    %rbx
  401296:	c3                   	retq   
  401297:	e8 47 04 00 00       	callq  4016e3 <explode_bomb>
  40129c:	eb d7                	jmp    401275 <secret_phase+0x25>
  40129e:	e8 40 04 00 00       	callq  4016e3 <explode_bomb>
  4012a3:	eb e1                	jmp    401286 <secret_phase+0x36>

00000000004012a5 <sig_handler>:
  4012a5:	48 83 ec 08          	sub    $0x8,%rsp
  4012a9:	bf 80 25 40 00       	mov    $0x402580,%edi
  4012ae:	e8 bd f8 ff ff       	callq  400b70 <puts@plt>
  4012b3:	bf 03 00 00 00       	mov    $0x3,%edi
  4012b8:	e8 e3 f9 ff ff       	callq  400ca0 <sleep@plt>
  4012bd:	bf 21 27 40 00       	mov    $0x402721,%edi
  4012c2:	b8 00 00 00 00       	mov    $0x0,%eax
  4012c7:	e8 c4 f8 ff ff       	callq  400b90 <printf@plt>
  4012cc:	48 8b 3d ad 34 20 00 	mov    0x2034ad(%rip),%rdi        # 604780 <stdout@@GLIBC_2.2.5>
  4012d3:	e8 48 f9 ff ff       	callq  400c20 <fflush@plt>
  4012d8:	bf 01 00 00 00       	mov    $0x1,%edi
  4012dd:	e8 be f9 ff ff       	callq  400ca0 <sleep@plt>
  4012e2:	bf 29 27 40 00       	mov    $0x402729,%edi
  4012e7:	e8 84 f8 ff ff       	callq  400b70 <puts@plt>
  4012ec:	bf 10 00 00 00       	mov    $0x10,%edi
  4012f1:	e8 8a f9 ff ff       	callq  400c80 <exit@plt>

00000000004012f6 <invalid_phase>:
  4012f6:	48 83 ec 08          	sub    $0x8,%rsp
  4012fa:	48 89 fe             	mov    %rdi,%rsi
  4012fd:	bf 31 27 40 00       	mov    $0x402731,%edi
  401302:	b8 00 00 00 00       	mov    $0x0,%eax
  401307:	e8 84 f8 ff ff       	callq  400b90 <printf@plt>
  40130c:	bf 08 00 00 00       	mov    $0x8,%edi
  401311:	e8 6a f9 ff ff       	callq  400c80 <exit@plt>

0000000000401316 <read_six_numbers>:
  401316:	48 83 ec 08          	sub    $0x8,%rsp
  40131a:	48 89 f2             	mov    %rsi,%rdx
  40131d:	48 8d 4e 04          	lea    0x4(%rsi),%rcx
  401321:	48 8d 46 14          	lea    0x14(%rsi),%rax
  401325:	50                   	push   %rax
  401326:	48 8d 46 10          	lea    0x10(%rsi),%rax
  40132a:	50                   	push   %rax
  40132b:	4c 8d 4e 0c          	lea    0xc(%rsi),%r9
  40132f:	4c 8d 46 08          	lea    0x8(%rsi),%r8
  401333:	be 42 27 40 00       	mov    $0x402742,%esi
  401338:	b8 00 00 00 00       	mov    $0x0,%eax
  40133d:	e8 ee f8 ff ff       	callq  400c30 <__isoc99_sscanf@plt>
  401342:	48 83 c4 10          	add    $0x10,%rsp
  401346:	83 f8 05             	cmp    $0x5,%eax
  401349:	7e 05                	jle    401350 <read_six_numbers+0x3a>
  40134b:	48 83 c4 08          	add    $0x8,%rsp
  40134f:	c3                   	retq   
  401350:	bf 01 00 00 00       	mov    $0x1,%edi
  401355:	e8 26 f9 ff ff       	callq  400c80 <exit@plt>

000000000040135a <string_length>:
  40135a:	80 3f 00             	cmpb   $0x0,(%rdi)
  40135d:	74 12                	je     401371 <string_length+0x17>
  40135f:	b8 00 00 00 00       	mov    $0x0,%eax
  401364:	48 83 c7 01          	add    $0x1,%rdi
  401368:	83 c0 01             	add    $0x1,%eax
  40136b:	80 3f 00             	cmpb   $0x0,(%rdi)
  40136e:	75 f4                	jne    401364 <string_length+0xa>
  401370:	c3                   	retq   
  401371:	b8 00 00 00 00       	mov    $0x0,%eax
  401376:	c3                   	retq   

0000000000401377 <strings_not_equal>:
  401377:	41 54                	push   %r12
  401379:	55                   	push   %rbp
  40137a:	53                   	push   %rbx
  40137b:	48 89 fb             	mov    %rdi,%rbx
  40137e:	48 89 f5             	mov    %rsi,%rbp
  401381:	e8 d4 ff ff ff       	callq  40135a <string_length>
  401386:	41 89 c4             	mov    %eax,%r12d
  401389:	48 89 ef             	mov    %rbp,%rdi
  40138c:	e8 c9 ff ff ff       	callq  40135a <string_length>
  401391:	41 39 c4             	cmp    %eax,%r12d
  401394:	75 31                	jne    4013c7 <strings_not_equal+0x50>
  401396:	0f b6 03             	movzbl (%rbx),%eax
  401399:	84 c0                	test   %al,%al
  40139b:	74 34                	je     4013d1 <strings_not_equal+0x5a>
  40139d:	3a 45 00             	cmp    0x0(%rbp),%al
  4013a0:	75 36                	jne    4013d8 <strings_not_equal+0x61>
  4013a2:	b8 01 00 00 00       	mov    $0x1,%eax
  4013a7:	0f b6 14 03          	movzbl (%rbx,%rax,1),%edx
  4013ab:	84 d2                	test   %dl,%dl
  4013ad:	74 11                	je     4013c0 <strings_not_equal+0x49>
  4013af:	48 83 c0 01          	add    $0x1,%rax
  4013b3:	38 54 05 ff          	cmp    %dl,-0x1(%rbp,%rax,1)
  4013b7:	74 ee                	je     4013a7 <strings_not_equal+0x30>
  4013b9:	b8 01 00 00 00       	mov    $0x1,%eax
  4013be:	eb 0c                	jmp    4013cc <strings_not_equal+0x55>
  4013c0:	b8 00 00 00 00       	mov    $0x0,%eax
  4013c5:	eb 05                	jmp    4013cc <strings_not_equal+0x55>
  4013c7:	b8 01 00 00 00       	mov    $0x1,%eax
  4013cc:	5b                   	pop    %rbx
  4013cd:	5d                   	pop    %rbp
  4013ce:	41 5c                	pop    %r12
  4013d0:	c3                   	retq   
  4013d1:	b8 00 00 00 00       	mov    $0x0,%eax
  4013d6:	eb f4                	jmp    4013cc <strings_not_equal+0x55>
  4013d8:	b8 01 00 00 00       	mov    $0x1,%eax
  4013dd:	eb ed                	jmp    4013cc <strings_not_equal+0x55>

00000000004013df <initialize_bomb>:
  4013df:	53                   	push   %rbx
  4013e0:	48 81 ec 40 20 00 00 	sub    $0x2040,%rsp
  4013e7:	be a5 12 40 00       	mov    $0x4012a5,%esi
  4013ec:	bf 02 00 00 00       	mov    $0x2,%edi
  4013f1:	e8 ea f7 ff ff       	callq  400be0 <signal@plt>
  4013f6:	be 40 00 00 00       	mov    $0x40,%esi
  4013fb:	48 8d bc 24 00 20 00 	lea    0x2000(%rsp),%rdi
  401402:	00 
  401403:	e8 58 f8 ff ff       	callq  400c60 <gethostname@plt>
  401408:	85 c0                	test   %eax,%eax
  40140a:	75 43                	jne    40144f <initialize_bomb+0x70>
  40140c:	48 8b 3d 6d 2f 20 00 	mov    0x202f6d(%rip),%rdi        # 604380 <host_table>
  401413:	bb 88 43 60 00       	mov    $0x604388,%ebx
  401418:	48 85 ff             	test   %rdi,%rdi
  40141b:	74 1e                	je     40143b <initialize_bomb+0x5c>
  40141d:	48 8d b4 24 00 20 00 	lea    0x2000(%rsp),%rsi
  401424:	00 
  401425:	e8 16 f7 ff ff       	callq  400b40 <strcasecmp@plt>
  40142a:	85 c0                	test   %eax,%eax
  40142c:	74 51                	je     40147f <initialize_bomb+0xa0>
  40142e:	48 83 c3 08          	add    $0x8,%rbx
  401432:	48 8b 7b f8          	mov    -0x8(%rbx),%rdi
  401436:	48 85 ff             	test   %rdi,%rdi
  401439:	75 e2                	jne    40141d <initialize_bomb+0x3e>
  40143b:	bf f0 25 40 00       	mov    $0x4025f0,%edi
  401440:	e8 2b f7 ff ff       	callq  400b70 <puts@plt>
  401445:	bf 08 00 00 00       	mov    $0x8,%edi
  40144a:	e8 31 f8 ff ff       	callq  400c80 <exit@plt>
  40144f:	bf b8 25 40 00       	mov    $0x4025b8,%edi
  401454:	e8 17 f7 ff ff       	callq  400b70 <puts@plt>
  401459:	bf 08 00 00 00       	mov    $0x8,%edi
  40145e:	e8 1d f8 ff ff       	callq  400c80 <exit@plt>
  401463:	48 89 e6             	mov    %rsp,%rsi
  401466:	bf 54 27 40 00       	mov    $0x402754,%edi
  40146b:	b8 00 00 00 00       	mov    $0x0,%eax
  401470:	e8 1b f7 ff ff       	callq  400b90 <printf@plt>
  401475:	bf 08 00 00 00       	mov    $0x8,%edi
  40147a:	e8 01 f8 ff ff       	callq  400c80 <exit@plt>
  40147f:	48 89 e7             	mov    %rsp,%rdi
  401482:	e8 02 0c 00 00       	callq  402089 <init_driver>
  401487:	85 c0                	test   %eax,%eax
  401489:	78 d8                	js     401463 <initialize_bomb+0x84>
  40148b:	48 81 c4 40 20 00 00 	add    $0x2040,%rsp
  401492:	5b                   	pop    %rbx
  401493:	c3                   	retq   

0000000000401494 <initialize_bomb_solve>:
  401494:	c3                   	retq   

0000000000401495 <blank_line>:
  401495:	55                   	push   %rbp
  401496:	53                   	push   %rbx
  401497:	48 83 ec 08          	sub    $0x8,%rsp
  40149b:	48 89 fd             	mov    %rdi,%rbp
  40149e:	0f b6 5d 00          	movzbl 0x0(%rbp),%ebx
  4014a2:	84 db                	test   %bl,%bl
  4014a4:	74 1e                	je     4014c4 <blank_line+0x2f>
  4014a6:	e8 05 f8 ff ff       	callq  400cb0 <__ctype_b_loc@plt>
  4014ab:	48 83 c5 01          	add    $0x1,%rbp
  4014af:	48 0f be db          	movsbq %bl,%rbx
  4014b3:	48 8b 00             	mov    (%rax),%rax
  4014b6:	f6 44 58 01 20       	testb  $0x20,0x1(%rax,%rbx,2)
  4014bb:	75 e1                	jne    40149e <blank_line+0x9>
  4014bd:	b8 00 00 00 00       	mov    $0x0,%eax
  4014c2:	eb 05                	jmp    4014c9 <blank_line+0x34>
  4014c4:	b8 01 00 00 00       	mov    $0x1,%eax
  4014c9:	48 83 c4 08          	add    $0x8,%rsp
  4014cd:	5b                   	pop    %rbx
  4014ce:	5d                   	pop    %rbp
  4014cf:	c3                   	retq   

00000000004014d0 <skip>:
  4014d0:	53                   	push   %rbx
  4014d1:	48 63 05 d4 32 20 00 	movslq 0x2032d4(%rip),%rax        # 6047ac <num_input_strings>
  4014d8:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
  4014dc:	48 c1 e0 04          	shl    $0x4,%rax
  4014e0:	48 89 c7             	mov    %rax,%rdi
  4014e3:	48 81 c7 c0 47 60 00 	add    $0x6047c0,%rdi
  4014ea:	48 8b 15 bf 32 20 00 	mov    0x2032bf(%rip),%rdx        # 6047b0 <infile>
  4014f1:	be 50 00 00 00       	mov    $0x50,%esi
  4014f6:	e8 d5 f6 ff ff       	callq  400bd0 <fgets@plt>
  4014fb:	48 89 c3             	mov    %rax,%rbx
  4014fe:	48 85 c0             	test   %rax,%rax
  401501:	74 0c                	je     40150f <skip+0x3f>
  401503:	48 89 c7             	mov    %rax,%rdi
  401506:	e8 8a ff ff ff       	callq  401495 <blank_line>
  40150b:	85 c0                	test   %eax,%eax
  40150d:	75 c2                	jne    4014d1 <skip+0x1>
  40150f:	48 89 d8             	mov    %rbx,%rax
  401512:	5b                   	pop    %rbx
  401513:	c3                   	retq   

0000000000401514 <read_line>:
  401514:	48 83 ec 08          	sub    $0x8,%rsp
  401518:	b8 00 00 00 00       	mov    $0x0,%eax
  40151d:	e8 ae ff ff ff       	callq  4014d0 <skip>
  401522:	48 85 c0             	test   %rax,%rax
  401525:	74 71                	je     401598 <read_line+0x84>
  401527:	44 8b 05 7e 32 20 00 	mov    0x20327e(%rip),%r8d        # 6047ac <num_input_strings>
  40152e:	49 63 c0             	movslq %r8d,%rax
  401531:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
  401535:	48 c1 e0 04          	shl    $0x4,%rax
  401539:	48 89 c2             	mov    %rax,%rdx
  40153c:	48 81 c2 c0 47 60 00 	add    $0x6047c0,%rdx
  401543:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  40154a:	b8 00 00 00 00       	mov    $0x0,%eax
  40154f:	48 89 d7             	mov    %rdx,%rdi
  401552:	f2 ae                	repnz scas %es:(%rdi),%al
  401554:	48 89 ce             	mov    %rcx,%rsi
  401557:	48 f7 d6             	not    %rsi
  40155a:	48 89 f1             	mov    %rsi,%rcx
  40155d:	48 83 e9 01          	sub    $0x1,%rcx
  401561:	83 f9 4e             	cmp    $0x4e,%ecx
  401564:	0f 8f a0 00 00 00    	jg     40160a <read_line+0xf6>
  40156a:	83 e9 01             	sub    $0x1,%ecx
  40156d:	48 63 c9             	movslq %ecx,%rcx
  401570:	49 63 c0             	movslq %r8d,%rax
  401573:	48 8d 34 80          	lea    (%rax,%rax,4),%rsi
  401577:	48 89 f0             	mov    %rsi,%rax
  40157a:	48 c1 e0 04          	shl    $0x4,%rax
  40157e:	c6 84 01 c0 47 60 00 	movb   $0x0,0x6047c0(%rcx,%rax,1)
  401585:	00 
  401586:	41 8d 40 01          	lea    0x1(%r8),%eax
  40158a:	89 05 1c 32 20 00    	mov    %eax,0x20321c(%rip)        # 6047ac <num_input_strings>
  401590:	48 89 d0             	mov    %rdx,%rax
  401593:	48 83 c4 08          	add    $0x8,%rsp
  401597:	c3                   	retq   
  401598:	48 8b 05 f1 31 20 00 	mov    0x2031f1(%rip),%rax        # 604790 <stdin@@GLIBC_2.2.5>
  40159f:	48 39 05 0a 32 20 00 	cmp    %rax,0x20320a(%rip)        # 6047b0 <infile>
  4015a6:	74 19                	je     4015c1 <read_line+0xad>
  4015a8:	bf 8c 27 40 00       	mov    $0x40278c,%edi
  4015ad:	e8 7e f5 ff ff       	callq  400b30 <getenv@plt>
  4015b2:	48 85 c0             	test   %rax,%rax
  4015b5:	74 1e                	je     4015d5 <read_line+0xc1>
  4015b7:	bf 00 00 00 00       	mov    $0x0,%edi
  4015bc:	e8 bf f6 ff ff       	callq  400c80 <exit@plt>
  4015c1:	bf 6e 27 40 00       	mov    $0x40276e,%edi
  4015c6:	e8 a5 f5 ff ff       	callq  400b70 <puts@plt>
  4015cb:	bf 08 00 00 00       	mov    $0x8,%edi
  4015d0:	e8 ab f6 ff ff       	callq  400c80 <exit@plt>
  4015d5:	48 8b 05 b4 31 20 00 	mov    0x2031b4(%rip),%rax        # 604790 <stdin@@GLIBC_2.2.5>
  4015dc:	48 89 05 cd 31 20 00 	mov    %rax,0x2031cd(%rip)        # 6047b0 <infile>
  4015e3:	b8 00 00 00 00       	mov    $0x0,%eax
  4015e8:	e8 e3 fe ff ff       	callq  4014d0 <skip>
  4015ed:	48 85 c0             	test   %rax,%rax
  4015f0:	0f 85 31 ff ff ff    	jne    401527 <read_line+0x13>
  4015f6:	bf 6e 27 40 00       	mov    $0x40276e,%edi
  4015fb:	e8 70 f5 ff ff       	callq  400b70 <puts@plt>
  401600:	bf 00 00 00 00       	mov    $0x0,%edi
  401605:	e8 76 f6 ff ff       	callq  400c80 <exit@plt>
  40160a:	bf 97 27 40 00       	mov    $0x402797,%edi
  40160f:	e8 5c f5 ff ff       	callq  400b70 <puts@plt>
  401614:	8b 05 92 31 20 00    	mov    0x203192(%rip),%eax        # 6047ac <num_input_strings>
  40161a:	8d 50 01             	lea    0x1(%rax),%edx
  40161d:	89 15 89 31 20 00    	mov    %edx,0x203189(%rip)        # 6047ac <num_input_strings>
  401623:	48 98                	cltq   
  401625:	48 6b c0 50          	imul   $0x50,%rax,%rax
  401629:	48 be 2a 2a 2a 74 72 	movabs $0x636e7572742a2a2a,%rsi
  401630:	75 6e 63 
  401633:	48 bf 61 74 65 64 2a 	movabs $0x2a2a2a64657461,%rdi
  40163a:	2a 2a 00 
  40163d:	48 89 b0 c0 47 60 00 	mov    %rsi,0x6047c0(%rax)
  401644:	48 89 b8 c8 47 60 00 	mov    %rdi,0x6047c8(%rax)
  40164b:	bf 01 00 00 00       	mov    $0x1,%edi
  401650:	e8 2b f6 ff ff       	callq  400c80 <exit@plt>

0000000000401655 <send_msg>:
  401655:	48 81 ec 08 40 00 00 	sub    $0x4008,%rsp
  40165c:	44 8b 05 49 31 20 00 	mov    0x203149(%rip),%r8d        # 6047ac <num_input_strings>
  401663:	41 8d 40 ff          	lea    -0x1(%r8),%eax
  401667:	48 98                	cltq   
  401669:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
  40166d:	48 c1 e0 04          	shl    $0x4,%rax
  401671:	49 89 c1             	mov    %rax,%r9
  401674:	49 81 c1 c0 47 60 00 	add    $0x6047c0,%r9
  40167b:	b9 ba 27 40 00       	mov    $0x4027ba,%ecx
  401680:	85 ff                	test   %edi,%edi
  401682:	74 05                	je     401689 <send_msg+0x34>
  401684:	b9 b2 27 40 00       	mov    $0x4027b2,%ecx
  401689:	8b 15 dd 2c 20 00    	mov    0x202cdd(%rip),%edx        # 60436c <bomb_id>
  40168f:	be c3 27 40 00       	mov    $0x4027c3,%esi
  401694:	48 8d bc 24 00 20 00 	lea    0x2000(%rsp),%rdi
  40169b:	00 
  40169c:	b8 00 00 00 00       	mov    $0x0,%eax
  4016a1:	e8 ca f5 ff ff       	callq  400c70 <sprintf@plt>
  4016a6:	49 89 e0             	mov    %rsp,%r8
  4016a9:	b9 00 00 00 00       	mov    $0x0,%ecx
  4016ae:	48 8d 94 24 00 20 00 	lea    0x2000(%rsp),%rdx
  4016b5:	00 
  4016b6:	be 50 43 60 00       	mov    $0x604350,%esi
  4016bb:	bf 65 43 60 00       	mov    $0x604365,%edi
  4016c0:	e8 75 0b 00 00       	callq  40223a <driver_post>
  4016c5:	85 c0                	test   %eax,%eax
  4016c7:	78 08                	js     4016d1 <send_msg+0x7c>
  4016c9:	48 81 c4 08 40 00 00 	add    $0x4008,%rsp
  4016d0:	c3                   	retq   
  4016d1:	48 89 e7             	mov    %rsp,%rdi
  4016d4:	e8 97 f4 ff ff       	callq  400b70 <puts@plt>
  4016d9:	bf 00 00 00 00       	mov    $0x0,%edi
  4016de:	e8 9d f5 ff ff       	callq  400c80 <exit@plt>

00000000004016e3 <explode_bomb>:
  4016e3:	48 83 ec 08          	sub    $0x8,%rsp
  4016e7:	bf cf 27 40 00       	mov    $0x4027cf,%edi
  4016ec:	e8 7f f4 ff ff       	callq  400b70 <puts@plt>
  4016f1:	bf d8 27 40 00       	mov    $0x4027d8,%edi
  4016f6:	e8 75 f4 ff ff       	callq  400b70 <puts@plt>
  4016fb:	bf 00 00 00 00       	mov    $0x0,%edi
  401700:	e8 50 ff ff ff       	callq  401655 <send_msg>
  401705:	bf 28 26 40 00       	mov    $0x402628,%edi
  40170a:	e8 61 f4 ff ff       	callq  400b70 <puts@plt>
  40170f:	bf 08 00 00 00       	mov    $0x8,%edi
  401714:	e8 67 f5 ff ff       	callq  400c80 <exit@plt>

0000000000401719 <phase_defused>:
  401719:	48 83 ec 68          	sub    $0x68,%rsp
  40171d:	bf 01 00 00 00       	mov    $0x1,%edi
  401722:	e8 2e ff ff ff       	callq  401655 <send_msg>
  401727:	83 3d 7e 30 20 00 06 	cmpl   $0x6,0x20307e(%rip)        # 6047ac <num_input_strings>
  40172e:	74 05                	je     401735 <phase_defused+0x1c>
  401730:	48 83 c4 68          	add    $0x68,%rsp
  401734:	c3                   	retq   
  401735:	4c 8d 44 24 10       	lea    0x10(%rsp),%r8
  40173a:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
  40173f:	48 8d 54 24 0c       	lea    0xc(%rsp),%rdx
  401744:	be ef 27 40 00       	mov    $0x4027ef,%esi
  401749:	bf b0 48 60 00       	mov    $0x6048b0,%edi
  40174e:	b8 00 00 00 00       	mov    $0x0,%eax
  401753:	e8 d8 f4 ff ff       	callq  400c30 <__isoc99_sscanf@plt>
  401758:	83 f8 03             	cmp    $0x3,%eax
  40175b:	74 16                	je     401773 <phase_defused+0x5a>
  40175d:	bf b0 26 40 00       	mov    $0x4026b0,%edi
  401762:	e8 09 f4 ff ff       	callq  400b70 <puts@plt>
  401767:	bf e0 26 40 00       	mov    $0x4026e0,%edi
  40176c:	e8 ff f3 ff ff       	callq  400b70 <puts@plt>
  401771:	eb bd                	jmp    401730 <phase_defused+0x17>
  401773:	be f8 27 40 00       	mov    $0x4027f8,%esi
  401778:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
  40177d:	e8 f5 fb ff ff       	callq  401377 <strings_not_equal>
  401782:	85 c0                	test   %eax,%eax
  401784:	75 d7                	jne    40175d <phase_defused+0x44>
  401786:	bf 50 26 40 00       	mov    $0x402650,%edi
  40178b:	e8 e0 f3 ff ff       	callq  400b70 <puts@plt>
  401790:	bf 78 26 40 00       	mov    $0x402678,%edi
  401795:	e8 d6 f3 ff ff       	callq  400b70 <puts@plt>
  40179a:	b8 00 00 00 00       	mov    $0x0,%eax
  40179f:	e8 ac fa ff ff       	callq  401250 <secret_phase>
  4017a4:	eb b7                	jmp    40175d <phase_defused+0x44>

00000000004017a6 <sigalrm_handler>:
  4017a6:	48 83 ec 08          	sub    $0x8,%rsp
  4017aa:	ba 00 00 00 00       	mov    $0x0,%edx
  4017af:	be 20 28 40 00       	mov    $0x402820,%esi
  4017b4:	48 8b 3d e5 2f 20 00 	mov    0x202fe5(%rip),%rdi        # 6047a0 <stderr@@GLIBC_2.2.5>
  4017bb:	b8 00 00 00 00       	mov    $0x0,%eax
  4017c0:	e8 3b f4 ff ff       	callq  400c00 <fprintf@plt>
  4017c5:	bf 01 00 00 00       	mov    $0x1,%edi
  4017ca:	e8 b1 f4 ff ff       	callq  400c80 <exit@plt>

00000000004017cf <rio_readlineb>:
  4017cf:	41 56                	push   %r14
  4017d1:	41 55                	push   %r13
  4017d3:	41 54                	push   %r12
  4017d5:	55                   	push   %rbp
  4017d6:	53                   	push   %rbx
  4017d7:	48 89 f5             	mov    %rsi,%rbp
  4017da:	48 83 fa 01          	cmp    $0x1,%rdx
  4017de:	0f 86 9d 00 00 00    	jbe    401881 <rio_readlineb+0xb2>
  4017e4:	48 89 fb             	mov    %rdi,%rbx
  4017e7:	4c 8d 74 16 ff       	lea    -0x1(%rsi,%rdx,1),%r14
  4017ec:	41 bc 01 00 00 00    	mov    $0x1,%r12d
  4017f2:	4c 8d 6f 10          	lea    0x10(%rdi),%r13
  4017f6:	eb 17                	jmp    40180f <rio_readlineb+0x40>
  4017f8:	e8 53 f3 ff ff       	callq  400b50 <__errno_location@plt>
  4017fd:	83 38 04             	cmpl   $0x4,(%rax)
  401800:	74 0d                	je     40180f <rio_readlineb+0x40>
  401802:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  401809:	eb 28                	jmp    401833 <rio_readlineb+0x64>
  40180b:	4c 89 6b 08          	mov    %r13,0x8(%rbx)
  40180f:	8b 53 04             	mov    0x4(%rbx),%edx
  401812:	85 d2                	test   %edx,%edx
  401814:	7f 2e                	jg     401844 <rio_readlineb+0x75>
  401816:	ba 00 20 00 00       	mov    $0x2000,%edx
  40181b:	4c 89 ee             	mov    %r13,%rsi
  40181e:	8b 3b                	mov    (%rbx),%edi
  401820:	e8 9b f3 ff ff       	callq  400bc0 <read@plt>
  401825:	89 43 04             	mov    %eax,0x4(%rbx)
  401828:	85 c0                	test   %eax,%eax
  40182a:	78 cc                	js     4017f8 <rio_readlineb+0x29>
  40182c:	75 dd                	jne    40180b <rio_readlineb+0x3c>
  40182e:	b8 00 00 00 00       	mov    $0x0,%eax
  401833:	85 c0                	test   %eax,%eax
  401835:	75 52                	jne    401889 <rio_readlineb+0xba>
  401837:	41 83 fc 01          	cmp    $0x1,%r12d
  40183b:	75 34                	jne    401871 <rio_readlineb+0xa2>
  40183d:	b8 00 00 00 00       	mov    $0x0,%eax
  401842:	eb 34                	jmp    401878 <rio_readlineb+0xa9>
  401844:	48 8b 43 08          	mov    0x8(%rbx),%rax
  401848:	0f b6 08             	movzbl (%rax),%ecx
  40184b:	48 83 c0 01          	add    $0x1,%rax
  40184f:	48 89 43 08          	mov    %rax,0x8(%rbx)
  401853:	83 ea 01             	sub    $0x1,%edx
  401856:	89 53 04             	mov    %edx,0x4(%rbx)
  401859:	48 83 c5 01          	add    $0x1,%rbp
  40185d:	88 4d ff             	mov    %cl,-0x1(%rbp)
  401860:	80 f9 0a             	cmp    $0xa,%cl
  401863:	74 0c                	je     401871 <rio_readlineb+0xa2>
  401865:	41 83 c4 01          	add    $0x1,%r12d
  401869:	4c 39 f5             	cmp    %r14,%rbp
  40186c:	75 a1                	jne    40180f <rio_readlineb+0x40>
  40186e:	4c 89 f5             	mov    %r14,%rbp
  401871:	c6 45 00 00          	movb   $0x0,0x0(%rbp)
  401875:	49 63 c4             	movslq %r12d,%rax
  401878:	5b                   	pop    %rbx
  401879:	5d                   	pop    %rbp
  40187a:	41 5c                	pop    %r12
  40187c:	41 5d                	pop    %r13
  40187e:	41 5e                	pop    %r14
  401880:	c3                   	retq   
  401881:	41 bc 01 00 00 00    	mov    $0x1,%r12d
  401887:	eb e8                	jmp    401871 <rio_readlineb+0xa2>
  401889:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  401890:	eb e6                	jmp    401878 <rio_readlineb+0xa9>

0000000000401892 <submitr>:
  401892:	41 57                	push   %r15
  401894:	41 56                	push   %r14
  401896:	41 55                	push   %r13
  401898:	41 54                	push   %r12
  40189a:	55                   	push   %rbp
  40189b:	53                   	push   %rbx
  40189c:	48 81 ec 68 a0 00 00 	sub    $0xa068,%rsp
  4018a3:	48 89 fd             	mov    %rdi,%rbp
  4018a6:	41 89 f5             	mov    %esi,%r13d
  4018a9:	48 89 14 24          	mov    %rdx,(%rsp)
  4018ad:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
  4018b2:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
  4018b7:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
  4018bc:	48 8b 9c 24 a0 a0 00 	mov    0xa0a0(%rsp),%rbx
  4018c3:	00 
  4018c4:	4c 8b bc 24 a8 a0 00 	mov    0xa0a8(%rsp),%r15
  4018cb:	00 
  4018cc:	c7 84 24 3c 20 00 00 	movl   $0x0,0x203c(%rsp)
  4018d3:	00 00 00 00 
  4018d7:	ba 00 00 00 00       	mov    $0x0,%edx
  4018dc:	be 01 00 00 00       	mov    $0x1,%esi
  4018e1:	bf 02 00 00 00       	mov    $0x2,%edi
  4018e6:	e8 d5 f3 ff ff       	callq  400cc0 <socket@plt>
  4018eb:	85 c0                	test   %eax,%eax
  4018ed:	0f 88 35 01 00 00    	js     401a28 <submitr+0x196>
  4018f3:	41 89 c4             	mov    %eax,%r12d
  4018f6:	48 89 ef             	mov    %rbp,%rdi
  4018f9:	e8 f2 f2 ff ff       	callq  400bf0 <gethostbyname@plt>
  4018fe:	48 85 c0             	test   %rax,%rax
  401901:	0f 84 71 01 00 00    	je     401a78 <submitr+0x1e6>
  401907:	48 8d b4 24 50 a0 00 	lea    0xa050(%rsp),%rsi
  40190e:	00 
  40190f:	48 c7 84 24 52 a0 00 	movq   $0x0,0xa052(%rsp)
  401916:	00 00 00 00 00 
  40191b:	c7 84 24 5a a0 00 00 	movl   $0x0,0xa05a(%rsp)
  401922:	00 00 00 00 
  401926:	66 c7 84 24 5e a0 00 	movw   $0x0,0xa05e(%rsp)
  40192d:	00 00 00 
  401930:	66 c7 84 24 50 a0 00 	movw   $0x2,0xa050(%rsp)
  401937:	00 02 00 
  40193a:	48 63 50 14          	movslq 0x14(%rax),%rdx
  40193e:	48 8b 40 18          	mov    0x18(%rax),%rax
  401942:	48 8d 7e 04          	lea    0x4(%rsi),%rdi
  401946:	48 8b 30             	mov    (%rax),%rsi
  401949:	e8 f2 f2 ff ff       	callq  400c40 <memmove@plt>
  40194e:	66 41 c1 c5 08       	rol    $0x8,%r13w
  401953:	66 44 89 ac 24 52 a0 	mov    %r13w,0xa052(%rsp)
  40195a:	00 00 
  40195c:	ba 10 00 00 00       	mov    $0x10,%edx
  401961:	48 8d b4 24 50 a0 00 	lea    0xa050(%rsp),%rsi
  401968:	00 
  401969:	44 89 e7             	mov    %r12d,%edi
  40196c:	e8 1f f3 ff ff       	callq  400c90 <connect@plt>
  401971:	85 c0                	test   %eax,%eax
  401973:	0f 88 6a 01 00 00    	js     401ae3 <submitr+0x251>
  401979:	49 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%r9
  401980:	b8 00 00 00 00       	mov    $0x0,%eax
  401985:	4c 89 c9             	mov    %r9,%rcx
  401988:	48 89 df             	mov    %rbx,%rdi
  40198b:	f2 ae                	repnz scas %es:(%rdi),%al
  40198d:	48 89 ce             	mov    %rcx,%rsi
  401990:	48 f7 d6             	not    %rsi
  401993:	4c 89 c9             	mov    %r9,%rcx
  401996:	48 8b 3c 24          	mov    (%rsp),%rdi
  40199a:	f2 ae                	repnz scas %es:(%rdi),%al
  40199c:	49 89 c8             	mov    %rcx,%r8
  40199f:	4c 89 c9             	mov    %r9,%rcx
  4019a2:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  4019a7:	f2 ae                	repnz scas %es:(%rdi),%al
  4019a9:	48 f7 d1             	not    %rcx
  4019ac:	48 89 ca             	mov    %rcx,%rdx
  4019af:	4c 89 c9             	mov    %r9,%rcx
  4019b2:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  4019b7:	f2 ae                	repnz scas %es:(%rdi),%al
  4019b9:	4c 29 c2             	sub    %r8,%rdx
  4019bc:	48 29 ca             	sub    %rcx,%rdx
  4019bf:	48 8d 44 76 fd       	lea    -0x3(%rsi,%rsi,2),%rax
  4019c4:	48 8d 44 02 7b       	lea    0x7b(%rdx,%rax,1),%rax
  4019c9:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
  4019cf:	0f 87 6b 01 00 00    	ja     401b40 <submitr+0x2ae>
  4019d5:	48 8d 94 24 40 40 00 	lea    0x4040(%rsp),%rdx
  4019dc:	00 
  4019dd:	b9 00 04 00 00       	mov    $0x400,%ecx
  4019e2:	b8 00 00 00 00       	mov    $0x0,%eax
  4019e7:	48 89 d7             	mov    %rdx,%rdi
  4019ea:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  4019ed:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  4019f4:	48 89 df             	mov    %rbx,%rdi
  4019f7:	f2 ae                	repnz scas %es:(%rdi),%al
  4019f9:	48 89 ce             	mov    %rcx,%rsi
  4019fc:	48 f7 d6             	not    %rsi
  4019ff:	48 89 f1             	mov    %rsi,%rcx
  401a02:	48 83 e9 01          	sub    $0x1,%rcx
  401a06:	85 c9                	test   %ecx,%ecx
  401a08:	0f 84 b8 04 00 00    	je     401ec6 <submitr+0x634>
  401a0e:	8d 41 ff             	lea    -0x1(%rcx),%eax
  401a11:	4c 8d 74 03 01       	lea    0x1(%rbx,%rax,1),%r14
  401a16:	48 89 d5             	mov    %rdx,%rbp
  401a19:	49 bd d9 ff 00 00 00 	movabs $0x2000000000ffd9,%r13
  401a20:	00 20 00 
  401a23:	e9 a5 01 00 00       	jmpq   401bcd <submitr+0x33b>
  401a28:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  401a2f:	3a 20 43 
  401a32:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
  401a39:	20 75 6e 
  401a3c:	49 89 07             	mov    %rax,(%r15)
  401a3f:	49 89 57 08          	mov    %rdx,0x8(%r15)
  401a43:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  401a4a:	74 6f 20 
  401a4d:	48 ba 63 72 65 61 74 	movabs $0x7320657461657263,%rdx
  401a54:	65 20 73 
  401a57:	49 89 47 10          	mov    %rax,0x10(%r15)
  401a5b:	49 89 57 18          	mov    %rdx,0x18(%r15)
  401a5f:	41 c7 47 20 6f 63 6b 	movl   $0x656b636f,0x20(%r15)
  401a66:	65 
  401a67:	66 41 c7 47 24 74 00 	movw   $0x74,0x24(%r15)
  401a6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401a73:	e9 dd 02 00 00       	jmpq   401d55 <submitr+0x4c3>
  401a78:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
  401a7f:	3a 20 44 
  401a82:	48 ba 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rdx
  401a89:	20 75 6e 
  401a8c:	49 89 07             	mov    %rax,(%r15)
  401a8f:	49 89 57 08          	mov    %rdx,0x8(%r15)
  401a93:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  401a9a:	74 6f 20 
  401a9d:	48 ba 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rdx
  401aa4:	76 65 20 
  401aa7:	49 89 47 10          	mov    %rax,0x10(%r15)
  401aab:	49 89 57 18          	mov    %rdx,0x18(%r15)
  401aaf:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
  401ab6:	72 20 61 
  401ab9:	49 89 47 20          	mov    %rax,0x20(%r15)
  401abd:	41 c7 47 28 64 64 72 	movl   $0x65726464,0x28(%r15)
  401ac4:	65 
  401ac5:	66 41 c7 47 2c 73 73 	movw   $0x7373,0x2c(%r15)
  401acc:	41 c6 47 2e 00       	movb   $0x0,0x2e(%r15)
  401ad1:	44 89 e7             	mov    %r12d,%edi
  401ad4:	e8 d7 f0 ff ff       	callq  400bb0 <close@plt>
  401ad9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401ade:	e9 72 02 00 00       	jmpq   401d55 <submitr+0x4c3>
  401ae3:	48 b8 45 72 72 6f 72 	movabs $0x55203a726f727245,%rax
  401aea:	3a 20 55 
  401aed:	48 ba 6e 61 62 6c 65 	movabs $0x6f7420656c62616e,%rdx
  401af4:	20 74 6f 
  401af7:	49 89 07             	mov    %rax,(%r15)
  401afa:	49 89 57 08          	mov    %rdx,0x8(%r15)
  401afe:	48 b8 20 63 6f 6e 6e 	movabs $0x7463656e6e6f6320,%rax
  401b05:	65 63 74 
  401b08:	48 ba 20 74 6f 20 74 	movabs $0x20656874206f7420,%rdx
  401b0f:	68 65 20 
  401b12:	49 89 47 10          	mov    %rax,0x10(%r15)
  401b16:	49 89 57 18          	mov    %rdx,0x18(%r15)
  401b1a:	41 c7 47 20 73 65 72 	movl   $0x76726573,0x20(%r15)
  401b21:	76 
  401b22:	66 41 c7 47 24 65 72 	movw   $0x7265,0x24(%r15)
  401b29:	41 c6 47 26 00       	movb   $0x0,0x26(%r15)
  401b2e:	44 89 e7             	mov    %r12d,%edi
  401b31:	e8 7a f0 ff ff       	callq  400bb0 <close@plt>
  401b36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401b3b:	e9 15 02 00 00       	jmpq   401d55 <submitr+0x4c3>
  401b40:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
  401b47:	3a 20 52 
  401b4a:	48 ba 65 73 75 6c 74 	movabs $0x747320746c757365,%rdx
  401b51:	20 73 74 
  401b54:	49 89 07             	mov    %rax,(%r15)
  401b57:	49 89 57 08          	mov    %rdx,0x8(%r15)
  401b5b:	48 b8 72 69 6e 67 20 	movabs $0x6f6f7420676e6972,%rax
  401b62:	74 6f 6f 
  401b65:	48 ba 20 6c 61 72 67 	movabs $0x202e656772616c20,%rdx
  401b6c:	65 2e 20 
  401b6f:	49 89 47 10          	mov    %rax,0x10(%r15)
  401b73:	49 89 57 18          	mov    %rdx,0x18(%r15)
  401b77:	48 b8 49 6e 63 72 65 	movabs $0x6573616572636e49,%rax
  401b7e:	61 73 65 
  401b81:	48 ba 20 53 55 42 4d 	movabs $0x5254494d42555320,%rdx
  401b88:	49 54 52 
  401b8b:	49 89 47 20          	mov    %rax,0x20(%r15)
  401b8f:	49 89 57 28          	mov    %rdx,0x28(%r15)
  401b93:	48 b8 5f 4d 41 58 42 	movabs $0x46554258414d5f,%rax
  401b9a:	55 46 00 
  401b9d:	49 89 47 30          	mov    %rax,0x30(%r15)
  401ba1:	44 89 e7             	mov    %r12d,%edi
  401ba4:	e8 07 f0 ff ff       	callq  400bb0 <close@plt>
  401ba9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401bae:	e9 a2 01 00 00       	jmpq   401d55 <submitr+0x4c3>
  401bb3:	49 0f a3 c5          	bt     %rax,%r13
  401bb7:	73 1e                	jae    401bd7 <submitr+0x345>
  401bb9:	88 55 00             	mov    %dl,0x0(%rbp)
  401bbc:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
  401bc0:	48 83 c3 01          	add    $0x1,%rbx
  401bc4:	4c 39 f3             	cmp    %r14,%rbx
  401bc7:	0f 84 f9 02 00 00    	je     401ec6 <submitr+0x634>
  401bcd:	0f b6 13             	movzbl (%rbx),%edx
  401bd0:	8d 42 d6             	lea    -0x2a(%rdx),%eax
  401bd3:	3c 35                	cmp    $0x35,%al
  401bd5:	76 dc                	jbe    401bb3 <submitr+0x321>
  401bd7:	89 d0                	mov    %edx,%eax
  401bd9:	83 e0 df             	and    $0xffffffdf,%eax
  401bdc:	83 e8 41             	sub    $0x41,%eax
  401bdf:	3c 19                	cmp    $0x19,%al
  401be1:	76 d6                	jbe    401bb9 <submitr+0x327>
  401be3:	80 fa 20             	cmp    $0x20,%dl
  401be6:	74 45                	je     401c2d <submitr+0x39b>
  401be8:	8d 42 e0             	lea    -0x20(%rdx),%eax
  401beb:	3c 5f                	cmp    $0x5f,%al
  401bed:	76 09                	jbe    401bf8 <submitr+0x366>
  401bef:	80 fa 09             	cmp    $0x9,%dl
  401bf2:	0f 85 41 02 00 00    	jne    401e39 <submitr+0x5a7>
  401bf8:	0f b6 d2             	movzbl %dl,%edx
  401bfb:	be f8 28 40 00       	mov    $0x4028f8,%esi
  401c00:	48 8d 7c 24 28       	lea    0x28(%rsp),%rdi
  401c05:	b8 00 00 00 00       	mov    $0x0,%eax
  401c0a:	e8 61 f0 ff ff       	callq  400c70 <sprintf@plt>
  401c0f:	0f b6 44 24 28       	movzbl 0x28(%rsp),%eax
  401c14:	88 45 00             	mov    %al,0x0(%rbp)
  401c17:	0f b6 44 24 29       	movzbl 0x29(%rsp),%eax
  401c1c:	88 45 01             	mov    %al,0x1(%rbp)
  401c1f:	0f b6 44 24 2a       	movzbl 0x2a(%rsp),%eax
  401c24:	88 45 02             	mov    %al,0x2(%rbp)
  401c27:	48 8d 6d 03          	lea    0x3(%rbp),%rbp
  401c2b:	eb 93                	jmp    401bc0 <submitr+0x32e>
  401c2d:	c6 45 00 2b          	movb   $0x2b,0x0(%rbp)
  401c31:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
  401c35:	eb 89                	jmp    401bc0 <submitr+0x32e>
  401c37:	48 01 c5             	add    %rax,%rbp
  401c3a:	48 29 c3             	sub    %rax,%rbx
  401c3d:	0f 84 f1 02 00 00    	je     401f34 <submitr+0x6a2>
  401c43:	48 89 da             	mov    %rbx,%rdx
  401c46:	48 89 ee             	mov    %rbp,%rsi
  401c49:	44 89 e7             	mov    %r12d,%edi
  401c4c:	e8 2f ef ff ff       	callq  400b80 <write@plt>
  401c51:	48 85 c0             	test   %rax,%rax
  401c54:	7f e1                	jg     401c37 <submitr+0x3a5>
  401c56:	e8 f5 ee ff ff       	callq  400b50 <__errno_location@plt>
  401c5b:	83 38 04             	cmpl   $0x4,(%rax)
  401c5e:	0f 85 76 01 00 00    	jne    401dda <submitr+0x548>
  401c64:	4c 89 e8             	mov    %r13,%rax
  401c67:	eb ce                	jmp    401c37 <submitr+0x3a5>
  401c69:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  401c70:	3a 20 43 
  401c73:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
  401c7a:	20 75 6e 
  401c7d:	49 89 07             	mov    %rax,(%r15)
  401c80:	49 89 57 08          	mov    %rdx,0x8(%r15)
  401c84:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  401c8b:	74 6f 20 
  401c8e:	48 ba 72 65 61 64 20 	movabs $0x7269662064616572,%rdx
  401c95:	66 69 72 
  401c98:	49 89 47 10          	mov    %rax,0x10(%r15)
  401c9c:	49 89 57 18          	mov    %rdx,0x18(%r15)
  401ca0:	48 b8 73 74 20 68 65 	movabs $0x6564616568207473,%rax
  401ca7:	61 64 65 
  401caa:	48 ba 72 20 66 72 6f 	movabs $0x73206d6f72662072,%rdx
  401cb1:	6d 20 73 
  401cb4:	49 89 47 20          	mov    %rax,0x20(%r15)
  401cb8:	49 89 57 28          	mov    %rdx,0x28(%r15)
  401cbc:	41 c7 47 30 65 72 76 	movl   $0x65767265,0x30(%r15)
  401cc3:	65 
  401cc4:	66 41 c7 47 34 72 00 	movw   $0x72,0x34(%r15)
  401ccb:	44 89 e7             	mov    %r12d,%edi
  401cce:	e8 dd ee ff ff       	callq  400bb0 <close@plt>
  401cd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401cd8:	eb 7b                	jmp    401d55 <submitr+0x4c3>
  401cda:	48 8d 4c 24 30       	lea    0x30(%rsp),%rcx
  401cdf:	be 48 28 40 00       	mov    $0x402848,%esi
  401ce4:	4c 89 ff             	mov    %r15,%rdi
  401ce7:	b8 00 00 00 00       	mov    $0x0,%eax
  401cec:	e8 7f ef ff ff       	callq  400c70 <sprintf@plt>
  401cf1:	44 89 e7             	mov    %r12d,%edi
  401cf4:	e8 b7 ee ff ff       	callq  400bb0 <close@plt>
  401cf9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401cfe:	eb 55                	jmp    401d55 <submitr+0x4c3>
  401d00:	ba 00 20 00 00       	mov    $0x2000,%edx
  401d05:	48 8d b4 24 40 60 00 	lea    0x6040(%rsp),%rsi
  401d0c:	00 
  401d0d:	48 8d bc 24 40 80 00 	lea    0x8040(%rsp),%rdi
  401d14:	00 
  401d15:	e8 b5 fa ff ff       	callq  4017cf <rio_readlineb>
  401d1a:	48 85 c0             	test   %rax,%rax
  401d1d:	7e 48                	jle    401d67 <submitr+0x4d5>
  401d1f:	48 8d b4 24 40 60 00 	lea    0x6040(%rsp),%rsi
  401d26:	00 
  401d27:	4c 89 ff             	mov    %r15,%rdi
  401d2a:	e8 31 ee ff ff       	callq  400b60 <strcpy@plt>
  401d2f:	44 89 e7             	mov    %r12d,%edi
  401d32:	e8 79 ee ff ff       	callq  400bb0 <close@plt>
  401d37:	bf 13 29 40 00       	mov    $0x402913,%edi
  401d3c:	b9 03 00 00 00       	mov    $0x3,%ecx
  401d41:	4c 89 fe             	mov    %r15,%rsi
  401d44:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
  401d46:	0f 97 c0             	seta   %al
  401d49:	1c 00                	sbb    $0x0,%al
  401d4b:	84 c0                	test   %al,%al
  401d4d:	0f 95 c0             	setne  %al
  401d50:	0f b6 c0             	movzbl %al,%eax
  401d53:	f7 d8                	neg    %eax
  401d55:	48 81 c4 68 a0 00 00 	add    $0xa068,%rsp
  401d5c:	5b                   	pop    %rbx
  401d5d:	5d                   	pop    %rbp
  401d5e:	41 5c                	pop    %r12
  401d60:	41 5d                	pop    %r13
  401d62:	41 5e                	pop    %r14
  401d64:	41 5f                	pop    %r15
  401d66:	c3                   	retq   
  401d67:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  401d6e:	3a 20 43 
  401d71:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
  401d78:	20 75 6e 
  401d7b:	49 89 07             	mov    %rax,(%r15)
  401d7e:	49 89 57 08          	mov    %rdx,0x8(%r15)
  401d82:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  401d89:	74 6f 20 
  401d8c:	48 ba 72 65 61 64 20 	movabs $0x6174732064616572,%rdx
  401d93:	73 74 61 
  401d96:	49 89 47 10          	mov    %rax,0x10(%r15)
  401d9a:	49 89 57 18          	mov    %rdx,0x18(%r15)
  401d9e:	48 b8 74 75 73 20 6d 	movabs $0x7373656d20737574,%rax
  401da5:	65 73 73 
  401da8:	48 ba 61 67 65 20 66 	movabs $0x6d6f726620656761,%rdx
  401daf:	72 6f 6d 
  401db2:	49 89 47 20          	mov    %rax,0x20(%r15)
  401db6:	49 89 57 28          	mov    %rdx,0x28(%r15)
  401dba:	48 b8 20 73 65 72 76 	movabs $0x72657672657320,%rax
  401dc1:	65 72 00 
  401dc4:	49 89 47 30          	mov    %rax,0x30(%r15)
  401dc8:	44 89 e7             	mov    %r12d,%edi
  401dcb:	e8 e0 ed ff ff       	callq  400bb0 <close@plt>
  401dd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401dd5:	e9 7b ff ff ff       	jmpq   401d55 <submitr+0x4c3>
  401dda:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  401de1:	3a 20 43 
  401de4:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
  401deb:	20 75 6e 
  401dee:	49 89 07             	mov    %rax,(%r15)
  401df1:	49 89 57 08          	mov    %rdx,0x8(%r15)
  401df5:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  401dfc:	74 6f 20 
  401dff:	48 ba 77 72 69 74 65 	movabs $0x6f74206574697277,%rdx
  401e06:	20 74 6f 
  401e09:	49 89 47 10          	mov    %rax,0x10(%r15)
  401e0d:	49 89 57 18          	mov    %rdx,0x18(%r15)
  401e11:	48 b8 20 74 68 65 20 	movabs $0x7265732065687420,%rax
  401e18:	73 65 72 
  401e1b:	49 89 47 20          	mov    %rax,0x20(%r15)
  401e1f:	41 c7 47 28 76 65 72 	movl   $0x726576,0x28(%r15)
  401e26:	00 
  401e27:	44 89 e7             	mov    %r12d,%edi
  401e2a:	e8 81 ed ff ff       	callq  400bb0 <close@plt>
  401e2f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401e34:	e9 1c ff ff ff       	jmpq   401d55 <submitr+0x4c3>
  401e39:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
  401e40:	3a 20 52 
  401e43:	48 ba 65 73 75 6c 74 	movabs $0x747320746c757365,%rdx
  401e4a:	20 73 74 
  401e4d:	49 89 07             	mov    %rax,(%r15)
  401e50:	49 89 57 08          	mov    %rdx,0x8(%r15)
  401e54:	48 b8 72 69 6e 67 20 	movabs $0x6e6f6320676e6972,%rax
  401e5b:	63 6f 6e 
  401e5e:	48 ba 74 61 69 6e 73 	movabs $0x6e6120736e696174,%rdx
  401e65:	20 61 6e 
  401e68:	49 89 47 10          	mov    %rax,0x10(%r15)
  401e6c:	49 89 57 18          	mov    %rdx,0x18(%r15)
  401e70:	48 b8 20 69 6c 6c 65 	movabs $0x6c6167656c6c6920,%rax
  401e77:	67 61 6c 
  401e7a:	48 ba 20 6f 72 20 75 	movabs $0x72706e7520726f20,%rdx
  401e81:	6e 70 72 
  401e84:	49 89 47 20          	mov    %rax,0x20(%r15)
  401e88:	49 89 57 28          	mov    %rdx,0x28(%r15)
  401e8c:	48 b8 69 6e 74 61 62 	movabs $0x20656c6261746e69,%rax
  401e93:	6c 65 20 
  401e96:	48 ba 63 68 61 72 61 	movabs $0x6574636172616863,%rdx
  401e9d:	63 74 65 
  401ea0:	49 89 47 30          	mov    %rax,0x30(%r15)
  401ea4:	49 89 57 38          	mov    %rdx,0x38(%r15)
  401ea8:	66 41 c7 47 40 72 2e 	movw   $0x2e72,0x40(%r15)
  401eaf:	41 c6 47 42 00       	movb   $0x0,0x42(%r15)
  401eb4:	44 89 e7             	mov    %r12d,%edi
  401eb7:	e8 f4 ec ff ff       	callq  400bb0 <close@plt>
  401ebc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401ec1:	e9 8f fe ff ff       	jmpq   401d55 <submitr+0x4c3>
  401ec6:	48 8d 9c 24 40 60 00 	lea    0x6040(%rsp),%rbx
  401ecd:	00 
  401ece:	48 83 ec 08          	sub    $0x8,%rsp
  401ed2:	48 8d 84 24 48 40 00 	lea    0x4048(%rsp),%rax
  401ed9:	00 
  401eda:	50                   	push   %rax
  401edb:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
  401ee0:	4c 8b 44 24 28       	mov    0x28(%rsp),%r8
  401ee5:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  401eea:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  401eef:	be 78 28 40 00       	mov    $0x402878,%esi
  401ef4:	48 89 df             	mov    %rbx,%rdi
  401ef7:	b8 00 00 00 00       	mov    $0x0,%eax
  401efc:	e8 6f ed ff ff       	callq  400c70 <sprintf@plt>
  401f01:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  401f08:	b8 00 00 00 00       	mov    $0x0,%eax
  401f0d:	48 89 df             	mov    %rbx,%rdi
  401f10:	f2 ae                	repnz scas %es:(%rdi),%al
  401f12:	48 f7 d1             	not    %rcx
  401f15:	48 83 c4 10          	add    $0x10,%rsp
  401f19:	48 83 e9 01          	sub    $0x1,%rcx
  401f1d:	48 89 cb             	mov    %rcx,%rbx
  401f20:	48 8d ac 24 40 60 00 	lea    0x6040(%rsp),%rbp
  401f27:	00 
  401f28:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  401f2e:	0f 85 0f fd ff ff    	jne    401c43 <submitr+0x3b1>
  401f34:	44 89 a4 24 40 80 00 	mov    %r12d,0x8040(%rsp)
  401f3b:	00 
  401f3c:	c7 84 24 44 80 00 00 	movl   $0x0,0x8044(%rsp)
  401f43:	00 00 00 00 
  401f47:	48 8d 84 24 50 80 00 	lea    0x8050(%rsp),%rax
  401f4e:	00 
  401f4f:	48 89 84 24 48 80 00 	mov    %rax,0x8048(%rsp)
  401f56:	00 
  401f57:	ba 00 20 00 00       	mov    $0x2000,%edx
  401f5c:	48 8d b4 24 40 60 00 	lea    0x6040(%rsp),%rsi
  401f63:	00 
  401f64:	48 8d bc 24 40 80 00 	lea    0x8040(%rsp),%rdi
  401f6b:	00 
  401f6c:	e8 5e f8 ff ff       	callq  4017cf <rio_readlineb>
  401f71:	48 85 c0             	test   %rax,%rax
  401f74:	0f 8e ef fc ff ff    	jle    401c69 <submitr+0x3d7>
  401f7a:	4c 8d 44 24 30       	lea    0x30(%rsp),%r8
  401f7f:	48 8d 8c 24 3c 20 00 	lea    0x203c(%rsp),%rcx
  401f86:	00 
  401f87:	48 8d 94 24 40 20 00 	lea    0x2040(%rsp),%rdx
  401f8e:	00 
  401f8f:	be ff 28 40 00       	mov    $0x4028ff,%esi
  401f94:	48 8d bc 24 40 60 00 	lea    0x6040(%rsp),%rdi
  401f9b:	00 
  401f9c:	b8 00 00 00 00       	mov    $0x0,%eax
  401fa1:	e8 8a ec ff ff       	callq  400c30 <__isoc99_sscanf@plt>
  401fa6:	8b 94 24 3c 20 00 00 	mov    0x203c(%rsp),%edx
  401fad:	81 fa c8 00 00 00    	cmp    $0xc8,%edx
  401fb3:	0f 85 21 fd ff ff    	jne    401cda <submitr+0x448>
  401fb9:	48 8d 9c 24 40 60 00 	lea    0x6040(%rsp),%rbx
  401fc0:	00 
  401fc1:	bf 10 29 40 00       	mov    $0x402910,%edi
  401fc6:	b9 03 00 00 00       	mov    $0x3,%ecx
  401fcb:	48 89 de             	mov    %rbx,%rsi
  401fce:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
  401fd0:	0f 97 c0             	seta   %al
  401fd3:	1c 00                	sbb    $0x0,%al
  401fd5:	84 c0                	test   %al,%al
  401fd7:	0f 84 23 fd ff ff    	je     401d00 <submitr+0x46e>
  401fdd:	ba 00 20 00 00       	mov    $0x2000,%edx
  401fe2:	48 89 de             	mov    %rbx,%rsi
  401fe5:	48 8d bc 24 40 80 00 	lea    0x8040(%rsp),%rdi
  401fec:	00 
  401fed:	e8 dd f7 ff ff       	callq  4017cf <rio_readlineb>
  401ff2:	48 85 c0             	test   %rax,%rax
  401ff5:	7f ca                	jg     401fc1 <submitr+0x72f>
  401ff7:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  401ffe:	3a 20 43 
  402001:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
  402008:	20 75 6e 
  40200b:	49 89 07             	mov    %rax,(%r15)
  40200e:	49 89 57 08          	mov    %rdx,0x8(%r15)
  402012:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  402019:	74 6f 20 
  40201c:	48 ba 72 65 61 64 20 	movabs $0x6165682064616572,%rdx
  402023:	68 65 61 
  402026:	49 89 47 10          	mov    %rax,0x10(%r15)
  40202a:	49 89 57 18          	mov    %rdx,0x18(%r15)
  40202e:	48 b8 64 65 72 73 20 	movabs $0x6f72662073726564,%rax
  402035:	66 72 6f 
  402038:	48 ba 6d 20 73 65 72 	movabs $0x726576726573206d,%rdx
  40203f:	76 65 72 
  402042:	49 89 47 20          	mov    %rax,0x20(%r15)
  402046:	49 89 57 28          	mov    %rdx,0x28(%r15)
  40204a:	41 c6 47 30 00       	movb   $0x0,0x30(%r15)
  40204f:	44 89 e7             	mov    %r12d,%edi
  402052:	e8 59 eb ff ff       	callq  400bb0 <close@plt>
  402057:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  40205c:	e9 f4 fc ff ff       	jmpq   401d55 <submitr+0x4c3>

0000000000402061 <init_timeout>:
  402061:	85 ff                	test   %edi,%edi
  402063:	74 23                	je     402088 <init_timeout+0x27>
  402065:	53                   	push   %rbx
  402066:	89 fb                	mov    %edi,%ebx
  402068:	be a6 17 40 00       	mov    $0x4017a6,%esi
  40206d:	bf 0e 00 00 00       	mov    $0xe,%edi
  402072:	e8 69 eb ff ff       	callq  400be0 <signal@plt>
  402077:	85 db                	test   %ebx,%ebx
  402079:	bf 00 00 00 00       	mov    $0x0,%edi
  40207e:	0f 49 fb             	cmovns %ebx,%edi
  402081:	e8 1a eb ff ff       	callq  400ba0 <alarm@plt>
  402086:	5b                   	pop    %rbx
  402087:	c3                   	retq   
  402088:	c3                   	retq   

0000000000402089 <init_driver>:
  402089:	55                   	push   %rbp
  40208a:	53                   	push   %rbx
  40208b:	48 83 ec 18          	sub    $0x18,%rsp
  40208f:	48 89 fd             	mov    %rdi,%rbp
  402092:	be 01 00 00 00       	mov    $0x1,%esi
  402097:	bf 0d 00 00 00       	mov    $0xd,%edi
  40209c:	e8 3f eb ff ff       	callq  400be0 <signal@plt>
  4020a1:	be 01 00 00 00       	mov    $0x1,%esi
  4020a6:	bf 1d 00 00 00       	mov    $0x1d,%edi
  4020ab:	e8 30 eb ff ff       	callq  400be0 <signal@plt>
  4020b0:	be 01 00 00 00       	mov    $0x1,%esi
  4020b5:	bf 1d 00 00 00       	mov    $0x1d,%edi
  4020ba:	e8 21 eb ff ff       	callq  400be0 <signal@plt>
  4020bf:	ba 00 00 00 00       	mov    $0x0,%edx
  4020c4:	be 01 00 00 00       	mov    $0x1,%esi
  4020c9:	bf 02 00 00 00       	mov    $0x2,%edi
  4020ce:	e8 ed eb ff ff       	callq  400cc0 <socket@plt>
  4020d3:	85 c0                	test   %eax,%eax
  4020d5:	0f 88 83 00 00 00    	js     40215e <init_driver+0xd5>
  4020db:	89 c3                	mov    %eax,%ebx
  4020dd:	bf 06 28 40 00       	mov    $0x402806,%edi
  4020e2:	e8 09 eb ff ff       	callq  400bf0 <gethostbyname@plt>
  4020e7:	48 85 c0             	test   %rax,%rax
  4020ea:	0f 84 ba 00 00 00    	je     4021aa <init_driver+0x121>
  4020f0:	48 c7 44 24 02 00 00 	movq   $0x0,0x2(%rsp)
  4020f7:	00 00 
  4020f9:	c7 44 24 0a 00 00 00 	movl   $0x0,0xa(%rsp)
  402100:	00 
  402101:	66 c7 44 24 0e 00 00 	movw   $0x0,0xe(%rsp)
  402108:	66 c7 04 24 02 00    	movw   $0x2,(%rsp)
  40210e:	48 63 50 14          	movslq 0x14(%rax),%rdx
  402112:	48 8b 40 18          	mov    0x18(%rax),%rax
  402116:	48 8d 7c 24 04       	lea    0x4(%rsp),%rdi
  40211b:	48 8b 30             	mov    (%rax),%rsi
  40211e:	e8 1d eb ff ff       	callq  400c40 <memmove@plt>
  402123:	66 c7 44 24 02 3b 7a 	movw   $0x7a3b,0x2(%rsp)
  40212a:	ba 10 00 00 00       	mov    $0x10,%edx
  40212f:	48 89 e6             	mov    %rsp,%rsi
  402132:	89 df                	mov    %ebx,%edi
  402134:	e8 57 eb ff ff       	callq  400c90 <connect@plt>
  402139:	85 c0                	test   %eax,%eax
  40213b:	0f 88 d1 00 00 00    	js     402212 <init_driver+0x189>
  402141:	89 df                	mov    %ebx,%edi
  402143:	e8 68 ea ff ff       	callq  400bb0 <close@plt>
  402148:	66 c7 45 00 4f 4b    	movw   $0x4b4f,0x0(%rbp)
  40214e:	c6 45 02 00          	movb   $0x0,0x2(%rbp)
  402152:	b8 00 00 00 00       	mov    $0x0,%eax
  402157:	48 83 c4 18          	add    $0x18,%rsp
  40215b:	5b                   	pop    %rbx
  40215c:	5d                   	pop    %rbp
  40215d:	c3                   	retq   
  40215e:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  402165:	3a 20 43 
  402168:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
  40216f:	20 75 6e 
  402172:	48 89 45 00          	mov    %rax,0x0(%rbp)
  402176:	48 89 55 08          	mov    %rdx,0x8(%rbp)
  40217a:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  402181:	74 6f 20 
  402184:	48 ba 63 72 65 61 74 	movabs $0x7320657461657263,%rdx
  40218b:	65 20 73 
  40218e:	48 89 45 10          	mov    %rax,0x10(%rbp)
  402192:	48 89 55 18          	mov    %rdx,0x18(%rbp)
  402196:	c7 45 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%rbp)
  40219d:	66 c7 45 24 74 00    	movw   $0x74,0x24(%rbp)
  4021a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4021a8:	eb ad                	jmp    402157 <init_driver+0xce>
  4021aa:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
  4021b1:	3a 20 44 
  4021b4:	48 ba 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rdx
  4021bb:	20 75 6e 
  4021be:	48 89 45 00          	mov    %rax,0x0(%rbp)
  4021c2:	48 89 55 08          	mov    %rdx,0x8(%rbp)
  4021c6:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  4021cd:	74 6f 20 
  4021d0:	48 ba 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rdx
  4021d7:	76 65 20 
  4021da:	48 89 45 10          	mov    %rax,0x10(%rbp)
  4021de:	48 89 55 18          	mov    %rdx,0x18(%rbp)
  4021e2:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
  4021e9:	72 20 61 
  4021ec:	48 89 45 20          	mov    %rax,0x20(%rbp)
  4021f0:	c7 45 28 64 64 72 65 	movl   $0x65726464,0x28(%rbp)
  4021f7:	66 c7 45 2c 73 73    	movw   $0x7373,0x2c(%rbp)
  4021fd:	c6 45 2e 00          	movb   $0x0,0x2e(%rbp)
  402201:	89 df                	mov    %ebx,%edi
  402203:	e8 a8 e9 ff ff       	callq  400bb0 <close@plt>
  402208:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  40220d:	e9 45 ff ff ff       	jmpq   402157 <init_driver+0xce>
  402212:	ba 06 28 40 00       	mov    $0x402806,%edx
  402217:	be d0 28 40 00       	mov    $0x4028d0,%esi
  40221c:	48 89 ef             	mov    %rbp,%rdi
  40221f:	b8 00 00 00 00       	mov    $0x0,%eax
  402224:	e8 47 ea ff ff       	callq  400c70 <sprintf@plt>
  402229:	89 df                	mov    %ebx,%edi
  40222b:	e8 80 e9 ff ff       	callq  400bb0 <close@plt>
  402230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  402235:	e9 1d ff ff ff       	jmpq   402157 <init_driver+0xce>

000000000040223a <driver_post>:
  40223a:	53                   	push   %rbx
  40223b:	4c 89 c3             	mov    %r8,%rbx
  40223e:	85 c9                	test   %ecx,%ecx
  402240:	75 17                	jne    402259 <driver_post+0x1f>
  402242:	48 85 ff             	test   %rdi,%rdi
  402245:	74 05                	je     40224c <driver_post+0x12>
  402247:	80 3f 00             	cmpb   $0x0,(%rdi)
  40224a:	75 2f                	jne    40227b <driver_post+0x41>
  40224c:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
  402251:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
  402255:	89 c8                	mov    %ecx,%eax
  402257:	5b                   	pop    %rbx
  402258:	c3                   	retq   
  402259:	48 89 d6             	mov    %rdx,%rsi
  40225c:	bf 16 29 40 00       	mov    $0x402916,%edi
  402261:	b8 00 00 00 00       	mov    $0x0,%eax
  402266:	e8 25 e9 ff ff       	callq  400b90 <printf@plt>
  40226b:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
  402270:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
  402274:	b8 00 00 00 00       	mov    $0x0,%eax
  402279:	eb dc                	jmp    402257 <driver_post+0x1d>
  40227b:	41 50                	push   %r8
  40227d:	52                   	push   %rdx
  40227e:	41 b9 2d 29 40 00    	mov    $0x40292d,%r9d
  402284:	49 89 f0             	mov    %rsi,%r8
  402287:	48 89 f9             	mov    %rdi,%rcx
  40228a:	ba 38 29 40 00       	mov    $0x402938,%edx
  40228f:	be 7a 3b 00 00       	mov    $0x3b7a,%esi
  402294:	bf 06 28 40 00       	mov    $0x402806,%edi
  402299:	e8 f4 f5 ff ff       	callq  401892 <submitr>
  40229e:	48 83 c4 10          	add    $0x10,%rsp
  4022a2:	eb b3                	jmp    402257 <driver_post+0x1d>
  4022a4:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4022ab:	00 00 00 
  4022ae:	66 90                	xchg   %ax,%ax

00000000004022b0 <__libc_csu_init>:
  4022b0:	f3 0f 1e fa          	endbr64 
  4022b4:	41 57                	push   %r15
  4022b6:	49 89 d7             	mov    %rdx,%r15
  4022b9:	41 56                	push   %r14
  4022bb:	49 89 f6             	mov    %rsi,%r14
  4022be:	41 55                	push   %r13
  4022c0:	41 89 fd             	mov    %edi,%r13d
  4022c3:	41 54                	push   %r12
  4022c5:	4c 8d 25 34 1b 20 00 	lea    0x201b34(%rip),%r12        # 603e00 <__frame_dummy_init_array_entry>
  4022cc:	55                   	push   %rbp
  4022cd:	48 8d 2d 34 1b 20 00 	lea    0x201b34(%rip),%rbp        # 603e08 <__init_array_end>
  4022d4:	53                   	push   %rbx
  4022d5:	4c 29 e5             	sub    %r12,%rbp
  4022d8:	48 83 ec 08          	sub    $0x8,%rsp
  4022dc:	e8 1f e8 ff ff       	callq  400b00 <_init>
  4022e1:	48 c1 fd 03          	sar    $0x3,%rbp
  4022e5:	74 1f                	je     402306 <__libc_csu_init+0x56>
  4022e7:	31 db                	xor    %ebx,%ebx
  4022e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  4022f0:	4c 89 fa             	mov    %r15,%rdx
  4022f3:	4c 89 f6             	mov    %r14,%rsi
  4022f6:	44 89 ef             	mov    %r13d,%edi
  4022f9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  4022fd:	48 83 c3 01          	add    $0x1,%rbx
  402301:	48 39 dd             	cmp    %rbx,%rbp
  402304:	75 ea                	jne    4022f0 <__libc_csu_init+0x40>
  402306:	48 83 c4 08          	add    $0x8,%rsp
  40230a:	5b                   	pop    %rbx
  40230b:	5d                   	pop    %rbp
  40230c:	41 5c                	pop    %r12
  40230e:	41 5d                	pop    %r13
  402310:	41 5e                	pop    %r14
  402312:	41 5f                	pop    %r15
  402314:	c3                   	retq   

0000000000402315 <.annobin___libc_csu_fini.start>:
  402315:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  40231c:	00 00 00 00 

0000000000402320 <__libc_csu_fini>:
  402320:	f3 0f 1e fa          	endbr64 
  402324:	c3                   	retq   

Disassembly of section .fini:

0000000000402328 <_fini>:
  402328:	f3 0f 1e fa          	endbr64 
  40232c:	48 83 ec 08          	sub    $0x8,%rsp
  402330:	48 83 c4 08          	add    $0x8,%rsp
  402334:	c3                   	retq   

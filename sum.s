	.global _start
	.global main

	.bss
buf:	.skip	0x50

	.text
main:
	push	%rbp
	movq	%rsp,%rbp
	add	$0xffffffffffffffe0,%rsp
	movl	%edi,0xfffffffffffffffc(%rbp)	# argc
	movq	%rsi,0xfffffffffffffff0(%rbp)	# argv
	movl	0xfffffffffffffffc(%rbp),%eax
	cmp	$2,%eax
	jl	.end				# argc < 2
	movq	0xfffffffffffffff0(%rbp),%rax
	add	$8,%rax
	movq	(%rax),%rax			# argv[1]
	movq	%rax,0xffffffffffffffe8(%rbp)
	movl	$0,0xfffffffffffffff8(%rbp)
.l0:
	movq	0xffffffffffffffe8(%rbp),%rax
	xor	%edx,%edx
	movb	(%rax),%dl
	test	%dl,%dl
	je	.calc
	add	$1,%rax
	movq	%rax,0xffffffffffffffe8(%rbp)
	add	$0xffffffffffffffd0,%edx
	movl	0xfffffffffffffff8(%rbp),%eax
	imul	$0xa,%eax
	add	%edx,%eax
	movl	%eax,0xfffffffffffffff8(%rbp)
	jmp	.l0
.calc:
	movl	0xfffffffffffffff8(%rbp),%eax
	movl	%eax,%ecx
	add	$1,%ecx
	xor	%edx,%edx
	imul	%ecx
	shr	$1,%eax
	movl	%eax,0xfffffffffffffff8(%rbp)
	movq	$buf,0xffffffffffffffe0(%rbp)
	movq	0xffffffffffffffe0(%rbp),%rax
	add	$0x4f,%rax
	movb	$0,(%rax)
	add	$0xffffffffffffffff,%rax
	movb	$0xa,(%rax)
	add	$0xffffffffffffffff,%rax
	movq	%rax,0xffffffffffffffe0(%rbp)
.l1:
	movl	0xfffffffffffffff8(%rbp),%eax
	test	%eax,%eax
	je	.nl
	movl	%eax,%edx
	shr	$4,%eax
	movl	%eax,0xfffffffffffffff8(%rbp)
	and	$0xf,%edx
	cmp	$0xa,%edx
	jl	.b0
	add	$0x57,%edx
	jmp	.b1
.b0:
	add	$0x30,%edx
.b1:
	movq	0xffffffffffffffe0(%rbp),%rax
	movb	%dl,(%rax)
	add	$0xffffffffffffffff,%rax
	movq	%rax,0xffffffffffffffe0(%rbp)
	jmp	.l1
.nl:
	movq	0xffffffffffffffe0(%rbp),%rax
	movb	$0x78,(%rax)
	add	$0xffffffffffffffff,%rax
	movb	$0x30,(%rax)
	movq	%rax,0xffffffffffffffe0(%rbp)
.l2:
	movq	0xffffffffffffffe0(%rbp),%rax
	movb	(%rax),%dl
	test	%dl,%dl
	je	.end
	movq	%rax,%rsi
	movq	$1,%rax
	movq	$1,%rdi
	movq	$1,%rdx
	syscall
	movq	0xffffffffffffffe0(%rbp),%rax
	add	$1,%rax
	movq	%rax,0xffffffffffffffe0(%rbp)
	jmp	.l2
.end:
	movl	$0,%eax
	add	$0x20,%rsp
	pop	%rbp
	ret
_start:
	pop	%rdi
	movq	%rsp,%rsi
	call	main
	movl	%eax,%edi
	movl	$0x3c,%eax
	syscall

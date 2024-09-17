	.file	"bits.c"
	.text
	.globl	isZero
	.type	isZero, @function
isZero:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	cmpl	$0, -4(%rbp)
	sete	%al
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	isZero, .-isZero
	.globl	bitNor
	.type	bitNor, @function
bitNor:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	orl	-8(%rbp), %eax
	notl	%eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	bitNor, .-bitNor
	.globl	distinctNegation
	.type	distinctNegation, @function
distinctNegation:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	negl	%eax
	xorl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	setne	%al
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	distinctNegation, .-distinctNegation
	.globl	dividePower2
	.type	dividePower2, @function
dividePower2:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	-20(%rbp), %eax
	sarl	$31, %eax
	movl	%eax, -8(%rbp)
	movl	-24(%rbp), %eax
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	subl	$1, %eax
	movl	%eax, -4(%rbp)
	movl	-8(%rbp), %eax
	andl	-4(%rbp), %eax
	movl	%eax, %edx
	movl	-20(%rbp), %eax
	addl	%eax, %edx
	movl	-24(%rbp), %eax
	movl	%eax, %ecx
	sarl	%cl, %edx
	movl	%edx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	dividePower2, .-dividePower2
	.globl	getByte
	.type	getByte, @function
getByte:
.LFB4:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	-24(%rbp), %eax
	sall	$3, %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	-20(%rbp), %edx
	movl	%eax, %ecx
	sarl	%cl, %edx
	movl	%edx, %eax
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	getByte, .-getByte
	.globl	isPositive
	.type	isPositive, @function
isPositive:
.LFB5:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	-20(%rbp), %eax
	sarl	$31, %eax
	movl	%eax, -4(%rbp)
	cmpl	$0, -20(%rbp)
	sete	%al
	movzbl	%al, %edx
	cmpl	$0, -4(%rbp)
	sete	%al
	movzbl	%al, %eax
	xorl	%edx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	isPositive, .-isPositive
	.globl	floatNegate
	.type	floatNegate, @function
floatNegate:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	-20(%rbp), %eax
	andl	$-2147483648, %eax
	movl	%eax, -12(%rbp)
	movl	-20(%rbp), %eax
	andl	$2139095040, %eax
	movl	%eax, -8(%rbp)
	movl	-20(%rbp), %eax
	andl	$8388607, %eax
	movl	%eax, -4(%rbp)
	cmpl	$2139095040, -8(%rbp)
	jne	.L14
	cmpl	$0, -4(%rbp)
	je	.L14
	movl	-20(%rbp), %eax
	jmp	.L15
.L14:
	movl	-12(%rbp), %eax
	notl	%eax
	andl	$-2147483648, %eax
	orl	-8(%rbp), %eax
	orl	-4(%rbp), %eax
.L15:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	floatNegate, .-floatNegate
	.globl	isLessOrEqual
	.type	isLessOrEqual, @function
isLessOrEqual:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	-24(%rbp), %eax
	subl	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	notl	%eax
	shrl	$31, %eax
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	isLessOrEqual, .-isLessOrEqual
	.globl	bitMask
	.type	bitMask, @function
bitMask:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	$-1, -12(%rbp)
	movl	-20(%rbp), %eax
	movl	-12(%rbp), %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, -8(%rbp)
	movl	-24(%rbp), %eax
	movl	-12(%rbp), %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	movl	%eax, -4(%rbp)
	movl	-8(%rbp), %eax
	notl	%eax
	andl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	bitMask, .-bitMask
	.globl	addOK
	.type	addOK, @function
addOK:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %eax
	addl	%edx, %eax
	sarl	$31, %eax
	movl	%eax, -12(%rbp)
	movl	-20(%rbp), %eax
	sarl	$31, %eax
	movl	%eax, -8(%rbp)
	movl	-24(%rbp), %eax
	sarl	$31, %eax
	movl	%eax, -4(%rbp)
	movl	-8(%rbp), %eax
	xorl	-4(%rbp), %eax
	notl	%eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	xorl	-12(%rbp), %eax
	andl	%edx, %eax
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	addOK, .-addOK
	.globl	floatScale64
	.type	floatScale64, @function
floatScale64:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	-20(%rbp), %eax
	andl	$-2147483648, %eax
	movl	%eax, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L23
.L26:
	movl	-20(%rbp), %eax
	andl	$2139095040, %eax
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jne	.L24
	movl	-20(%rbp), %eax
	addl	%eax, %eax
	orl	-8(%rbp), %eax
	movl	%eax, -20(%rbp)
	jmp	.L25
.L24:
	cmpl	$2139095040, -4(%rbp)
	je	.L25
	addl	$8388608, -20(%rbp)
	movl	-20(%rbp), %eax
	andl	$2139095040, %eax
	movl	%eax, -4(%rbp)
	cmpl	$2139095040, -4(%rbp)
	jne	.L25
	andl	$-8388608, -20(%rbp)
.L25:
	addl	$1, -12(%rbp)
.L23:
	cmpl	$5, -12(%rbp)
	jle	.L26
	movl	-20(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	floatScale64, .-floatScale64
	.globl	floatPower2
	.type	floatPower2, @function
floatPower2:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	cmpl	$-149, -20(%rbp)
	jge	.L29
	movl	$0, %eax
	jmp	.L30
.L29:
	cmpl	$-126, -20(%rbp)
	jge	.L31
	cmpl	$-149, -20(%rbp)
	jl	.L31
	movl	$-126, %eax
	subl	-20(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	$23, %eax
	subl	-12(%rbp), %eax
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %eax
	jmp	.L30
.L31:
	cmpl	$-126, -20(%rbp)
	jl	.L32
	cmpl	$127, -20(%rbp)
	jg	.L32
	movl	-20(%rbp), %eax
	addl	$127, %eax
	sall	$23, %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	jmp	.L30
.L32:
	cmpl	$127, -20(%rbp)
	jle	.L33
	movl	$2139095040, %eax
	jmp	.L30
.L33:
	movl	$0, %eax
.L30:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	floatPower2, .-floatPower2
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

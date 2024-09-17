# Read the following instructions carefully
# You will provide your solution to this part of the project by
# editing the collection of functions in this source file.
#
# Some rules from Project 2 are still in effect for your assembly code here:
#  1. No global variables are allowed
#  2. You may not define or call any additional functions in this file
#  3. You may not use any floating-point assembly instructions
# You may assume that your machine:
#  1. Uses two's complement, 32-bit representations of integers.

# isZero - returns 1 if x == 0, and 0 otherwise
#   Argument 1: x
#   Examples: isZero(5) = 0, isZero(0) = 1
#   Rating: 1
.global isZero
isZero:
    cmpl $0, %edi
    je IS_ZERO_RET_1
    movl $0, %eax
    ret
    IS_ZERO_RET_1:
        movl $1, %eax 
        ret

# bitNor - ~(x|y)
#   Argument 1: x
#   Argument 2: y
#   Example: bitNor(0x6, 0x5) = 0xFFFFFFF8
#   Rating: 1
.global bitNor
bitNor:
    orl %esi, %edi              # or between x and y, stored in edi
    not %edi                    # not with edi
    movl %edi, %eax
    ret

# distinctNegation - returns 1 if x != -x.
#     and 0 otherwise
#   Argument 1: x
#   Rating: 2
.global distinctNegation
distinctNegation:
    movl %edi, %ecx             # makes copy of x into ecx
    not %ecx                    # negates copy
    addl $1, %ecx               # adds 1 to finish two's complement
    cmpl %ecx, %edi
    jne DIST_NEG_RET_1

    movl $0, %eax
    ret
DIST_NEG_RET_1:
    movl $1, %eax
    ret

# dividePower2 - Compute x/(2^n), for 0 <= n <= 30
#  Round toward zero
#   Argument 1: x
#   Argument 2: n
#   Examples: dividePower2(15,1) = 7, dividePower2(-33,4) = -2
#   Rating: 2
.global dividePower2
dividePower2:
    movl %edi, %eax             # moves x into eax (dividend)
    xorl %edx, %edx             # clears edx for division

    movl $1, %r8d               # moves 1 into r8d (divisor)
    movl %esi, %ecx             # moves n to ecx register
    shll %cl, %r8d              # shifts left n times

    cqto

    testl %eax, %eax            # tests if x is negative or positive
    jg DIV_POW_2_POSITIVE       # if positive, jump below
    
    not %eax                    # if negative, then convert to positive, divide, then result back to negative
    incl %eax

    idivq %r8

    not %eax
    incl %eax
    ret

DIV_POW_2_POSITIVE:
    idivq %r8
    ret

# getByte - Extract byte n from word x
#   Argument 1: x
#   Argument 2: n
#   Bytes numbered from 0 (least significant) to 3 (most significant)
#   Examples: getByte(0x12345678,1) = 0x56
#   Rating: 2
.global getByte
getByte:
    shll $3, %esi               # computes shift amount, (n << 3) 
    movl %esi, %ecx

    sarl %cl, %edi              # computes x >> shift amount
    movl $0xFF, %eax        
    andl %edi, %eax             # masks result

    ret

# isPositive - return 1 if x > 0, return 0 otherwise
#   Argument 1: x
#   Example: isPositive(-1) = 0.
#   Rating: 2
.global isPositive
isPositive:
    cmp $0, %edi
    jg IS_POSITIVE_RET_1
    movl $0, %eax
    ret
    IS_POSITIVE_RET_1:
        movl $1, %eax
        ret

# floatNegate - Return bit-level equivalent of expression -f for
#   floating point argument f.
#   Both the argument and result are passed as unsigned int's, but
#   they are to be interpreted as the bit-level representations of
#   single-precision floating point values.
#   When argument is NaN, return argument.
#   Argument 1: f
#   Rating: 2
.global floatNegate
floatNegate:
    movl %edi, %ecx
    andl $0x80000000, %ecx      # sign 
    movl %edi, %esi
    andl $0x7F800000, %esi      # exponent
    movl %edi, %eax
    andl $0x7FFFFF, %eax        # mantissa

    cmpl $0x7F800000, %esi
    jne FLOAT_NEGATE_NOT_NAN

    cmpl $0, %eax
    je FLOAT_NEGATE_NOT_NAN

    movl %edi, %eax
    ret

FLOAT_NEGATE_NOT_NAN:
    xorl $0x80000000, %ecx
    orl %ecx, %esi
    orl %esi, %eax
    ret


# isLessOrEqual - if x <= y  then return 1, else return 0
#   Argument 1: x
#   Argument 2: y
#   Example: isLessOrEqual(4,5) = 1.
#   Rating: 3
.global isLessOrEqual
isLessOrEqual:
    cmpl %esi, %edi             # compares x and y
    jle LESS_OR_EQ_1            # if x <= y, jump and ret 1

    movl $0, %eax
    ret

LESS_OR_EQ_1:
    movl $1, %eax
    ret


# bitMask - Generate a mask consisting of all 1's between
#   lowbit and highbit
#   Argument 1: highbit
#   Argument 2: lowbit
#   Examples: bitMask(5,3) = 0x38
#   Assume 0 <= lowbit <= 31, and 0 <= highbit <= 31
#   If lowbit > highbit, then mask should be all 0's
#   Rating: 3
.global bitMask
bitMask:
    movl $0, %edx
    not %edx                    # mask of all 1's
    movl %edx, %eax

    movl %edi, %ecx
    shll %cl, %edx              # computes mask of all 1's << highbit
    shll $1, %edx

    movl %esi, %ecx
    shll %cl, %eax              # computes mask of all 1's << lowbit

    xorl %eax, %edx
    andl %edx, %eax

    ret

# addOK - Determine if can compute x+y without overflow
#   Argument 1: x
#   Argument 2: y
#   Example: addOK(0x80000000,0x80000000) = 0,
#            addOK(0x80000000,0x70000000) = 1,
#   Rating: 3
.global addOK
addOK:
    movl %esi, %edx
    addl %edi, %edx
    sarl $31, %edx              # sign of sum of x and y, stored in edx
    
    sarl $31, %edi              # sign of x, stored in edi
    sarl $31, %esi              # sign of y, stored in esi

    cmpl %edi, %esi
    jne ADD_OK_NOT_OVERFLOW

    cmpl %edi, %edx
    je ADD_OK_NOT_OVERFLOW

    movl $0, %eax
    ret

ADD_OK_NOT_OVERFLOW:
    movl $1, %eax
    ret


# floatScale64 - Return bit-level equivalent of expression 64*f for
#   floating point argument f.
#   Both the argument and result are passed as unsigned int's, but
#   they are to be interpreted as the bit-level representation of
#   single-precision floating point values.
#   When argument is NaN, return argument
#   Argument 1: f
#   Rating: 4
.global floatScale64
floatScale64:
    movl %edi, %esi
    andl $0x80000000, %esi      # sign stored in esi

    movl $0, %r8d               # counter 
 
FS64_LOOP:
    cmpl $6, %r8d               # compare counter with 6 (loop will iterate 6 times)
    jge FS64_END_LOOP

    movl %edi, %edx
    andl $0x7F800000, %edx      # exponent stored in edx

    # Denormalized case
    cmpl $0, %edx
    jne FS64_NORMALIZED

    shll $1, %edi               # shift f left 1 time
    orl %esi, %edi              # or sign and f
    jmp FS64_REPEAT

FS64_NORMALIZED:
    # Normalized case
    cmpl $0x7F800000, %edx
    je FS64_REPEAT

    addl $0x800000, %edi
    movl %edi, %edx
    andl $0x7F800000, %edx

    # Overflow case
    cmpl $0x7F800000, %edx
    jne FS64_REPEAT

    andl $0xFF800000, %edi      # clears fraction

FS64_REPEAT:
    incl %r8d                   # increments counter
    jmp FS64_LOOP

FS64_END_LOOP:
    movl %edi, %eax
    ret

# floatPower2 - Return bit-level equivalent of the expression 2.0^x
#   (2.0 raised to the power x) for any 32-bit integer x.
#
#   The unsigned value that is returned should have the identical bit
#   representation as the single-precision floating-point number 2.0^x.
#   If the result is too small to be represented as a denorm, return
#   0. If too large, return +INF.
#
#   Argument 1: x
#   Rating: 4
.global floatPower2
floatPower2:
    cmpl $-149, %edi            # comparing x with -149
    jl FP2_ZERO

    cmpl $-126, %edi            # comparing x with -126
    jge FP2_NORMALIZED

    cmpl $-149, %edi            
    jl FP2_NORMALIZED

    # Denormalized case
    not %edi
    incl %edi
    subl $126, %edi             # computes amount to shift by

    movl $23, %edx 
    subl %edi, %edx             # edx - edi

    shll $1, %edx               # shifts edx left once
    movl %edx, %eax
    ret
    

FP2_NORMALIZED:
    cmpl $-126, %edi            
    jl FP2_INF

    cmpl $127, %edi             # compares x with 127
    jg FP2_INF

    # Normalized case
    addl $127, %edi
    shll $23, %edi              # shifts x left 23 times
    movl %edi, %eax
    ret

FP2_INF:
    cmpl $127, %edi
    jle FP2_ZERO

    # If x > 127, return +INF
    movl $0xFF, %eax
    shll $23, %eax
    ret
    
FP2_ZERO:
    movl $0, %eax
    ret

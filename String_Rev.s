@Take the string from a label and write the value in reverse order
@at a different memory location. In the code below the .asciz directive
@indicates that there will be a string of ascii characters followed by a
@terminating 0.

.data
.align 4
string:
    .asciz "helloworld\n"
newstring:
    .space 4

.text
.align 4
.global _start

_start:
stmdb	sp!, {r1-r3}     @store original values of r1-r4
MOV R0, #0             @initialising count that will step forward through string
MOV R1, #9             @initialising count that will step back through string

stringreverse:
.rept  10
LDR  R2, =string
LDR  R3, [R2, R0]      @loading cell in string pointed at by R0
LDR  R2, =newstring
STR  R3, [R2, R1]      @storing value in cell in newstring pointed at by R1
ADD  R0, #1            @increment R0 by one
SUB  R1, #1            @decrement R1 by one
.endr

ldmia	sp!, {r0-r3}     @restore original values of r0-r3

_end:	b	_end

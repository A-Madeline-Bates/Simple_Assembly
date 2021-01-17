@Given a positive integer n, if you repeatedly do the following:
@If n is even, replace it by n/2.
@If n is odd, replace it by 3n+1.
@Exit once n=1

.data
.align 2
initvar:
   .word 7

.text
.align 2
.global _start
_start:
   LDR R1, addr_initvar @load the address for initvar
   LDR R0, [R1]         @get val assigned to initvar

@where we start looping
loopstart:
   MOV R1, #1           @put 1 in R1
   AND R3, R0, R1       @AND 1 and R0 and put result in R3
   CMP R3, R1           @subtract R1 from R3
   BNE even

@if odd
   MOV R2, #3
   MUL R3, R0, R2       @multiply R0 by 3 (in R2) and place in temp (R3)
   MOV R0, R3
   MOV R2, #1
   ADD R0, R0, R2       @add one to R0 (in R2)
   CMP R0, #1
   BEQ end
   B loopstart

@if even
even:
   LSR R0, R0, #1       @divide by two
   CMP R0, #1
   BEQ end
   B loopstart

end:
   b end

@Label for initvar address
   addr_initvar : .word initvar

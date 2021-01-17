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
   @push   {fp, lr}
   @add    fp, sp, #4

   LDR R1, =initvar     @load the address for initvar
   LDR R0, [R1]         @get val assigned to initvar

loopstart:
   TST R0, #1
   BNE ifodd

ifeven:
   LSR R0, R0, #1       @divide by two
   CMP R0, #1
   BEQ epilogue
   B loopstart

ifodd:
   MOV R2, #3
   MUL R0, R2       @multiply R0 by 3 (in R2) and place in temp (R3)
   ADD R0, R0, #1       @add one to R0 (in R2)
   CMP R0, #1
   BEQ epilogue
   B loopstart

epilogue:
   @sub    sp, fp, #4   @it's good form to save your fp and lr at the start of
   @pop    {fp, lr}     @your code, but since we're using no functions I have
                        @commented them out this time for efficiency.
end:
   b end

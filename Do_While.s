@Do 1 - 100 and sum the numbers 1 to 100 while the sum is less than 2000

.text
.align 2
.global _start
_start:

MOV R1, #1              @put 1 in R1
MOV R0, #0              @put 0 in R0

loopstart:
ADD R0, R0, R1          @add value within R0 and R1 (the 'count') and put new value in R0
ADD R1, #1              @increment count
CMP R0, #2000           @if R0 > 2000, branch to end
BGT end
B   loopstart

end:
   b end

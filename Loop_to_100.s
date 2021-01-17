@Loop from 1 - 100 and sum the numbers 1 to 100 as you pass through

.text
.align 2
.global _start
_start:

MOV R1, #1              @put 1 in R1
MOV R0, #0              @put 0 in R0

loopstart:
CMP R1, #100            @if R1 == 100, branch to end
BEQ end
ADD R0, R0, R1          @add value within R0 and R1 (the 'count') and put new value in R0
ADD R1, #1              @increment count
B   loopstart

end:
   b end

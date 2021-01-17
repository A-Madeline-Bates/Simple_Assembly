@BCD (Binary Coded Decimal) is a way of packing a single
@decimal digit into a byte, as you have learnt from Tanenbaum.
@In this assignment, we will experiment with BCD on S16,
@except that we will use a whole word (16 bits) for each decimal digit.
@Your assignment is to design and write a program
@that adds two 8-digit BCD-word numbers given in the following .DATA section

.data
.align 4
arrayone:
    .word 0, 0, 0, 0, 9, 9, 0, 1
arraytwo:
    .word 0, 0, 0, 0, 0, 1, 0, 5
arrayanswer:
    .word 0, 0, 0, 0, 0, 0, 0, 0

.text
.align 4
.global _start
_start:

MOV R0, #28                @establish that we are initially accessing 8th word

loopstart:
LDR  R1, addr_arrayone
LDR  R2, [R1, R0]          @ask to access bit in arrayone pointed at by R0.
LDR  R1, addr_arraytwo
LDR  R3, [R1, R0]          @ask to access bit in arraytwo pointed at by R0.
ADD  R1, R2, R3            @add R2 and R3, and put result in R1

LDR  R2, addr_arrayanswer
STR R1, [R2, R0]           @store R2+R3 in position pointed at by R0 in arrayanswer
CMP  R0, #0                @if R0 = 0, jump to end
BEQ  end
SUB  R0, #4                @decriment value in R0 by 4 (one word)
B   loopstart

end:
   b end

@Label for arrayone address
   addr_arrayone : .word arrayone
@Label for arraytwo address
   addr_arraytwo : .word arraytwo
@Label for arrayanswer address
   addr_arrayanswer : .word arrayanswer

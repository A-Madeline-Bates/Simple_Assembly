@The fibonacci sequence is a famous number sequence that appears in
@lots of places in nature. The sequence can be formulated as follows.
@f(n) = f(n − 1) + f(n − 2)
@f(1) = f(2) = 1
@Create a program which takes the element in the sequence that you
@want to compute in r0 and returns from the function with the value
@of the sequence in r0. Make sure that your subroutine does not "trash"
@any registers.

@code by @carlhenrikek (https://github.com/carlhenrikek), annotations by me

.section	.text
.global		_start
.align		4

_start:
mov	r0, #10                 @move 10 into r0
bl	_fibonacci              @branch to fibonacci, and copy our PC to LR

_end:	b	_end


_fibonacci:
stmdb	sp!, {r1-r3}          @store original values of r1-r3
      mov   r1,  #0         @move 0 into r1. r1 acting as initial f(n-2)
      mov   r2,  #1         @move 1 into r2. r2 acting as initial f(n-1)

_fibloop:
      mov   r3,  r2         @move r2 into r3
      add   r2,  r1,  r2    @add r2 and r1, put into r2
      mov   r1,  r3         @move r3 into r1
      sub   r0,  r0,  #1    @subtract 1 from r0, put into r0. r0 is acting
                            @as a count
      cmp   r0,  #1         @compare r0 and 1
      bne   _fibloop        @if not equal, branch to _fibloop

      mov   r0,  r2         @if equal, move  r2 into r0
ldmia	sp!, {r1-r3}          @restore original values of r1-r3
      mov   pc,  lr         @move link register into program counter
                            @(returning to bl)

@Check if a word is an palindrome. Return 1 if yes, 0 if no.

.data
.align 2
palindrome:
   .asciz "MADAM"

.text
.align 2
.global _start

_start:
	push   {r1, r2, r3, r4, r5, r6, fp, lr}
	add    fp, sp, #28
  eor    r0, r0, r0          @initialise r0 as zero
  ldr    r1, =palindrome     @load possible palindrome address

wordlengthloop:
  ldrb   r2, [r1, r3]        @load word r1, cell r3
  cmp    r2, #0
  addne  r3, #1              @increment r3 by 1. r3 will = anagram length
  bne    wordlengthloop      @if r2 != '/0', loop

  lsr    r4, r3, #1          @divide r3 by 2, put in r4

palinloop:
  sub    r3, #1              @r3 is initially too high to access zero, so
                             @it's first in the loop
  ldrb   r2, [r1, r6]        @access first cell of array
  ldrb   r5, [r1, r3]        @access last cell of array
  cmp    r2, r5
  bne    notpalin
  add    r6, #1
  subs   r4, #1
  bne    palinloop           @if count!=zero, keep looping. If it is and we have
                             @not branched away, it is an anagram
ispalin:
  mov    r0, #1

notpalin:
	sub    sp, fp, #28
	pop    {r1, r2, r3, r4, r5, r6, fp, lr}

end:
  b      end

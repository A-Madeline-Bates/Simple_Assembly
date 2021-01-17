@Programme to check if something is a prime. Returns 1 in r0 if yes
@and 0 if no

.data
.align 2
prime:
   .byte 7

.text
.align 2
.global _start

_start:
	push   {r1, r2, r3, r4, fp, lr}
	add    fp, sp, #20
  eor    r0, r0, r0
  ldr    r1, =prime      @load prime address
  ldrb   r1, [r1]        @load our possible prime from our mem location
  mov    r2, #2
  lsr    r2, r2, #1      @make a copy of r1 / 2, which is count + divisor
loopstart:
  udiv   r3, r1, r2
  mls    r4, r3, r2, r1   @find remainder of division + set flags
  cmp    r4, #0
  beq    notprime         @if the remainder is ever zero, it's not prime
  sub    r2, #1           @subtract 1 from r2
  cmp    r2, #1
  bne    loopstart        @if r2!=1, loop. If not, we've passed all options,
                          @and r1 is prime
isprime:
  mov    r0, #1

notprime:                 @if notprime we skip the step where we set r0 to 1
	sub    sp, fp, #20
	pop    {r1, r2, r3, r4, fp, lr}

end:
  b      end

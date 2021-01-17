@Take a sequence of numbers and perform a bubble sort on them.

.data
.align 2
numarr:
    .byte 5, 6, 2, 3, 9, 9, 0, 1

.text
.align 2
.global _start

_start:
	push   {r1, r2, r3, r4, r5, r6, fp, lr}
	add    fp, sp, #28
  ldr    r4, =numarr
  mov    r1, #8          @masterloop count
masterloop:
  mov    r2, #7          @the count
  mov    r3, #6          @the count - 1
loopstart:
  ldrb   r5, [r4, r2]    @load cell pointed to by r2
  ldrb   r6, [r4, r3]    @load cell pointed to by r3
  cmp    r5, r6          @compare values in r5 and r6
  bllt   swap            @if r6 is less than r5, branch to swap
  strb   r5, [r4, r2]
  strb   r6, [r4, r3]
  sub    r2, #1
  subs   r3, #1          @subtract and set flags
  bpl    loopstart       @branch if r3 is positive or zero
  subs   r1, #1
  bne    masterloop

	sub    sp, fp, #28
	pop    {r1, r2, r3, r4, r5, r7, fp, lr}

end:
  b      end

swap:
  push   {r1, fp}
  add    fp, sp, #4
  mov    r1, r5
  mov    r5, r6
  mov    r6, r1
  sub    sp, fp, #4
  pop    {r1, fp}
  bx     lr

@note: I think I probably need to pass information to the swap
@function in one of the r0-r3 registers and should strictly pop r4 onwards
@before doing a function call (although it did not break when I ran it).
@A better solution might be to keep the mov instructions in my main
@function and to run them all as movlt

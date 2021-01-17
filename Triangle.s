@ Write a subroutine LEN that computes √(𝑥^2 + 𝑦^2) . Assume x
@ is passed to the subroutine in R0, y in R1 and that the result is returned
@ in R0. Assume also that you can call a subroutine SQRT
@ which the returns the integer square root of R0 in R0.

.text
.align 2
.global _start

_start:
	push   {fp, lr}
	add    fp, sp, #4
  mov    r0, #4        @inserting nums in r0 & r1
  mov    r1, #3
	bl     pythagoras
	sub    sp, fp, #4
	pop    {fp, lr}

end:
  b      end

pythagoras:
	push   {fp, lr}
	add    fp, sp, #4
  @Note: rather than moving r0 into a new cell, I should have targeted a
  @different cell in MUL - i.e mul r2, r0, r0 (mul r0, r0, r0 is not allowed)
  mov    r2, r0
  mul    r0, r2, r2        @squaring r0 and r1
  mov    r2, r1
  mul    r1, r2, r2
  add    r0, r0, r1
	bl     SQRT
	sub    sp, fp, #4
	pop    {fp, pc}

SQRT:
	push   {fp}
	add    fp, sp, #0
...
	sub    sp, fp, #0
	pop    {fp}
	bx     lr

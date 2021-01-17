@Take a sequence of numbers and perform a bubble sort on them.

.data
.align 4
numarr:
    .word 5, 6, 2, 3, 9, 9, 0, 1

.text
.align 4
.global _start

_start:
	push   {r1, r2, r3, r4, r5, r7, fp, lr}
	add    fp, sp, #24
  ldr    r3, =numarr
  mov    r7, #0          @masterloop count
masterloop:
  mov    r1, #0          @the count
  mov    r2, #4          @the count + 4
loopstart:
  ldr    r4, [r3, r1]    @load cell pointed to by r1
  ldr    r5, [r3, r2]    @load cell pointed to by r1
  cmp    r4, r5          @compare values in r4 and r5
  blgt   swap            @if r4 is bigger than r5, branch to swap
  str    r4, [r3, r1]
  str    r5, [r3, r2]
  add    r1, #4
  add    r2, #4
  cmp    r2, #28
  bne    loopstart
  add    r7, #1
  cmp    r7, #8
  bne    masterloop

  mov    r0, #0          @return 0
	sub    sp, fp, #24
	pop    {r1, r2, r3, r4, r5, r7, fp, lr}

end:
  b      end

swap:
  push   {r6, fp}
  add    fp, sp, #4
  mov    r6, r4
  mov    r4, r5
  mov    r5, r6
  sub    sp, fp, #4
  pop    {r6, fp}
  bx     lr

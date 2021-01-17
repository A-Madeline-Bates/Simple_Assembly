@Messing about using functions- adding two local variables in two functions
@and returning them. Obviously this a terrible way to go about
@adding numbers. This is testing the principles in Std_Setup.s

.text
.align 2
.global _start

_start:
	push   {fp, lr}
	add    fp, sp, #4
	bl     function
	sub    sp, fp, #4
	pop    {fp, lr}

end:
  b      end

function:
	push   {r1, r4, r5, fp, lr}
	add    fp, sp, #16
  mov    r4, #10
  mov    r5, #15
  add    r1, r4, r5
  bl     functiontwo
  add    r0, r0, r1
	sub    sp, fp, #16
	pop    {r1, r4, r5, fp, pc}

functiontwo:
  push   {r4, r5, fp}
  add    fp, sp, #8
  mov    r4, #20
  mov    r5, #30
  add    r0, r4, r5
  sub    sp, fp, #8
  pop    {r4, r5, fp}
  bx     lr

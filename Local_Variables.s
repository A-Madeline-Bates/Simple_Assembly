@Messing about using functions- adding two local variables in a function
@and returning them. Obviously this a terrible way to go about
@adding two numbers. I have also made space on the stack that I do not
@use. This is testing the principles in Std_Setup.s

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
	push   {r4, r5, fp}
	add    fp, sp, #8
	sub    sp, sp, #12
  mov    r4, #10
  mov    r5, #15
  add    r0, r4, r5
	sub    sp, fp, #8
	pop    {r4, r5, fp}
	bx     lr

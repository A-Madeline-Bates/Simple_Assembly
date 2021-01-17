@Messing about using functions- making two locations in the stack in a
@function, and storing and retrieving from them.The numbers used are then
@added together and returned. Obviously this a terrible way to go about
@adding two numbers. This is testing the principles in Std_Setup.s

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
	push   {r1, r2, r3, r4, r5, fp}
	add    fp, sp, #20
	sub    sp, sp, #8      @make space on stack
  mov    r2, #10         @put 10 in r2
  sub    r4, fp, #24     @put the address of free stack location in r4
  str    r2, [r4, #0]    @store r2 (10) in the location
  mov    r3, #15         @put 15 in r3
  str    r3, [r4, #-4]   @store r3 (15) in stack location offset from r4
  ldr    r1, [r4, #0]    @load from the stack locations we created
  ldr    r2, [r4, #-4]
  add    r0, r1, r2      @add results together
	sub    sp, fp, #20
	pop    {r1, r2, r3, r4, r5, fp}
	bx     lr

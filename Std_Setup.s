***EXPLANATORY VERSION***

.text
.align 2
.global _start

_start:
      /*This is a non-leaf function as something is branching from it*/
 	push   {fp, lr}
      /* Start of the prologue. Saving Frame Pointer and LR onto the stack.
      This automatically subtracts 8 from the stack.*/
 	add    fp, sp, #4
      /* Setting up the bottom of the stack frame. This establishes a new
      frame pointer address by adding 4×(r−1), where r=number of registers
      saved, to the address in the stack pointer. This ensures
      that the frame pointer will point to the location on the stack
      where the frame pointer of the calling function is stored.*/
 	sub    sp, sp, #16
      /* End of the prologue. Allocating some buffer on the stack. The
      number subtracted from the sp, n, must meet two criteria:
      a) n ≥ total number of bytes required by local variables.
      b) (m+n+4) is a multiple of 8, where m=4×(r−1) (see above)*/
   ...
 	bl     function
      /* Calling/branching to function. Copies the current address of
      PC into LR to make it possible to return here*/
   ...
 	sub    sp, fp, #4
      /* Start of the epilogue. Re adjusting the Stack Pointer so
      it points at the bottom of the space reserved for fp/lr.
      This could also be done by adding back the amount we subtracted
      from sp in the line above bl. At this point, the values "below"
      the stack pointer are considered invalid, and thus, deallocated.*/
 	pop    {fp, pc}
      /* End of the epilogue. Restoring Frame pointer from the stack,
      jumping to previously saved LR via direct load into PC. This
      adds 8 to the stack. This can also be done using the lines
      "ldmfd sp!, {fp, lr} / bx lr" or "pop {fp, lr} / bx lr". By calling
      instruction we are trying to return to caller, but if this is the
      top level function, this line will send us somewhere odd. Maybe
      try "pop {fp, lr}" instead?*/

function:
      /*This is a leaf function, hence why we do not bother to copy the
      link register*/
      /*Assume that the values in the r0, r1, r2, and r3 registers will
      be changed by the called function. If that is a problem then
      save them.*/
	 push   {fp}
      /* Start of the prologue. Saving Frame Pointer onto the stack */
	 add    fp, sp, #0
      /* Setting up the bottom of the stack frame. i.e Establish a
      new frame pointer address by adding 4×(n−1), where n=number of
      registers saved, to the address in the stack pointer (r13) */
	 sub    sp, sp, #12
      /* End of the prologue. Allocating some buffer on the stack.
      Allocate space on the stack for all the local variables, plus any
      required register save space, by subtracting the number of bytes
      required from sp, observing stack alignment restrictions. */
	 ...
/*
While in the function:
a.	Do not use the stack pointer to access arguments or local variables. 
    sp is pointing to the current bottom of the portion of the stack that is
    accessible to this function, observing the usual stack discipline. 
b.	Never change the value in the frame pointer, r11. 
c.	Local variables are on the stack and are accessed through negative 
    offsets from the frame pointer. (the values of offsets for the
    local variables need to take into account the
    registers that will be saved on the stack. These offsets are
    relative to the frame pointer, fp, which points to a place on the
    stack “below” the saved registers. The first available byte for local
    variables is −5 from the fp if we pushed two registers) 
d.	Arguments passed on the stack to the function are accessed through 
    positive offsets from the frame pointer.
e.  When leaving the function, place the return value, if any, in r0.
*/
   ...
   sub    sp, fp, #0
      /* Start of the epilogue. Readjusting the Stack Pointer. Deallocate
      the local variables by adding the same amount to sp that was
      subtracted at the beginning of the function.*/
   pop    {fp}
      /* restoring frame pointer */
 	 bx     lr
      /* End of the epilogue. Jumping back to main via LR register */



***BARE VERSION***

.text
.align 2
.global _start

_start:
	push   {fp, lr}
	add    fp, sp, #4
	sub    sp, sp, #16
  ...
	bl     function
  ...
	sub    sp, fp, #4
	pop    {fp, lr}

  end:
     b end

function:
	push   {fp}
	add    fp, sp, #0
	sub    sp, sp, #12
  ...
	sub    sp, fp, #0
	pop    {fp}
	bx     lr

@the information for this file came from
@http://bob.cs.sonoma.edu/IntroCompOrg-RPi/sec-varstack.html and
@https://azeria-labs.com/writing-arm-assembly-part-1/

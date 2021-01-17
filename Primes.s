.data
.align 2
initvar:
   .word 7

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

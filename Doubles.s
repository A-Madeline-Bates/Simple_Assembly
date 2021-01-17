@Add two doubles, and convert the result to a float
@This instruction set didn't work with the ARM architecture I was using,
@so I couldn't experiment with it

.text
.align 2
.global _start

_start:
	push          {fp, lr}
	add           fp, sp, #4
  vldr          d0, a           @ load x into fp reg
  vldr          d1, b           @ load y into fp reg
  vadd.f64      d2, d1, s0      @ add
  vcvt.f32.f64  s5, d2          @ convert result to float

	sub    sp, fp, #4
	pop    {fp, lr}

_end:
  b	     _end

a:
  .double  1.95
b:
  .double  2.35

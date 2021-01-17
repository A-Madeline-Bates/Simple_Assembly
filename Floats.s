@Add two floats, and convert the result to a double
@This instruction set didn't work with the ARM architecture I was using,
@so I couldn't experiment with it

.text
.align 2
.global _start

_start:
	push          {fp, lr}
	add           fp, sp, #4
  vldr          s0, x           @ load x into fp reg
  vldr          s1, y           @ load y into fp reg
  vadd.f32      s2, s1, s0      @ add
  vcvt.f64.f32  d5, s2          @ convert result to double

	sub    sp, fp, #4
	pop    {fp, lr}

_end:
  b	     _end

x:
  .float  1.22
y:
  .float  2.75

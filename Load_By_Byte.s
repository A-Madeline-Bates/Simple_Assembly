@writing a program to load a constant array by .byte

.data
.align 2
numarr:
    .byte 1, 2, 3, 4, 5, 6, 7, 8

.text
.align 2
.global _start

_start:
  ldr    r3, =numarr
  mov    r1, #8

loop:
  subs   r1, #1
  ldrb   r0, [r3, r1]
  BNE    loop

end:
  b      end

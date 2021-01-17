@clear bits 4 to 7 of R0

.text
.align 2
.global _start
_start:

MOV R1, #345
MOV R2, #0b11110001111

AND R0, R1, R2

end:
   b end


@replace bits 3 to 8 in R0 with the value 17

.text
.align 2
.global _start
_start:

MOV R0, #345

BIC R0, R0, #0b11111000 @ clear bits
ORR R0, R0, #0b10001000 @ insert 0x44 in correct position

end:
   b end

@In a Scrabble® like game, players form words and each word is awarded a
@score that is the sum of the points for each letter in the word. English
@language editions of Scrabble contain 100 letter
@tiles with the following letter points and letter distribution:
@1 point: E×12, A×9, I×9, O×8, N×6, R×6, T×6, L×4, S×4, U×4
@2 points: D×4, G×3
@3 points: B×2, C×2, M×2, P×2
@4 points: F×2, H×2, V×2, W×2, Y×2
@5 points: K×1
@8 points: J×1, X×1
@10 points: Q×1, Z×1
@For example, the word “MAZE” would have a score of 15 (3 + 1 + 10 + 1).
@Write an ARM assembly language program that will compute the word
@score for a NUL terminated string containing UPPER CASE alphabetic
@characters. The word is stored in memory at the address contained in R1.
@The score for each letter is stored in flash memory as a sequence (or table
@or array) of 26 byte values. The first byte is the score for
@“A”, the second byte is the score for “B”, and so on.
@Your program should calculate the word score in R0.

.data
.align 2

alphapoints:
.byte 1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10,1, 1, 1, 1, 4, 4, 8, 4, 10
     @A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z

scrabbleword:
.asciz "MAZE"

.text
.align 2
.global _start

_start:
	push   {fp, lr}
	add    fp, sp, #4
  eor    r0, r0, r0          @clearing r0
  ldr    r1, =scrabbleword   @load word address
  ldr    r3, =alphapoints    @load points array

loopstart:
  ldrb   r2, [r1], #1        @load first letter, increment address by 1
  cmp    r2, #0
  beq    epilogue
  sub    r2, r2, #65         @subtract ascii code of 'A' to align with array cell no.
  ldrb   r2, [r3, r2]        @replace r2 with point score
  add    r0, r0, r2          @add r2 to total
  b      loopstart

epilogue:
	sub    sp, fp, #4
	pop    {fp, lr}

end:
  b      end

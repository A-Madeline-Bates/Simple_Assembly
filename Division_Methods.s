***EXPLANATORY VERSION***

.text
.align 2
.global _start

_start:

@ ** SHIFT RIGHT **

 push   {R1, R2, R3}         @ Storing registers so they can be zero-ed later

 MOV    R0, #40
 MOV    R1, R0, LSR #1      @ Dividing by two
 MOV    R2, R0, ASR #1      @ Dividing by two
 SUB    R3, R2, R2, LSR #2  @ Times by 3/4

 pop    {R1, R2, R3}


@ ** NORMAL DIVISION (IF ALLOWED BY ARCHITECTURE) **

 push   {R1, R2, R3, R4, R5, R6}

 MOV    R1, #28              @ Number to be divided
 MOV    R2, #3               @ The divisor
 UDIV   R0, R1, R2           @ Unsigned divide
 SDIV   R5, R1, R2           @ Signed divide

 MUL    R3, R0, R2
 SUB    R4, R1, R3           @ Calculating remainder

 pop    {R1, R2, R3, R4, R5, R6}


@ ** THE SUBTRACTION LOOP **

 push    {R1, R2, R3}

 MOV     R1, #128            @ Number to be divided
 MOV     R2, #4              @ The divisor
 MOV     R0, #0              @ Initialise counter

subtract:
 SUBS    R1, R1, R2          @ Subtract R2 from R1 and store
                             @    result back in R1 setting flags
 ADD     R0, R0, #1          @ Add 1 to counter, NOT setting flags
 BHI     subtract            @ Branch to start of loop on condition
                             @    higher, i.e. R1 is still greater than
                             @    R2. Answer now in R0
 pop    {R1, R2, R3}


@ ** THE SHIFT LOOP **

 push   {R1, R2, R3}

 MOV    R1, #45              @ The number to be divided
 MOV    R2, #3               @ The divisor
 MOV    R3, #1               @ Set bit 0
 MOV    R0, #0               @ Initialise counter

start:
 CMP      R2, R1             @shift R2 left until it is about to
 MOVLS    R2, R2, LSL #1     @be bigger than R1
 MOVLS    R3, R3, LSL #1     @shift R3 left in parallel in order
 BLS      start              @to flag how far we have to go

loopstart:
 CMP    R1, R2               @ Carry set if R1>R2 (don't ask why)
 SUBCS  R1, R1, R2           @ Subtract R2 from R1 if this would
                             @    give a positive answer
 ADDCS  R0, R0, R3           @    and add the current bit in R3 to
                             @    the accumulating answer in R0
 MOVS   R3, R3, LSR #1       @ Shift R3 right into carry flag
 MOVCC  R2, R2, LSR #1       @    and if bit 0 of R3 was zero, also
                             @    shift R2 right
 BCC    loopstart            @ If carry not clear, R3 has shifted
                             @    back to where it started, and we
                             @    can end
                             @ R1 holds the remainder, R0 holds the result
 pop   {R1, R2, R3}

 end:
    b end

***BARE VERSION***

.text
.align 2
.global _start

_start:

@ ** SHIFT RIGHT **

 push   {R1, R2, R3}

 MOV    R0, #40
 MOV    R1, R0, LSR #1
 MOV    R2, R0, ASR #1
 SUB    R3, R2, R2, LSR #2

 pop    {R1, R2, R3}


@ ** NORMAL DIVISION (IF ALLOWED BY ARCHITECTURE) **

 push   {R1, R2, R3, R4, R5, R6}

 MOV    R1, #28
 MOV    R2, #3
 UDIV   R0, R1, R2
 SDIV   R5, R1, R2

 MUL    R3, R0, R2
 SUB    R4, R1, R3           @ Calculating remainder

 pop    {R1, R2, R3, R4, R5, R6}


@ ** THE SUBTRACTION LOOP **

 push    {R1, R2, R3}

 MOV     R1, #128            @ Number to be divided
 MOV     R2, #4              @ The divisor
 MOV     R0, #0              @ Initialise counter

subtract:
 SUBS    R1, R1, R2
 ADD     R0, R0, #1
 BHI     subtract
 pop     {R1, R2, R3}


@ ** THE SHIFT LOOP **

 push   {R1, R2, R3}

 MOV    R1, #45              @ The number to be divided
 MOV    R2, #3               @ The divisor
 MOV    R3, #1               @ Set bit 0
 MOV    R0, #0               @ Initialise counter

start:
 CMP      R2, R1
 MOVLS    R2, R2, LSL #1
 MOVLS    R3, R3, LSL #1
 BLS      start

loopstart:
 CMP    R1, R2
 SUBCS  R1, R1, R2
 ADDCS  R0, R0, R3
 MOVS   R3, R3, LSR #1
 MOVCC  R2, R2, LSR #1
 BCC    loopstart

 pop   {R1, R2, R3}

 end:
    b end

@the information for this file came from
@http://bob.cs.sonoma.edu/IntroCompOrg-RPi/sec-varstack.html and
@http://www.tofla.iconbar.com/tofla/arm/arm02/index.htm

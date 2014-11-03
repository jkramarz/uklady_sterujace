#include "m32def.inc"

.DSEG
.EQU LENGTH = 16 ; input size
	tA: .BYTE LENGTH
	tB: .BYTE LENGTH

.CSEG

.ORG 0
        ; uC start
	jmp INIT

.ORG 16
        ; timer0 overflow interrupt
	jmp ASWOM_TIMER_INTERRUPT

.ORG 32
ASWOM_TIMER_INTERRUPT:
	CALL UBER_MAKAPAKA_SUM
	RETI

INIT:

        ; store 1 in X word 
	LDI XL, low(tB)
	LDI XH, high(tB)
	LDI ZL, low(LENGTH)
	LDI ZH, high(LENGTH)
OKPOK: 
	ADIW XL, 1
	SBIW ZL, 1
	BRNE OKPOK

	SBIW XL, 1
	LDI r16, 1
	ST X, r16

        ; move to end, init required by word sum later
	LDI YL, low(tA)
	LDI YH, high(tA)
	LDI XL, low(tB)
	LDI XH, high(tB)
	LDI ZL, low(LENGTH)
	LDI ZH, high(LENGTH)
        
        ; configure stack pointer
	LDI r16, low(RAMEND)
	OUT spl, r16
	LDI r16, high(RAMEND)
	OUT sph, r16

        ; enable timer0 clock source
	LDI r16, 1<<CS00
	OUT TCCR0, r16
        ; enable timer0 overflow interrupt
	LDI r16, 1<<TOIE0
	OUT TIMSK, r16
        ; enable interrupts
	SEI

HCF:
	JMP HCF


; Y += X
; set Y and X registers to start of summands
; set Z to summands length
UBER_MAKAPAKA_SUM:
	PUSH XL
	PUSH XH
	PUSH YH
	PUSH YL
	PUSH ZH
	PUSH ZL
	PUSH r16
	PUSH r17
	PUSH r18

	; prepare for computation: move to end of tables, clear carry bit
	ADD XL, ZL
	ADC XH, ZH
	ADD YL, ZL
	ADC YH, ZH
	CLR R18

UBER_MAKAPAKA_LOOP:
	LD R16, -X ; load intermediate operands ...
	LD R17, -Y ; ... and decrement counters

	; restore carry bit
	CLC
	TST R18
	BREQ LEAVE_C_UNSET
	SEC
LEAVE_C_UNSET:
	; end of restore carry bit

	ADC R17, R16  ; compute intermediate result

	; store carry bit, would be modified by SBIW
	CLR R18
	BRCC LEAVE_CARRY_0
	SER R18
LEAVE_CARRY_0:
	; end of store carry bit
	
	ST Y, R17 ; store intermediate result
	SBIW ZL, 1 ; decrement byte counter (word)
	BRNE UBER_MAKAPAKA_LOOP ; check for completion

	; computiation completed, set carry bit
	CLC
	TST R18
	BREQ UBER_MAKAPAKA_HALT
	SEC

UBER_MAKAPAKA_HALT:
	POP r18
	POP r17
	POP r16
	POP ZL
	POP ZH
	POP YL
	POP YH
	POP XH
	POP XL
	ret

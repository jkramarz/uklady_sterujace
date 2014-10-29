.DSEG
.EQU LENGTH = 2 ; input size
	tA: .BYTE LENGTH
	tB: .BYTE LENGTH

.CSEG

SETUP:
	LDI ZL, low(LENGTH)
	LDI ZH, high(LENGTH)

	; current byte addresses in tA, tB 
	LDI XL, low(tA)
	LDI XH, high(tA)
	LDI YL, low(tB)
	LDI YH, high(tB)

	; prepare for computation: move to end of tables, clear carry bit
	ADD XL, ZL
	ADC XH, ZH
	ADD YL, ZL
	ADC YH, ZH
	CLR R18

LOOP:
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
	BRNE LOOP ; check for completion

	; computiation completed, set carry bit
	CLC
	TST R18
	BREQ HALT
	SEC

HALT:
	JMP HALT
	; result stored in tB

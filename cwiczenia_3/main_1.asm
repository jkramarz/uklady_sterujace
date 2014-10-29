.DSEG
.EQU LENGTH = 2 ; input size
    tA: .BYTE LENGTH
    tB: .BYTE LENGTH

.CSEG




STACK_NOT_REALLY_MAKAPAKA_INIT:
    LDI r16, low(RAMEND)
    OUT spl, r16
    LDI r16, high(RAMEND)
    OUT sph, r16

TEST:
    NOP
    CALL UBER_MAKAPAKA_SUM

    JMP STOP
    


STOP:
    JMP STOP

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

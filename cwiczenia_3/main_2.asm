#include "m32def.inc"

.CSEG

.ORG 0
    jmp INIT_TIMER

.ORG 16
    jmp ASWOM_TIMER_INTERRUPT

.ORG 32
ASWOM_TIMER_INTERRUPT:
    NOP
    RETI

INIT_TIMER:
    LDI r16, 1<<CS00
    OUT TCCR0, r16

    LDI r16, 1<<TOIE0
    OUT TIMSK, r16
    
    SEI

    NOP

HCF:
    JMP HCF

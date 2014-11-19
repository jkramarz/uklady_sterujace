#include <avr/io.h>
#include <avr/interrupt.h>

ISR(TIMER0_COMP_vect){
   int state = (PORTB >> 5) & 1;
   if(state == 0)
    PORTB |= (1<<5);
   else
    PORTB &= (~(1) << 5);
}

int main(){
    DDRB |= (1 << 5);
    PORTB |= (PORTB & (1<<5));
    OCR0 = 125;
    TIMSK |= (1 << OCIE0);
    TCCR0 |= (1 << WGM01)|(1 << CS01)|(1 << CS00);
    sei();
    for(;;);
}

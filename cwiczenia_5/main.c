#include "cooperative_scheduler.c"

ISR(TIMER0_COMP_vect)
{
    schedule();
}

void init_timer_irq(){
    OCR0 = 125;
    TIMSK |= (1 << OCIE0);
    TCCR0 |= (1 << WGM01)|(1 << CS01)|(1 << CS00);
}
void init_scheduler(){     
    sei();
}

void diode(void * params){
   int offset = (int) params;
   PORTA ^= _BV(offset);
}

int main(int argc, char * argv[])
{
    init_timer_irq();
    init_scheduler();

    DDRA = 0xFF;
    PORTA = 0xFF;
    addTask(0,-1000,diode,(void *)0);
    addTask(1,-2000,diode,(void *)1);
    addTask(2,-3000,diode,(void *)2);
    addTask(3,-4000,diode,(void *)3);
    addTask(4,-5000,diode,(void *)4);
    addTask(5,-6000,diode,(void *)5);
    addTask(6,-7000,diode,(void *)6);
    addTask(7,-8000,diode,(void *)7);
    execute();

    return 0;
}


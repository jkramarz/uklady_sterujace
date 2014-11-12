#ifndef COOPERATIVE_SCHEDULER_H
#define COOPERATIVE_SCHEDULER_H
#include <avr/io.h>
#include <avr/interrupt.h>

/* funkcja odpowiedzialna za oznaczenie zadań do wykonania. Jej zadaniem jest przeglądanie tablicy zadań i sprawdzenie czy upłynął czas po jakim zadanie powinno zostać “wybudzone”. W założeniu powinna być umieszczona w procedurze obsługi przerwania zegarowego wywoływanego co 1 ms. */
void schedule();
/* Zadaniem funkcji jest  ciągłe przeglądanie tablicy w poszukiwaniu zadań gotowych do wykonania i ich wykonywanie. Funkcja nie powinna nigdy kończyć swojego działania. W większości przypadków funkcja ta będzie ostatnią funkcją znajdującą sie w main(). */
void execute();
/* Funkcja dodaje do tablicy zadanie wskazywane przez wzkaźnik func_ptr. Zadanie będzie miało priorytet priority i będzie wykonywane co period milisekund. Dodatkowo do zadania mogą być przekazane parametry wskazywane przez wskaźnik params. */
void addTask(int priority, int period, void (*func_ptr)(void *), void * params);

#endif 

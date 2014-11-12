#include "cooperative_scheduler.h"

typedef struct task {
    void (*task)(void * params);
    void * params;
    int period;
    int remaining;
    int ready;  
} task;
task tasks[MAX_NUMBER_OF_TASKS];

void schedule(){
    int i; 
    cli();
    for(i = 0; i < MAX_NUMBER_OF_TASKS; i++){
        task * current = &tasks[i];
        if(current->period != 0){
            current->remaining--;
            if(current->remaining == 0){
                current->ready++;
                current->remaining = current->period;
            }
        }
    }
    sei();
}

void execute(){
    int i;
    for(;;){
        cli();
        for(i = 0; i < MAX_NUMBER_OF_TASKS; i++){
            task * current = &tasks[i];
            if(current->ready > 0){
                current->ready--;
                sei();
                current->task(current->params);
                break;
            }
        }
        sei();
    }
}

void addTask(int priority, int period, void (*func_ptr)(void *), void * params){
    cli();
    task * current = &tasks[priority];
    current->period = period;
    if(period > 0){
        current->remaining = period;
    }else{
        current->remaining = -period;
    }
    current->task = func_ptr;
    current->params = params;
    sei();
}


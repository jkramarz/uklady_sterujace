== sprawozdanie z 5. ćwiczeń, Jakub Kramarz ==
Przełączanie zadań

W funkcji obsługi przerwania skonfigurowanego na 4. ćwiczeniach
przeglądana jest tablica zadań w poszukiwaniu możliwych do wykonania
po zakończeniu obecnie wykonywanego zadania.
Pętla funkcji execute również przegląda tą tablicę po zakończeniu 
obecnie wykonywanego zadania , wykonując zadanie o najwyższym
priorytecie gotowe do wykonania. 

Zadania jednorazowe wykonywane z zadanym opóźnieniem są dodawane
poprzez podanie jako okresu wartości opóźnienia * -1.

Obsługa błędów w zadaniach nie została tutaj zaimplementowana ze
względu na oczekiwany interface biblioteki, jeżeli konkretne
zastosowanie wymagało by obsłużenia różnych kodów wyjścia zadań
i powtórzenia lub zaniechania dalszych powtórzeń zadania, wymagało
by to zmiany typu zwracanego przez zadanie.

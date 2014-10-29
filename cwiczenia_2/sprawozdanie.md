== sprawozdanie z 2. ćwiczeń, Jakub Kramarz ==
dodawanie dodatnich liczb wielobajtowych (o dowolnej długości) w assemblerze

Rejestry X i Y zostały wykorzystane do przechowania adresów przetwarzanych
w obecnej iteracji bajtów, stanowiących części wejściowych liczb, odpowiednio
z tA i tB (których wartość powinna zostać wcześniej ustawiona).
Stała LENGTH wyznacza ilość bajtów rezerwowanych dla każdej z liczb.
Rejestr Z, ze względu na możliwość użycia na nim SBIW, został wykorzystany
do przechowania licznika pozostałych iteracji.
Dodatkowy rejestr R18 przechowuje między kolejnymi dodawaniami wartość flagi
przeniesienia, ze względu na nadpisanie jej przez inne operacje arytmetyczne.
Wartość ta jest zapisywana i ładowana odpowiednio po i przed wykonaniem
dodawania oraz po zakończeniu całości obliczeń.

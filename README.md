Calc
====

A primitive calculator made using flex and bison.

Commands to run :-

bison -d calc2.y 

flex calc2.y

g++ calc2.tab.c lex.yy.c -lfl -o calc2

./calc2

Sample output :-


a=45

print a

Printing....45

a=2^3 + 4 * 5 -1

print a

Printing....27

A=56

print A

Printing....56

5*4

= 20

6^3

= 216

%{
	#include <iostream>
	using namespace std;
	#define YY_DECL extern "C" int yylex()
%}

%%
"+" { cout<<"PLUS"<<endl; }
"-" { cout<<"MINUS"<<endl; }
"*" { cout<<"MULTIPLY"<<endl; }
"/" { cout<<"DIVIDE"<<endl; }
"^" { cout<<"POWER"<<endl; }
[0-9]+ { cout<<"NUMBER"<<endl; }
\n { cout<<"NEWLINE"<<endl; }
\t { }
. { cout<<"Mystery character : "<<yytext<<endl; }
%%

/* Code to run it :

flex calc.l
g++ lex.yy.c -lfl

*/

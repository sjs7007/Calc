%{
	#include <iostream>
	using namespace std;
	#define YY_DECL extern "C" int yylex()

	#include "calc2.tab.h" //to get token types that we return from bison
%}

%%
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"^" { return POW; }
[0-9]+ { yylval.ival = atoi(yytext); return NUMBER; }
"print" { return PRINT; }
[a-zA-Z] { yylval.cval = yytext[0]; return IDENTIFIER; }
"=" { return EQUALTO; }
\n { return EOL; }
\t ; //ignore white space
. ; //ignore any other char
%%



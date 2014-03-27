%{
	#include <cstdio>
	#include <iostream>
	using namespace std;

	//things from flex that bison needs to know about
	extern "C" int yylex();
	extern "C" int yyparse();

	void yyerror(const char *s);
%}

//Defining token data types that flex can return
%union{
	int ival; //integer
	char *sval; //string 
}

//Defining token types
%token <ival> NUMBER  
%token ADD SUB MUL DIV POW
%token EOL
%type <ival> exp factor term calclist

%%
//grammar which bison will parse

calclist: 
	| calclist exp EOL { cout<<"= "<<$2<<endl; } //EOL is for end of expression
	;

exp:	factor	{ $$ = $1; }
	| exp ADD factor { $$ = $1 + $3; } //eqv. to exp = exp + factor
	| exp SUB factor { $$ = $1 - $3; } // exp = exp = factor
	;

factor:	term { $$ = $1; }
	| factor MUL term { $$ = $1 * $3; }
	| factor DIV term { $$ = $1 / $3; }
	;

term: NUMBER { $$ = $1; }
	;
%%

main()
{
	yyparse();
}

void yyerror(const char *s)
{
	cout<<"Parse error."<<endl;
	cout<<"Message : "<<s<<endl;
}

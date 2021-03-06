%{
	#include <cstdio>
	#include <iostream>
	using namespace std;

	//things from flex that bison needs to know about
	extern "C" int yylex();
	extern "C" int yyparse();

	void yyerror(const char *s);
	int findPower(int num,int pow);
	int symbolTable[52];
	void updateSymbolTable(char symbol,int val);
	int computeSymbolIndex(char symbol);
	int symbolVal(char symbol); //returns value from symbol table
%}

//Defining token data types that flex can return
%union
{
	int ival; //integer
	//ichar *sval; //string
	char cval; //char
}

//Defining token types
%token <ival> NUMBER  
%token ADD SUB MUL DIV POW
%token EOL
%type <ival> exp factor term calclist
%token <ival> IDENTIFIER
%token PRINT EQUALTO

%%
//grammar which bison will parse

calclist: 
	| calclist exp EOL { cout<<"= "<<$2<<endl; } //EOL is for end of expression
	| calclist assignment EOL 
	| calclist print EOL
	;

assignment:	IDENTIFIER EQUALTO exp { updateSymbolTable($1,$3); }

print:	PRINT exp	{ cout<<"Printing...."<<$2<<endl; }

exp:	factor	{ $$ = $1; }
	| exp ADD factor { $$ = $1 + $3; } //eqv. to exp = exp + factor
	| exp SUB factor { $$ = $1 - $3; } // exp = exp = factor
	;

factor:	term { $$ = $1; }
	| factor MUL term { $$ = $1 * $3; }
	| factor DIV term { $$ = $1 / $3; }
	| factor POW term { $$ = findPower($1,$3); } 
	;

term: NUMBER { $$ = $1; }
	| IDENTIFIER { $$ = symbolVal($1); }
	;
%%

int main()
{
	/*cout<<"STI : "<<computeSymbolIndex('a')<<endl;
	updateSymbolTable('a',34);
	cout<<symbolTable[26]<<endl;
	cout<<symbolVal('a')<<endl;
	*/
	yyparse();
}

void yyerror(const char *s)
{
	cout<<"Parse error."<<endl;
	cout<<"Message : "<<s<<endl;
}

int findPower(int num,int pow)
{
	int temp=1;
	//consider for pow<0 later
	if(pow>0)
	{
		for(int i=1;i<=pow;i++)
		{
			temp=temp*num;
		}
	}
	return temp;
}

int computeSymbolIndex(char symbol)
{
	//Symbol table starts with A from 0-25 and a from 26-51
	int id = -1;
	if(islower(symbol))
	{
		id = symbol - 'a' + 26;
	}
	else if(isupper(symbol))
	{
		id = symbol - 'A';
	}
	return id;
}

void updateSymbolTable(char symbol, int val)
{
	int id = computeSymbolIndex(symbol);
	if(id<0)
	{
		cout<<"No such symbol."<<"*"<<symbol<<"*"<<endl;
	}
	else
	{
		symbolTable[id]=val;
	}
}

int symbolVal(char symbol)
{
	return(symbolTable[computeSymbolIndex(symbol)]);
}

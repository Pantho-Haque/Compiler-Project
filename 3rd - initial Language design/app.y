%{
#include <bits/stdc++.h>
using namespace std;
#define YYSTYPE double;

    extern FILE *yyin;
    extern FILE *yyout;

	int yylex();
	int yyparse();
    void yyerror(const char *s);
    

%}


%token add sub mul div
%token gt lt ge le ne eq
%token var 
%token INTEGER_VALUE

%%
program:

    | program statement
    ;

statement: 

%%


void yyerror(const char *s) {
    fprintf(stderr, "%s\n\n", s);

}


int main() {
    yyin = freopen("input.txt", "r", stdin);
    yyout = freopen("output.txt", "w", stdout);
    yyparse();
    return 0;
}
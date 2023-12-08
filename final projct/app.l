%{

  #include "app.tab.h"
  
  #include <stdlib.h>

  int yyparse();
 void yyerror(char *); 
 

%}


Var [a-zA-Z][0-9a-zA-Z]*[_]?[0-9a-zA-Z]*

Int [0-9]+

Char ['][a-zA-Z0-9][']

Float [0-9]*[.][0-9]+

String ["].+["]

logicaloperator ">>"|"<<"|">>=="|"<<=="|"!!=="|"===="

operation "++"|"--"|"**"|"//"|"%%"

io "++++"|"----"?

white [ \t\n]*

%%

.h               {return extension;}
"##"      {return headr;}
"begining"         {return begin;}
"ending"        {return end;}

"in"          {return int_type;}
"flt"           {return float_type;}
"charcter"         {return char_type;}
"string"        {return string_type;}

"<-"            {return assign;}
"add"            {return plus;}
"sub"            {return minus;}
"**"            {return into;}
"div"            {return divi;}
"pow"            {return power;}
"mod"            {return mod;}
"root"          {return ssqrt;}
 
"ge"          {return ge;}
"le"          {return le;}
"eq"          {return eqeq;}
"gt"            {return gt;}
"ngt"          {return ngt;}
"lt"            {return lt;}
"nlt"          {return nlt;}
"ne"          {return neq;}

"inc"          {return inc;}
"dec"          {return dec;}

{white}";;"{white}            {return eol;}
{white}","{white}            {return sep;}
[=\n]           {return *yytext;}


"display"         {return prnt;}
"prime"         {return prime;}


"do-if"           {return doif;}
{white}"or"{white}         {return or;}
{white}"or-if"{white}         {return orif;}

"from"          {return from;}
"to"          {return to;}

"stopif"        {return stopif;}

"func"          {return ffunc;}
{white}"|"{white}           {return ps;}
{white}"{"{white}            {return sbs;}
{white}"}"{white}            {return sbf;}


{Int}      {
                yylval = atoi(yytext);
                return INTEGER;
            }
{Var}           {
			yylval = strdup(yytext);
 			return VARIABLE;
 			}
{Float}         {yylval = atoi(yytext);
                return FLOAT;}
{String}        {yylval = strdup(yytext);
                return STRING;} 
{Char}          {yylval = *yytext;
                return CHARACTER;}


==.*==     {yylval = strdup(yytext);
                return slcmnt;}

\/=[^=]*=\/ {yylval = strdup(yytext);
                return mlcmnt;}

"  " {}


[ \t]   {}       /* skip whitespace */
[\n]       {}
.               {return invalid;}


%%

int yywrap(void) {
    return 1;
}

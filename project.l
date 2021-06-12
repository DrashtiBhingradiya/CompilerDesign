%{
#include<stdio.h> 
#include "y.tab.h"
int yyerror(char *errormsg);
%}

keywords WITH|BOTH|AND|DO|WHAT|RESULT|ALSO|TO|NOW|OF|BOTH|ANSWERS|IS
whitespace \t|\b|\n
punctuations "."|"?"
opadd "ADD"|"ADDITION"
opsub "SUBTRACT"|"SUBTRACTION"
opmul "MULTIPLY"|"MULTIPLICATION"|"TIMES"
opdiv "DIVIDE"|"DIVISION"

%%
{keywords}		{printf("%s is valid KEYWORD\n",yytext); return KEYWORD;}

(([0-9]+)|([0-9]*\.[0-9]+)) {printf("%s is valid Literal\n",yytext); yylval.number=(float)atof(yytext); return NUM;}

{punctuations}	{printf("%s is valid Punctuation\n",yytext); return PUNCTUATION;}
[ \t\n]+

{opadd}		{printf("%s is valid + OPERATOR\n",yytext); return '+';}

{opsub}		{printf("%s is valid - OPERATOR\n",yytext); return '-';}

{opmul}		{printf("%s is valid * OPERATOR\n",yytext); return '*';}

{opdiv}		{printf("%s is valid / OPERATOR\n",yytext); return '/';}

.			{printf("%s is NOT a valid Token\n",yytext);}
%%

int yywrap(void)
{
	return 1;
}

int yyerror(char *errormsg)
{   
printf("\n======ERROR GENERATED:======\n"); 
fprintf(stderr, "line %d: %s\n:", yylineno, errormsg);
exit(1);
}




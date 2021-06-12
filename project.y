%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
int yyerror(const char *s);
int flag=0;
float tmp[3];
float ans=0.0;
%} 
%union
{
float number;
}

%token <number> NUM FLOAT
%type <number> A B C

%token KEYWORD PUNCTUATION OPERATOR

%%
S : A B C D { printf("===Entered Query is CORRECTLY WRITTEN!===\n"); 
				if(flag==0){printf ("RESULT = %.3f\n",ans);} return 0;}
	;

A : '+' NUM KEYWORD NUM PUNCTUATION		{ $$ = $2 + $4; 
		tmp[0]=$$;
		printf("ENTERED FIRST EXPRESSION IS: %f + %f = %f \n",$2,$4,tmp[0]); 
	} 
	| '-' NUM KEYWORD NUM PUNCTUATION	{ $$ = $2 - $4;  
		tmp[0]=$$;
		printf("ENTERED FIRST EXPRESSION IS: %f - %f = %f\n",$2,$4,tmp[0]);
	}
	| '*' NUM KEYWORD NUM PUNCTUATION	{ $$ = $2 * $4; 
		tmp[0]=$$;
		printf("ENTERED FIRST EXPRESSION IS: %f * %f = %f\n",$2,$4,tmp[0]);
	}
	| '/' NUM KEYWORD NUM PUNCTUATION	{ 
	if($4==0){printf("===ERROR: DIVIDE BY ZERO \n CANNOT CALCULATE RESULT!==\n"); flag=1; }
		else{ 
		$$=$2/$4; 
		tmp[0]=$$;
		printf("ENTERED FIRST EXPRESSION IS: %f / %f = %f\n",$2,$4,tmp[0]); }
	}
	;

B : KEYWORD '+' NUM KEYWORD NUM PUNCTUATION		{ $$ = $3 + $5; 
		tmp[1]=$$;
		printf("ENTERED SECOND EXPRESSION IS: %f + %f = %f\n",$3,$5,tmp[1]); 
	} 
	| KEYWORD '-' NUM KEYWORD NUM PUNCTUATION  { $$ = $3 - $5; 
		tmp[1]=$$;
		printf("ENTERED SECOND EXPRESSION IS: %f - %f = %f\n",$3,$5,tmp[1]);  
	}
	| KEYWORD '*' NUM KEYWORD NUM PUNCTUATION   { $$ = $3 * $5; 
		tmp[1]=$$;
		printf("ENTERED SECOND EXPRESSION IS: %f * %f = %f\n",$3,$5,tmp[1]);  
	}
		| KEYWORD '/' NUM KEYWORD NUM PUNCTUATION    { if($5==0){printf("===ERROR: DIVIDE BY ZERO \n CANNOT CALCULATE RESULT!==\n"); flag=1; }
		else{ 
		$$=$3/$5; 
		tmp[1]=$$;
		printf("ENTERED SECOND EXPRESSION IS: %f / %f = %f\n",$3,$5,tmp[1]); }
	}
	;

C : KEYWORD KEYWORD '+' KEYWORD KEYWORD KEYWORD PUNCTUATION  {   
		ans = tmp[0] + tmp[1];
		printf("THIRD OPERATION PROVIDED IS + \n"); 
	}
	| KEYWORD KEYWORD '-' KEYWORD KEYWORD KEYWORD PUNCTUATION { 
		ans = tmp[0] - tmp[1];
		printf("THIRD OPERATION PROVIDED IS - \n"); 
	}
	| KEYWORD KEYWORD '*' KEYWORD KEYWORD KEYWORD PUNCTUATION { 
		ans = tmp[0] * tmp[1];
		printf("THIRD OPERATION PROVIDED IS * \n"); 
	}
	| KEYWORD KEYWORD '/' KEYWORD KEYWORD KEYWORD PUNCTUATION  { 
		if(tmp[1]==0){printf("===ERROR: DIVIDE BY ZERO \n CANNOT CALCULATE RESULT!==\n"); flag=1; }
		else{ 
		ans = tmp[0]/tmp[1];
		printf("THIRD OPERATION PROVIDED IS / /n"); }
	}
	;

D : KEYWORD KEYWORD KEYWORD PUNCTUATION  
	;
%%
    
int main()
{
printf("Enter Your Query : \n");  
yyparse();   
printf("\nSUCCESSFULLY EXECTUED PROGRAM! \n PROGRAM TERMINATING...\n"); 
return 0; 
}
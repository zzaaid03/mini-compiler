%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%
"int"           { return INT; }
"if"            { return IF; }
"while"         { return WHILE; }
"print"         { return PRINT; }

"=="            { return EQ; }
"!="            { return NE; }
">="            { return GE; }
"<="            { return LE; }
">"             { return GT; }
"<"             { return LT; }

"&&"            { return AND; }
"||"            { return OR; }
"!"             { return NOT; }

[0-9]+          { yylval.intval = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.id = strdup(yytext); return ID; }

[ \t\r\n]+      ;
.               { return yytext[0]; }
%%

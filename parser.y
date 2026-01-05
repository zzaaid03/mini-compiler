%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

int symtab[26];
%}

%union {
    int intval;
    char* id;
}

%token <intval> NUMBER
%token <id> ID
%token INT IF WHILE PRINT
%token GT LT GE LE EQ NE AND OR NOT

%type <intval> expr

%%
program:
    stmt_list
;

stmt_list:
    stmt_list stmt
  | stmt
;

stmt:
    INT ID ';'                 { symtab[$2[0]-'a'] = 0; }
  | ID '=' expr ';'            { symtab[$1[0]-'a'] = $3; }
  | PRINT expr ';'             { printf("Output: %d\n", $2); }
  | IF '(' expr ')' stmt
  | WHILE '(' expr ')' stmt
  | '{' stmt_list '}'
;

expr:
    expr '+' expr              { $$ = $1 + $3; }
  | expr '-' expr              { $$ = $1 - $3; }
  | expr '*' expr              { $$ = $1 * $3; }
  | expr '/' expr              { $$ = $1 / $3; }

  | expr GT expr               { $$ = $1 > $3; }
  | expr LT expr               { $$ = $1 < $3; }
  | expr GE expr               { $$ = $1 >= $3; }
  | expr LE expr               { $$ = $1 <= $3; }
  | expr EQ expr               { $$ = $1 == $3; }
  | expr NE expr               { $$ = $1 != $3; }

  | expr AND expr              { $$ = $1 && $3; }
  | expr OR expr               { $$ = $1 || $3; }
  | NOT expr                   { $$ = !$2; }

  | NUMBER
  | ID                         { $$ = symtab[$1[0]-'a']; }
  | '(' expr ')'
;
%%
void yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
}

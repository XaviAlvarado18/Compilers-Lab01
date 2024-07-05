%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%union {
    char *str;
    int num;
}

%token <str> ID
%token <num> NUMBER

%type <num> expression

%left '+' '-'
%left '*' '/'
%right '='

%%

program: statement_list
        ;

statement_list: statement '\n'
              | statement_list statement '\n'
              | statement
              | statement_list statement
              ;

statement: assignment
         | expression
         ;

assignment: ID '=' expression
          { printf("Assign %s = %d\n", $1, $3); }
          ;

expression: NUMBER
          { $$ = $1; }
          | ID
          { $$ = atoi($1); }  // Asumiendo que ID puede ser convertido a entero
          | expression '+' expression
          { $$ = $1 + $3; }
          | expression '-' expression
          { $$ = $1 - $3; }
          | expression '*' expression
          { $$ = $1 * $3; }
          | expression '/' expression
          { $$ = $1 / $3; }
          ;

%%

int main() {
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    printf("Error: %s\n", s);
    return 0;
}

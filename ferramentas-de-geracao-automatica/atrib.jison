%lex
%%
\s+
"int"                         return 'INT';
"float"                       return 'FLOAT';
"char"                        return 'CHAR';
[0-9]+\.[0-9]+                return 'FLOAT_CONST';
[0-9]+                        return 'INT_CONST';
"'"[a-zA-Z0-9]"'"             return 'CHAR_CONST';
[a-zA-Z_][a-zA-Z0-9_]*        return 'ID';
"="                           return '=';
";"                           return ';';
"*"                           return '*';
"/"                           return '/';
"+"                           return '+';
"-"                           return '-';
.                             return 'INVALID';
<<EOF>>                       return 'EOF';
/lex

%start line

%token INT FLOAT CHAR INT_CONST FLOAT_CONST CHAR_CONST ID

%%

line
    : declaration '=' expr ';'
        { return 'Linha válida de atribuição!'; }
    ;

declaration
    : INT ID
    | FLOAT ID
    | CHAR ID
    ;

expr
    : expr '+' term
    | expr '-' term
    | term
    ;

term
    : term '*' factor
    | term '/' factor
    | factor
    ;

factor
    : ID
    | INT_CONST
    | FLOAT_CONST
    | CHAR_CONST
    ;

%lex
%%

\s+                     /* ignora espaços e quebras de linha */
"//".*                  /* ignora comentários de linha */
"/*"([^*]|\*+[^*/])*"*/" /* ignora comentários de bloco */
"char"                  return 'CHAR';
"int"                   return 'INT';
"float"                 return 'FLOAT';
"if"                    return 'IF';
"else"                  return 'ELSE';
"switch"                return 'SWITCH';
"case"                  return 'CASE';
"default"               return 'DEFAULT';
"break"                 return 'BREAK';
"while"                 return 'WHILE';
"for"                   return 'FOR';
"++"                    return 'INCREMENT';
"--"                    return 'DECREMENT';
"+="                    return 'ADD_ASSIGN';
"-="                    return 'SUB_ASSIGN';
"*="                    return 'MUL_ASSIGN';
"/="                    return 'DIV_ASSIGN';
"=="                    return 'EQ';
"!="                    return 'NE';
"<"                     return 'LT';
"<="                    return 'LE';
">"                     return 'GT';
">="                    return 'GE';
"+"                     return '+';
"-"                     return '-';
"*"                     return '*';
"/"                     return '/';
"="                     return '=';
","                     return ',';
";"                     return ';';
":"                     return ':';
"("                     return '(';
")"                     return ')';
"{"                     return '{';
"}"                     return '}';
[0-9]+\.[0-9]+          return 'FLOAT_CONST';
[0-9]+                  return 'INT_CONST';
\'[^\'\\]\'             return 'CHAR_CONST';
\"[^\"\\]*\"            return 'STRING_CONST';
[a-zA-Z_][a-zA-Z0-9_]*  return 'IDENTIFIER';
.                       return 'INVALID';

/lex

%start program

%%

program
    : declarations statements
    ;

declarations
    : declaration
    | declarations declaration
    ;

declaration
    : type var_list ';'
    ;

type
    : CHAR
    | INT
    | FLOAT
    ;

var_list
    : variable
    | var_list ',' variable
    ;

variable
    : IDENTIFIER
    | IDENTIFIER '=' value
    ;

value
    : INT_CONST
    | FLOAT_CONST
    | CHAR_CONST
    | STRING_CONST
    ;

statements
    : statement
    | statements statement
    ;

statement
    : declaration
    | expression ';'
    | block
    | if_statement
    | switch_statement
    | while_statement
    | for_statement
    ;

block
    : '{' statements '}'
    ;

expression
    : assignment
    | logical_or
    ;

assignment
    : IDENTIFIER '=' expression
    | IDENTIFIER ADD_ASSIGN expression
    | IDENTIFIER SUB_ASSIGN expression
    | IDENTIFIER MUL_ASSIGN expression
    | IDENTIFIER DIV_ASSIGN expression
    | IDENTIFIER INCREMENT
    | IDENTIFIER DECREMENT
    | logical_or
    ;

logical_or
    : logical_and
    | logical_or '||' logical_and
    ;

logical_and
    : equality
    | logical_and '&&' equality
    ;

equality
    : relational
    | equality EQ relational
    | equality NE relational
    ;

relational
    : additive
    | relational LT additive
    | relational LE additive
    | relational GT additive
    | relational GE additive
    ;

additive
    : multiplicative
    | additive '+' multiplicative
    | additive '-' multiplicative
    ;

multiplicative
    : unary
    | multiplicative '*' unary
    | multiplicative '/' unary
    ;

unary
    : postfix
    | '-' unary
    | '+' unary
    ;

postfix
    : primary
    | postfix INCREMENT
    | postfix DECREMENT
    ;

primary
    : IDENTIFIER
    | INT_CONST
    | FLOAT_CONST
    | CHAR_CONST
    | STRING_CONST
    | '(' expression ')'
    ;

if_statement
    : IF '(' expression ')' statement
    | IF '(' expression ')' statement ELSE statement
    ;

switch_statement
    : SWITCH '(' expression ')' '{' case_list '}'
    ;

case_list
    : /* empty */
    | case_list case_block
    ;

case_block
    : CASE expression ':' case_body
    | DEFAULT ':' case_body
    ;

case_body
    : '{' statements BREAK ';' '}'
    | '{' statements '}'
    | '{' BREAK ';' '}'
    | statements BREAK ';'
    | statements
    | BREAK ';'
    ;

while_statement
    : WHILE '(' expression ')' statement
    ;

for_statement
    : FOR '(' expression ';' expression ';' expression ')' statement
    ;

%%
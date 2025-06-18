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
"<="                    return 'LE';
"<"                     return 'LT';
">="                    return 'GE';
">"                     return 'GT';
"||"                    return 'OR';
"&&"                    return 'AND';
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
    : declarations statements { return {type:"program", declarations: $1, statements: $2}; }
    ;

declarations
    : declaration { $$ = [$1]; }
    | declarations declaration { $$ = $1.concat([$2]); }
    | /* empty */ { $$ = []; }
    ;

declaration
    : type var_list ';' { $$ = {type:"declaration", varType: $1, vars: $2}; }
    ;

type
    : CHAR { $$ = "char"; }
    | INT { $$ = "int"; }
    | FLOAT { $$ = "float"; }
    ;

var_list
    : variable { $$ = [$1]; }
    | var_list ',' variable { $$ = $1.concat([$3]); }
    ;

variable
    : IDENTIFIER { $$ = {name: yytext, value: null}; }
    | IDENTIFIER '=' value { $$ = {name: $1, value: $3}; }
    ;

value
    : INT_CONST { $$ = Number(yytext); }
    | FLOAT_CONST { $$ = Number(yytext); }
    | CHAR_CONST { $$ = yytext; }
    | STRING_CONST { $$ = yytext; }
    ;

statements
    : statement { $$ = [$1]; }
    | statements statement { $$ = $1.concat([$2]); }
    | /* empty */ { $$ = []; }
    ;

statement
    : declaration { $$ = $1; }
    | expression ';' { $$ = $1; }
    | block { $$ = $1; }
    | if_statement { $$ = $1; }
    | switch_statement { $$ = $1; }
    | while_statement { $$ = $1; }
    | for_statement { $$ = $1; }
    ;

block
    : '{' statements '}' { $$ = {type:"block", statements:$2}; }
    ;

expression
    : assignment { $$ = $1; }
    | logical_or { $$ = $1; }
    ;

assignment
    : IDENTIFIER '=' expression { $$ = {type:"assign", left:$1, right:$3}; }
    | IDENTIFIER ADD_ASSIGN expression { $$ = {type:"assignAdd", left:$1, right:$3}; }
    | IDENTIFIER SUB_ASSIGN expression { $$ = {type:"assignSub", left:$1, right:$3}; }
    | IDENTIFIER MUL_ASSIGN expression { $$ = {type:"assignMul", left:$1, right:$3}; }
    | IDENTIFIER DIV_ASSIGN expression { $$ = {type:"assignDiv", left:$1, right:$3}; }
    | IDENTIFIER INCREMENT { $$ = {type:"increment", var:$1}; }
    | IDENTIFIER DECREMENT { $$ = {type:"decrement", var:$1}; }
    | logical_or { $$ = $1; }
    ;

logical_or
    : logical_and { $$ = $1; }
    | logical_or OR logical_and { $$ = {type:"or", left:$1, right:$3}; }
    ;

logical_and
    : equality { $$ = $1; }
    | logical_and AND equality { $$ = {type:"and", left:$1, right:$3}; }
    ;

equality
    : relational { $$ = $1; }
    | equality EQ relational { $$ = {type:"eq", left:$1, right:$3}; }
    | equality NE relational { $$ = {type:"ne", left:$1, right:$3}; }
    ;

relational
    : additive { $$ = $1; }
    | relational LT additive { $$ = {type:"lt", left:$1, right:$3}; }
    | relational LE additive { $$ = {type:"le", left:$1, right:$3}; }
    | relational GT additive { $$ = {type:"gt", left:$1, right:$3}; }
    | relational GE additive { $$ = {type:"ge", left:$1, right:$3}; }
    ;

additive
    : multiplicative { $$ = $1; }
    | additive '+' multiplicative { $$ = {type:"add", left:$1, right:$3}; }
    | additive '-' multiplicative { $$ = {type:"sub", left:$1, right:$3}; }
    ;

multiplicative
    : unary { $$ = $1; }
    | multiplicative '*' unary { $$ = {type:"mul", left:$1, right:$3}; }
    | multiplicative '/' unary { $$ = {type:"div", left:$1, right:$3}; }
    ;

unary
    : postfix { $$ = $1; }
    | '-' unary { $$ = {type:"neg", value:$2}; }
    | '+' unary { $$ = {type:"pos", value:$2}; }
    ;

postfix
    : primary { $$ = $1; }
    | postfix INCREMENT { $$ = {type:"postInc", value:$1}; }
    | postfix DECREMENT { $$ = {type:"postDec", value:$1}; }
    ;

primary
    : IDENTIFIER { $$ = {type:"id", value:$1}; }
    | INT_CONST { $$ = {type:"int", value:Number(yytext)}; }
    | FLOAT_CONST { $$ = {type:"float", value:Number(yytext)}; }
    | CHAR_CONST { $$ = {type:"char", value:yytext}; }
    | STRING_CONST { $$ = {type:"string", value:yytext}; }
    | '(' expression ')' { $$ = $2; }
    ;

if_statement
    : IF '(' expression ')' statement { $$ = {type:"if", condition:$3, then:$5}; }
    | IF '(' expression ')' statement ELSE statement { $$ = {type:"ifelse", condition:$3, then:$5, else:$7}; }
    ;

switch_statement
    : SWITCH '(' expression ')' '{' case_list '}' { $$ = {type:"switch", expression:$3, cases:$6}; }
    ;

case_list
    : /* empty */ { $$ = []; }
    | case_list case_block { $$ = $1.concat([$2]); }
    ;

case_block
    : CASE expression ':' case_body { $$ = {type:"case", value:$2, body:$4}; }
    | DEFAULT ':' case_body { $$ = {type:"default", body:$3}; }
    ;

case_body
    : '{' statements BREAK ';' '}' { $$ = {type:"caseBody", statements:$2, break:true}; }
    | '{' statements '}' { $$ = {type:"caseBody", statements:$2, break:false}; }
    | '{' BREAK ';' '}' { $$ = {type:"caseBody", statements:[], break:true}; }
    | statements BREAK ';' { $$ = {type:"caseBody", statements:$1, break:true}; }
    | statements { $$ = {type:"caseBody", statements:$1, break:false}; }
    | BREAK ';' { $$ = {type:"caseBody", statements:[], break:true}; }
    ;

while_statement
    : WHILE '(' expression ')' statement { $$ = {type:"while", condition:$3, body:$5}; }
    ;

for_statement
    : FOR '(' expression ';' expression ';' expression ')' statement { $$ = {type:"for", init:$3, cond:$5, iter:$7, body:$9}; }
    ;

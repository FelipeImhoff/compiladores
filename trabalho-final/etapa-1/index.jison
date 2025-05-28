%lex
%%
\s+                    /* ignora espaços e quebras de linha */
"char"                 return 'CHAR';
"int"                  return 'INT';
"float"                return 'FLOAT';
[0-9]+\.[0-9]+         return 'FLOAT_CONST';
[0-9]+                 return 'INT_CONST';
\'[^\'\\]\'            return 'CHAR_CONST';         // exemplo: 'a'
\"[^\"\\]*\"           return 'STRING_CONST';       // exemplo: "abc"
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER';         // identificadores válidos em C
"="                    return '=';
","                    return ',';
";"                    return ';';
.                      return 'INVALID';
/lex

%start declaracoes

%%

declaracoes
    : declaracao
    | declaracoes declaracao
    ;

declaracao
    : tipo lista_vars ';'
        { return "Declaração válida"; }
    ;

tipo
    : CHAR
    | INT
    | FLOAT
    ;

lista_vars
    : var
    | lista_vars ',' var
    ;

var
    : IDENTIFIER
    | IDENTIFIER '=' valor
    ;

valor
    : INT_CONST
    | FLOAT_CONST
    | CHAR_CONST
    | STRING_CONST
    ;

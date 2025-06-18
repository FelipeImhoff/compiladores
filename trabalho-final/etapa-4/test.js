const parser = require('./index');

const input = `
int i;
float total = 0;
char letra = 'a';

i = 0;
total = total + 1.5;
i += 2;
total *= 3.0;

/* IF
simples */
if (i > 0) {
  total = total + 1.0;
}

// IF com ELSE
if (i < 5) {
  total = total + 2.0;
} else {
  total = total - 1.0;
}

// SWITCH com múltiplos cases
switch(i) {
  case 0: {
    total = total + 10.0;
    break;
  }
  case 1: {
    total = total + 20.0;
    break;
  }
  default: {
    total = total + 30.0;
  }
}

// WHILE loop
while (i < 3) {
  total = total + 1.5;
  i++;
}

// FOR loop
for (i = 0; i < 5; i++) {
  total += 2;
}
`;

try {
  // Análise léxica
  const lexer = new parser.Parser().lexer;
  lexer.setInput(input);

  console.log("Tokens reconhecidos (análise léxica):");
  let token;
  while ((token = lexer.lex()) !== 1) {  // 1 == EOF
    console.log(`Token: ${token}, Valor: ${lexer.yytext}`);
  }

  console.log("\nIniciando análise sintática...");

  // Análise sintática
  const ast = parser.parse(input);

  console.log("Análise sintática deu certo!");
  console.log("AST gerada:", JSON.stringify(ast, null, 2));
} catch (e) {
  console.error("Erro na análise sintática:\n", e.message);
}


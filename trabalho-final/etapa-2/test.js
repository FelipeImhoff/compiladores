const parser = require('./index');

const input = `
int a;
float b = 3.14;
char letra = 'x';

if (a == 10) {
  a = a + 1;
} else {
  a = a - 1;
}

switch (a) {
  case 1: {
    b += 2.5;
    break;
  }
  case 2: case 3: {
    b *= 1.5;
    break;
  }
  default: {
    b = 0;
  }
}
`;

try {
  parser.parse(input);
  console.log("Análise sintática deu certo!");
} catch (e) {
  console.error("Erro na análise sintática:\n", e.message);
}

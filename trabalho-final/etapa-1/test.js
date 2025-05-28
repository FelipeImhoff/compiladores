const parser = require('./index');

const exemplos = [
  `int a;`,
  `float b = 3.14;`,
  `char letra = 'x';`,
  `char nome = "Felipe";`,
  `int a, b = 10, c;`,
  `float x, y = 2.5;`,
  `char ch = 'a', str = "abc";`,
  `int _var123 = 42;`,
  `float x=2.5,y=3.5,z;`
];

exemplos.forEach((entrada, i) => {
  console.log(`\n🧪 Exemplo ${i + 1}: "${entrada}"`);
  try {
    const resultado = parser.parse(entrada + '\n');
    console.log("Resultado:", resultado);
  } catch (erro) {
    console.error("Erro de sintaxe:", erro.message);
  }
});

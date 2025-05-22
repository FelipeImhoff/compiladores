const fs = require('fs');
const jison = require('jison');

const grammar = fs.readFileSync('atrib.jison', 'utf8');
const parser = new jison.Parser(grammar);

const exemplos = [
  'int a = 5;',
  'float z = 3.14 * r;',
  "char c = 'x';",
  'int 1a = 10;',
  'float b = ;',
  'double d = 2.0;',
];

exemplos.forEach((linha) => {
  try {
    const resultado = parser.parse(linha);
    console.log(`✅ Válida: "${linha}" → ${resultado}`);
  } catch (err) {
    console.log(`❌ Inválida: "${linha}" → ${err.message}`);
  }
});

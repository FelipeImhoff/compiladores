Ferramenta: Jison (https://github.com/zaach/jison)

Execução:
1. Instale o jison:
   npm install -g jison

2. Gere o parser:
   jison etapa1.jison

3. Use o parser gerado em um arquivo JS (ex: test.js)

Exemplo de código JS:
---------------------
const parser = require('./etapa1');

const entrada = `
    int a;
    float b = 3.14, c;
    char letra = 'x', nome = "Felipe";
`;

try {
    const resultado = parser.parse(entrada);
    console.log("Resultado:", resultado);
} catch (e) {
    console.error("Erro de sintaxe:", e.message);
}

Especificações:
- char: caractere ('x') ou cadeia de caracteres ("texto")
- float: precisão não limitada pela ferramenta
- identificadores seguem o padrão da linguagem C
- declarações terminam com ponto-e-vírgula

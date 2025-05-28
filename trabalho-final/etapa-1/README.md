# 📚 Etapa 1 — Analisador Léxico e Sintático com Jison

## 🛠 Ferramenta Utilizada

- **Jison**: [https://github.com/zaach/jison](https://github.com/zaach/jison)

## 📋 Objetivo

Criar um analisador léxico e sintático para reconhecer **declarações de variáveis no estilo da linguagem C**, conforme os requisitos do trabalho da disciplina de Compiladores.

---

## ▶️ Execução

### 1. Instalar o Jison globalmente

```bash
npm install -g jison
```

### 2. Gerar o parser a partir do arquivo `.jison`

```bash
jison index.jison
```

Esse comando irá gerar um arquivo `index.js` que exporta um parser pronto para uso.

### 3. Criar e executar o arquivo de teste

Crie um arquivo chamado `test.js` com o seguinte conteúdo:

```js
const parser = require("./index");

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
```

Execute com:

```bash
node test.js
```

---

## 📌 Especificações da Gramática

- **Tipos suportados**: `char`, `int`, `float`
- **char**:

  - Pode ser um **caractere**: `'x'`
  - Ou uma **cadeia de caracteres**: `"texto"`

- **float**:

  - Números com ponto flutuante, como `3.14`
  - Sem limitação de casas decimais

- **Identificadores**:

  - Começam com letra ou `_`
  - Seguidos por letras, números ou `_`
  - Padrão compatível com a linguagem C

- **Inicialização**: Variáveis podem ser declaradas com ou sem atribuição de valor
- **Listas de variáveis**: Separadas por vírgulas
- **Finalização**: Toda declaração termina com `;`

---

## 📂 Estrutura esperada dos arquivos

```
.
├── index.jison       # Definição léxica e sintática
├── index.js          # Parser gerado pelo Jison
├── test.js            # Script de teste
└── README.md          # Instruções de uso
```

---

## ✅ Exemplo válido de entrada

```c
char letra = 'a', nome = "João";
int idade, ano = 2025;
float nota = 9.75, media;
```

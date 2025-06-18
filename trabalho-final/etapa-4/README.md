# Projeto de Analisador Sintático com Jison

Este projeto implementa um analisador léxico e sintático completo utilizando Jison, capaz de reconhecer a sintaxe básica de uma linguagem estilo C, incluindo:

- 📌 Declarações de variáveis (`int`, `float`, `char`)
- 🧮 Expressões matemáticas e operadores de atribuição
- 🚦 Estruturas condicionais (`if-else`, `switch-case`)
- 🔄 Estruturas de repetição (`while`, `for`)
- 🔄 Operadores de incremento/decremento (`++`, `--`)

---

## 📂 Estrutura do Projeto

- `index.jison`: Arquivo principal contendo a gramática completa
- `test.js`: Script de testes com exemplos de código válido
- `README.md`: Este arquivo de documentação

---

## ▶️ Como Executar

1. Instale o Jison globalmente (caso ainda não tenha):

```bash
npm install -g jison
```

2. Compile o analisador sintático:

```bash
jison index.jison -o index.js
```

3. Execute os testes:

```bash
node test.js
```

---

## 🛠️ Funcionalidades Implementadas

### Declarações de Variáveis

```c
int i;
float total = 0;
char letra = 'a';
```

### Operadores Matemáticos

```c
i = 0;
total = total + 1.5;
i += 2;
total *= 3.0;
```

### Estruturas Condicionais

```c
// IF-ELSE
if (i < 5) {
  total = total + 2.0;
} else {
  total = total - 1.0;
}

// SWITCH-CASE
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
```

### Estruturas de Repetição

```c
// WHILE loop
while (i < 3) {
  total = total + 1.5;
  i++;
}

// FOR loop
for (i = 0; i < 5; i++) {
  total += 2;
}
```

### Operadores Especiais

```c
i++;      // incremento
total--;  // decremento
i += 2;   // atribuição com adição
total *= 3.0; // atribuição com multiplicação
```

---

## 🧪 Exemplo de Código Válido Completo

```c
int main() {
  int counter = 0;
  float result = 1.0;

  // Loop while
  while(counter < 10) {
    result *= 1.5;
    counter++;

    // Condicional if
    if(result > 10.0) {
      break;
    }
  }

  // Loop for
  for(int i = 0; i < 5; i++) {
    result -= 0.5;
  }

  // Switch case
  switch(counter) {
    case 5: {
      result /= 2.0;
      break;
    }
    default: {
      result += 1.0;
    }
  }

  return 0;
}
```

---

## 📚 Especificações Técnicas

### Operadores Suportados

- **Aritméticos**: `+`, `-`, `*`, `/`
- **Relacionais**: `==`, `!=`, `<`, `<=`, `>`, `>=`
- **Atribuição**: `=`, `+=`, `-=`, `*=`, `/=`
- **Incremento/Decremento**: `++`, `--`

### Estruturas Suportadas

- Blocos de código com `{ }`
- Comandos terminados com `;`
- Comentários de linha (`//`) e bloco (`/* */`)

### Regras Léxicas

- Identificadores: `[a-zA-Z_][a-zA-Z0-9_]*`
- Números inteiros: `[0-9]+`
- Números decimais: `[0-9]+\.[0-9]+`
- Caracteres: `'[^\'\\]'`
- Strings: `"[^\"\\]*"`

---

## 🔍 Saída de Testes Atualizada

Ao executar `node test.js`, você verá:

1. **Tokens reconhecidos (Análise Léxica)**  
   Uma lista detalhada de tokens com seus valores conforme o código fonte é lido.

2. **Árvore Sintática (AST)**  
   A estrutura hierárquica da árvore sintática impressa no console, mostrando os nós e seus filhos de maneira indentada, facilitando o entendimento da análise do código.

# Projeto de Analisador Sintático com Jison (Etapas 1 e 2)

Este projeto implementa um analisador léxico e sintático utilizando Jison, capaz de reconhecer:

- 📌 Declarações de variáveis (`int`, `float`, `char`);
- 🧮 Comandos matemáticos com operadores de atribuição;
- ✅ Comandos condicionais `if-else` com operadores relacionais;
- 🔁 Comandos `switch-case` com múltiplos `case` e `default` opcional.

---

## 📂 Estrutura

- `index.jison`: Arquivo principal contendo a gramática das etapas 1 e 2.
- `test.js`: Script de testes com código de entrada simulando um programa em estilo C.
- `README.md`: Este arquivo.

---

## ▶️ Como Executar

1. Instale o Jison (caso ainda não tenha):

   ```bash
   npm install -g jison
   ```

2. Gere o parser:

   ```bash
   jison index.jison
   ```

   Isso vai gerar um arquivo `index.js`.

3. Execute o teste:

   ```bash
   node test.js
   ```

---

## 🧪 Exemplo de Código Válido

```c
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
```

---

## ℹ️ Observações

- O `else` e o `default` são opcionais, assim como na linguagem C.
- Cada comando termina obrigatoriamente com ponto-e-vírgula (`;`).
- Variáveis devem ser declaradas com identificadores válidos (`[a-zA-Z_][a-zA-Z0-9_]*`).
- Expressões nas condições podem envolver comparações entre variáveis ou valores.

---

## ✅ Requisitos Atendidos

- Etapa 1: Declarações, comandos matemáticos e operadores;
- Etapa 2: Reconhecimento de `if`, `else`, `switch`, `case`, `default` com blocos de comandos.

# Analisador Léxico e Sintático com Jison

Este projeto implementa um analisador léxico e sintático usando **Jison**, com o objetivo de validar **linhas de atribuição** da linguagem C, como:

```c
int x = 10 + y;
```

## ✅ Funcionalidades

O analisador reconhece:

- Tipos básicos: `int`, `float`, `char`
- Identificadores válidos (ex: `x`, `var1`)
- Constantes numéricas inteiras e de ponto flutuante
- Constantes de caractere (ex: `'a'`)
- Operadores aritméticos: `+`, `-`, `*`, `/`
- Atribuições finalizadas com ponto e vírgula (`;`)

---

## 📦 Requisitos

- [Node.js](https://nodejs.org/) instalado

---

## 📁 Arquivos

- `atrib.jison`: arquivo contendo a gramática léxica e sintática
- `teste.js`: script de teste para avaliar exemplos válidos e inválidos

---

## ▶️ Como Executar

1. Instale as dependências do projeto:

```bash
npm install
```

2. Execute os testes com:

```bash
node teste.js
```

---

## 🧪 Exemplos de Entradas

### ✅ Aceitas

| Linha de código       | Explicação                            |
| --------------------- | ------------------------------------- |
| `int a = 5;`          | Atribuição simples com inteiro        |
| `float z = 3.14 * r;` | Expressão com `float` e variável      |
| `char c = 'x';`       | Atribuição com constante de caractere |

### ❌ Rejeitadas

| Linha de código   | Motivo da rejeição                                     |
| ----------------- | ------------------------------------------------------ |
| `int 1a = 10;`    | Identificador inválido (começa com número)             |
| `float b = ;`     | Expressão ausente à direita do `=`                     |
| `double d = 2.0;` | Tipo `double` não está incluído na gramática suportada |

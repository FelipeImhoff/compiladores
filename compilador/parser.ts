import { Lexer, TokenType } from './lexer'
import * as fs from 'fs'

function parse(tokens: { type: TokenType, value: string }[]): boolean {
  let position = 0

  function accept(type: TokenType): boolean {
    if (tokens[position] && tokens[position].type === type) {
      position++
      return true
    }
    return false
  }

  function expect(type: TokenType) {
    if (!accept(type)) {
      throw new Error(`Esperado ${type}, mas encontrado '${tokens[position]?.value || 'fim da linha'}'`)
    }
  }

  function parseLinha() {
    expect(TokenType.ID)
    expect(TokenType.ASSIGN)
    parseExpressao()

    if (position < tokens.length) {
      throw new Error(`Token inesperado: '${tokens[position].value}'`)
    }
  }

  function parseExpressao() {
    parseTermo()
    while (accept(TokenType.OP)) {
      parseTermo()
    }
  }

  function parseTermo() {
    if (accept(TokenType.ID) || accept(TokenType.NUM)) {
      return
    }
    throw new Error(`Esperado um ID ou NUM, mas encontrado '${tokens[position]?.value || 'fim da linha'}'`)
  }

  parseLinha()
  return true
}

const content = fs.readFileSync('input.txt', 'utf-8')

const lines = content.split('\n')

lines.forEach((line, index) => {
  const cleanLine = line.trim()
  if (cleanLine === '') return

  try {
    const lexer = new Lexer(cleanLine)
    const tokens = lexer.getTokens()

    parse(tokens)
    console.log(`✅ Linha ${index + 1} válida: ${cleanLine}`)
  } catch (err) {
    console.error(`❌ Erro na linha ${index + 1}: ${(err as Error).message} — '${cleanLine}'`)
  }
})

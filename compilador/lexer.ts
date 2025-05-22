export enum TokenType {
  ID = 'TOKEN_ID',
  NUM = 'TOKEN_NUM',
  OP = 'TOKEN_OP',
  ASSIGN = 'TOKEN_ASSIGN'
}

export interface Token {
  type: TokenType
  value: string
}

export class Lexer {
  private content: string
  private position: number = 0

  constructor(content: string) {
    this.content = content
  }

  private isLetter(char: string): boolean {
    return /^[a-zA-Z_]$/.test(char)
  }

  private isDigit(char: string): boolean {
    return /^[0-9]$/.test(char)
  }

  private isOperator(char: string): boolean {
    return /^[+\-*/]$/.test(char)
  }

  private skipWhitespace() {
    while (this.position < this.content.length && /\s/.test(this.content[this.position])) {
      this.position++
    }
  }

  public getTokens(): Token[] {
    const tokens: Token[] = []

    while (this.position < this.content.length) {
      this.skipWhitespace()
      const currentChar = this.content[this.position]

      if (this.isLetter(currentChar)) {
        let identifier = ''
        while (this.position < this.content.length && (this.isLetter(this.content[this.position]) || this.isDigit(this.content[this.position]))) {
          identifier += this.content[this.position]
          this.position++
        }
        tokens.push({ type: TokenType.ID, value: identifier })
      }
      else if (this.isDigit(currentChar)) {
        let number = ''
        while (this.position < this.content.length && this.isDigit(this.content[this.position])) {
          number += this.content[this.position]
          this.position++
        }
        tokens.push({ type: TokenType.NUM, value: number })
      }
      else if (currentChar === '=') {
        tokens.push({ type: TokenType.ASSIGN, value: '=' })
        this.position++
      }
      else if (this.isOperator(currentChar)) {
        tokens.push({ type: TokenType.OP, value: currentChar })
        this.position++
      }
      else {
        throw new Error(`Caractere inválido: '${currentChar}' na posição ${this.position}`)
      }
    }

    return tokens
  }
}

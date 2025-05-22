import * as fs from 'fs'

function isSevenLetterWord (token: string): boolean {
  const regex = /^[a-zA-Z]{7}$/
  return regex.test(token)
}

function isThreeLetterTwoNumbers (token: string): boolean {
  const regex = /^[a-zA-Z]{3}\d{2}$/
  return regex.test(token)
}

function isPhoneNumber (token: string): boolean {
  const regex = /^\(\d{2}\)\s\d{5}-\d{4}$/
  return regex.test(token)
}

function isCapitalizedSentence (token: string): boolean {
  const regex = /^[A-Z].*\.$/
  return regex.test(token)
}

function isValidEmail (token: string): boolean {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  return regex.test(token)
}

function isURL (token: string): boolean {
  const regex = /https?:\/\/[^\s]+/
  return regex.test(token)
}

function hasRepeatedWords (token: string): boolean {
  const regex = /\b([A-Za-z]+)\b\s+\1\b/
  return regex.test(token)
}

function isDate (token: string): boolean {
  const regex = /\b(0[1-9]|[12][0-9]|3[01])[-\/](0[1-9]|1[0-2])[-\/](\d{4})\b/
  return regex.test(token)
}

function hasTwoDecimalPlaces (token: string): boolean {
  const regex = /^\d+\.\d{2}$/
  return regex.test(token)
}

function isCompoundProperName (token: string): boolean {
  const regex = /\b[A-Z][a-zÀ-ÿ]*\s[A-Z][a-zÀ-ÿ]*\b/
  return regex.test(token)
}

function getType (token: string): string {
  if(isSevenLetterWord(token)) return 'Palavra com 7 letras'
  if(isPhoneNumber(token)) return 'Número de telefone'
  if(isThreeLetterTwoNumbers(token)) return '3 letras seguidas de 2 números'
  if(isCapitalizedSentence(token)) return 'Inicia com maiúscula e terminam com ponto final'
  if(isValidEmail(token)) return 'Email valido'
  if(isURL(token)) return 'URL iniciada com http ou https'
  if(hasRepeatedWords(token)) return 'Duas palavras iguais separadas por espaço'
  if(isDate(token)) return 'Data formatada'
  if(hasTwoDecimalPlaces(token)) return 'Número com duas casas decimais'
  if(isCompoundProperName(token)) return 'Nome composto'
  
  return 'Tipo desconhecido'
}

(() => {
  const filePath = './texto_teste.txt'

  if(!fs.existsSync(filePath)) {
    console.error(`Arquivo ${filePath} não encontrado.`)
    return
  }

  try {
    const fileContent: string = fs.readFileSync('./texto_teste.txt', 'utf-8')
    const lines: string[] = fileContent.split('\n')
  
    for (const value of lines) {
      console.log(`${value} - ${getType(value)}`)
    }
    
  } catch (error) {
    console.error('Erro ao ler o arquivo:', error)
  }
})()

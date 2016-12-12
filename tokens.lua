local M = {}

local tokens = {
    ILLEGAL = 'ILLEGAL',
    EOF = 'EOF',
    IDENT = 'IDENT',
    INTEGER = 'INTEGER',
    ASSIGN   = '=',
    PLUS     = '+',
    COMMA     = ',',
    SEMICOLON = ';',
    MINUS = '-',
    BANG = '!',
    SLASH = '/',
    ASTERISK = '*',
    LT = '<',
    GT = '>',
    LPAREN = '(',
    RPAREN = ')',
    LBRACE = '{',
    RBRACE = '}',
    FUNCTION = 'FUNCTION',
    LET = 'LET',
    TRUE = 'TRUE',
    FALSE = 'FALSE',
    IF = 'IF',
    ELSE = 'ELSE',
    RETURN = 'RETURN',
    EQ = '==',
    NOTEQ = '!=',
}

local keywords = {
    ["fn" ]= tokens.FUNCTION,
    ["let"] = tokens.LET,
    ["true"] = tokens.TRUE,
    ["false"] = tokens.FALSE,
    ["if" ]= tokens.IF,
    ["else"] = tokens.ELSE,
    ["return"] = tokens.RETURN,
}

return {
    tokens = tokens,
    keywords = keywords
}

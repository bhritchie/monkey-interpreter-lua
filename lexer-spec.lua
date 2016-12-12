local token = require('tokens')
local tokens = token.tokens
local keywords = token.keywords
local lexer = require('lexer')

local l = lexer:new([[
    let five = 5;
    let ten = 10;

    let add = fn(x, y) {
        x + y;
    };

    let result = add(five, ten);
    !-/*5;
    5 < 10 > 5;

    if (5 < 10) {
        return true;
    } else {
        return false;
    }

    10 == 10;
    10 != 9;
]])

local expectedTokens = {
    {tokens.LET, "let"},
    {tokens.IDENT, "five"},
    {tokens.ASSIGN, "="},
    {tokens.INTEGER, "5"},
    {tokens.SEMICOLON, ";"},
    {tokens.LET, "let"},
    {tokens.IDENT, "ten"},
    {tokens.ASSIGN, "="},
    {tokens.INTEGER, "10"},
    {tokens.SEMICOLON, ";"},
    {tokens.LET, "let"},
    {tokens.IDENT, "add"},
    {tokens.ASSIGN, "="},
    {tokens.FUNCTION, "fn"},
    {tokens.LPAREN, "("},
    {tokens.IDENT, "x"},
    {tokens.COMMA, ","},
    {tokens.IDENT, "y"},
    {tokens.RPAREN, ")"},
    {tokens.LBRACE, "{"},
    {tokens.IDENT, "x"},
    {tokens.PLUS, "+"},
    {tokens.IDENT, "y"},
    {tokens.SEMICOLON, ";"},
    {tokens.RBRACE, "}"},
    {tokens.SEMICOLON, ";"},

    {tokens.LET, "let"},
    {tokens.IDENT, "result"},
    {tokens.ASSIGN, "="},
    {tokens.IDENT, "add"},
    {tokens.LPAREN, "("},
    {tokens.IDENT, "five"},
    {tokens.COMMA, ","},
    {tokens.IDENT, "ten"},
    {tokens.RPAREN, ")"},
    {tokens.SEMICOLON, ";"},

    {tokens.BANG, "!"},
    {tokens.MINUS, "-"},
    {tokens.SLASH, "/"},
    {tokens.ASTERISK, "*"},
    {tokens.INTEGER, "5"},
    {tokens.SEMICOLON, ";"},
    {tokens.INTEGER, "5"},
    {tokens.LT, "<"},
    {tokens.INTEGER, "10"},
    {tokens.GT, ">"},
    {tokens.INTEGER, "5"},
    {tokens.SEMICOLON, ";"},

    {tokens.IF, "if"},
    {tokens.LPAREN, "("},
    {tokens.INTEGER, "5"},
    {tokens.LT, "<"},
    {tokens.INTEGER, "10"},
    {tokens.RPAREN, ")"},
    {tokens.LBRACE, "{"},

    {tokens.RETURN, "return"},
    {tokens.TRUE, "true"},
    {tokens.SEMICOLON, ";"},

    {tokens.RBRACE, "}"},
    {tokens.ELSE, "else"},
    {tokens.LBRACE, "{"},

    {tokens.RETURN, "return"},
    {tokens.FALSE, "false"},
    {tokens.SEMICOLON, ";"},
    {tokens.RBRACE, "}"},

    {tokens.INTEGER, "10"},
    {tokens.EQ, "=="},
    {tokens.INTEGER, "10"},
    {tokens.SEMICOLON, ";"},

    {tokens.INTEGER, "10"},
    {tokens.NOTEQ, "!="},
    {tokens.INTEGER, "9"},
    {tokens.SEMICOLON, ";"},

    {tokens.EOF, ""},
}

for i = 1, #expectedTokens do
    local tok = l:nextToken()

    assert(
        tok.type == expectedTokens[i][1],
        "Tests ("..i..") - expected type "..tostring(expectedTokens[i][1])..", but got "..tostring(tok.type)
    )
    assert(
        tok.literal == expectedTokens[i][2],
        "Tests ("..i..") - expected literal "..tostring(expectedTokens[i][2])..", but got "..tostring(tok.literal)
    )

end
print("All tests passed")

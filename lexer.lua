local token = require('tokens')
local tokens = token.tokens
local keywords = token.keywords

local M = {}

function M:new(input)
    local obj = {
        input = input,
        position = 0,
        readPosition = 1,
        ch = nil,
    }
    self.__index = self
    setmetatable(obj, self)
    obj:readChar()
    return obj
end

function M:readChar()
    if self.readPosition > #self.input then
        self.ch = 0
    else
        self.ch = self.input:sub(self.readPosition, self.readPosition)
    end
    self.position = self.readPosition
    self.readPosition = self.readPosition + 1
end

function M:peekChar()
    if self.readPosition > #self.input then
        return 0
    else
        return self.input:sub(self.readPosition, self.readPosition)
    end
end

local function newToken(token, literal)
    return {type = token, literal = literal}
end

function M:nextToken()
    local token = {type =  nil, literal = nil}

    self:skipWhitespace()

    if self.ch == '=' then
        if self:peekChar() == "=" then
            local char = self.ch
            self:readChar()
            token = newToken(tokens.EQ, char..self.ch)
        else
            token = newToken(tokens.ASSIGN, self.ch)
        end
    elseif self.ch == '+' then token = newToken(tokens.PLUS, self.ch)
    elseif self.ch == '-' then token = newToken(tokens.MINUS, self.ch)
    elseif self.ch == '!' then
        if self:peekChar() == "=" then
            local char = self.ch
            self:readChar()
            token = newToken(tokens.NOTEQ, char..self.ch)
        else
            token = newToken(tokens.BANG, self.ch)
        end
    elseif self.ch == '/' then token = newToken(tokens.SLASH, self.ch)
    elseif self.ch == '*' then token = newToken(tokens.ASTERISK, self.ch)
    elseif self.ch == '<' then token = newToken(tokens.LT, self.ch)
    elseif self.ch == '>' then token = newToken(tokens.GT, self.ch)
    elseif self.ch == ',' then token = newToken(tokens.COMMA, self.ch)
    elseif self.ch == ';' then token = newToken(tokens.SEMICOLON, self.ch)
    elseif self.ch == '(' then token = newToken(tokens.LPAREN, self.ch)
    elseif self.ch == ')' then token = newToken(tokens.RPAREN, self.ch)
    elseif self.ch == '{' then token = newToken(tokens.LBRACE, self.ch)
    elseif self.ch == '}' then token = newToken(tokens.RBRACE, self.ch)
    elseif self.ch == 0 then token = newToken(tokens.EOF, '')
    else
        if self:isLetter(self.ch) then
            token.literal = self:readIdentifier()
            token.type = self:lookupIdentifier(token.literal)
            return token -- so we don't readChar() again
        elseif self:isDigit(self.ch) then
            token.type = tokens.INTEGER
            token.literal = self:readNumber()
            return token
        else
            token = newToken(tokens.ILLEGAL, self.ch)
        end
    end

    self:readChar()
    return token
end

function M:skipWhitespace()
    local ch = self.ch
    while ch == ' ' or ch == '\t' or ch == '\n' or ch == '\r' do
        self:readChar()
        ch = self.ch
    end
end

function M:readIdentifier()
    local position = self.position
    while self:isLetter(self.ch) do
        self:readChar()
    end

    return self.input:sub(position, self.position - 1)
end

function M:isDigit(ch)
    return '0' <= ch and ch <= '9'
end

function M:readNumber()
    local position = self.position
    while self:isDigit(self.ch) do
        self:readChar()
    end
    return self.input:sub(position, self.position - 1)
end

function M:isLetter(char)
    local ch = tostring(char)
    return 'a' <= ch and ch <= 'z' or 'A' <= ch and ch <= 'Z' or ch == '_'
end

function M:lookupIdentifier(s)
    if keywords[s] then
        return keywords[s]
    else
        return tokens.IDENT
    end
end

return M

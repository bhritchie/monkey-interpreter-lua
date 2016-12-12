local token = require('tokens')
local tokens = token.tokens
local lexer = require('lexer')

local prompt = ">> "

local function printToken(token)
    print("{ ".."Type: "..token.type..", ".."Literal: "..token.literal.." }")
end

local function repl()
    while true do
        io.write(prompt)
        local line = io.read()
        if not line then break end
        if line == "\\q" then break end
        local l = lexer:new(line)
        local token = l:nextToken()
        while token.type ~= tokens.EOF do
            printToken(token)
            token = l:nextToken()
        end
    end
end

print("LuaMonkey REPL 0.0.1; \\q to exit")
repl()
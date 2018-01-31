" Treat docstrings like comments. This would also affect any long, multi-line
" strings that are wrapped in triple quotes.
syntax region pythonDocstring start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError
syntax region pythonDocstring start=+^\s*[uU]\?[rR]\?'''+ end=+'''+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError

highlight define link pythonDocstring pythonString

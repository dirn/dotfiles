" Treat docstrings like comments. This would also affect any long, multi-line
" strings that are wrapped in triple quotes.
syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError
syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?'''+ end=+'''+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError

hi def link pythonDocstring pythonString

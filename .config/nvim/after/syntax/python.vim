" Treat docstrings like comments. This would also affect any long, multi-line
" strings that are wrapped in triple quotes.
syntax region pythonDocstring start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError
syntax region pythonDocstring start=+^\s*[uU]\?[rR]\?'''+ end=+'''+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError
highlight link pythonDocstring pythonString

" mypy (and other type checkers?) won't detect a type annotation comment if the
" exact token isn't found. This will treat these comments differently from
" regular comments to help find improperly formatted type annotations.
syntax match pythonAnnotation '# type: ' display
highlight link pythonAnnotation pythonStatement

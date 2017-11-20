" Long comments and strings should only be 72 characters, not 79
setlocal colorcolumn=73,80
setlocal textwidth=79

" Toggle textwidth
call OnSyntaxChange#Install('Comment', '^Comment$', 0, 'a')
autocmd User SyntaxCommentEnterA setlocal textwidth=72
autocmd User SyntaxCommentLeaveA setlocal textwidth=79
call OnSyntaxChange#Install('pythonDocstring', '^pythonDocstring$', 0, 'a')
autocmd User SyntaxpythonDocstringEnterA setlocal textwidth=72
autocmd User SyntaxpythonDocstringLeaveA setlocal textwidth=79

" Boilerplate shortcuts
:iabbrev ifmain<t>	if __name__ == '__main__':<cr>

" Highlight all the things
let python_highlight_all=1

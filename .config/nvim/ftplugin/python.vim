" Long comments and strings should only be 72 characters, not 79.
setlocal colorcolumn=73,80,100
" Black will usually take care of the width for me.
setlocal textwidth=99

" Toggle textwidth
call OnSyntaxChange#Install('Comment', '^Comment$', 0, 'a')
autocmd User SyntaxCommentEnterA setlocal textwidth=72
autocmd User SyntaxCommentLeaveA setlocal textwidth=100
call OnSyntaxChange#Install('pythonDocstring', '^pythonDocstring$', 0, 'a')
autocmd User SyntaxpythonDocstringEnterA setlocal textwidth=72
autocmd User SyntaxpythonDocstringLeaveA setlocal textwidth=100

" Boilerplate shortcuts
:iabbrev ifmain if __name__ == '__main__':<cr>main()<c-o>v^<c-g>

" Highlight all the things
let python_highlight_all=1

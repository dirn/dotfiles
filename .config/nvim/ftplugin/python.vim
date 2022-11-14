" Long comments and strings should only be 72 characters, not 79.
setlocal colorcolumn=73,80,100
" Let Black worry about where to break the lines.
setlocal textwidth=99

" Boilerplate shortcuts
:iabbrev ifmain if __name__ == '__main__':<cr>main()<c-o>v^<c-g>

" Highlight all the things
let python_highlight_all=1

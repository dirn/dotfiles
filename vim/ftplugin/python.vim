" Long comments and strings should only be 72 characters, not 79
setlocal colorcolumn=73,80
setlocal textwidth=79

" Insert a bpython breakpoint
inoremap <buffer> <c-b>             import bpdb; bpdb.set_trace()

" Highlight all the things
let python_highlight_all=1

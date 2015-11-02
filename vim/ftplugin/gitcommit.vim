" Put the cursor back at the beginning of the commit message
call setpos('.', [0, 1, 1, 0])

" Commit messages should only be 72 characters, not 80
setlocal colorcolumn=73
setlocal textwidth=72

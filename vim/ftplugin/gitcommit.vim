" Put the cursor back at the beginning of the commit message
call setpos('.', [0, 1, 1, 0])

" Commit messages should only be 72 characters, not 80, and their subject should
" only be 50 characters.
setlocal colorcolumn=51,73
setlocal textwidth=72

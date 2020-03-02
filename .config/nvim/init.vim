" Set the leader first so that any plugins providing mappings will pick it up.
let mapleader = "\<Space>"

call plug#begin(stdpath('data') . '/plugged')

Plug 'https://github.com/dense-analysis/ale'
let g:ale_fix_on_save = 1

Plug 'https://github.com/rhysd/committia.vim'
Plug 'https://github.com/editorconfig/editorconfig-vim'

Plug 'https://github.com/junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} | Plug 'https://github.com/junegunn/fzf.vim'
let g:fzf_action = {
    \ 'ctrl-t': 'tab-split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit',
\ }
let g:fzf_colors = {
    \ 'fg': ['fg', 'Normal'],
    \ 'bg': ['bg', 'Normal'],
    \ 'hl': ['fg', 'Comment'],
    \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+': ['fg', 'Statement'],
    \ 'info': ['fg', 'PreProc'],
    \ 'prompt': ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker': ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header': ['fg', 'Comment'],
\ }
let g:fzf_layout = {'window': 'enew'}
if executable('rg')
    " Include a preview window with :Rg.
    " :Rg will start with the preview hidden. It can be shown with `?`.
    " :Rg! will start with the preview displayed on the right.
    command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
            \ 'rg
                \ --column
                \ --line-number
                \ --no-heading
                \ --color-always
                \ --smart-case
                \ --type=py
                \ --type=rst
                \ --type=yaml
                \ --glob="!.git/*"
                \ --glob="!.mypy_cache/*"
            \ '.shellescape(<q-args>), 1,
            \ <bang>0 ? fzf#vim#with_preview('right:50%')
            \         : fzf#vim#with_preview('right:50%:hidden', '?'),
            \ <bang>0
        \ )
endif
command! -bang -nargs=? -complete=dir GitFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

Plug 'https://github.com/vim-scripts/OnSyntaxChange', {'for': ['python']}
Plug 'https://github.com/raimon49/requirements.txt.vim'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://gitlab.com/dirn/TODO.vim'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/altercation/vim-colors-solarized'
Plug 'https://github.com/blueyed/vim-diminactive'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/pbrisbin/vim-mkdir'
Plug 'https://github.com/tpope/vim-obsession' | Plug 'https://github.com/dhruvasagar/vim-prosession'
Plug 'https://github.com/Vimjas/vim-python-pep8-indent'

if executable('tmux')
    Plug 'https://github.com/christoomey/vim-tmux-navigator'
endif
call plug#end()

filetype plugin indent on
syntax enable

colorscheme solarized
if has('mac')
    set background=dark
elseif has('unix')
    set background=light
endif

set encoding=utf8

set autoindent
set backspace=indent,eol,start
set smarttab

" Let me switch buffers without saving the current one. This will return undo
" history even when switching between buffers.
set hidden

" Don't use two spaces after a period when joining lines.
set nojoinspaces

" Don't redraw the screen while executing macros (and other things).
set lazyredraw

" Set the maximum length of lines.
set textwidth=80
" Wrap lines based on characters, not line length.
set linebreak
" That said, don't wrap lines.
set nowrap

" I find that swap and backup files cause more trouble than they're worth so
" disable them.
set nobackup
set noswapfile
set nowritebackup

" While I don't use it much, having mouse support can be nice from time to time.
set mouse=a

" Highlight the current line.
set cursorline
" Highlight matching brackets.
set showmatch
" Include angle brackets.
set matchpairs+=<:>

" Highlight conflict markers as errors.
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Show a rule at the width of the text.
if exists('&colorcolumn')
    highlight ColorColumn guibg=Red
    set colorcolumn=+1
endif

" Replace all matches in a line, not just the first.
set gdefault
" Highlight all matches.
set hlsearch
" And begin doing so immediately.
set incsearch
" Make search case insensitive.
set ignorecase
" Unless an uppercase letter is used.
set smartcase

" Always show the status line.
set laststatus=2
" Along with the current line and column positions.
set ruler

" Show relative line numbers.
set relativenumber
" But show the current line's number.
set number

" Set the window title, defaulting to the name of the current file.
set title

" Use spell check.
set spell

" Make horizontal scrolling smoother.
set sidescroll=1

" Automatically expand all folds.
set nofoldenable

" When completing in insert mode:
"   - only insert the common text of matches
"   - show the menu even when there's only one match
"   - show more about the currently selected item
set completeopt=longest,menuone,preview

" Open new splits to the right and bottom.
set splitright
set splitbelow

" Always open diffs in vertical splits.
set diffopt+=vertical

inoremap jk <esc>

" The following set of previous/next/first/last mappings are inspired by
" (borrowed from) https://github.com/tpope/vim-unimpaired.
" Navigate buffers.
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]b :bnext<cr>
nnoremap <silent> [B :bfirst<cr>
nnoremap <silent> ]B :blast<cr>

" Navigate the location list.
nnoremap <silent> [l :lprevious<cr>
nnoremap <silent> ]l :lnext<cr>
nnoremap <silent> [L :lfirst<cr>
nnoremap <silent> ]L :llast<cr>

" Navigate the quickfix list.
nnoremap <silent> [q :qprevious<cr>
nnoremap <silent> ]q :qnext<cr>
nnoremap <silent> [Q :qfirst<cr>
nnoremap <silent> ]Q :qlast<cr>

" Navigate tabs (these differ from vim-unimpaired).
nnoremap <silent> [t :tprevious<cr>
nnoremap <silent> ]t :tnext<cr>
nnoremap <silent> [T :tfirst<cr>
nnoremap <silent> ]T :tlast<cr>

" Copy and paste using the system clipboard.
vnoremap <leader>y "+y
vnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Fuzzy find files.
nnoremap <silent> <c-p> :GitFiles!<cr>

augroup misc
    autocmd!

    " Jump to the last known cursor position if it's valid (from the docs).
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \ execute "normal g'\"" |
        \ endif
augroup END

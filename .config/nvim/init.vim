let mapleader = "\<Space>"
let maplocalleader = ","

" --- vim-plug ---
call plug#begin(expand('~/.vim/bundle/'))

Plug 'Shougo/vimproc.vim', {'do': 'make'}

" --- Appearance ---
Plug 'altercation/vim-colors-solarized'
Plug 'airblade/vim-gitgutter'
Plug 'blueyed/vim-diminactive'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" --- Settings ---
Plug 'tpope/vim-sensible'

" --- File types ---
Plug 'dhruvasagar/vim-table-mode', {'for': ['python', 'rst']}
Plug 'elzr/vim-json'
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
Plug 'mitsuhiko/vim-jinja', {'for': ['html', 'jinja']}
Plug 'pangloss/vim-javascript'
Plug 'pearofducks/ansible-vim'
Plug 'raimon49/requirements.txt.vim'
Plug 'sheerun/vim-polyglot'

" --- Language helpers ---
Plug 'majutsushi/tagbar'

" --- Utilities ---
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-obsession' | Plug 'dhruvasagar/vim-prosession'
Plug 'ervandew/supertab'
Plug 'haya14busa/incsearch.vim'
Plug 'tomtom/tlib_vim' | Plug 'MarcWeber/vim-addon-mw-utils' | Plug 'garbas/vim-snipmate' | Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} | Plug 'junegunn/fzf.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'rhysd/committia.vim'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'} | Plug 'zchee/deoplete-jedi'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'

" --- Tmux support ---
if executable('tmux')
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'sjl/vitality.vim'
endif
call plug#end()

" --- Configuration ---
syntax on
filetype plugin indent on

set encoding=utf8
set lazyredraw                  " no redraw during macros (much faster)
set linebreak
set nojoinspaces
set nowrap
set report=0                    " :cmd always shows changed line count
set textwidth=80

set nobackup
set nowritebackup
set noswapfile

set mouse=a                     " turn on mouse support

" --- Guides ---
set cursorline                  " highlight current line
set showmatch                   " show matching brackets ...
set matchpairs+=<:>
set matchtime=5                 " ... for 5 seconds
" Conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Show a rule
if exists('&colorcolumn')
    highlight ColorColumn guibg=Red
    set colorcolumn=+1
endif

" --- Appearance ---
set background=dark

colorscheme solarized
let g:airline_theme = 'solarized'

if has('nvim')
    " Set the look of the cursor...
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
        \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
        \,sm:block-blinkwait175-blinkoff150-blinkon175
    " ...but make sure it's restored before exiting.
    au VimLeave * set guicursor=a:block-blinkon0
end

set noshowmode                  " hide the mode text, Powerline shows it

set listchars=tab:▸\ ,eol:¬

set relativenumber              " show relative line numbers
set number                      " but show the current line number

set title                       " show the filename in the window's title

" --- Behavior ---
set confirm

set complete=.,w,b,u,t          " this should be the default, but just in case
set completeopt=longest,menuone,preview

set spell                       " use spell check

set sidescroll=1                " make scrolling smoother

set nofoldenable                " stop folding things!

" Open splits to the right and bottom.
set splitbelow                  " this feels weird with Fugitive
set splitright

set diffopt+=vertical           " always use vertical diffs

" --- Search ---
set gdefault                    " replace with g by default
set ignorecase                  " make search case insensitive ...
set smartcase                   " ... unless an uppercase character is used
set hlsearch

if executable('ag')
    " Use ag instead of grep.
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in ctrlp for listing files. Oh yeah, and it honors .gitignore.
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast, so don't use ctrlp's cache.
    let g:ctrlp_use_caching = 0
endif

" --- Whitespace ---
set expandtab                   " spaces > tabs
set shiftround                  " indents to a multiple of shiftwidth
set shiftwidth=4
set softtabstop=4
set tabstop=8

" Treat li and p tags as block elements.
let g:html_indent_tags = 'li\|p'

" --- Mappings ---
" Make word uppercase
nnoremap <c-u> mzgUiw`z
" Make word lowercase (down, because <c-l> is used for navigation)
nnoremap <c-d> mzguiw`z

" Reindent a file
nnoremap <silent> <leader><tab> gg=G

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_

" Exit insert mode
inoremap jk <esc>

" Keystroke savers
" vim-easymotion takes care of losing ;
nnoremap ; :
vnoremap ; :

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Quickly change windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Quickly change tabs
nnoremap <s-h> gT
nnoremap <s-l> gt

" Copy and paste using the system clipboard
vnoremap <leader>y "+y
vnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Swap selected regions (vim-exchange)
" I never use s anyway.
map s <Plug>(Exchange)
map sxx <Plug>(ExchangeClear)
map S <Plug>(ExchangeLine)

" Open a new tab. This remaps jumping to the next tag, but I don't use those.
nnoremap <c-t> :tabnew<cr>
inoremap <c-t> <esc>:tabnew<cr>

" FileType switching
nnoremap <leader>Tp :set ft=python<cr>
nnoremap <leader>Tj :set ft=htmljinja<cr>

" Don't use the cursor keys
for prefix in ['i', 'n', 'v']
    for key in ['<up>', '<right>', '<down>', '<left>']
        execute prefix . 'noremap ' . key . ' <nop>'
    endfor
endfor

" Retrain my brain
inoremap <esc> <nop>

" --- Typos ---
" this one has plagued me for years
:iabbrev functino function
:iabbrev verison version

:iabbrev :shrug: ¯\_(ツ)_/¯
:iabbrev :tableflip: (╯°□°)╯︵ ┻━┻

" --- Autocmds ---
if has('autocmd') && has('eval')
    augroup misc
        autocmd!

        " Resize splits
        autocmd VimResized * :wincmd =

        " Jump to the last known cursor position if it's valid (from the docs)
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   execute "normal g`\"" |
            \ endif
    augroup END

    augroup whitespace
        function! TrimWhitespace()
            %s/\s\+$//e
        endfunction

        autocmd FileWritePre * :call TrimWhitespace()
        autocmd FileAppendPre * :call TrimWhitespace()
        autocmd FilterWritePre * :call TrimWhitespace()
        autocmd BufWritePre * :call TrimWhitespace()
    augroup END
endif

" --- Filetypes ---
augroup filetypes
    autocmd!

    autocmd FileType css,html,htmldjango,htmljinja,ruby,scss,xml,yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

    " --- .vimrc ---
    " Reload .vimrc if changes are made to it
    autocmd BufWritePost .vimrc source $MYVIMRC
augroup END

" --- Plugin configuration ---

" --- ctrlp ---
let g:ctrlp_dont_split = 'NERD_tree_2'
set wildignore+=*.pyc,*/*.egg-info/*
set wildignore+=.git,.hg
set wildignore+=*.orig
set wildignore+=*.jpg,*.jpeg,*.gif,*.png
set wildignore+=*.mp3
set wildignore+=*.sw?                           " Vim swap files

" --- NERD Tree ---
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.vim$', '\~$', '\.pyc$', '^__pycache__$', '\.swp$', '\.git$', '\.egg', '\.egg\-info', '\.coverage', '\.tox', '.DS_Store', '.sass-cache']
let g:NERDTreeSortOrder = ['^__\.py$', '\/$', '*', '\.swp$', '\~$']
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1

nnoremap <leader>fs :NERDTreeToggle<cr>

"--- Airline ---
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_powerline_fonts = 1

" --- Git Gutter ---
highlight clear SignColumn  " same as the row number column
highlight GitGutterAddDefault          guifg=Green  guibg=NONE  ctermfg=DarkGreen   ctermbg=NONE
highlight GitGutterChangeDefault       guifg=Yellow guibg=NONE  ctermfg=DarkYellow  ctermbg=NONE
highlight GitGutterDeleteDefault       guifg=Red    guibg=NONE  ctermfg=DarkRed     ctermbg=NONE

" --- Gist Vim ---
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" --- Learn Vimscript the Hard Way ---
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" --- incsearch ---
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map * <Plug>(incsearch-nohl-*)
map # <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
let g:incsearch#auto_nohlsearch = 1

" --- Table Mode ---
let g:table_mode_corner_corner = "+"
let g:table_mode_header_fillchar = "="

" --- vim-json ---
let g:vim_json_syntax_conceal = 0

" --- ALE ---
let g:ale_sign_column_always = 1

" --- deoplete ---
call g:deoplete#enable()
let g:python3_host_prog = '/usr/bin/env python3'

" --- fzf ---
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
" command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* Rg call fzf#vim#grep(
    \ 'rg
        \ --line-number
        \ --no-heading
        \ --fixed-strings
        \ --ignore-case
        \ --hidden
        \ --follow
        \ --type-add "stone:*.stone"
        \ --type "py"
        \ --type "rst"
        \ --type "stone"
        \ --type "ts"
        \ --type "yaml"
        \ --glob "!.git/*"
        \ --color "always"
    \ '.shellescape(<q-args>).' 2> /dev/null', 1, <bang>0)
nnoremap <silent> <c-p> :Files!<cr>
nnoremap <silent> <c-_> :Rg!<space>
let g:fzf_action = {
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
let g:fzf_layout = { 'window': 'enew' }

" --- SuperTab ---
let g:SuperTabDefaultCompletionType = "<c-n>"

set nocompatible

" --- Vundle ---
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" --- Themes ---
Bundle 'altercation/vim-colors-solarized'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

" --- Plugins ---
Bundle 'Lokaltog/vim-powerline'
Bundle 'nvie/vim-flake8'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'

" --- Configuration
syntax on
filetype plugin indent on

set encoding=utf8
set lazyredraw                  " no redraw during macros (much faster)
set linebreak
set nowrap
set report=0                    " :cmd always shows changed line count
set textwidth=79

" --- Guides ---
set cursorline                  " highlight current line
set showmatch                   " show matching brackets ...
set matchpairs+=<:>
set matchtime=5                 " ... for 5 seconds

" Show a rule
if exists('&colorcolumn')
    highlight ColorColumn guibg=Red
    set colorcolumn=+1
endif

" --- History ---
set history=256

" --- Appearance ---
set background=dark

if &t_Co > 8
    set t_Co=256

    colorscheme solarized
    let g:solarized_termcolors=256
    let g:solarized_visibility="high"
    let g:solarized_contrast="high"
endif

set laststatus=2                " always show status line

set display+=lastline
set listchars=tab:▸\ ,eol:¬

set ruler                       " show the cursor position

set scrolloff=2                 " lines above and below the current line
set sidescrolloff=2

set number                      " show line numbers

" --- Behavior ---
set confirm

set backspace=indent,eol,start  " allow backspacing everywhere in edit mode

set spell                       " use spell check

set timeoutlen=500

" --- Search ---
set ignorecase                  " make search case insensitive ...
set smartcase                   " ... unless an uppercase character is used
set incsearch
set hlsearch

" --- Whitespace ---
set autoindent

set expandtab                   " spaces > tabs
set shiftround                  " indents to a multiple of shiftwidth
set shiftwidth=4
set softtabstop=4
set tabstop=8

" --- Mappings ---
" Make word uppercase
nnoremap          <c-u>             gUiw
" Make word lowercase
nnoremap          <c-l>             guiw

" Exit insert mode
inoremap          jk                <esc>

" Don't use the cursor keys
for prefix in ['i', 'n', 'v']
    for key in ['<up>', '<right>', '<down>', '<left>']
        exe prefix . 'noremap ' . key . ' <nop>'
    endfor
endfor

" Retrain my brain
inoremap          <esc>             <nop>

" --- Typos ---
:iabbrev functino function      " this one has plagued me for years

" --- Autocmds ---
if has('autocmd') && has('eval')
    augroup misc
        au!

        " Trim trailing whitespace on save
        autocmd BufWritePre <buffer> :%s/\s\+$//e

        " Jump to the last known cursor position if it's valid (from the docs)
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif
    augroup END
endif

" --- Filetypes ---
augroup filetypes
    au!

    " --- Git ---
    " Put cursor back at beginning of commit message
    autocmd BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    " Commit messages should only be 72 characters, not 79
    autocmd BufEnter COMMIT_EDITMSG setlocal colorcolumn=73
    autocmd BufEnter COMMIT_EDITMSG setlocal textwidth=72

    " --- Python ---
    " Long comments and strings should only be 72 characters, not 79
    autocmd BufEnter *.py setlocal colorcolumn=73,80

    " --- .vimrc
    " Reload .vimrc if changes are made to it
    autocmd BufWritePost .vimrc source $MYVIMRC
augroup END

" --- Plugin configuration ---

" --- vim-flake8 ---
let g:flake8_ignore="W391"

if has('autocmd')
    augroup flake8
        au!

        " Automatically run flake8 on save
        autocmd BufWritePost *.py call Flake8()
    augroup END
endif

" --- NERD Tree ---
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$', '\.git$', '\.egg\-info', '\.coverage', '\.tox', '.DS_Store']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowHidden=1

nnoremap <leader>fs :NERDTreeToggle<cr>

" --- Powerline ---
let g:Powerline_symbols='unicode'

" --- Learn Vimscript the Hard Way ---
let mapleader=","
let maplocalleader="\\"
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap H 0
nnoremap L $
nnoremap pb :exe "rightbelow vsplit " . bufname('#')<cr>

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END


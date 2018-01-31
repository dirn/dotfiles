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
Plug 'dirn/Stone.vim'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
Plug 'mitsuhiko/vim-jinja', {'for': ['html', 'jinja']}
Plug 'pangloss/vim-javascript'
Plug 'pearofducks/ansible-vim'
Plug 'raimon49/requirements.txt.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/OnSyntaxChange', {'for': ['python']}

" --- Language helpers ---
Plug 'majutsushi/tagbar'

" --- Utilities ---
Plug 'tpope/vim-obsession' | Plug 'dhruvasagar/vim-prosession'
Plug 'ervandew/supertab'
Plug 'haya14busa/incsearch.vim'
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
" Don't redraw the screen while executing macros (and other things).
set lazyredraw
" Always show the number of lines changed when executing a command.
set report=0

" Don't use two spaces after sentence ending punctuation when joining lines.
set nojoinspaces

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

" --- Guides ---
" Highlight the current line.
set cursorline
" Highlight matches brackets.
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

" Since Airline includes the current mode, hide the default message.
set noshowmode

set listchars=tab:▸\ ,eol:¬

" Show relative line numbers.
set relativenumber
" But show the current line's number.
set number

" Set the window title, defaulting to the name of the current file.
set title

" --- Behavior ---
" Make sure we don't losing unsaved changes when closing a window.
set confirm

" When completing in insert mode:
"   - only insert the common text of matches
"   - show the menu even when there's only one match
"   - show more about the currently selected item
set completeopt=longest,menuone,preview

" Use spell check.
set spell

" Make horizontal scrolling smoother.
set sidescroll=1

" Automatically expand all folds.
set nofoldenable

" Open splits to the right and bottom.
set splitbelow
set splitright

" Always open diffs in vertical splits.
set diffopt+=vertical

" --- Search ---
" Replace all matches in a line.
set gdefault
" Highlight all matches.
set hlsearch
" Make search case insensitive.
set ignorecase
" Do that unless an uppercase letter is used.
set smartcase

" --- Whitespace ---
" Insert spaces when <tab> is pressed.
set expandtab
" Indent to the nearest multiple of shiftwidth.
set shiftround
" Use 4 spaces for each indent.
set shiftwidth=4
" Use 4 spaces when inserting a <tab>.
set softtabstop=4
" Make a <tab> equal to 4 spaces.
set tabstop=4

" Treat li and p tags as block elements.
let g:html_indent_tags = 'li\|p'

" --- Mappings ---
" Make the word under the cursor uppercase.
nnoremap <c-u> mzgUiw`z
" Make the word under the cursor lowercase.
" D represents down, <c-l> is used for navigation.
nnoremap <c-d> mzguiw`z

" Reindent a file.
nnoremap <silent> <leader><tab> gg=G

" Select the contents of the current line, excluding indentation. Great for
" pasting Python lines into REPLs.
nnoremap vv ^vg_

" Exit insert mode with something on the home row, not <esc>.
inoremap jk <esc>
inoremap <esc> <nop>

" Keystroke savers
" vim-easymotion takes care of losing ;.
nnoremap ; :
vnoremap ; :

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Quickly change windows.
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Quickly change tabs.
nnoremap <s-h> gT
nnoremap <s-l> gt

" Copy and paste using the system clipboard.
vnoremap <leader>y "+y
vnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Swap selected regions (vim-exchange).
map s <Plug>(Exchange)
map sxx <Plug>(ExchangeClear)
map S <Plug>(ExchangeLine)

" Open a new tab. Note that this remaps jumping to the next tag.
nnoremap <c-t> :tabnew<cr>
inoremap <c-t> <esc>:tabnew<cr>

" Load .vimrc in a vertical split.
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Resource .vimrc.
nnoremap <leader>sv :source $MYVIMRC<cr>

" Don't use the cursor keys.
for prefix in ['i', 'n', 'v']
    for key in ['<up>', '<right>', '<down>', '<left>']
        execute prefix . 'noremap ' . key . ' <nop>'
    endfor
endfor

" --- Typos ---
" Replace some typos I make more often than I'd like.
:iabbrev functino function
:iabbrev verison version

:iabbrev :shrug: ¯\_(ツ)_/¯
:iabbrev :tableflip: (╯°□°)╯︵ ┻━┻

" --- Autocmds ---
if has('autocmd') && has('eval')
    augroup misc
        autocmd!

        " Resize splits when Vim is resized.
        autocmd VimResized * :wincmd =

        " Jump to the last known cursor position if it's valid (from the docs).
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   execute "normal g`\"" |
            \ endif
    augroup END

    augroup whitespace
        function! TrimWhitespace()
            %s/\s\+$//e
        endfunction

        " Trim trailing whitespace when the file is saved.
        autocmd FileWritePre * :call TrimWhitespace()
        autocmd FileAppendPre * :call TrimWhitespace()
        autocmd FilterWritePre * :call TrimWhitespace()
        autocmd BufWritePre * :call TrimWhitespace()
    augroup END
endif

" --- Filetypes ---
augroup filetypes
    autocmd!

    " Some file types uses 2 spaces instead of 4.
    autocmd FileType css,html,htmldjango,htmljinja,ruby,scss,xml,yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

    " Reload .vimrc if changes are made to it.
    autocmd BufWritePost .vimrc source $MYVIMRC
augroup END

" --- Plugin configuration ---

"--- Airline ---
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_powerline_fonts = 1

" --- ALE ---
let g:ale_sign_column_always = 1

" --- deoplete ---
let g:deoplete#enable_at_startup = 1

" --- fzf ---
" Create an :Rg command to use ripgrep to find text.
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
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
" Fuzzy find files.
nnoremap <silent> <c-p> :Files!<cr>
" Fuzzy find text.
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

" --- Gist Vim ---
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" --- Git Gutter ---
" The sign column is the same as the line number column.
highlight clear SignColumn
highlight GitGutterAddDefault          guifg=Green  guibg=NONE  ctermfg=DarkGreen   ctermbg=NONE
highlight GitGutterChangeDefault       guifg=Yellow guibg=NONE  ctermfg=DarkYellow  ctermbg=NONE
highlight GitGutterDeleteDefault       guifg=Red    guibg=NONE  ctermfg=DarkRed     ctermbg=NONE

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

" --- NERD Tree ---
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.vim$', '\~$', '\.pyc$', '^__pycache__$', '\.swp$', '\.git$', '\.egg', '\.egg\-info', '\.coverage', '\.tox', '.DS_Store', '.sass-cache']
let g:NERDTreeSortOrder = ['^__\.py$', '\/$', '*', '\.swp$', '\~$']
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1

nnoremap <leader>fs :NERDTreeToggle<cr>

" --- SuperTab ---
let g:SuperTabDefaultCompletionType = "<c-n>"

" --- Table Mode ---
let g:table_mode_corner_corner = "+"
let g:table_mode_header_fillchar = "="

" --- vim-json ---
let g:vim_json_syntax_conceal = 0

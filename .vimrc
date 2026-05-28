set nocompatible
set rtp+=/home/hallowdance/.vim/bundle/Vundle.vim	
filetype on
syntax on
filetype plugin indent on

" Security
set modelines=0

" Show line numbers
set number

" Persistent undo
" " Keep undo history across sessions by storing it in a file
"if has('persistent_undo')
"    let myUndoDir = expand(vimDir . '/undo')
"    " Create dirs
"    call system('mkdir ' . vimDir)
"    call system('mkdir ' . myUndoDir)
"    let &undodir = myUndoDir
"    set undofile
"endif

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
"set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Background color
"colorscheme badwolf
highlight Normal guibg=black guifg=white
set background=dark

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Bind spellcheck
map <leader>ss :set spell spelllang=bg

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

set t_Co=256
let g:XkbSwitchEnabled = 1

set conceallevel=2
hi Conceal ctermbg=none
set concealcursor=""

" Vim-plug section
call plug#begin('~/.vim/plugged')
Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_latexmk_progname = 'nvr' 
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_mode = 0
let g:vimtex_compiler_latexmk = {
  \ 'backend' : 'nvim',
  \ 'background' : 1,
  \ 'build_dir' : './build',
  \ 'callback' : 1,
  \ 'continuous' : 1,
  \ 'executable' : 'latexmk',
  \ 'options' : [
  \   '-xelatex',
  \   '-verbose',
  \   '-file-line-error',
  \   '-synctex=1',
  \   '-interaction=nonstopmode',
  \ ],
  \}
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-xelatex',
    \}
"Plug 'sirver/ultisnips'
"let g:UltiSnipsEditSplit="horizontal"
"let g:UltiSnipsExpandTrigger="<c-x>"
"let g:UltiSnipsJumpForwardTrigger = '<c-b>'
"let g:UltiSnipsJumpBackwardTrigger = '<c-z>'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/vim-cursorword'
Plug 'yegappan/mru'
call plug#end()
" let g:vimtex_quickfix_mode=0
" let g:tex_conceal='abdgms'
" let g:tex_fast = "cmMprs"
let g:tex_conceal = ""
let g:tex_comment_nospell = 1

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'lyokha/vim-xkbswitch'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
call vundle#end()            " required
filetype plugin indent on    " required



imap <c-d> ^
let python_highlight_all=1

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

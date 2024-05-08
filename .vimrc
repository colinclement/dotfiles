set nocompatible
set modeline

call pathogen#infect()
call pathogen#helptags()

filetype indent on
filetype on
filetype plugin on
filetype plugin indent on

set ofu=syntaxcomplete#Complete
"set foldmethod=indent
"set foldnestmax=5
"set foldlevel=0
"map ] za
"map [ zM

"set nobackup
"set nowritebackup
"set noswapfile
"set lines=40
"set columns=80
set tabstop=4
set wrap
set shiftwidth=4
set softtabstop=4
set autoindent
set smarttab
set expandtab
set hidden
set number
set wildmenu
set hlsearch
set incsearch
set history=100
set scrolloff=3

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap $ g$
nnoremap 0 g0
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" set swap file location
set backupdir=~/.backup//,/tmp//,.
set directory=~/.backup//,/tmp//,.


" Turn off gui looks
set guioptions=ac
set guifont=Ubuntu\ Mono\ for\ Powerline\ 11
" set sessionoptions+=resize,winpos

" useful esc
" map ;; <Esc>
" cmap ;; <Esc>
" imap ;; <Esc>

"save 
noremap  <silent> <C-q>         :update<CR>
vnoremap <silent> <C-q>         <C-C>:update<CR>
inoremap <silent> <C-q>         <C-O>:update<CR>
noremap  <silent> <Leader>w      :update<CR>

" Make C-l clear search
nnoremap <silent> <C-l>         :<C-u>nohlsearch<CR><C-l>

" Make & behave like &&
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" highlight word at cursor without changing position
nnoremap <Leader>h *<C-O>

" if markdown, set makeprg and <leader>m
au FileType markdown set makeprg=pelmake
au FileType markdown map <Leader>m :update<CR>:make<CR><CR><CR>

" set up persistent undo
if exists("+undofile")
    set udf
    set undodir=~/.backup
endif

" Make vim-latex default to pdf
let g:Tex_DefaultTargetFormat = 'pdf'

" Set latex <leader>m
au FileType tex map <Leader>m :update<cr>:make <cr><cr>|set spell

" enable the sudo write
command W w !sudo tee % > /dev/null

" enable the make on just this file
command Make :!make %<

set encoding=utf-8
set laststatus=2
"let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'skwp'

syntax on
syntax enable
set background=dark
"set t_Co=256

" let g:solarized_termtrans = 1
colorscheme solarized
"colorscheme zenburn
"call togglebg#map("<F12>")

"add dictionary
set dictionary+=/usr/share/dict/words

" map arrow keys to split navigation
nnoremap <Right> <C-w>l
nnoremap <Left> <C-w>h
nnoremap <Up> <C-w>k
nnoremap <Down> <C-w>j

" html indent settings
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

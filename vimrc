""""""""""""""""""""""""""""""""""""""""
" Lines in the vimrc:                  "
" => Vundle                            "
" => Options                           "
" => Maps                              "
" => Functions                         "
" => Autocmds and cmds                 "
" => Misc                              "
""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""
" => Vundle             "
"""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Lokaltog/vim-distinguished' " Color scheme
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'davidhalter/jedi-vim'

call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""
" => Options            "
"""""""""""""""""""""""""
syntax enable 
set history=500
set so=7
set wildmenu
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set ruler
set cmdheight=2
set backspace=eol,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch 
set lazyredraw 
set magic
set showmatch 
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set foldcolumn=1
set background=dark
set encoding=utf8
set nobackup
set nowb
set noswapfile
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set laststatus=2
set relativenumber
set number
set gdefault
set showcmd
set clipboard=unnamed
set mouse=nvc
"""""""""""""""""""""""""
" => Maps               "
"""""""""""""""""""""""""
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

inoremap jk <Esc>
inoremap kj <Esc>
inoremap <Esc> <Nop>

map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Leader
let mapleader = ","
let g:mapleader = ","

nmap <silent> <leader><cr> :noh<cr>
nmap <leader>bd :Bclose<cr>:tabclose<cr>gT
nmap <leader>e :e! ~/.vimrc<cr>
nmap <leader>w :w!<cr>

" For commands / functions
map <leader><leader> :Encrypt<cr>
nnoremap <expr> <leader>q OpenTmp()

"""""""""""""""""""""""""
" => Functions          "
"""""""""""""""""""""""""
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

function! OpenTmp()
    return ":e" . system("mktemp") . "\n"
endfunc

"""""""""""""""""""""""""
" => Autocmds and cmds  "
"""""""""""""""""""""""""
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif " Return to last edit position when opening files

" Highlights trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

command! Encrypt normal ggg?G``ggg~G``
command! Bclose call <SID>BufcloseCloseIt()

"""""""""""""""""""""""""
" => Misc               "
"""""""""""""""""""""""""
colorscheme distinguished

"==> Plug
set runtimepath+=~/.vim
set runtimepath+=~/.vim/pythonx

call plug#begin("~/.local/share/nvim/plugged")

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Custom motions
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tommcdo/vim-lion'
Plug 'wellle/targets.vim'

" Colorscheme
Plug 'chriskempson/vim-tomorrow-theme'

" Misc
Plug 'yuttie/comfortable-motion.vim'
Plug 'preservim/nerdtree'

call plug#end()
"<==

"==> Options
syntax enable

" Wildmenu
set wildmenu
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch
set gdefault

" Drawing
set lazyredraw
set noerrorbells

" Backups
set nobackup
set nowritebackup
set noswapfile

" Tabs
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Numbering
set relativenumber
set number

" List
set listchars=tab:»·,trail:·
set list

" Splits
set splitright
set splitbelow


" Neovim-specific
if has('nvim')
    set modelineexpr
endif

"==>Misc

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

set showcmd
set noshowmatch
set clipboard=unnamed
set mouse=nvc
set history=500
set scrolloff=7
set backspace=eol,indent
set whichwrap=h,l
set laststatus=2
set colorcolumn=80,120
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
set statusline=%f\ %y%1*%m%*
"<==
"<==

"==> Coc
" :CocDiagnostics to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <F2> <Plug>(coc-rename)

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
"<==

"==> Maps
" Escaping from insert
inoremap jk <Esc>
inoremap JK <Esc>
inoremap kj <Esc>
inoremap KJ <Esc>

" Leader
let g:mapleader = ","

" Remove highlights from search
nnoremap <silent> <leader><cr> :noh<cr>
" Open vimrc
nnoremap <silent> <leader>e :e $MYVIMRC<cr>
" Save
nnoremap <space> :w<cr>
" Open NERDTree
nnoremap <C-N> :NERDTreeToggle<cr>

" Quit
nnoremap <leader>q :q<cr>

" [S]plit line (sister to [J]oin lines)
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
"<==

"==> Autocmds and cmds
" Automatically get Eclim shortcuts on java files
au BufRead *.java nnoremap <leader>i :JavaImportOrganize<CR>
au BufRead *.java inoremap . .<C-x><C-u>

" Set .html.hbs to html
au BufRead *.html.hbs set ft=html

au VimEnter * if exists('g:GuiLoaded')
            \ | exe 'GuiPopupmenu 0'
            \ | exe 'GuiFont Consolas:h14'
            \ | endif
"<==

"==> Colorscheme
colo Tomorrow-Night
highlight User1 ctermfg=222 ctermbg=1
"<==

" vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=v\:folddashes.getline(v\:foldstart)[3\:]

" Plug
set runtimepath+=~/.vim
call plug#begin("~/.local/share/nvim/plugged")

"==> Non-Plugin Settings
syntax enable

" Wildmenu
set wildmenu wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/Cargo.lock
set path=.,**,,

" Searching
set ignorecase smartcase
set hlsearch incsearch
set gdefault

" Drawing
set lazyredraw
set noerrorbells belloff=all
set showcmd
set scrolloff=7
set statusline=%f\ %y%1*%m%*
set laststatus=2
set title
set cursorline
set virtualedit=block

" Inserting
set backspace=eol,indent
set whichwrap=h,l

" Backups
set nobackup
set nowritebackup
set noswapfile

" Tabs
set expandtab smarttab shiftround
set shiftwidth=4 tabstop=4

" Numbering
set relativenumber number

" List
set list listchars=tab:»·,trail:·

" Splits
set splitright splitbelow

" Neovim-specific
if has('nvim')
    set modelineexpr
endif

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Interact with X
set clipboard=unnamed,unnamedplus
set mouse=nvc
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50

" Turn off ugly gui popupmenu on windows neovim and setup font
au VimEnter * if exists('g:GuiLoaded')
            \ | exe 'GuiPopupmenu 0'
            \ | exe 'GuiFont Hack:h14'
            \ | endif
"<==

"==> Non-Plugin Mappings
" Escaping from insert
inoremap jk <Esc>
inoremap JK <Esc>
inoremap kj <Esc>
inoremap KJ <Esc>

" Move around windows
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Leader
let g:mapleader = ","

" Remove highlights from search
nnoremap <silent> <leader><cr> :noh<cr>
" Open vimrc
nnoremap <silent> <leader>rc :e ~/.dotfiles/vimrc<cr>
" Make
nnoremap <leader>m :silent make\|redraw!\|cc<CR>
" Save
nnoremap <space> :w<cr>

" Quit
nnoremap <silent> <leader>q :q<cr>
" Kill
nnoremap <silent> <leader>k :q!<cr>

" [S]plit line (sister to [J]oin lines)
nnoremap <silent> S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
"<==

"==> Filetype-specific
" Handlebars
au BufReadPost *.html.hbs set filetype=html

" Rust
au BufReadPost *.rs setlocal makeprg=cargo\ clippy\ --release\ -q\ --message-format=short
command! -nargs=* Cargo :FloatermNew cargo <args>
" Stronger `K`
nnoremap <C-k> :CocCommand rust-analyzer.openDocs<cr>
nnoremap <f5> :silent !cargo build<cr>:VBGstartGDB target/debug/
"<==

" Async compiling/testing
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'

"==> Completion/Language
" Support for various languages
Plug 'sheerun/vim-polyglot'

{{#if (eq dotter.os "unix")~}}
"==> Vebugger
Plug 'idanarye/vim-vebugger'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

nnoremap <f8> :VBGtoggleBreakpointThisLine<cr>
nnoremap <f9> :VBGcontinue<cr>
nnoremap <f10> :VBGstepIn<cr>
nnoremap <f11> :VBGstepOver<cr>
nnoremap <f12> :VBGstepOut<cr>
"<==

{{/if~}}
"==> Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
"<==

"==> Custom motions/actions
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tommcdo/vim-lion'
Plug 'wellle/targets.vim'

"==> Sneak
Plug 'justinmk/vim-sneak'
" Next match on repeat s
let g:sneak#s_next = 1
" Apply ; to f/t normally
let g:sneak#f_reset = 1
let g:sneak#t_reset = 1
" Case insensitive
let g:sneak_use_ic_scs = 1
let g:sneak#prompt = 'Sneak >'
"<==
"<==

"==> Navigation/filesystem
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'

" FZF
nnoremap <silent> <leader>e :call fzf#run(fzf#wrap({'source': 'fd --type f'}))<cr>
nnoremap <silent> <leader>cd :call fzf#run(fzf#wrap({'source': 'fd -H -I --type d', 'sink': 'cd', 'dir': $HOME}))<cr>
" Swap to a buffer
nnoremap <leader>b :Buffers<cr>
" Stronger search
nnoremap <silent> <leader>/ :Ag<cr>
"<==

"==> Terminal
Plug 'voldikss/vim-floaterm'
let g:floaterm_wintype="vsplit"
let g:floaterm_width=0.3

" Enter terminal
nnoremap <C-t> :FloatermToggle<CR>
" Kill terminal
tnoremap <C-d> <CMD>q!<CR>
" Leave terminal
tnoremap <Esc> <C-\><C-N>
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

augroup TerminalInsert
    au!
    au TermOpen * setlocal nonumber norelativenumber signcolumn=no
augroup END

" In fzf windows, esc should go through to the fzf binary
" and close the window (instead of being mapped to going to normal mode)
au FileType fzf tnoremap <buffer> <esc> <esc>
"<==

"==> Org mode
Plug 'hsitz/VimOrganizer'
Plug 'vim-scripts/utl.vim'

au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org  call org#SetOrgFileType()
"<==

"==> Misc Plugins
Plug 'yuttie/comfortable-motion.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
"<==

"==> Colorscheme
Plug 'chriskempson/vim-tomorrow-theme'
" Red plus on statusline when buffer is dirty
highlight User1 ctermfg=222 ctermbg=1 guibg=red
"<==

call plug#end()
" Has to be called after end
colo Tomorrow-Night

" vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=v\:folddashes.getline(v\:foldstart)[3\:]

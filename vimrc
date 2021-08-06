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
set title titlestring=NVIM:\ %F
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
" Open vimrc editing workspace
{{#if (eq dotter.os "unix")~}}
nmap <silent> <leader>vrc :tabedit ~/.dotfiles/vimrc<cr><c-t>cd ~/.dotfiles; c; ./dotter watch -v<cr><A-h>
{{else~}}
execute "nmap <silent> <leader>vrc :tabedit ~/.dotfiles/vimrc<cr><c-t>" . $HOMEDRIVE . "<cr>cd " . $HOMEPATH . "\\.dotfiles<cr>dotter watch -v<cr><A-h>"
{{/if~}}
nnoremap <silent> <leader>src :source $MYVIMRC<cr>
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

"==> Completion/Language
" Support for various languages
Plug 'sheerun/vim-polyglot'

" Async compiling/testing
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'

" Handlebars
au BufReadPost *.html.hbs set filetype=html

" Make (only used when no language-specific binding is found) (execute is needed)
nnoremap <leader>m :execute "Make" \| redraw! \| cc<CR>

" Format
nnoremap <leader>f :Format<cr>

"==> Rust
au BufReadPost *.rs call SetRustMappings()
au BufEnter *.rs call SetRustMappings()

function SetRustMappings()
  nnoremap <buffer> <leader>m :Dispatch cargo clippy --release -q --message-format=short<cr>
  nnoremap <buffer> <leader>t :Dispatch cargo test<cr>
  execute "nnoremap <leader>r :Cargo run -- "
  {{~#if (eq dotter.os "unix")}}
  nnoremap <buffer> <leader>d :silent !cargo build<cr>:VBGstartGDB target/debug/
  {{~/if}}
endfunction

command! -nargs=* Cargo :FloatermNew cargo <args>
"<==

"==> Python
au BufReadPost *.py call SetPythonMappings()
au BufEnter *.py call SetPythonMappings()

function SetPythonMappings()
  execute "nnoremap <leader>r :!python3 % -- "
endfunction
"<==

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
" Stronger `K` - specific to rust
nnoremap <C-k> :CocCommand rust-analyzer.openDocs<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>a  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>F  <Plug>(coc-fix-current)

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
"<==

"==> Navigation/filesystem
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'

" FZF
nnoremap <silent> <leader>e :call fzf#run(fzf#wrap({'source': 'fd --type f'}))<cr>
nnoremap <silent> <leader>cd :call fzf#run(fzf#wrap({'source': 'fd -H -I --type d', 'sink': 'cd', 'dir': {{#if vim_root_dir}}"{{vim_root_dir}}"{{else}}$HOME{{/if}}}))<cr>
" Swap to a buffer
nnoremap <leader>b :Buffers<cr>
" Stronger search
{{#if (is_executable "rg")~}}
nnoremap <silent> <leader>/ :Rg<cr>
{{else~}}
{{#if (is_executable "ag")~}}
nnoremap <silent> <leader>/ :Ag<cr>
{{else~}}
nnoremap <silent> <leader>/ :echoerr "no rg or ag"<cr>
{{/if~}}
{{/if~}}
"<==

"==> Terminal
Plug 'voldikss/vim-floaterm'
let g:floaterm_wintype="vsplit"
let g:floaterm_width=0.3
let g:floaterm_autohide=0

" Enter terminal
nnoremap <C-t> :FloatermNew<CR>
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
Plug 'kristijanhusak/orgmode.nvim'
lua require('orgmode').setup({})
"<==

"==> Statusline
Plug 'itchyny/lightline.vim'
set noshowmode
let g:lightline = {}
let g:lightline.active = {
	  \ 'left': [ [ 'mode', 'paste' ],
	  \           [ 'relativepath' ],
	  \           [ 'readonly' , 'modified' ] ],
	  \ 'right': [ [ 'lineinfo' ],
	  \           [ 'filetype' ] ],
	  \ }
let g:lightline.inactive = {
	  \ 'left': [ [ 'relativepath' ] ],
	  \ 'right': [ [ 'lineinfo' ] ] }
let g:lightline.colorscheme = 'Tomorrow_Night'
let g:lightline.mode_map = {
	  \ 'n'      : 'N',
	  \ 'c'      : 'N',
	  \ 'i'      : 'I',
	  \ 't'      : 'T',
	  \ 'R'      : 'R',
	  \ 'v'      : 'V',
	  \ 'V'      : 'VL',
	  \ "\<C-v>" : 'VB',
	  \ 's'      : 'S',
	  \ 'S'      : 'SL',
	  \ "\<C-s>" : 'SB',
	  \ }
let g:lightline.tab = {
	  \ 'active': [ 'filename', 'modified' ],
	  \ 'inactive': [ 'filename', 'modified' ] }
"<==

"==> Misc Plugins
Plug 'yuttie/comfortable-motion.vim'
Plug 'tpope/vim-fugitive'
nnoremap <leader>g <cmd>Git<cr>
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-unimpaired'
Plug 'kevinhwang91/nvim-bqf'
"<==

"==> Colorscheme (+ plug#end)
Plug 'chriskempson/vim-tomorrow-theme'
call plug#end()
" This has to happen after plug#end
colorscheme Tomorrow-Night
"<==

" vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=v\:folddashes.getline(v\:foldstart)[3\:]

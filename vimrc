" Plug
set runtimepath+=~/.vim
call plug#begin("~/.local/share/nvim/plugged")

"==> Non-Plugin Settings
syntax enable
set modelineexpr

" Wildmenu
set wildmenu wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/Cargo.lock
set path=.,**,,

" Searching
set ignorecase smartcase
set hlsearch incsearch
nohlsearch  " setting hlsearch turns on highlights, clear them
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
set signcolumn=number

" Inserting
set backspace=eol,indent,start
set whichwrap=

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
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'ray-x/lsp_signature.nvim'

" Support for various languages
Plug 'sheerun/vim-polyglot'

" Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Async compiling/testing
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'

" Handlebars
au BufReadPost *.html.hbs set filetype=html

" Make (only used when no language-specific binding is found) (execute is needed)
nnoremap <leader>m :execute "Make" \| redraw! \| cc<CR>

"==> Rust
Plug 'simrat39/rust-tools.nvim'
au BufReadPost *.rs call SetRustMappings()
au BufEnter *.rs call SetRustMappings()

command! -nargs=* Cargo :Dispatch cargo <args>
function SetRustMappings()
  nnoremap <buffer> <silent> <leader>m :Cargo clippy<cr>
  nnoremap <buffer> <silent> <leader>t :Cargo test<cr>
  execute "nnoremap <silent> <leader>r :FloatermNew cargo run -- "
endfunction
"<==

"==> Python
au BufReadPost *.py call SetPythonMappings()
au BufEnter *.py call SetPythonMappings()

function SetPythonMappings()
  execute "nnoremap <leader>r :!python3 % -- "
endfunction
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
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" FZF
nnoremap <silent> <leader>e <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>/ <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>* <cmd>Telescope grep_string<cr>
nnoremap <silent> <leader>b <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>cd <cmd>call v:lua.cd_picker()<cr>

Plug 'tpope/vim-eunuch'
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

augroup OpenTerminal
    au!
    au TermOpen * setlocal nonumber norelativenumber signcolumn=no
    au TermOpen * IndentBlanklineDisable
augroup END
"<==

"==> Org mode
Plug 'kristijanhusak/orgmode.nvim'
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
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'chriskempson/vim-tomorrow-theme'
"<==

call plug#end()

"==> Post-plugend configuration
colorscheme Tomorrow-Night

lua require('orgmode').setup({})
lua require('rust-tools').setup({})

"==> LSP
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>y', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Show signatures
  require "lsp_signature".on_attach()
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end


-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

-- required for compe
vim.o.completeopt = "menuone,noselect"

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

--This line is important for auto-import
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
EOF
"<==

"==> Telescope
lua << EOF
local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    mappings = {
        i = {
            ["<esc>"] = actions.close
        }
    }
  }
})
_G.cd_picker = function()
  require("telescope.pickers").new({}, {
    prompt_title = "Change Directory",
    finder = require("telescope.finders").new_oneshot_job({"fd", "-a", "--type", "d"}, {cwd = "{{#if vim_root_dir}}{{vim_root_dir}}{{else}}~{{/if}}"}),
    previewer = nil,
    sorter = require("telescope.config").values.file_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      function change_directory()
        actions.close(prompt_bufnr)
        vim.api.nvim_command("cd " .. require("telescope.actions.state").get_selected_entry()[1])
      end
      map("i", "<cr>", change_directory)
      return true
    end
  }):find()
end
EOF

"<==
"<==

" vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=v\:folddashes.getline(v\:foldstart)[3\:]

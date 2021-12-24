"==> Packer
lua << EOF
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'williamboman/nvim-lsp-installer' -- Install LSP servers
  use 'neovim/nvim-lspconfig' -- Make LSP servers work well
  use 'hrsh7th/nvim-cmp' -- Autocompletion framework
  use 'hrsh7th/cmp-nvim-lsp' -- Completion framework <-> LSP
  use 'hrsh7th/cmp-buffer' -- Completion framework <-> buffer
  use 'L3MON4D3/LuaSnip' -- Snippets support (mainly for completion)

  -- Languages
  use 'sheerun/vim-polyglot'
  use 'nvim-treesitter/nvim-treesitter' --, {'do': ':TSUpdate'}
  use 'tpope/vim-dispatch'
  use 'radenling/vim-dispatch-neovim'
  use 'simrat39/rust-tools.nvim'
  use 'leafoftree/vim-vue-plugin'
  use 'mattn/emmet-vim'

  -- Motions
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tommcdo/vim-lion'
  use 'wellle/targets.vim'

  -- Bells & Whistles
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'tpope/vim-eunuch'
  use 'voldikss/vim-floaterm'
  use 'itchyny/lightline.vim'
  use 'yuttie/comfortable-motion.vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-unimpaired'
  use 'kevinhwang91/nvim-bqf'

  -- Colors
  use 'chriskempson/vim-tomorrow-theme'
  use 'rebelot/kanagawa.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
EOF
"<==

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
" Execute macro over each line of selection
xnoremap Q :'<,'>:normal @q<CR>

" Change doesn't overwrite clipboard
nnoremap c "_c

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
"<==

"==> Completion/Language
" Handlebars
au BufReadPost *.html.hbs set filetype=html

" Make (only used when no language-specific binding is found) (execute is needed)
nnoremap <leader>m :execute "Make" \| redraw! \| cc<CR>

"==> Rust
au BufReadPost *.rs call SetRustMappings()
au BufEnter *.rs call SetRustMappings()
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)

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

imap <C-Tab> <plug>(emmet-expand-abbr)
"<==

"==> Telescope
nnoremap <silent> <leader>e <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>/ <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>* <cmd>Telescope grep_string<cr>
nnoremap <silent> <leader>b <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>cd <cmd>call v:lua.cd_picker()<cr>
"<==

"==> Terminal
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
augroup END
"<==

"==> Statusline
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
let g:lightline.colorscheme = 'kanagawa'
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
nnoremap <leader>g <cmd>Git<cr>
au FileType fugitive nmap <buffer> <tab> =
"<==

"==> Post-plugend configuration
colorscheme kanagawa

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
  buf_set_keymap('n', '<leader>y', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  if server.name == "rust_analyzer" then
    require("rust-tools").setup {
      tools = {
          autoSetHints = true,
          hover_with_actions = true,
          inlay_hints = {
              show_parameter_hints = true,
          },
      },

      server = {
          cmd = server:get_default_options().cmd,
          on_attach = on_attach,
          settings = {
              -- to enable rust-analyzer settings visit:
              -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
              ["rust-analyzer"] = {
                  checkOnSave = {
                      command = "clippy"
                  },
              }
          }
      },
    }

  else
    server:setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = server.name == "volar" and 500 or 150,
      },
      capabilities = capabilities,
    }
  end

  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

local luasnip = require 'luasnip'

local cmp = require'cmp'

cmp.setup{
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
  experimental = {
    ghost_text = {},
  },
}

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

" vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=v\:folddashes.getline(v\:foldstart)[3\:]

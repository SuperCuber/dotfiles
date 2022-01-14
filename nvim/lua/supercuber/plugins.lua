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
  use 'nvim-treesitter/nvim-treesitter'
  use 'tpope/vim-dispatch'
  use 'radenling/vim-dispatch-neovim'
  use 'simrat39/rust-tools.nvim'
  use 'leafoftree/vim-vue-plugin'
  use "folke/lua-dev.nvim"

  -- Motions
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'numToStr/Comment.nvim'
  use 'tommcdo/vim-lion'
  use 'wellle/targets.vim'

  -- Bells & Whistles
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'tpope/vim-eunuch'
  use 'voldikss/vim-floaterm'
  use 'nvim-lualine/lualine.nvim'
  use 'yuttie/comfortable-motion.vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-unimpaired'
  use 'kevinhwang91/nvim-bqf'
  use 'junegunn/goyo.vim'

  -- Colors
  use 'rebelot/kanagawa.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.cmd [[command! PackerConfigReload execute "luafile %" | PackerSync]]
vim.cmd [[au BufEnter plugins.lua nnoremap <F5> <cmd>PackerConfigReload<CR>]]

-- Fugitive
vim.cmd [[au FileType fugitive nmap <buffer> <tab> =]]

require("Comment").setup()

require("supercuber.plugins.treesitter")
require("supercuber.plugins.floaterm")
require("supercuber.plugins.lsp")
require("supercuber.plugins.lualine")
require("supercuber.plugins.telescope")

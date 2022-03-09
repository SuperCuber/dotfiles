local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-path'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Languages
  use 'sheerun/vim-polyglot'
  use 'nvim-treesitter/nvim-treesitter'
  use 'tpope/vim-dispatch'
  use 'radenling/vim-dispatch-neovim'
  use 'simrat39/rust-tools.nvim'
  use 'leafoftree/vim-vue-plugin'
  use 'folke/lua-dev.nvim'

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
  use 'j-hui/fidget.nvim'

  -- Colors
  use 'rebelot/kanagawa.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Lua plugin dev
P = function(v)
  print(vim.inspect(v))
  return v
end

R = function(name)
  require("plenary.reload").reload_module(name)
  return require(name)
end

vim.cmd [[command! PackerConfigReload execute "luafile %" | PackerSync]]
vim.cmd [[
augroup SupercuberPlugins
  au!
  au BufEnter plugins.lua nnoremap <buffer> <F5> <cmd>PackerConfigReload<CR>
augroup END
]]

-- Fugitive
vim.cmd [[au FileType fugitive nmap <buffer> <tab> =]]

-- Setup
require"fidget".setup{text = {spinner = "dots"}}
require("Comment").setup()

-- Included
require("supercuber.plugins.treesitter")
require("supercuber.plugins.floaterm")
require("supercuber.plugins.lsp")
require("supercuber.plugins.lualine")
require("supercuber.plugins.telescope")
require("supercuber.plugins.luasnip")

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'mbbill/undotree'

    use 'rebelot/kanagawa.nvim'

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    use { 'j-hui/fidget.nvim', branch = "legacy" }

    -- Languages
    use 'nvim-treesitter/nvim-treesitter'
    -- use 'sheerun/vim-polyglot'
    use 'tpope/vim-dispatch'
    use 'radenling/vim-dispatch-neovim'
    --use 'simrat39/rust-tools.nvim'
    --use 'leafoftree/vim-vue-plugin'
    --use 'windwp/nvim-ts-autotag'
    use 'guns/vim-sexp'
    use { 'Olical/conjure', ft = { "clojure" } }
    use { 'clojure-vim/vim-jack-in', ft = { "clojure" } }

    -- Motions
    use 'tpope/vim-repeat'
    use { 'kylechui/nvim-surround', config = function()
        require('nvim-surround').setup {}
    end }
    -- use 'tommcdo/vim-lion'
    use 'wellle/targets.vim'
    use { 'numToStr/Comment.nvim', config = function()
        require('Comment').setup()
    end }

    -- Bells & Whistles
    use 'tpope/vim-eunuch'
    use 'tpope/vim-fugitive'
    use 'shumphrey/fugitive-gitlab.vim'
    use 'tpope/vim-unimpaired'
    use 'nvim-lualine/lualine.nvim'
    use 'psliwka/vim-smoothie'
    use 'tversteeg/registers.nvim'
    use 'editorconfig/editorconfig-vim'
    use 'stevearc/oil.nvim'
    use 'godlygeek/tabular'
end)

-- vim.g.smoothie_experimental_mappings = 1
vim.g.dispatch_no_maps = 1

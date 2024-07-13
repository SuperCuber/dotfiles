-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    { import = "supercuber.plugins" },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
        config = true,
    },

    -- Languages
    -- 'sheerun/vim-polyglot',
    'tpope/vim-dispatch',
    'radenling/vim-dispatch-neovim',
    --'simrat39/rust-tools.nvim',
    --'leafoftree/vim-vue-plugin',
    --'windwp/nvim-ts-autotag',
    { 'Olical/conjure',          ft = { "clojure" } },
    { 'clojure-vim/vim-jack-in', ft = { "clojure" } },

    -- Motions
    'tpope/vim-repeat',
    {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup {}
        end
    },
    -- 'tommcdo/vim-lion',
    'wellle/targets.vim',
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    -- Org
    {
        "nvim-neorg/neorg",
        rocks = { "lua-utils.nvim", "nvim-nio", "nui.nvim", "plenary.nvim", "pathlib.nvim" },
        config = function()
            require("neorg").setup()
        end,
    },

    -- Bells & Whistles
    'tpope/vim-eunuch',
    'tpope/vim-unimpaired',
    'psliwka/vim-smoothie',
    'tversteeg/registers.nvim',
    'editorconfig/editorconfig-vim',
    'godlygeek/tabular',
    'github/copilot.vim',
})

vim.g.dispatch_no_maps = 1

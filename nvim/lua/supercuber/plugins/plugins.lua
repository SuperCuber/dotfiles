return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
        config = true,
    },

    -- Languages
    'tpope/vim-dispatch',
    'radenling/vim-dispatch-neovim',
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
    'wellle/targets.vim',
    { 'AndrewRadev/splitjoin.vim' },

    -- Bells & Whistles
    'tpope/vim-eunuch',
    'tpope/vim-unimpaired',
    'psliwka/vim-smoothie',
    'github/copilot.vim',
}

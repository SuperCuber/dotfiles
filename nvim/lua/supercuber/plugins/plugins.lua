vim.g.dispatch_no_maps = 1

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
        config = function() require('nvim-surround').setup {} end
    },
    'wellle/targets.vim',
    'AndrewRadev/splitjoin.vim',

    -- Bells & Whistles
    'tpope/vim-eunuch',
    'tpope/vim-unimpaired',
    'psliwka/vim-smoothie',
    'github/copilot.vim',
    'Ramilito/kubectl.nvim',

    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        keys = {
            { "<leader>a", nil, desc = "AI/Claude Code" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
            {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
            },
            -- Diff management
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        },
    }
}

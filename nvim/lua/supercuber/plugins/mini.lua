return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        config = function()
            require("mini.pairs").setup()
            require("mini.jump2d").setup({ mappings = { start_jumping = "s", } })
            require("mini.comment").setup()

            require("mini.indentscope").setup({ draw = { animation = require('mini.indentscope').gen_animation.none() } })
            vim.cmd [[highlight! link MiniIndentscopeSymbol Comment]]

            local trailspace = require("mini.trailspace")
            trailspace.setup()
            vim.keymap.set("n", "<Leader>f", function() trailspace.trim() end)
        end
    },
}

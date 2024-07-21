return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        config = function()
            require("mini.pairs").setup()
            require("mini.jump2d").setup({ mappings = { start_jumping = "s", } })
            require("mini.comment").setup()

            require("mini.indentscope").setup({
                draw = {
                    delay = 0,
                    animation = require('mini.indentscope').gen_animation.none()
                }
            })
            vim.cmd [[highlight! link MiniIndentscopeSymbol Comment]]
            local g = vim.api.nvim_create_augroup('MyMiniIndentscope', { clear = true })
            vim.api.nvim_create_autocmd({ "TermOpen" }, {
                group = g,
                callback = function(ev)
                    vim.b.minicursorword_disable = true
                end,
            })

            local trailspace = require("mini.trailspace")
            trailspace.setup()
            vim.keymap.set("n", "<Leader>f", function() trailspace.trim() end)
        end
    },
}

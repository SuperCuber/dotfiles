require("mini.pairs").setup {}

require("mini.indentscope").setup {}
vim.cmd [[
    highlight link MiniIndentscopeSymbol Comment
]]

vim.cmd [[
    command! Bwipe lua require"mini.bufremove".wipeout()
]]

require('mini.comment').setup({
    hooks = {
        pre = function()
            require('ts_context_commentstring.internal').update_commentstring()
        end,
    },
})

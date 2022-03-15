require("mini.pairs").setup{}

require("mini.indentscope").setup{}
vim.cmd [[
    highlight link MiniIndentscopeSymbol Comment
]]

vim.cmd [[
    command! Bwipe lua require"mini.bufremove".wipeout()
]]

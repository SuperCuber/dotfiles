require("supercuber.plugins")
require("supercuber.options")
require("supercuber.keymaps")
require("supercuber.language")

vim.cmd [[au FileType fugitive nmap <buffer> <tab> =]]
require('kanagawa').setup({
    commentStyle = "NONE",
    keywordStyle = "bold",
    statementStyle = "bold",
    variablebuiltinStyle = "bold",
    specialReturn = false,       -- special highlight for the return keyword
    specialException = false,    -- special highlight for exception handling keywords
})
vim.cmd [[colorscheme kanagawa]]

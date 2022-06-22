require('kanagawa').setup({
    commentStyle = {},
    keywordStyle = { bold = true },
    statementStyle = { bold = true },
    variablebuiltinStyle = { bold = true },
    specialReturn = false,
    specialException = false,
})
vim.cmd [[colorscheme kanagawa]]

require('kanagawa').setup({
    commentStyle = { italic = false },
    keywordStyle = { bold = true },
    statementStyle = { bold = true },
    variablebuiltinStyle = { bold = true },
    specialReturn = false,
    specialException = false,
    overrides = function(colors)
        local theme = colors.theme
        return {
            -- Dark completion menu
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
        }
    end
})

vim.cmd.colorscheme("kanagawa")

vim.cmd [[highlight link clojureBoolean Constant]]

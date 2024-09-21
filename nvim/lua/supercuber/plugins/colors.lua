local function config()
    require('kanagawa').setup({
        undercurl = false,
        commentStyle = { italic = false },
        keywordStyle = { bold = true },
        statementStyle = { bold = true },
        variablebuiltinStyle = { bold = true },
        specialReturn = false,
        specialException = false,
        dimInactive = true,
        colors = {
            theme = {
                all = {
                    ui = {
                        -- No special background for signs
                        bg_gutter = "none"
                    },
                },
            },
        },
        overrides = function(colors)
            local theme = colors.theme
            return {
                -- Dark completion menu
                Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
                PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                PmenuSbar = { bg = theme.ui.bg_m1 },
                PmenuThumb = { bg = theme.ui.bg_p2 },

                -- Color on FG instead of BG
                Todo = { fg = theme.diag.info, bg = "NONE" },
                ["@comment.warning"] = { fg = theme.diag.warning, bg = "NONE" },
                ["@comment.note"] = { fg = theme.diag.hint, bg = "NONE" },
            }
        end,
    })

    vim.cmd.colorscheme("kanagawa-wave")

    vim.cmd [[highlight link clojureBoolean Constant]]
end

return { 'rebelot/kanagawa.nvim', config = config }

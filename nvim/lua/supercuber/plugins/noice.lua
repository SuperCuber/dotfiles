local function config()
    require("noice").setup({
        cmdline = {
            format = {
                cmdline = { icon = ":" },
                search_down = { icon = "/" },
                search_up = { icon = "?" },
                filter = { icon = "$" },
                lua = { icon = ":lua" },
                help = { icon = ":help" },
            },
        },
        format = {
            level = {
                icons = {
                    error = "",
                    warn = "",
                    info = "",
                },
            },
        },
        popupmenu = {
            kind_icons = false,
        },
        routes = {
            -- hide search virtualtext
            {
                filter = {
                    event = "msg_show",
                    kind = "search_count",
                },
                opts = { skip = true },
            }
        },
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
        },
        presets = {
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
    })
end

return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
    },
    config = config,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    }
}

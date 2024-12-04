local function config()
    require("neorg").setup({
        load = {
            ["core.defaults"] = {
                config = {
                    disable = {
                        "core.todo-introspector",
                    },
                },
            },
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        main = "~/neorg",
                    },
                    default_workspace = "main",
                    index = "index.norg",
                },
            },
            ["core.journal"] = {
                config = {
                    strategy = "flat",
                    workspace = "main",
                },
            },
            ["core.qol.todo_items"] = {
                config = {
                    create_todo_parents = false,
                    order = {
                        { "undone",  " " },
                        { "pending", "-" },
                        { "done",    "x" },
                    }
                },
            },
            ["core.concealer"] = {
                config = {
                    icons = {
                        todo = false,
                    },
                },
            },
        }
    })

    vim.keymap.set("n", "<Leader>nt", function()
        vim.cmd.tabnew()
        vim.cmd [[Neorg journal today]]
        vim.cmd.tcd("~/neorg")
        vim.cmd.tabmove("0")
    end)

    vim.keymap.set("n", "<Leader>ni", function() vim.cmd [[Neorg index]] end)
    vim.keymap.set("n", "<Leader>nr", function() vim.cmd [[Neorg return]] end)
end

return {
    "nvim-neorg/neorg",
    rocks = { "lua-utils.nvim", "nvim-nio", "nui.nvim", "plenary.nvim", "pathlib.nvim" },
    config = config,
}

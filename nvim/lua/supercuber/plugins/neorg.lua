local function config()
    require("neorg").setup({
        load = {
            ["core.defaults"] = {},
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
            ["core.concealer"] = {
                config = {
                    folds = false,
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
    end)
end

return {
    "nvim-neorg/neorg",
    rocks = { "lua-utils.nvim", "nvim-nio", "nui.nvim", "plenary.nvim", "pathlib.nvim" },
    config = config,
}

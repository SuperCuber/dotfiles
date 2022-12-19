local grp = vim.api.nvim_create_augroup("SuperCuberFugitive")
vim.api.nvim_create_autocmd("FileType", {
    group = grp,
    pattern = "fugitive",
    callback = function()
        vim.keymap.set("n", "<Tab>", "=", {buffer=true, remap=true})
    end,
})
vim.keymap.set("n", "<Leader>g", vim.cmd.Git)

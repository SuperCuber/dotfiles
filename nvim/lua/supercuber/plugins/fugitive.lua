local function config()
    local grp = vim.api.nvim_create_augroup("SuperCuberFugitive", {})
    vim.api.nvim_create_autocmd("FileType", {
        group = grp,
        pattern = "fugitive",
        callback = function()
            vim.keymap.set("n", "<Tab>", "=", { buffer = true, remap = true })
        end,
    })
    vim.keymap.set("n", "<Leader>g", vim.cmd.Git)
    vim.g.fugitive_gitlab_domains = { "https://gitlab.appsflyer.com" }
    vim.api.nvim_create_user_command(
        'Browse',
        function(opts)
            -- windows->start, mac->open, linux->xdg-open
            vim.fn.system { '{{#if (eq dotter.os "windows")}}start{{else}}{{#if (is_executable "open")}}open{{else}}xdg-open{{/if}}{{/if}}', opts.fargs[1] }
        end,
        { nargs = 1 }
    )
end
-- TODO: find a way to combo `:Gvdiffsplit` with `:G mergetool`

return {
    { 'tpope/vim-fugitive', config = config },
    'shumphrey/fugitive-gitlab.vim',
    'sindrets/diffview.nvim',
}

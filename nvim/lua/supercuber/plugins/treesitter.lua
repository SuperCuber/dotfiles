local function config()
    local excluded = { 'clojure' }

    vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter.setup', {}),
        callback = function(args)
            local buf = args.buf
            local filetype = args.match

            local language = vim.treesitter.language.get_lang(filetype) or filetype
            if vim.tbl_contains(excluded, language)
                or not vim.treesitter.language.add(language) then
                return
            end

            -- vim.wo.foldmethod = 'expr'
            -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

            vim.treesitter.start(buf, language)
        end,
    })
end

return {
    {
        -- PITA to update this. Run :TSUpdate, on windows needs to be from x64 native build tools command prompt
        'nvim-treesitter/nvim-treesitter',
        config = config,
        lazy = false,
    }
}

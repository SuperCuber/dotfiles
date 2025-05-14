local function config()
    local function on_list(options)
        vim.fn.setqflist({}, ' ', options)
        if #options.items > 1 then
            -- always take full width
            vim.cmd("botright cwindow")
        end
        -- jump back to previous window and on first match
        vim.cmd("silent cfirst")
    end

    -- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "vim.lsp.buf.hover()" })
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition({ on_list = on_list }) end,
        { desc = "vim.lsp.buf.definition()" })
    vim.keymap.set("n", "gD", function()
        vim.cmd.vsplit()
        vim.lsp.buf.definition({ on_list = on_list })
    end, { desc = "vsplit -> vim.lsp.buf.definition()" })
    -- vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation({ on_list = on_list }) end, { desc = "vim.lsp.buf.implementation()" })
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references(nil, { on_list = on_list }) end)
    vim.keymap.set("n", "gR", function()
        vim.cmd.vsplit()
        vim.lsp.buf.references(nil, { on_list = on_list })
    end, { desc = "vsplit -> vim.lsp.buf.references()" })
    vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, { desc = "vim.diagnostic.open_float()" })
    vim.keymap.set("n", "<Leader>rn", function() vim.lsp.buf.rename() end, { desc = "vim.lsp.buf.rename()" })
    vim.keymap.set("n", "<Leader>a", function() vim.lsp.buf.code_action() end, { desc = "vim.lsp.buf.code_action()" })
    vim.keymap.set("n", "<Leader>f", function() vim.lsp.buf.format() end, { desc = "vim.lsp.buf.format()" })
    vim.keymap.set("n", "gh", function() pcall(vim.lsp.buf.document_highlight) end,
        { desc = "vim.lsp.buf.document_highlight()" })

    -- default nvim keybinds
    for _, key in ipairs({ "grn", "gra", "grr", "n", "gri", "gO" }) do
        for _, mode in ipairs({ "n", "x" }) do
            if vim.fn.mapcheck(key, mode) ~= "" then
                vim.keymap.del(mode, key)
            end
        end
    end

    vim.cmd [[
        autocmd CursorMoved silent! lua pcall(vim.lsp.buf.clear_references)
    ]]

    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client ~= nil and client:supports_method('textDocument/inlayHint') then
                vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
        end,
    })

    vim.diagnostic.config({ signs = false })

    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
            -- TODO: remove this, seems stupid but vim.stuff's help text doesnt work without it
            function(server_name)
                require('lspconfig')[server_name].setup({})
            end,
        }
    })

    local cmp = require('cmp')
    local cmp_mappings = {
        ["<C-n>"]     = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<Tab>"]     = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"]     = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<S-Tab>"]   = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-d>"]     = cmp.mapping.scroll_docs(4),
        ["<C-u>"]     = cmp.mapping.scroll_docs(-4),
        ["<C-e>"]     = cmp.mapping.abort(),
        ["<C-Cr>"]    = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
        ["<C-Space>"] = cmp.mapping.complete(),
    }
    vim.keymap.set('i', '<C-;>', 'copilot#Accept("")', { expr = true, replace_keycodes = false })
    vim.g.copilot_no_tab_map = true

    cmp.setup({
        mapping = cmp_mappings,
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'nvim_lua' },
        })
    })
end

return {
    {
        -- LSP Support
        { 'neovim/nvim-lspconfig', config=config },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    },
}

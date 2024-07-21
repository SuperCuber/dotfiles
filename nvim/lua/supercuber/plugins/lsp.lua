local function config()
    local lsp_zero = require('lsp-zero')

    local function on_list(options)
        vim.fn.setqflist({}, ' ', options)
        if #options.items > 1 then
            vim.cmd("botright cwindow") -- always take full width
        end
        vim.cmd("silent cfirst")        -- jump back to previous window and on first match
    end

    lsp_zero.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        lsp_zero.default_keymaps({ buffer = bufnr, exclude = { '<F2>', '<F4>', 'gr', 'gd', 'gD' } })

        vim.keymap.set("n", "<Leader>rn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<Leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<Leader>f", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references(nil, { on_list = on_list }) end)
        vim.keymap.set("n", "gR", function()
            vim.cmd.vsplit()
            vim.lsp.buf.references(nil, { on_list = on_list })
        end)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition({ on_list = on_list }) end)
        vim.keymap.set("n", "gD", function()
            vim.cmd.vsplit()
            vim.lsp.buf.definition({ on_list = on_list })
        end)
        vim.keymap.set("i", "<C-s>", function() vim.lsp.buf.signature_help() end, opts)

        -- if client.server_capabilities.documentHighlightProvider then
        --     vim.cmd [[
        --         autocmd CursorHold  <buffer> silent! lua pcall(vim.lsp.buf.document_highlight)
        --         autocmd CursorHoldI <buffer> silent! lua pcall(vim.lsp.buf.document_highlight)
        --         autocmd CursorMoved <buffer> silent! lua pcall(vim.lsp.buf.clear_references)
        --     ]]
        -- end
    end)

    vim.diagnostic.config({ signs = false })

    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
            function(server_name)
                require('lspconfig')[server_name].setup({})
            end,

            lua_ls = function()
                local lua_opts = lsp_zero.nvim_lua_ls()
                require('lspconfig').lua_ls.setup(lua_opts)
            end,
        }
    })

    local cmp = require('cmp')
    local cmp_format = lsp_zero.cmp_format()
    local cmp_mappings = {
        ["<C-n>"]     = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<Tab>"]     = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"]     = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<S-Tab>"]   = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
        ["<C-f>"]     = cmp.mapping.scroll_docs(4),
        ["<C-e>"]     = cmp.mapping.abort(),
        ["<C-Cr>"]    = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
        ["<C-Space>"] = cmp.mapping.complete(),
    }
    vim.keymap.set('i', '<C-;>', 'copilot#Accept("")', { expr = true, replace_keycodes = false })
    vim.g.copilot_no_tab_map = true

    cmp.setup({
        formatting = cmp_format,
        mapping = cmp_mappings,
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
    })
end

return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = "v3.x",
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
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
        config = config,
    },
}

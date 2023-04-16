local lsp = require('lsp-zero')

lsp.preset('recommended')

local cmp = require("cmp")
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

lsp.set_preferences {
    sign_icons = {},
    set_lsp_keymaps = { omit = { '<F2>', '<F4>', 'gr', 'gd' } }
}

lsp.setup_nvim_cmp {
    mapping = cmp_mappings
}

local function on_list(options)
    vim.fn.setqflist({}, ' ', options)
    if #options.items > 1 then
        vim.cmd("botright cwindow") -- always take full width
    end
    vim.cmd("silent cfirst") -- jump back to previous window and on first match
end

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<Leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<Leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<Leader>f", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references(nil, { on_list = on_list }) end)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition({ on_list = on_list }) end)

    if client.server_capabilities.documentHighlightProvider then
        vim.cmd [[
            autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        ]]
    end
end)


lsp.setup()

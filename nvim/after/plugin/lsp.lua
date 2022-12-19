local lsp = require('lsp-zero')

lsp.preset('recommended')

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings {
}

lsp.set_preferences {
    sign_icons = {},
}

lsp.setup_nvim_cmp {
    mapping = cmp_mappings
}

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = buffer, remap = false}

    vim.keymap.set("n", "<Leader>rn", function() vim.lsp.rename() end, opts)
    vim.keymap.set("n", "<Leader>ca", function() vim.lsp.code_action() end, opts)
    vim.keymap.set("n", "<Leader>f", function() vim.lsp.buf.format() end, opts)
end)

lsp.setup()

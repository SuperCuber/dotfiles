P = {}

function P.nmap(from, to)
    return vim.api.nvim_set_keymap("n", from, to, { noremap = false, silent = true })
end

function P.nnoremap(from, to)
    return vim.api.nvim_set_keymap("n", from, to, { noremap = true, silent = true })
end

function P.inoremap(from, to)
    return vim.api.nvim_set_keymap("i", from, to, { noremap = true, silent = true })
end

function P.tnoremap(from, to)
    return vim.api.nvim_set_keymap("t", from, to, { noremap = true, silent = true })
end

return P

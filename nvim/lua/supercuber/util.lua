local M = {}

function M.nmap(from, to)
    return vim.api.nvim_set_keymap("n", from, to, { noremap = false, silent = true })
end

function M.nnoremap(from, to)
    return vim.api.nvim_set_keymap("n", from, to, { noremap = true, silent = true })
end

function M.inoremap(from, to)
    return vim.api.nvim_set_keymap("i", from, to, { noremap = true, silent = true })
end

function M.tnoremap(from, to)
    return vim.api.nvim_set_keymap("t", from, to, { noremap = true, silent = true })
end

return M

local util = require("supercuber.util")

vim.g.floaterm_wintype = "vsplit"
vim.g.floaterm_width = 0.3
vim.g.floaterm_autohide = 0

-- Open
util.nnoremap("<C-t>", "<Cmd>FloatermNew<Cr>")
-- Close
util.tnoremap("<C-d>", "<Cmd>q!<Cr>")
-- Leave
util.tnoremap("<Esc>", "<C-\\><C-n>")
util.tnoremap("<A-h>", "<C-\\><C-n><C-w>h")
util.tnoremap("<A-j>", "<C-\\><C-n><C-w>j")
util.tnoremap("<A-k>", "<C-\\><C-n><C-w>k")
util.tnoremap("<A-l>", "<C-\\><C-n><C-w>l")

vim.cmd [[
augroup OpenTerminal
    au!
    au TermOpen * setlocal nonumber norelativenumber signcolumn=no
augroup END
]]

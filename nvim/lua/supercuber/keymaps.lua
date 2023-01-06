vim.g.mapleader = ","

-- Save
vim.keymap.set("n", "<Space>", vim.cmd.w)
-- Quit
vim.keymap.set("n", "<Leader>q", vim.cmd.q)

-- Move between windows
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")

-- Navigate lists
vim.keymap.set("n", "<C-j>", "<Cmd>cnext<Enter>zz")
vim.keymap.set("n", "<C-k>", "<Cmd>cprev<Enter>zz")
vim.keymap.set("n", "<Leader>j", "<Cmd>lnext<Enter>zz")
vim.keymap.set("n", "<Leader>k", "<Cmd>lprev<Enter>zz")

-- Open vimrc editing workspace
vim.keymap.set("n", "<Leader>vrc", [[<Cmd>tabnew<Enter><Cmd>tcd ~/.dotfiles<Enter><Cmd>edit nvim/init.lua<Enter><Cmd>vsp +term<Enter>{{#if (eq dotter.os "unix")}}./{{/if}}dotter watch -v<Cr><A-h>]])
-- Source vimrc
vim.keymap.set("n", "<Leader>src", ":luafile $MYVIMRC<cr>")

-- Remove highlights
vim.keymap.set("n", "<Leader><Enter>", vim.cmd.nohlsearch)
vim.keymap.set("n", "*", "g*")
vim.keymap.set("n", "#", "g#")

-- Easier to type, and I never use the default behavior.
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
-- Move stuff in selected visually
vim.keymap.set("v", "J", ":m '>+1<Enter>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<Enter>gv=gv")

-- Cursor doesn't move when joining
vim.keymap.set("n", "J", "mzJ`z")
-- [S]plit line (sister to [J]oin lines)
vim.keymap.set("n", "S", "i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w")

-- Change doesn't overwrite clipboard
vim.keymap.set("n", "c", [["_c]])
-- Paste over & delete without overwriting clipboard
vim.keymap.set("v", "p", "\"_dP")
vim.keymap.set("v", "<Leader>p", "p", {remap=false})
vim.keymap.set("n", "<Leader>d", "\"_d")
vim.keymap.set("v", "<Leader>d", "\"_d")
-- OS Clipboard
vim.keymap.set({"n", "v"}, "<Leader>y", "\"+y")
vim.keymap.set({"n", "v"}, "<Leader>p", "\"+p")
vim.keymap.set({"n", "v"}, "<Leader>P", "\"+P")

vim.keymap.set("n", "Q", "<Nop>")

-- Terminal
vim.keymap.set("n", "<C-t>", "<Cmd>vsp +term<Enter>")
vim.keymap.set("t", "<C-d>", "<Cmd>q!<Cr>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<A-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<A-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<A-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<A-l>", "<C-\\><C-n><C-w>l")
local group = vim.api.nvim_create_augroup("SuperCuberTerminal", {})
vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.signcolumn = "no"
        vim.cmd("startinsert")
    end,
})
vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    pattern = "term://*",
    command = "startinsert",
})

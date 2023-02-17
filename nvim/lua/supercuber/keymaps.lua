vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Save
vim.keymap.set("n", "<Space>", vim.cmd.w)
-- Quit
vim.keymap.set("n", "<Leader>q", vim.cmd.q)

-- Move between windows
for _, key in ipairs({"h", "j", "k", "l"}) do
    vim.keymap.set({ "n", "t" }, "<A-" .. key .. ">", function ()
        vim.cmd.stopinsert()
        vim.cmd.wincmd(key)
        local name = vim.api.nvim_buf_get_name(0)
        if string.find(name, "term://") then
            vim.cmd.startinsert()
        end
    end)
end

-- Navigate lists
vim.keymap.set("n", "<C-j>", "<Cmd>cnext<Enter>zz")
vim.keymap.set("n", "<C-k>", "<Cmd>cprev<Enter>zz")

-- Open vimrc editing workspace
local dotter_exe = [[{{#if (eq dotter.os "unix")}}./{{/if}}dotter{{#if arm}}.arm{{/if}}]]
vim.keymap.set("n", "<Leader>vrc",
    function()
        vim.cmd.tabnew()
        vim.cmd.tcd("~/.dotfiles")
        vim.cmd.edit("nvim/init.lua")
        vim.cmd.vsp()
        vim.cmd.term(dotter_exe .. " watch -v")
        vim.cmd.stopinsert()
        vim.cmd.wincmd("h")
    end)

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
vim.keymap.set("v", "<Leader>p", "p", { remap = false })
vim.keymap.set("n", "<Leader>d", "\"_d")
vim.keymap.set("v", "<Leader>d", "\"_d")
-- OS Clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<Leader>p", "\"+p")
vim.keymap.set({ "n", "v" }, "<Leader>P", "\"+P")

vim.keymap.set("n", "Q", "<Nop>")

-- Terminal
vim.keymap.set("n", "<C-t>", "<Cmd>vsp +term<Enter>i")
vim.keymap.set("t", "<C-d>", "<Cmd>q!<Cr>")
vim.keymap.set("t", "<C-v><C-d>", "<C-d>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
local group = vim.api.nvim_create_augroup("SuperCuberTerminal", {})
vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.signcolumn = "no"
    end,
})

local util = require("supercuber.util")

-- Move around windows
util.nnoremap("<A-h>", "<C-w>h")
util.nnoremap("<A-j>", "<C-w>j")
util.nnoremap("<A-k>", "<C-w>k")
util.nnoremap("<A-l>", "<C-w>l")

-- Remove highlights
util.nnoremap(",<Cr>", "<Cmd>noh<Cr>")

-- Open vimrc editing workspace
--{{#if (eq dotter.os "unix")}}
util.nmap(",vrc", ":tabedit ~/.dotfiles/nvim/init.lua<Cr><C-t>cd ~/.dotfiles; c; ./dotter watch -v<Cr><A-h>")
--{{else}}
util.nmap(",vrc", ":tabedit ~/.dotfiles/nvim/init.lua<Cr><C-t>" .. vim.env.HOMEDRIVE .. "<Cr>cd " .. vim.env.HOMEPATH .. "\\.dotfiles<Cr>dotter watch -v<Cr><A-h>")
--{{/if}}
-- Source vimrc
util.nnoremap(",src", ":luafile $MYVIMRC<cr>")

-- Save
util.nnoremap("<space>", ":w<cr>")
-- Quit
util.nnoremap(",q", ":q<cr>")
-- Kill
util.nnoremap(",k", ":q!<cr>")

-- [S]plit line (sister to [J]oin lines)
util.nnoremap("S", "i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w")

-- Change doesn't overwrite clipboard
util.nnoremap("c", [["_c]])

-- Easier to type, and I never use the default behavior.
util.nnoremap("H", "^")
util.nnoremap("L", "$")

-- Git
util.nnoremap(",g", "<cmd>Git<cr>")

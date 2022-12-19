vim.api.nvim_buf_create_user_command(0, "Lein", "Dispatch lein <args>", {nargs = "*"})
vim.keymap.set("n", "<Leader>t", "<Cmd>Lein test<Enter>", {buffer=true})

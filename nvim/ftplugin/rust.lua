vim.api.nvim_buf_create_user_command(0, "Cargo", "Dispatch cargo <args>", {nargs = "*"})
vim.keymap.set("n", "<Leader>m", "<Cmd>Cargo clippy<Enter>", {buffer=true})
vim.keymap.set("n", "<Leader>t", "<Cmd>Cargo test<Enter>", {buffer=true})
vim.keymap.set("n", "<Leader>r", ":Cargo run -- ", {buffer=true})

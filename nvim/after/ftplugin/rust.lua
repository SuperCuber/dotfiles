vim.api.nvim_buf_create_user_command(0, "Cargo", "Dispatch cargo <args>", {nargs = "*", force=true})
vim.keymap.set("n", "<LocalLeader>m", "<Cmd>Cargo clippy<Enter>", {buffer=true})
vim.keymap.set("n", "<LocalLeader>t", "<Cmd>Cargo test<Enter>", {buffer=true})
vim.keymap.set("n", "<LocalLeader>r", "<Cmd>Cargo run -- ", {buffer=true})

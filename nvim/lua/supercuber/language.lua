-- Handlebars
vim.cmd [[au BufReadPost *.html.hbs set filetype=html]]

-- Make (fallback for language-specific bindings)
vim.api.nvim_set_keymap("n", ",m", [[:execute "Make" \| redraw! \| cc<CR>]], { noremap = true, silent = true })

-- Emmet
vim.api.nvim_set_keymap("i", "<C-Tab>", "<plug>(emmet-expand-abbr)", { noremap = false, silent = true })

require("supercuber.languages.rust")
require("supercuber.languages.python")

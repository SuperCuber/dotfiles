-- Handlebars
vim.cmd [[au BufReadPost *.html.hbs set filetype=html]]

-- Make (fallback for language-specific bindings)
vim.api.nvim_set_keymap("n", ",m", [[:execute "Make" \| redraw! \| cc<CR>]], { noremap = true, silent = true })

require("supercuber.languages.rust")
require("supercuber.languages.python")
require("supercuber.languages.go")
require("supercuber.languages.clojure")

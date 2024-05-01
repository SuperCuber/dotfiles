require('marks').setup { builtin_marks = { ".", "<", ">", "^" } }
local group = vim.api.nvim_create_augroup("marks-fix-hl", {})
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = group,
    callback = function() vim.api.nvim_set_hl(0, "MarkSignNumHL", {}) end,
})

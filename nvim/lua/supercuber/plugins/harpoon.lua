local function config()
    local harpoon = require('harpoon')
    harpoon:setup({})

    vim.keymap.set("n", "<Leader>ha", function() harpoon:list():add() end)
    vim.keymap.set("n", "<Leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-,>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-.>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-/>", function() harpoon:list():select(3) end)
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = config,
}

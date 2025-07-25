local function config()
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')

    local cd_picker = require("telescope.pickers").new({}, {
        prompt_title = "Change Directory",
        finder = require("telescope.finders").new_oneshot_job({ "fd", "-a", "--type", "d" },
            { cwd = "{{#if vim_root_dir}}{{vim_root_dir}}{{else}}~{{/if}}" }),
        previewer = nil,
        sorter = require("telescope.config").values.file_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            local function change_directory()
                actions.close(prompt_bufnr)
                vim.api.nvim_command("cd " .. require("telescope.actions.state").get_selected_entry()[1])
            end

            map("i", "<cr>", change_directory)
            return true
        end
    })

    vim.keymap.set('n', '<Leader>e', function() builtin.find_files { no_ignore = false, hidden = true } end, {})
    vim.keymap.set('n', '<C-p>', function() builtin.find_files { no_ignore = true, hidden = true } end, {})
    vim.keymap.set('n', '<Leader>/', builtin.live_grep, {})
    vim.keymap.set('n', '<Leader>*', builtin.grep_string, {})
    vim.keymap.set('n', '<Leader>b', builtin.buffers, {})
    vim.keymap.set('n', '<Leader>he', builtin.help_tags, {})
    vim.keymap.set('n', '<Leader>cd', function() cd_picker:find() end, {})

    require("telescope").setup {
        defaults = {
            mappings = {
                i = {
                    ["<Esc>"] = require("telescope.actions").close
                }
            }
        }
    }
end

return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' } },
        config = config,
    },
}

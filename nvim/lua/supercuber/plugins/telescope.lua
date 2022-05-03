local util = require("supercuber.util")

util.nnoremap(",e", "<cmd>Telescope find_files<cr>")
util.nnoremap(",/", "<cmd>Telescope live_grep<cr>")
util.nnoremap(",*", "<cmd>Telescope grep_string<cr>")
util.nnoremap(",b", "<cmd>Telescope buffers<cr>")
util.nnoremap(",cd", "<cmd>call v:lua.cd_picker()<cr>")
util.nnoremap("gs", "<cmd>Telescope lsp_workspace_symbols<cr>")

local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      }
    }
  }
})
_G.cd_picker = function()
  require("telescope.pickers").new({}, {
    prompt_title = "Change Directory",
    finder = require("telescope.finders").new_oneshot_job({ "fd", "-a", "--type", "d" }, { cwd = "{{#if vim_root_dir}}{{vim_root_dir}}{{else}}~{{/if}}" }),
    previewer = nil,
    sorter = require("telescope.config").values.file_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      local function change_directory()
        actions.close(prompt_bufnr)
        vim.api.nvim_command("cd " .. require("telescope.actions.state").get_selected_entry()[1])
      end

      map("i", "<cr>", change_directory)
      return true
    end
  }):find()
end

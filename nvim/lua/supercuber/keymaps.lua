--==> Util
local function nmap(from, to)
    return vim.api.nvim_set_keymap("n", from, to, { noremap = false, silent = true })
end
local function nnoremap(from, to)
    return vim.api.nvim_set_keymap("n", from, to, { noremap = true, silent = true })
end
local function imap(from, to)
    return vim.api.nvim_set_keymap("i", from, to, { noremap = false, silent = true })
end
local function inoremap(from, to)
    return vim.api.nvim_set_keymap("i", from, to, { noremap = true, silent = true })
end
local function tnoremap(from, to)
    return vim.api.nvim_set_keymap("t", from, to, { noremap = true, silent = true })
end
--<==

--==> Vanilla keybinds
-- Escape from insert
inoremap("jk", "<Esc>")
inoremap("JK", "<Esc>")
inoremap("kj", "<Esc>")
inoremap("KJ", "<Esc>")

-- Move around windows
nnoremap("<A-h>", "<C-w>h")
nnoremap("<A-j>", "<C-w>j")
nnoremap("<A-k>", "<C-w>k")
nnoremap("<A-l>", "<C-w>l")

-- Leader
vim.g.mapleader = ","

-- Remove highlights
nnoremap("<Leader><Cr>", "<Cmd>noh<Cr>")

-- Open vimrc editing workspace
--{{#if (eq dotter.os "unix")}}
nmap("<Leader>vrc", ":tabedit ~/.dotfiles/nvim/init.lua<Cr><C-t>cd ~/.dotfiles; c; ./dotter watch -v<Cr><A-h>")
--{{else}}
nmap("<Leader>vrc", ":tabedit ~/.dotfiles/nvim/init.lua<Cr><C-t>" .. vim.env.HOMEDRIVE .. "<Cr>cd " .. vim.env.HOMEPATH .. "\\.dotfiles<Cr>dotter watch -v<Cr><A-h>")
--{{/if}}
-- Source vimrc
nnoremap("<Leader>src", ":luafile $MYVIMRC<cr>")

-- Save
nnoremap("<space>", ":w<cr>")
-- Quit
nnoremap("<leader>q", ":q<cr>")
-- Kill
nnoremap("<leader>k", ":q!<cr>")

-- [S]plit line (sister to [J]oin lines)
nnoremap("S", "i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w")

-- Change doesn't overwrite clipboard
nnoremap("c", [["_c]])

-- Easier to type, and I never use the default behavior.
nnoremap("H", "^")
nnoremap("L", "$")
--<==

--==> Language-specific
-- Handlebars
vim.cmd [[au BufReadPost *.html.hbs set filetype=html]]

-- Make (fallback for language-specific bindings)
nnoremap("<leader>m", [[:execute "Make" \| redraw! \| cc<CR>]])

--==> Rust
vim.cmd [[
au BufReadPost *.rs call SetRustMappings()
au BufEnter *.rs call SetRustMappings()
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)

command! -nargs=* Cargo :Dispatch cargo <args>
function SetRustMappings()
  nnoremap <buffer> <silent> <leader>m :Cargo clippy<cr>
  nnoremap <buffer> <silent> <leader>t :Cargo test<cr>
  execute "nnoremap <silent> <leader>r :FloatermNew cargo run -- "
endfunction
]]
--<==

--==> Python
vim.cmd [[
au BufReadPost *.py call SetPythonMappings()
au BufEnter *.py call SetPythonMappings()

function SetPythonMappings()
  execute "nnoremap <leader>r :!python3 % -- "
endfunction
]]
--<==

-- Emmet
imap("<C-Tab>", "<plug>(emmet-expand-abbr)")
--<==

--==> Telescope
nnoremap("<leader>e", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>/", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>*", "<cmd>Telescope grep_string<cr>")
nnoremap("<leader>b", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>cd", "<cmd>call v:lua.cd_picker()<cr>")
--<==

--==> Terminal
vim.g.floaterm_wintype = "vsplit"
vim.g.floaterm_width = 0.3
vim.g.floaterm_autohide = 0

-- Open
nnoremap("<C-t>", "<Cmd>FloatermNew<Cr>")
-- Close
tnoremap("<C-d>", "<Cmd>q!<Cr>")
-- Leave
tnoremap("<Esc>", "<C-\\><C-n>")
tnoremap("<A-h>", "<C-\\><C-n><C-w>h")
tnoremap("<A-j>", "<C-\\><C-n><C-w>j")
tnoremap("<A-k>", "<C-\\><C-n><C-w>k")
tnoremap("<A-l>", "<C-\\><C-n><C-w>l")

vim.cmd [[
augroup OpenTerminal
    au!
    au TermOpen * setlocal nonumber norelativenumber signcolumn=no
augroup END
]]
--<==

--==> Statusline
vim.opt.showmode = false
vim.g.lightline = {
    active = {
        left = {
            { "mode", "paste" },
            { "relativepath" },
            { "readonly", "modified" },
        },
        right = {
            { "lineinfo" },
            { "filetype" },
        },
    },
    inactive = {
        left = {
            { "relativepath" },
        },
        right = {
            { "lineinfo" },
        },
    },
    colorscheme = "kanagawa",
    mode_map = {
    ["n"    ]  = "N",
    ["c"    ]  = "N",
    ["i"    ]  = "I",
    ["t"    ]  = "T",
    ["R"    ]  = "R",
    ["v"    ]  = "V",
    ["V"    ]  = "VL",
    ["<C-v>"]  = "VB",
    ["s"    ]  = "S",
    ["S"    ]  = "SL",
    ["<C-s>"]  = "SB",
    },
    tab = {
        active = {
            { "filename", "modified" },
        },
        inactive = {
            { "filename", "modified" },
        },
    },
}
--<==

--==> Misc Plugins
nnoremap("<leader>g", "<cmd>Git<cr>")
vim.cmd [[au FileType fugitive nmap <buffer> <tab> =]]
--<==

--==> Post-plugend configuration
vim.cmd [[colorscheme kanagawa]]
local nvim_lsp = require('lspconfig')

local function set_keymap(...) vim.api.nvim_set_keymap(...) end
local function set_option(...) vim.api.nvim_set_option(...) end

--Enable completion triggered by <c-x><c-o>
set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
set_keymap('n', '<leader>y', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  if server.name == "rust_analyzer" then
    require("rust-tools").setup {
      tools = {
          autoSetHints = true,
          hover_with_actions = true,
          inlay_hints = {
              show_parameter_hints = true,
          },
      },

      server = {
          cmd = server:get_default_options().cmd,
          settings = {
              -- to enable rust-analyzer settings visit:
              -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
              ["rust-analyzer"] = {
                  checkOnSave = {
                      command = "clippy"
                  },
              }
          }
      },
    }
  elseif server.name == "sumneko_lua" then
      server:setup(require("lua-dev").setup())
      -- TODO: on_attach
  else
    server:setup {
      flags = {
        debounce_text_changes = server.name == "volar" and 500 or 150,
      },
      capabilities = capabilities,
    }
  end

  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

local luasnip = require 'luasnip'

local cmp = require'cmp'

cmp.setup{
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
  experimental = {
    ghost_text = {},
  },
}

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
    finder = require("telescope.finders").new_oneshot_job({"fd", "-a", "--type", "d"}, {cwd = "{{#if vim_root_dir}}{{vim_root_dir}}{{else}}~{{/if}}"}),
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
--<==

-- vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:foldtext=v\:folddashes.getline(v\:foldstart)[4\:]

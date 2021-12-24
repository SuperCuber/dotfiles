local util = require("supercuber.util")
local nvim_lsp = require('lspconfig')

-- Enable completion triggered by <c-x><c-o>
vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
util.nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
util.nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
util.nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
util.nnoremap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
util.nnoremap(',y', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
util.nnoremap(',rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
util.nnoremap(',a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
util.nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
util.nnoremap('[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
util.nnoremap(']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
util.nnoremap(',f', '<cmd>lua vim.lsp.buf.formatting()<CR>')

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

local M = {}

local util = require "supercuber.util"

local ls = require "luasnip"

ls.config.set_config {
    updateevents = "TextChanged, TextChangedI",
}


-- Expand/jump
util.inoremap("<c-j>", "<cmd>lua require'supercuber.plugins.luasnip'.next()<cr>")
util.inoremap("<c-k>", "<cmd>lua require'supercuber.plugins.luasnip'.prev()<cr>")
util.inoremap("<c-l>", "<cmd>lua require'supercuber.plugins.luasnip'.list()<cr>")


function M.next()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end

function M.prev()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end

function M.list()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end

-- Reload
util.nnoremap(",,s", "<cmd>lua R('luasnip');R('supercuber.plugins.luasnip')<cr>")

-- Snippets

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require "luasnip.extras.fmt".fmt
-- local i = ls.insert_node
-- local xs = require "luasnip.extras"

-- https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
ls.add_snippets("vue", {
    s("vue", fmt([[
        <template>
        {}
        </template>

        <script setup{}>
        </script>
        ]],
        {
            i(0),
            c(1, {
                t(' lang="ts"'),
                t(''),
            })
        }
    ))
})

ls.add_snippets("typescriptreact", {
    s("state", fmt([[
            const [{}, set{}] = useState<{}>({}){}
        ]],
        {
            i(1),
            f(function(args, snip)
                return args[1][1]:gsub("^.", string.upper)
            end, {1}),
            i(2),
            i(3),
            i(0),
        }
    ))
})

return M

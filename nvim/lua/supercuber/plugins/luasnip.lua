local function config()
    local ls = require("luasnip")

    -- Maps

    local function reload()
        ls = require("plenary.reload").reload_module("luasnip")
        define_snippets()
    end

    vim.keymap.set("i", "<C-j>", function() ls.jump(1) end)
    vim.keymap.set("i", "<C-k>", function() ls.jump(-1) end)
    vim.keymap.set("i", "<C-l>", "<Plug>luasnip-next-choice")
    vim.keymap.set("n", "<Leader><Leader>s", reload)

    -- Custom Snippets

    local s = ls.s
    local i = ls.insert_node
    local t = ls.text_node
    local c = ls.choice_node
    local f = ls.function_node
    local rep = require "luasnip.extras".rep
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
                end, { 1 }),
                i(2),
                i(3),
                i(0),
            }
        ))
    })

    ls.add_snippets("clojure", {
        s("caparg", fmt([[
                (def ^:dynamic *{}* {})
            ]],
            {
                rep(1),
                i(1),
            }
        ))
    })
end

return {
    { 'L3MON4D3/LuaSnip', config = config }
}

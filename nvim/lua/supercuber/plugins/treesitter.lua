local function config()
    require 'nvim-treesitter.configs'.setup {
        ensure_installed = {},
        sync_install = false,
        auto_install = false,

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            disable = { "clojure" },
        },
    }
end

return {
    {
        -- PITA to update this. Run :TSUpdate, on windows needs to be from x64 native build tools command prompt
        'nvim-treesitter/nvim-treesitter',
        config = config,
    }
}

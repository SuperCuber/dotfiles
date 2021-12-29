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
    tabline = {
        left = { { "tabs" } },
        right = { },
    },
    colorscheme = "Tomorrow_Night",
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
        active ={ "filename", "modified" },
        inactive = { "filename", "modified" },
    },
}

vim.opt.modelineexpr = true

-- Wildmenu
vim.opt.wildmenu = true
vim.opt.wildignore = "*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/Cargo.lock"
vim.opt.path=".,**,,"

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.gdefault = true
vim.cmd("nohlsearch")

-- Drawing
vim.opt.lazyredraw = true
vim.opt.errorbells = false
vim.opt.belloff = "all"
vim.opt.showcmd = true
vim.opt.scrolloff = 7
vim.opt.laststatus = 2
vim.opt.title = true
vim.opt.titlestring = "NVIM: %F"
vim.opt.cursorline = true
vim.opt.virtualedit = "block"
vim.opt.signcolumn = "number"
vim.opt.number = true
vim.opt.relativenumber = true

-- Inserting
vim.opt.backspace = "eol,indent,start"
vim.opt.whichwrap = ""

-- Backups
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Tabs
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- List
vim.opt.list = true
vim.opt.listchars = "tab:»·,trail:·"

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Interact with X
vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.mouse = "nvc"
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- Turn off ugly gui popupmenu on windows neovim and setup font
vim.cmd [[
au VimEnter * if exists('g:GuiLoaded')
            \ | exe 'GuiPopupmenu 0'
            \ | exe 'GuiFont Hack:h14'
            \ | endif
]]


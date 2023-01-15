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
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.updatetime = 500

-- Inserting
vim.opt.backspace = "eol,indent,start,nostop"
vim.opt.whichwrap = ""

-- Tabs
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- List
vim.opt.list = true
vim.opt.listchars = "tab:»·,trail:·"

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.mouse = "nvc"
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

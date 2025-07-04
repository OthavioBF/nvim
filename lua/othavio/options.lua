vim.opt.guicursor = "n-v-i-c:block-Cursor"
vim.g.undotree_DiffCommand = "FC"
vim.g.goyo_height = "100%"
vim.opt.showmode = false
vim.opt.nu = true
vim.opt.relativenumber = true
vim.wo.foldmethod = 'manual'

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.ignorecase = true

vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.wrap = false
vim.opt.ai = true
vim.opt.si = true
vim.opt.wrap = false
vim.opt.wildignore = { '*/node_modules/*' }

vim.opt.cursorline = true
vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5
vim.opt.background = 'dark'

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80,120"

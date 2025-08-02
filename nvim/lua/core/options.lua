vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.opt.shiftwidth = 4
vim.o.expandtab = true
vim.opt.guicursor = ""
vim.o.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.fileencoding = "utf-8"
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true

vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.autoindent = true
vim.o.showmode = false
vim.o.smartindent = true
vim.o.breakindent = true
vim.wo.cursorline = true -- temp
vim.o.wrap = true
vim.o.cmdheight = 1
vim.o.linebreak = true
vim.o.pumheight = 10
vim.wo.signcolumn = "yes"
vim.o.showtabline = 1
vim.o.numberwidth = 4
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = false
vim.o.whichwrap = "bs<>[]hl"

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.cmd([[autocmd FileType * set formatoptions-=ro]])
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.o.backspace = "indent,eol,start"
vim.o.completeopt = "menuone,noselect"
vim.opt.shortmess:append("c")

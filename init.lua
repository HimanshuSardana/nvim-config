-- GLOBAL OPTIONS
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

vim.cmd("set nowrap")

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 0
vim.opt.foldlevelstart = 99

vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undodir"
-- vim.o.winborder = "single"

vim.g.python3_host_prog = "/usr/bin/python3"

-- LAZY
require("config.lazy")

-- KEYBINDS
require("config.keybinds")

-- AUTOCOMMANDS
require("config.autocommands")

-- LSP
vim.lsp.enable({ 'luals' })

-- COPILOT CHAT
vim.api.nvim_set_hl(0, 'CopilotChatHeader', { fg = '#7C3AED', bold = true })
vim.api.nvim_set_hl(0, 'CopilotChatSeparator', { fg = '#374151' })

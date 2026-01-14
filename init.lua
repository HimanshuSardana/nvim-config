-- GLOBAL OPTIONS
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undodir"
vim.opt.undofile = true
vim.o.winborder = "none"
vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.python3_host_prog = "/usr/bin/python3"
vim.cmd("set nowrap")

-- FOLDING
require("config.folding")


-- LAZY
require("config.lazy")

-- KEYBINDS
require("config.keybinds")

-- AUTOCOMMANDS
require("config.autocommands")

-- LSP
-- vim.lsp.enable({ 'luals' })

-- COPILOT CHAT
vim.api.nvim_set_hl(0, 'CopilotChatHeader', { fg = '#7C3AED', bold = true })
vim.api.nvim_set_hl(0, 'CopilotChatSeparator', { fg = '#374151' })

-- vim.opt.rtp:append("~/projects/tangle.nvim/")
-- require("tangle").setup()

-- SNIPPETS
require("snippets")

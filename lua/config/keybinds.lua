-- QoL
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Oil.nvim
vim.keymap.set("n", "<leader>ft", require("oil").open)

-- fzf-lua
vim.keymap.set("n", "<leader>ff", require("fzf-lua").files)
vim.keymap.set("n", "<leader><leader>", require("fzf-lua").buffers)
vim.keymap.set("n", "<leader>fc", function()
	local config_dir = vim.fn.stdpath("config")
	require("fzf-lua").files({ cwd = config_dir })
end, { desc = "[F]ind [C]onfig" })
vim.keymap.set("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "[F]ind [G]rep" })

-- LSP
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

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
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostics window' })

local terminal_bufnr = nil
local terminal_winid = nil

local terminal_bufnr = nil
local terminal_winid = nil

function ToggleTerminal()
	if terminal_winid and vim.api.nvim_win_is_valid(terminal_winid) then
		vim.api.nvim_win_close(terminal_winid, true)
		terminal_winid = nil
	else
		vim.cmd("botright split")
		vim.cmd("resize 13") -- height of terminal
		terminal_winid = vim.api.nvim_get_current_win()

		if terminal_bufnr and vim.api.nvim_buf_is_valid(terminal_bufnr) then
			vim.api.nvim_win_set_buf(terminal_winid, terminal_bufnr)
		else
			vim.cmd("terminal")
			terminal_bufnr = vim.api.nvim_get_current_buf()
		end

		vim.cmd("startinsert")
	end
end

vim.keymap.set("n", "<leader>tt", ToggleTerminal, { noremap = true, silent = true })
vim.keymap.set("t", "<leader>tt", [[<C-\><C-n><cmd>lua ToggleTerminal()<CR>]], { noremap = true, silent = true })

-- miniharp
vim.keymap.set('n', '<leader>m', require('miniharp').toggle_file, { desc = 'miniharp: toggle file mark' })
vim.keymap.set('n', '<C-n>', require('miniharp').next, { desc = 'miniharp: next file mark' })
vim.keymap.set('n', '<C-p>', require('miniharp').prev, { desc = 'miniharp: prev file mark' })
vim.keymap.set('n', '<leader>l', require('miniharp').show_list, { desc = 'miniharp: list marks' })

-- Buffers (with C-n and C-p for next/prev buffer)
vim.keymap.set("n", "<C-n>", ":bnext<CR>", { desc = "[B]uffer [N]ext" })
vim.keymap.set("n", "<C-p>", ":bprevious<CR>", { desc = "[B]uffer [P]revious" })
vim.keymap.set("n", "<C-x>", ":bdelete<CR>", { desc = "[B]uffer [D]elete" })

-- Resizing splits
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -5<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +5<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize -5<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +5<CR>", { desc = "Increase window height" })

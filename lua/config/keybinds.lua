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

-- TOGGLE TERMINAL
local terminal_bufnr = nil
local terminal_winid = nil

-- Toggle terminal at the bottom
local terminal_bufnr = nil
local terminal_winid = nil

function ToggleTerminal()
	if terminal_winid and vim.api.nvim_win_is_valid(terminal_winid) then
		vim.api.nvim_win_close(terminal_winid, true)
		terminal_winid = nil
	else
		vim.cmd("botright split")
		vim.cmd("resize 10") -- height of terminal
		terminal_winid = vim.api.nvim_get_current_win()

		if terminal_bufnr and vim.api.nvim_buf_is_valid(terminal_bufnr) then
			-- Reuse previous terminal buffer
			vim.api.nvim_win_set_buf(terminal_winid, terminal_bufnr)
		else
			-- Create new terminal buffer
			vim.cmd("terminal")
			terminal_bufnr = vim.api.nvim_get_current_buf()
		end

		vim.cmd("startinsert")
	end
end

vim.keymap.set("n", "<leader>tt", ToggleTerminal, { noremap = true, silent = true })
vim.keymap.set("t", "<leader>tt", [[<C-\><C-n><cmd>lua ToggleTerminal()<CR>]], { noremap = true, silent = true })

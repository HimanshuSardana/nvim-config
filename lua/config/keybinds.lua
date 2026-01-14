-- QoL
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Oil.nvim
vim.keymap.set("n", "<leader>ft", require("oil").open)

-- fzf-lua
vim.keymap.set("n", "<leader>ff", require("fzf-lua").files)
vim.keymap.set("n", "<leader><leader>", require("fzf-lua").buffers)
vim.keymap.set("n", "<leader>ss", require("fzf-lua").lsp_document_symbols, { desc = "[S]earch [S]ymbols" })
vim.keymap.set("n", "<leader>fr", require("fzf-lua").lsp_references, { desc = "[F]ind [R]eferences" })
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

function ToggleTerminal()
	if terminal_winid and vim.api.nvim_win_is_valid(terminal_winid) then
		vim.api.nvim_win_close(terminal_winid, true)
		terminal_winid = nil
	else
		vim.cmd("botright split")
		vim.cmd("resize 8") -- height of terminal
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

-- Buffers (with C-n and C-p for next/prev buffer)
vim.keymap.set("n", "<C-n>", ":bnext<CR>", { desc = "[B]uffer [N]ext" })
vim.keymap.set("n", "<C-p>", ":bprevious<CR>", { desc = "[B]uffer [P]revious" })
vim.keymap.set("n", "<C-x>", ":bdelete<CR>", { desc = "[B]uffer [D]elete" })

-- Resizing splits
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -5<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +5<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize -5<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +5<CR>", { desc = "Increase window height" })

-- Quickfix navigation
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Quickfix [N]ext" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Quickfix [P]revious" })

-- tab navigation
vim.keymap.set("n", "<M-h>", "<cmd>tabprevious<CR>", { desc = "Tab [P]revious" })
vim.keymap.set("n", "<M-l>", "<cmd>tabnext<CR>", { desc = "Tab [N]ext" })
vim.keymap.set("n", "<M-t>", "<cmd>tabnew<CR>", { desc = "New [T]ab" })
vim.keymap.set("n", "<M-x>", "<cmd>tabclose<CR>", { desc = "[X] Close Tab" })

-- re-run last command (save file and run last command)
vim.keymap.set("n", "<leader>.", ":w<CR>:!!<up><CR>", { desc = "[R]e-run last command" })

-- MDEval.nvim
vim.keymap.set("n", "<leader>rc", ":MdEval<CR>", { desc = "[M]arkdown [E]val Line" })

-- gS: Edit fenced code block in a separate scratch buffer (LSP enabled)
local function EditCodeBlockScratch()
	local src_buf = vim.api.nvim_get_current_buf()
	local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_get_lines(src_buf, 0, -1, false)

	local lang, start_idx, end_idx = nil, nil, nil

	-- Find code fence upward
	for i = cursor_line, 1, -1 do
		local fence = lines[i]:match("^```([%w%p]+)")
		if fence then
			lang = fence
			start_idx = i + 1
			break
		end
	end
	if not start_idx then
		vim.notify("Not inside a fenced code block", vim.log.levels.WARN)
		return
	end

	-- Find closing fence downward
	for i = start_idx + 1, #lines do
		if lines[i]:match("^```") then
			end_idx = i - 1
			break
		end
	end
	if not end_idx then
		vim.notify("Code block end not found", vim.log.levels.ERROR)
		return
	end

	local block_code = vim.list_slice(lines, start_idx, end_idx)

	-- Open scratch buffer
	vim.cmd("new")
	local edit_buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_option(edit_buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(edit_buf, "swapfile", false)
	vim.api.nvim_buf_set_option(edit_buf, "bufhidden", "wipe")

	if lang then
		vim.api.nvim_buf_set_option(edit_buf, "filetype", lang)
	end

	vim.api.nvim_buf_set_lines(edit_buf, 0, -1, false, block_code)

	-- On save / buffer leave → write changes back to markdown
	vim.api.nvim_create_autocmd({ "BufWritePost", "BufWinLeave" }, {
		buffer = edit_buf,
		once = true,
		callback = function()
			if not vim.api.nvim_buf_is_valid(src_buf) then return end
			if not vim.api.nvim_buf_is_valid(edit_buf) then return end

			local new_code = vim.api.nvim_buf_get_lines(edit_buf, 0, -1, false)
			vim.api.nvim_buf_set_lines(src_buf, start_idx, end_idx + 1, false, new_code)
		end,
	})
end

vim.keymap.set("n", "gS", EditCodeBlockScratch, {
	noremap = true,
	silent = true,
	desc = "Edit markdown fenced code block in scratch buffer"
})

-- gitsigns
vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "[G]it [H]unk [S]tage" })
vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "[G]it [H]unk [R]eset" })
vim.keymap.set("n", "<leader>ghp", ":Gitsigns preview_hunk<CR>", { desc = "[G]it [H]unk [P]review" })
vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "[G]it [H]unk [B]lame" })

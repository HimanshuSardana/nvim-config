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

-- code execution
function run_block()
	local bufnr      = vim.api.nvim_get_current_buf()
	local start_line = vim.fn.getpos("'<")[2]
	local end_line   = vim.fn.getpos("'>")[2]

	local lines      = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
	local code       = table.concat(lines, "\n")

	-- Detect language
	local lang       = lines[1]:match("```(%w+)")
	local cmd        = nil
	if lang == "python" then
		cmd = "uv run"
	elseif lang == "r" then
		cmd = "Rscript"
	end

	if cmd then
		local tmp = os.tmpname()
		local f = io.open(tmp, "w")
		f:write(code:gsub("```%w*", ""):gsub("```", "")) -- strip fences
		f:close()

		local output = vim.fn.system(cmd .. " " .. tmp)
		os.remove(tmp)

		local output_lines = vim.split(output, "\n", { plain = true })

		if vim.bo.filetype == "typst" then
			-- Wrap output inside #output()[ ... ]
			table.insert(output_lines, 1, "#output()[```txt")
			table.insert(output_lines, "```]")
		else
			-- Normal markdown fenced block
			table.insert(output_lines, 1, "```txt")
			table.insert(output_lines, "```")
		end

		vim.api.nvim_buf_set_lines(bufnr, end_line, end_line, false, output_lines)
	else
		print("Unsupported language: " .. tostring(lang))
	end
end

function RunSelectedCode()
	local bufnr = vim.api.nvim_get_current_buf()
	local ft = vim.bo.filetype
	local start_line = vim.fn.getpos("'<")[2] - 1
	local end_line = vim.fn.getpos("'>")[2]
	local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)
	local code = table.concat(lines, "\n")

	local cmd
	if ft == "python" then
		cmd = { "python3", "-c", code }
	elseif ft == "javascript" then
		cmd = { "node", "-e", code }
	elseif ft == "lua" then
		cmd = { "lua", "-e", code }
	elseif ft == "r" then
		cmd = { "Rscript", "-e", code }
	else
		vim.notify("Unsupported filetype: " .. ft, vim.log.levels.ERROR)
		return
	end

	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded",
	})

	vim.fn.jobstart(cmd, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stdout = function(_, data)
			if data then
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
			end
		end,
		on_stderr = function(_, data)
			if data and #data > 0 then
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
			end
		end,
	})
end

-- vim.api.nvim_set_keymap("v", "<leader>r", ":lua run_block()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<leader>r", ":lua RunSelectedCode()<CR>", { noremap = true, silent = true })
--
-- vim.api.nvim_set_keymap('n', '<leader>c',
-- 	"<cmd>lua require 'mdeval'.eval_code_block()<CR>",
-- 	{ silent = true, noremap = true })
--
-- -- vim.keymap.set("v", "<leader>r", ":TangleRunVisual<CR>")

function send_visual_to_ipython()
	local bufnr = vim.api.nvim_get_current_buf()
	local start_line = vim.fn.getpos("'<")[2] - 1
	local end_line = vim.fn.getpos("'>")[2]
	local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)

	for i, line in ipairs(lines) do
		local escaped = line:gsub('"', '\\"')
		os.execute(string.format('tmux send-keys -t 2 "%s"', escaped))
		os.execute('tmux send-keys -t 2 C-o')
		os.execute('tmux send-keys -t 2 down')
	end
	os.execute('tmux send-keys -t 2 ^?')
	os.execute('tmux send-keys -t 2 Enter')
end

vim.api.nvim_set_keymap("v", "<leader>r", ":lua send_visual_to_ipython()<CR>", { noremap = true, silent = true })

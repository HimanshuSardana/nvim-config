vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.cursorline = true
	end
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
	pattern = "*",
	callback = function()
		vim.opt.cursorline = false
	end
})

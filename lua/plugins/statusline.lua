return {
	{
		'echasnovski/mini.statusline',
		version = false,
		config = function()
			require('mini.statusline').setup({
				use_icons = false
			})
		end
	},
	{
		"christopher-francisco/tmux-status.nvim",
		lazy = true,
		opts = {},
	},
}

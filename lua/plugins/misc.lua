return {
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				filetypes = {
					"html",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"svelte",
					"vue",
					"tsx",
					"jsx",
				},
			})
		end,
	},

	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({
			})
		end
	}
}

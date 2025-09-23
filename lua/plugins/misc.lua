return {
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},
	{
		'nvim-mini/mini.ai',
		version = false,
		config = function()
			require('mini.ai').setup()
		end
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end
	},
	{
		"folke/snacks.nvim",
		config = function()
			require("snacks").setup()
		end
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		config = function()
			require("render-markdown").setup()
		end
	}
}

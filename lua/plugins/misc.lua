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
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end
	},
	{
		"jubnzv/mdeval.nvim",
		config = function()
			require("mdeval").setup({
				require_confirmation = false,
				eval_options = {
					R = {
						command = { "Rscript", "--vanilla" },
						language_code = "r",
						exec_type = "interpreted",
					},
					python = {
						command = { "uv run" },
					},
				}
			})
		end
	},
	{
		'chomosuke/typst-preview.nvim',
		lazy = false, -- or ft = 'typst'
		version = '1.*',
		opts = {}, -- lazy.nvim will implicitly calls `setup {}`
	},
	{
		"radioactivepb/hoverflex.nvim",
		opts = {
			disable_default_keybinds = false,
			keybinds = {
				buffer = "<leader>hb",
			}
		}
	},
	{
		"j-hui/fidget.nvim",
		opts = {}
	}
}

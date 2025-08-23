return {
	{
		"github/copilot.vim",
		-- config = function()
		-- 	require("copilot").setup()
		-- end
	}

}

-- return {
-- 	{
-- 		"supermaven-inc/supermaven-nvim",
-- 		config = function()
-- 			require("supermaven-nvim").setup({})
-- 		end,
-- 	},
-- 	{
-- 		"olimorris/codecompanion.nvim",
-- 		opts = {},
-- 		dependencies = {
-- 			"nvim-lua/plenary.nvim",
-- 			"nvim-treesitter/nvim-treesitter",
-- 		},
-- 		config = function(_, opts)
-- 			require("codecompanion").setup({
-- 				adapters = {
-- 					gemini = function()
-- 						return require("codecompanion.adapters").extend("gemini", {
-- 							env = {
-- 								api_key = "AIzaSyBWVX8Vd-YjUeHiPnKRkjVrw0ZjkbMR9ec",
-- 							},
-- 						})
-- 					end,
-- 				},
-- 				strategies = {
-- 					chat = {
-- 						adapter = "gemini",
-- 					},
-- 					inline = {
-- 						adapter = "gemini",
-- 					},
-- 				},
-- 			})
-- 		end,
-- 	},
-- }

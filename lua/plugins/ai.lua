return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "github/copilot.vim" },
		},
		build = "make tiktoken",
		opts = {
			prompts = {
				Rename = {
					prompt =
					"Rename the selected variable appropriately, considering the surrounding code context.",
					selection = function(source)
						local select = require('CopilotChat.select')
						return select.visual(source)
					end,
				},
			},
		},
		keys = {
			{ "<leader>cc",  "<cmd>CopilotChat<cr>",         mode = { "n", "v" }, desc = "Copilot Chat" },
			{ "<leader>cce", "<cmd>CopilotChatExplain<cr>",  mode = "v",          desc = "Copilot Chat: Explain" },
			{ "<leader>ccr", "<cmd>CopilotChatReview<cr>",   mode = "v",          desc = "Copilot Chat: Review" },
			{ "<leader>ccf", "<cmd>CopilotChatFix<cr>",      mode = "v",          desc = "Copilot Chat: Fix" },
			{ "<leader>cco", "<cmd>CopilotChatOptimize<cr>", mode = "v",          desc = "Copilot Chat: Optimize" },
			{ "<leader>ccd", "<cmd>CopilotChatDocs<cr>",     mode = "v",          desc = "Copilot Chat: Docs" },
		},
	},
}

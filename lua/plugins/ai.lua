return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
			{ "github/copilot.vim" },
		},
		build = "make tiktoken",
		opts = {

		},
	},
}

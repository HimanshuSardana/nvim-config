return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		require('fzf-lua').setup({ "ivy" })
		require('fzf-lua').register_ui_select()
	end
}

-- border-fused
-- borderless-full
-- borderless
-- default-prompt
-- default-title
-- default
-- fzf-native
-- fzf-tmux
-- fzf-vim
-- hide
-- ivy
-- max-perf
-- skim
-- telescope

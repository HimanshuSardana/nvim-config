return {
	"nvim-treesitter/nvim-treesitter",
	branch = 'master',
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require 'nvim-treesitter.configs'.setup {
			ensure_installed = { "c", "lua", "python" },
			auto_install = true,
			highlight = {
				enable = true
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<CR>',
					scope_incremental = '<CR>',
					node_incremental = '<TAB>',
					node_decremental = '<S-TAB>',
				},
			},
		}
	end
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		require("lspconfig").lua_ls.setup { capabilities = capabilities }
		-- python
		require("lspconfig").basedpyright.setup { capabilities = capabilities }

		-- typst
		require("lspconfig").tinymist.setup { capabilities = capabilities, formatterMode = "typstyle" }

		-- Configure native LSP diagnostics
		vim.diagnostic.config {
			virtual_text = true,
			signs = true,
			update_in_insert = false,
			underline = true,
			severity_sort = true,
		}
	end
}

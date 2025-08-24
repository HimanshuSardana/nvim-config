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
		require("lspconfig").basedpyright.setup { capabilities = capabilities }
		require("lspconfig").tinymist.setup { capabilities = capabilities, formatterMode = "typstyle" }
		require("lspconfig").tsserver.setup { capabilities = capabilities, init_options = { preferences = { importModuleSpecifierPreference = "non-relative", quotePreference = "single", }, }, }
		require("lspconfig").clangd.setup { capabilities = capabilities, filetypes = { "c", "cpp", "objc", "objcpp" }, cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" }, }
		require("lspconfig").marksman.setup { capabilities = capabilities, filetypes = { "markdown" }, }

		vim.diagnostic.config {
			virtual_text = true,
			signs = true,
			update_in_insert = false,
			underline = true,
			severity_sort = true,
		}
	end
}

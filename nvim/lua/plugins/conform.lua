return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				go = { "gofmt" },
				-- rust = { "rustfmt", lsp_format = "fallback" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters = {
				prettier = {
					prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
				},
				prettierd = {},
				stylua = {
					prepend_args = { "--indent-width", "2" },
				},
			},
		})
	end,
}

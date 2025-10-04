return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
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

		vim.keymap.set({ "n", "v" }, "<leader>gf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}

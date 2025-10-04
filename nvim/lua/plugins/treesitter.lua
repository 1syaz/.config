return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		-- dependencies = { "nvim-treesitter/nvim-treesitter-context" },
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				indent = { enable = true },
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"go",
					"yaml",
					"html",
					"css",
					"http",
					"prisma",
					"markdown",
					"markdown_inline",
					"svelte",
					"bash",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
					"query",
					"vimdoc",
					"c",
					"rust",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
					},
				},
				additional_vim_regex_highlighting = false,
			})
			-- Configure nvim-treesitter-context
			-- require("treesitter-context").setup({
			-- 	max_lines = 3, -- The number of context lines to display
			-- 	throttle = 100, -- Delay in milliseconds before updating
			-- 	patterns = {
			-- 		default = {
			-- 			"function",
			-- 			"for",
			-- 			"while",
			-- 			"if",
			-- 			"class",
			-- 			"method",
			-- 		},
			-- 	},
			-- })
		end,
	},
}

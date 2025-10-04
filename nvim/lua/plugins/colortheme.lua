return {
	{
		"xiantang/darcula-dark.nvim",
		lazy = true,
		config = function()
			require("darcula").setup({
				override = function()
					return {
						-- background = "#333333",
						-- dark = "#000000",
					}
				end,
				opt = {
					integrations = {
						telescope = false,
						lualine = true,
						lsp_semantics_token = true,
						nvim_cmp = true,
						dap_nvim = true,
					},
				},
			})

			-- vim.cmd("colorscheme darcula-dark")
		end,
	},
	{
		"ramojus/mellifluous.nvim",
		config = function()
			require("mellifluous").setup({}) -- optional, see configuration section.
			vim.cmd("colorscheme mellifluous")
		end,
	},
	{
		"vague2k/vague.nvim",
		config = function()
			require("vague").setup({
				transparent = false,
				italic = false,
				colors = {
					bg = "#0f0f0f",
				},
			})
			-- vim.cmd("colorscheme vague")
			-- vim.cmd("hi StatusLine guibg=NONE")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				compile = false,
				undercurl = true,
				commentStyle = { italic = false },
				functionStyle = {},
				keywordStyle = { italic = false },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true,
				dimInactive = false,
				terminalColors = true,
				colors = {
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				overrides = function()
					return {
						StatusLine = { bg = "NONE" },
						LineNr = { fg = "#5c6370", bg = "NONE" },
						SignColumn = { bg = "NONE" },
					}
				end,
				theme = "wave",
				background = {
					dark = "dragon",
					light = "lotus",
				},
			})
			-- vim.cmd("colorscheme kanagawa")
		end,
	},
	{
		"aktersnurra/no-clown-fiesta.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("no-clown-fiesta").setup({
				transparent = false,
			})
			-- vim.cmd.colorscheme("no-clown-fiesta")
			-- vim.cmd([[
			--            highlight DiagnosticVirtualTextError guifg=#ff0000 guibg=NONE
			--            highlight DiagnosticUnderlineError gui=undercurl guisp=#ff0000
			--            highlight DiagnosticSignError guifg=#ff0000 guibg=NONE
			--          ]])
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.o.background = "dark"
			require("gruvbox").setup({
				bold = false,
				contrast = "hard",
				italic = { strings = false, comments = true },
				transparent_mode = false,
				inverse = false,
				overrides = {
					Normal = { bg = "#161616" }, -- main editor background
					NormalNC = { bg = "#161616" },
					CursorLineNr = { fg = "#dda930", bg = "#2a2a2a", bold = true },
					CursorLine = { bg = "#2a2a2a" },
					SignColumn = { bg = "#161616" },
				},
			})
			-- vim.cmd.colorscheme("gruvbox")
		end,
	},
}

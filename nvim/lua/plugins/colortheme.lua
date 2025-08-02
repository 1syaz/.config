return {
	{
		"vague2k/vague.nvim",
		config = function()
			require("vague").setup({
				transparent = false,
				italic = false,
				colors = {
					bg = "#151515",
				},
			})
			vim.cmd("colorscheme vague")
			vim.cmd("hi StatusLine guibg=NONE")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = false },
				functionStyle = {},
				keywordStyle = { italic = false },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				overrides = function(colors) -- add/modify highlights
					return {}
				end,
				theme = "wave", -- Load "wave" theme
				background = { -- map the value of 'background' option to a theme
					dark = "dragon", -- try "dragon" !
					light = "lotus",
				},
			})
			-- vim.cmd("colorscheme kanagawa")
			vim.cmd("hi StatusLine guibg=NONE")
			vim.api.nvim_set_hl(0, "LineNr", { fg = "#5c6370", bg = "NONE" })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
		end,
	},
	{
		"aktersnurra/no-clown-fiesta.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("no-clown-fiesta").setup({
				transparent = false,
				styles = {
					comments = {},
					functions = {},
					keywords = {},
					lsp = {},
					match_paren = {},
					type = {},
					variables = {},
				},
			})
			-- vim.cmd.colorscheme("no-clown-fiesta")
			vim.cmd([[
              highlight DiagnosticVirtualTextError guifg=#ff0000 guibg=NONE
              highlight DiagnosticUnderlineError gui=undercurl guisp=#ff0000
              highlight DiagnosticSignError guifg=#ff0000 guibg=NONE
            ]])
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.o.background = "dark"
			-- inverse = true
			require("gruvbox").setup({
				bold = false,
				contrast = "hard",
				italic = { strings = false, comments = true },
				transparent_mode = false,
				inverse = false,
				overrides = {
					-- CursorLineNr = { fg = "#dda930", bg = "#2a2a2a", bold = true },
					-- CursorLine = { bg = "#2a2a2a" },
					-- SignColumn = { bg = "#1e2122" },
				},
				"",
			})
			-- vim.cmd.colorscheme("gruvbox")
		end,
	},
}

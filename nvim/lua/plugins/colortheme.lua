-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.o.background = "dark"
-- 		-- inverse = true
-- 		require("gruvbox").setup({
-- 			bold = false,
-- 			contrast = "hard",
-- 			italic = { strings = false, comments = true },
-- 			transparent_mode = false,
-- 			inverse = false,
-- 			overrides = {
-- 				CursorLineNr = { fg = "#dda930", bg = "#2a2a2a", bold = true },
-- 				CursorLine = { bg = "#2a2a2a" },
-- 				SignColumn = { bg = "#1e2122" },
-- 			},
-- 			"",
-- 		})
-- 		vim.cmd.colorscheme("gruvbox")
-- 	end,
-- }
--
return {
	"aktersnurra/no-clown-fiesta.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("no-clown-fiesta").setup({
			transparent = false, -- Enable this to disable the bg color
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
		vim.cmd.colorscheme("no-clown-fiesta")
		vim.cmd([[
  highlight DiagnosticVirtualTextError guifg=#ff0000 guibg=NONE
  highlight DiagnosticUnderlineError gui=undercurl guisp=#ff0000
  highlight DiagnosticSignError guifg=#ff0000 guibg=NONE
]])
	end,
}

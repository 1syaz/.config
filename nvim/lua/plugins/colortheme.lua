-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.o.background = "dark"
-- 		-- inverse = true
-- 		-- bold = true
-- 		require("gruvbox").setup({
-- 			contrast = "hard",
-- 			italic = { strings = false, comments = false },
-- 			transparent_mode = false,
-- 			inverse = true,
-- 			overrides = {
-- 				CursorLineNr = { fg = "#dda930", bg = "#2a2a2a", bold = true },
-- 				CursorLine = { bg = "#2a2a2a" },
-- 				SignColumn = { bg = "#1e2122" },
-- 			},''
-- 		})
-- 		vim.cmd.colorscheme("gruvbox")
-- 	end,
-- }

return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = "dark"
		require("gruvbox").setup({
			contrast = "hard",
			italic = { strings = false, comments = false },
			transparent_mode = false,
			overrides = {
				Normal = { bg = "#000000" },
				NormalNC = { bg = "#000000" },
				NormalFloat = { bg = "#000000" },
				FloatBorder = { bg = "#000000" },
				CursorLineNr = { fg = "#dda930", bg = "#1a1a1a", bold = true },
				CursorLine = { bg = "#1a1a1a" },
				SignColumn = { bg = "#000000" },
			},
		})
		vim.cmd.colorscheme("gruvbox")
	end,
}

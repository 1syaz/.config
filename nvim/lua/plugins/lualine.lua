return {
	"echasnovski/mini.statusline",
	version = "*",
	config = function()
		local statusline = require("mini.statusline")
		vim.g.ministatusline_disable = false
		statusline.setup({
			use_icons = true, -- keep it clean
			set_vim_settings = true,
		})

		-- Optional: only show right-side info (like in your screenshot)
		statusline.section_location = function()
			return string.format("%3d:%-2d", vim.fn.line("."), vim.fn.col("."))
		end
		statusline.section_fileinfo = function()
			local fsize = vim.fn.getfsize(vim.fn.expand("%:p")) or 0
			local kb = fsize > 0 and string.format("%.2fKiB", fsize / 1024) or ""
			local ft = vim.bo.filetype
			local enc = vim.bo.fileencoding
			local format = vim.bo.fileformat
			return string.format("%s %s[%s] %s", ft, enc, format, kb)
		end
	end,
}

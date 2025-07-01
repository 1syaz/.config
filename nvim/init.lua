require("core.options")
require("core.keymaps")
-- LAZY NVIM Package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
	-- yank highlight
	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank()
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
			vim.opt.formatoptions:remove({ "c", "r", "o" })
		end,
	})
end
vim.opt.rtp:prepend(lazypath)
--  To update plugins you can run
--    :Lazy update
--
--
-- NOTE: Here is where you install your plugins.

require("lazy").setup({
	require("plugins.colortheme"),
	require("plugins.oil"),
	require("plugins.treesitter"),
	require("plugins.formating"),
	require("plugins.misc"),
	require("plugins.dashboard"),
	-- require("plugins.bufferline"),
	require("plugins.mini"),
	-- require("plugins.lualine"),
	require("plugins.harpoon"),
	-- require("plugins.indent-blankline"),
	require("plugins.telescope"),
	require("plugins.lsp.lsp"),
})

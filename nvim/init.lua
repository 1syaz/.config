require("core.options")
require("core.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.colortheme"),
	require("plugins.misc"),
	require("plugins.oil"),
	require("plugins.telescope"),
	require("plugins.undotree"),
	require("plugins.treesitter"),
	require("plugins.conform"),
	require("plugins.mini"),
	require("plugins.nvim-cmp"),
	require("plugins.lsp.mason"),
	require("plugins.lsp.lsp"),
	require("plugins.linter"),
	require("plugins.harpoon"),
	require("plugins.zen"),
	require("plugins.wakatime"),
	-- require("plugins.gitstuff"),
})

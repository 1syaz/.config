-- return {
-- 	"cbochs/grapple.nvim",
-- 	dependencies = { "nvim-telescope/telescope.nvim" },
-- 	config = function()
-- 		require("telescope").load_extension("grapple")
--
-- 		vim.keymap.set("n", "<c-e>", "<cmd>Telescope grapple tags<cr>")
-- 		vim.keymap.set("n", "<leader>ha", "<cmd>Grapple tag<cr>")
-- 		vim.keymap.set("n", "<C-hh>", "<cmd>Grapple open_tags<cr>")
--
-- 		vim.keymap.set("n", "<C-hu>", "<cmd>Grapple select index=1<cr>")
-- 		vim.keymap.set("n", "<C-hi>", "<cmd>Grapple select index=2<cr>")
-- 		vim.keymap.set("n", "<C-ho>", "<cmd>Grapple select index=3<cr>")
-- 		vim.keymap.set("n", "<C-hp>", "<cmd>Grapple select index=4<cr>")
--
-- 		-- Toggle previous & next buffers
-- 		vim.keymap.set("n", "<C-hn>", "<cmd>Grapple cycle backward<cr>")
-- 		vim.keymap.set("n", "<C-hb>", "<cmd>Grapple cycle forward<cr>")
-- 	end,
-- }
return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)

		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "'a", function()
			harpoon:list():select(1)
		end)

		vim.keymap.set("n", "'s", function()
			harpoon:list():select(2)
		end)

		vim.keymap.set("n", "'d", function()
			harpoon:list():select(3)
		end)

		vim.keymap.set("n", "'f", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		-- vim.keymap.set("n", "<C-S-P>", function()
		-- 	harpoon:list():prev()
		-- end)
		--
		-- vim.keymap.set("n", "<C-S-N>", function()
		-- 	harpoon:list():next()
		-- end)
	end,
}

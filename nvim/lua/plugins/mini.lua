return {
	-- {
	--
	-- 	"echasnovski/mini.comment",
	-- 	version = false,
	-- 	dependencies = {
	-- 		"JoosepAlviste/nvim-ts-context-commentstring",
	-- 	},
	-- 	config = function()
	-- 		-- disable the autocommand from ts-context-commentstring
	-- 		require("ts_context_commentstring").setup({
	-- 			enable_autocmd = false,
	-- 		})
	--
	-- 		require("mini.comment").setup({
	-- 			-- tsx, jsx, html , svelte comment support
	-- 			options = {
	-- 				custom_commentstring = function()
	-- 					return require("ts_context_commentstring.internal").calculate_commentstring({
	-- 						key = "commentstring",
	-- 					}) or vim.bo.commentstring
	-- 				end,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"echasnovski/mini.surround",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- Add custom surroundings to be used on top of builtin ones. For more
			-- information with examples, see `:h MiniSurround.config`.
			custom_surroundings = nil,

			-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
			highlight_duration = 300,

			-- Module mappings. Use `''` (empty string) to disable one.
			-- INFO:
			-- saiw surround with no whitespace
			-- saw surround with whitespace
			mappings = {
				add = "<leader>ma", -- Add surround
				delete = "<leader>md", -- Delete surrounding
				find = "<leader>mf", -- Find surrounding
				find_left = "<leader>mF", -- Find surrounding to the left
				highlight = "<leader>mh", -- Highlight surrounding
				replace = "<leader>mr", -- Replace surrounding
				update_n_lines = "<leader>mn", -- Update n_lines

				suffix_last = "l",
				suffix_next = "n",
			},

			-- Number of lines within which surrounding is searched
			n_lines = 20,

			-- Whether to respect selection type:
			-- - Place surroundings on separate lines in linewise mode.
			-- - Place surroundings on each line in blockwise mode.
			respect_selection_type = false,

			-- How to search for surrounding (first inside current line, then inside
			-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
			-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
			-- see `:h MiniSurround.config`.
			search_method = "cover",

			-- Whether to disable showing non-error feedback
			silent = false,
		},
	},
	-- Get rid of whitespace
	{
		"echasnovski/mini.trailspace",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local miniTrailspace = require("mini.trailspace")

			miniTrailspace.setup({
				only_in_normal_buffers = true,
			})
			vim.keymap.set("n", "<leader>cw", function()
				miniTrailspace.trim()
			end, { desc = "Erase Whitespace" })

			-- Ensure highlight never reappears by removing it on CursorMoved
			vim.api.nvim_create_autocmd("CursorMoved", {
				pattern = "*",
				callback = function()
					require("mini.trailspace").unhighlight()
				end,
			})
		end,
	},
}

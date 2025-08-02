return {
	"akinsho/bufferline.nvim",
	version = "*",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				numbers = "none",
				close_command = "bdelete %d",
				right_mouse_command = "bdelete %d",
				indicator = { style = "none" },
				show_buffer_close_icons = true,
				show_close_icon = false,
				separator_style = "thin",
				diagnostics = "nvim_lsp",
				max_name_length = 18,
				tab_size = 15,
				custom_areas = {},
				offsets = {},
				always_show_bufferline = true,
				icons = false, -- removes filetype icons
				buffer_close_icon = "×", -- close icon like VSCode
			},
		})
	end,
}

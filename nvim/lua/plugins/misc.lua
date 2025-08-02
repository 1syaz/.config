return {
{
		-- Tmux & split window navigation
		"christoomey/vim-tmux-navigator",
	},
    {
        	-- Autoclose parentheses, brackets, quotes, etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
    },
{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
				per_filetype = {
					html = {
						enable_close = true,
					},
				},
			})
		end,
	},
    "roobert/tailwindcss-colorizer-cmp.nvim",
    {
        "NvChad/nvim-colorizer.lua",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
        config = function()
            local nvchadcolorizer = require("colorizer")
            local tailwindcolorizer = require("tailwindcss-colorizer-cmp")

            nvchadcolorizer.setup({
                user_default_options = {
                    tailwind = true,
                },
                filetypes = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" },
            })

            tailwindcolorizer.setup({
                color_square_width = 2,
            })

            vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
                callback = function()
                    vim.cmd("ColorizerAttachToBuffer")
                end,
            })

        end,
    },
    -- NOTE: js,ts,jsx,tsx Auto Close Tags
    {
        "windwp/nvim-ts-autotag",
        enabled = true,
        ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
        config = function()
            -- Independent nvim-ts-autotag setup
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true,           -- Auto-close tags
                    enable_rename = true,          -- Auto-rename pairs
                    enable_close_on_slash = false, -- Disable auto-close on trailing `</`
                },
                per_filetype = {
                    ["html"] = {
                        enable_close = true, -- Disable auto-closing for HTML
                    },
                    ["typescriptreact"] = {
                        enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
                    },
                },
            })
        end,
    },
}
-- {
-- 		-- High-performance color highlighter
-- 		"norcalli/nvim-colorizer.lua",
-- 		config = function()
-- 			require("colorizer").setup()
-- 		end,
-- 	}

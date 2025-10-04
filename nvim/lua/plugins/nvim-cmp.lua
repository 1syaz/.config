return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- autocompletion
		"rafamadriz/friendly-snippets", -- snippets
		"nvim-treesitter/nvim-treesitter",
		"onsails/lspkind.nvim", -- vs-code pictograms
		"roobert/tailwindcss-colorizer-cmp.nvim",
	},
	opts = {
		performance = {
			debounce = 0,
			throttle = 0,
		},
	},
	config = function()
		local cmp = require("cmp")
		local _, luasnip = pcall(require, "luasnip")
		local lspkind = require("lspkind")
		local colorizer = require("tailwindcss-colorizer-cmp").formatter

		local lsp_kinds = {
			Class = " ",
			Color = " ",
			Constant = " ",
			Constructor = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Folder = " ",
			Function = " ",
			Interface = " ",
			Keyword = " ",
			Method = " ",
			Module = " ",
			Operator = " ",
			Property = " ",
			Reference = " ",
			Snippet = " ",
			Struct = " ",
			Text = " ",
			TypeParameter = " ",
			Unit = " ",
			Value = " ",
			Variable = " ",
		}

		local select_next_item = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end

		local select_prev_item = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end

		local confirm = function(entry)
			local behavior = cmp.ConfirmBehavior.Replace
			if entry then
				local completion_item = entry.completion_item
				local newText = ""
				if completion_item.textEdit then
					newText = completion_item.textEdit.newText
				elseif type(completion_item.insertText) == "string" and completion_item.insertText ~= "" then
					newText = completion_item.insertText
				else
					newText = completion_item.word or completion_item.label or ""
				end

				-- checks how many characters will be different after the cursor position if we replace?
				local diff_after = math.max(0, entry.replace_range["end"].character + 1) - entry.context.cursor.col

				-- does the text that will be replaced after the cursor match the suffix
				-- of the `newText` to be inserted ? if not, then `Insert` instead.
				if entry.context.cursor_after_line:sub(1, diff_after) ~= newText:sub(-diff_after) then
					behavior = cmp.ConfirmBehavior.Insert
				end
			end
			cmp.confirm({ select = true, behavior = behavior })
		end

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			preselect = cmp.PreselectMode.None,
			window = {
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
				completion = {
					border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
				},
			},
			-- config nvim cmp to work with snippet engine
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			-- autocompletion sources
			sources = cmp.config.sources({
				{ name = "luasnip" }, -- snippets
				{ name = "nvim_lsp" },
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
				{ name = "tailwindcss-colorizer-cmp" },
			}),

			mapping = cmp.mapping.preset.insert({
				["<C-e>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.abort()
					else
						cmp.complete()
					end
				end, { "i", "c" }),

				["<C-d>"] = cmp.mapping(function()
					cmp.close_docs()
				end, { "i", "s" }),

				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-n>"] = cmp.mapping(select_next_item),
				["<C-p>"] = cmp.mapping(select_prev_item),

				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						local entry = cmp.get_selected_entry()
						confirm(entry)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			formatting = {
				format = function(entry, vim_item)
					-- Add custom lsp_kinds icons
					vim_item.kind = string.format("%s %s", lsp_kinds[vim_item.kind] or "", vim_item.kind)

					-- add menu tags (e.g., [Buffer], [LSP])
					vim_item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[LaTeX]",
					})[entry.source.name]

					-- use lspkind and tailwindcss-colorizer-cmp for additional formatting
					vim_item = lspkind.cmp_format({
						maxwidth = 25,
						ellipsis_char = "...",
					})(entry, vim_item)

					if entry.source.name == "nvim_lsp" then
						vim_item = colorizer(entry, vim_item)
					end

					return vim_item
				end,
			},
		})
	end,
}

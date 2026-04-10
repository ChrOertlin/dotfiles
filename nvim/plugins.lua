vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	-- { src = ""},
	-- { src = ""},
	-- { src = ""},
	-- { src = ""},
	-- { src = ""},
	-- { src = ""},
	-- { src = ""},
	-- { src = ""},
	-- { src = ""},
})

vim.cmd.colorscheme("catppuccin-mocha")

-- Mason
--
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Mason installer
--
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"gopls",
		"jsonls",
		"stylua",
		"prettier",
		"pyright",
		"bashls",
	},
})

-- LSP config
--
vim.lsp.config("pyright", {
	settings = {
		pyright = {
			include = { "./*" },
			exclude = { "**/node_modules", "**/__pycache__" },
			typeCheckingMode = "basic",
			reportMissingImports = true,
			reportMissingTypeStubs = false,
		},
		python = {
			analysis = {
				-- Additional settings can go here
			},
		},
	},
	capabilities = capabilities,
	require_workspace = true,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config("gopls", {
	settings = {
		gopls = {
			staticcheck = true,
			gofumpt = true,
		},
	},
})

-- Mason LSPconfig
--
require("mason-lspconfig").setup({
	automatic_enable = true,
})

-- Lualine
--
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

-- Telescope
--
require("telescope").setup({
	defaults = {
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = " ",
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
			},
			width = 0.87,
			height = 0.80,
		},
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
	},

	extensions_list = { "themes", "terms" },
	extensions = {},
})

-- Treesitter
--
local ts_parsers = {
	"bash",
	"dockerfile",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"json",
	"toml",
	"yaml",
	"lua",
	"make",
	"markdown",
	"python",
	"terraform",
	"vim",
	"vimdoc",
}

local nts = require("nvim-treesitter")
nts.install(ts_parsers)
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function()
		nts.update()
	end,
})

require("treesitter-context").setup({
	max_lines = 3,
	multiline_threshold = 1,
	separator = "-",
	min_window_height = 20,
	line_numbers = true,
})

vim.api.nvim_create_autocmd("FileType", { -- enable treesitter highlighting and indents
	callback = function(args)
		local filetype = args.match
		local lang = vim.treesitter.language.get_lang(filetype)
		if vim.treesitter.language.add(lang) then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			vim.treesitter.start()
		end
	end,
})

-- Nvim tree
--
require("nvim-tree").setup({
	filters = { dotfiles = false, custom = { "build" } },
	disable_netrw = true,
	hijack_cursor = true,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	view = {
		width = 30,
		preserve_window_proportions = true,
	},
	renderer = {
		root_folder_label = false,
		highlight_git = true,
		indent_markers = { enable = true },
		icons = {
			glyphs = {
				default = "󰈚",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
				},
				git = { unmerged = "" },
			},
		},
	},
})

-- Autopairs
--
require("nvim-autopairs").setup({
	enabled = function(bufnr)
		return true
	end, -- control if auto-pairs should be enabled when attaching to a buffer
	disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
	disable_in_macro = true, -- disable when recording or executing a macro
	disable_in_visualblock = false, -- disable when insert after visual block mode
	disable_in_replace_mode = true,
	ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
	enable_moveright = true,
	enable_afterquote = true, -- add bracket pairs after quote
	enable_check_bracket_line = true, --- check bracket in same line
	enable_bracket_in_quote = true, --
	enable_abbr = false, -- trigger abbreviation
	break_undo = true, -- switch for basic rule break undo sequence
	check_ts = false,
	map_cr = true,
	map_bs = true, -- map the <BS> key
	map_c_h = false, -- Map the <C-h> key to delete a pair
	map_c_w = false, -- map <c-w> to delete a pair if possible
})

-- Conform
--
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "ruff", "black" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

vim.pack.add {
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/mason-org/mason.nvim"},
    { src = "https://github.com/neovim/nvim-lspconfig"},
    { src = "https://github.com/mason-org/mason-lspconfig.nvim"},
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"},
    { src = "https://github.com/kdheepak/lazygit.nvim"},
    { src = "https://github.com/nvim-lualine/lualine.nvim"},
    { src = "https://github.com/nvim-lua/plenary.nvim"},
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"},
    { src = "https://github.com/nvim-telescope/telescope.nvim"},
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context", },
    -- { src = ""},
    -- { src = ""},
    -- { src = ""},
    -- { src = ""},
    -- { src = ""},
    -- { src = ""},
    -- { src = ""},
    -- { src = ""},
    -- { src = ""},
    -- { src = ""},
    -- { src = ""},
    -- { src = ""},
}

vim.cmd.colorscheme "catppuccin-mocha"

-- Mason
--
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Mason installer
--
require('mason-tool-installer').setup({
  ensure_installed = {
    'lua_ls',
    'gopls',
    'jsonls',
    'stylua',
    'prettier',
    'pyright',
    'bashls',
  },
})


-- LSP config
--
vim.lsp.config('pyright', {
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

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config('gopls', {
  settings = {
    gopls = {
      staticcheck = true,
      gofumpt = true,
    },
  },
})

-- Mason LSPconfig
--
require('mason-lspconfig').setup({
  automatic_enable = true,
})

-- Lualine
--
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
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
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- Telescope
--
require("telescope").setup(
    {
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
  "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
  "go", "gomod", "gosum",
  "json", "toml", "yaml",
  "lua",
  "make",
  "markdown",
  "python",
  "terraform",
  "vim", "vimdoc",
}

local nts = require("nvim-treesitter")
nts.install(ts_parsers)
vim.api.nvim_create_autocmd('PackChanged', { 
    callback = function()
        nts.update()
    end
})

require("treesitter-context").setup({
  max_lines = 3,
  multiline_threshold = 1,
  separator = '-',
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
  end
})

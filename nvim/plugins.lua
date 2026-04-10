vim.pack.add{ 
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/mason-org/mason.nvim"},
    { src = "https://github.com/neovim/nvim-lspconfig"},
    { src = "https://github.com/mason-org/mason-lspconfig.nvim"},
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"},
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

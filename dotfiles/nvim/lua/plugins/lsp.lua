return {
    {
        "mason-org/mason.nvim",
        tag = "v1.11.0",
        pin = true,
        lazy = false,
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        tag = "v1.32.0",
        pin = true,
        lazy = true,
        config = false,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        tag = "v1.8.0",
        pin = true,
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "mason-org/mason.nvim" },
            { "mason-org/mason-lspconfig.nvim" },
        },
        init = function()
            vim.opt.signcolumn = "yes"
        end,
        config = function()
            local lsp_defaults = require("lspconfig").util.default_config
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Ensure workspace capabilities are enabled
            capabilities.workspace = {
                workspaceFolders = true,
            }

            lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, capabilities)

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    "clangd",
                    "lua_ls",
                },
                handlers = {
                    -- Default handler for all servers
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                            require_workspace = true,
                        })
                    end,
                    -- Custom handler for pyright
                    ["pyright"] = function()
                        require("lspconfig").pyright.setup({
                            settings = {
                                pyright = {
                                    include = { "./*" }, -- Include only the root directory
                                    exclude = { "**/node_modules", "**/__pycache__" },
                                    typeCheckingMode = "basic",
                                    reportMissingImports = true,
                                    reportMissingTypeStubs = false,
                                },
                                python = {
                                    analysis = {
                                        -- Additional settings can be added here
                                    },
                                },
                            },
                            capabilities = capabilities,
                            require_workspace = true,
                        })
                    end,
                },
            })
        end,
    },
}

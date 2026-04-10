return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    cond = vim.fn.getcwd() == vim.fn.expand("~/Documents/notes/orange"),
    opts = function() return require "configs.obsidian" end,
}

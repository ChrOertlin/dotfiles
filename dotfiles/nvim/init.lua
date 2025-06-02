vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("configs.lazy")
require("lazy").setup({
	{ "nvim-treesitter/nvim-treesitter", branch = "master", lazy = false, build = ":TSUpdate" },
})
require("options")
require("mappings")

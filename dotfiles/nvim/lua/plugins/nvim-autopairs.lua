return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = true,
	opts = function()
		require("configs.nvim-autopairs")
	end,
}

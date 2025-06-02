return {
	"akinsho/bufferline.nvim",
	config = function()
		local bufferline = require("bufferline")
		require("bufferline").setup({
			options = {
				style_preset = bufferline.style_preset.minimal,
				indicator = {
					style = "underline",
				},
				separator_style = "thin",
				always_show_bufferline = true,
				diagnostics = "nvim_lsp",
				themable = true,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
					},
				},
			},
		})
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end
	end,
}

return {
	"danymat/neogen",
	cmd = "Neogen",
	keys = {
		{
			"<leader>n",
			function()
				require("neogen").generate({ annotation_convention = { python = "google_docstrings" } })
			end,
			desc = "Generate Annotations (Neogen)",
		},
	},
	opts = { snippet_engine = "nvim" },
}

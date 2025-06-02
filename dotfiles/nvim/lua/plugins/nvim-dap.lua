return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dap_python = require("dap-python")

			require("dapui").setup({})
			require("nvim-dap-virtual-text").setup({
				commented = true, -- Show virtual text alongside comment
			})

			dap_python.setup("python3")
			dap_python.test_runner = "pytest"

			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointRejected", {
				text = "", -- or "❌"
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapStopped", {
				text = "", -- or "→"
				texthl = "DiagnosticSignWarn",
				linehl = "Visual",
				numhl = "DiagnosticSignWarn",
			})

			-- Automatically open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			-- Test function
			vim.keymap.set("n", "<leader>dm<CR>", function()
				dap_python.test_method()
			end, { noremap = true, silent = true, desc = "Test Function" })

			-- Toggle breakpoint
			vim.keymap.set("n", "<leader>dc", function()
				dap.toggle_class()
			end, { noremap = true, silent = true, desc = "Test Class" })

			-- Toggle breakpoint
			vim.keymap.set("n", "<leader>db", function()
				dap.toggle_breakpoint()
			end, { noremap = true, silent = true, desc = "Toggle Breakpoint" })

			-- Continue / Start
			vim.keymap.set("n", "<leader>ds", function()
				dap.continue()
			end, { noremap = true, silent = true, desc = "Continue / Start" })

			-- Step Over
			vim.keymap.set("n", "<leader>do", function()
				dap.step_over()
			end, { noremap = true, silent = true, desc = "Step Over" })

			-- Step Into
			vim.keymap.set("n", "<leader>di", function()
				dap.step_into()
			end, { noremap = true, silent = true, desc = "Step Into" })

			-- Step Out
			vim.keymap.set("n", "<leader>dO", function()
				dap.step_out()
			end, { noremap = true, silent = true, desc = "Step out" })

			-- Keymap to terminate debugging
			vim.keymap.set("n", "<leader>dq", function()
				require("dap").terminate()
			end, { noremap = true, silent = true, desc = "Terminate" })

			-- Toggle DAP UI
			vim.keymap.set("n", "<leader>du", function()
				dapui.toggle()
			end, { noremap = true, silent = true, desc = "Toggle Debug UI" })
		end,
	},
}

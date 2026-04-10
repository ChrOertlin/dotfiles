local setkey = vim.keymap.set
--- General
setkey("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
setkey("i", "<C-e>", "<End>", { desc = "move end of line" })
setkey("i", "<C-h>", "<Left>", { desc = "move left" })
setkey("i", "<C-l>", "<Right>", { desc = "move right" })
setkey("i", "<C-j>", "<Down>", { desc = "move down" })
setkey("i", "<C-k>", "<Up>", { desc = "move up" })

setkey("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
setkey("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
setkey("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
setkey("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

setkey("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

setkey("n", "<C-s>", "<cmd>w<CR>", { desc = "File save" })
setkey("n", "<C-c>", "<cmd>%y+<CR>", { desc = "File copy all" })

--- Split window
setkey("n", "<leader>sv", "<C-w>v", { desc = "Split window vertical" })
setkey("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontal" })
setkey("n", "<leader>se", "<C-w>=", { desc = "Split make equal width" })
setkey("n", "<leader>sx", ":close<CR>", { desc = "Split close current split" })

--- LSP
---
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		map("n", "K", vim.lsp.buf.hover, "LSP Hover")
		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
		map("n", "gr", vim.lsp.buf.references, "References")
		map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, "Format buffer")
	end,
})

-- Lazygit
--
setkey("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

--- Telescope mappings
local telescope_builtin = require("telescope.builtin")
setkey("n", "<leader>ff", telescope_builtin.find_files, { desc = "Telescope find files" })
setkey("n", "<leader>fs", telescope_builtin.live_grep, { desc = "Telescope live grep" })
setkey("n", "<leader>fg", telescope_builtin.git_files, { desc = "Telescope git files" })

--- nvimtree

local nvimTreeFocusOrToggle = function()
	local nvimTree = require("nvim-tree.api")
	local currentBuf = vim.api.nvim_get_current_buf()
	local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
	if currentBufFt == "NvimTree" then
		nvimTree.tree.toggle()
	else
		nvimTree.tree.focus()
	end
end

setkey("n", "<leader>e", nvimTreeFocusOrToggle, { desc = "nvimtree focus window" })

--- enable diagnostics
local diagnostic_enabled = true
local border_highlight_enabled = true

local function toggle_diagnostic_float()
	diagnostic_enabled = not diagnostic_enabled
	if diagnostic_enabled then
		vim.cmd([[
      autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, max_width=80})
    ]])
	else
		vim.cmd([[autocmd! CursorHold,CursorHoldI]])
	end
end

local function toggle_border_highlight()
	border_highlight_enabled = not border_highlight_enabled
	if border_highlight_enabled then
		vim.cmd([[
      autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335
    ]])
	else
		vim.cmd([[autocmd! ColorScheme]])
		vim.cmd([[highlight FloatBorder guifg=NONE guibg=NONE]])
	end
end

-- Set up key mappings
setkey("n", "<leader>sd", "", {
	noremap = true,
	silent = true,
	callback = function()
		toggle_diagnostic_float()
		toggle_border_highlight()
	end,
})

-- DAP
--
local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")
-- Tests
setkey("n", "<leader>dm", function()
	dap_python.test_method()
end, { desc = "Test Function" })

setkey("n", "<leader>dc", function()
	dap.toggle_class()
end, { desc = "Test Class" })

-- Breakpoints
setkey("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

-- Debug flow
setkey("n", "<leader>ds", function()
	dap.continue()
end, { desc = "Continue / Start" })

setkey("n", "<leader>do", function()
	dap.step_over()
end, { desc = "Step Over" })

setkey("n", "<leader>di", function()
	dap.step_into()
end, { desc = "Step Into" })

setkey("n", "<leader>dO", function()
	dap.step_out()
end, { desc = "Step Out" })

setkey("n", "<leader>dq", function()
	dap.terminate()
end, { desc = "Terminate" })

-- UI
setkey("n", "<leader>du", function()
	dapui.toggle()
end, { desc = "Toggle Debug UI" })

-- Copilot chat
--
local chat = require("CopilotChat")
setkey("n", "<leader>cco", function()
	chat.open()
end, { desc = "CP Open" })
setkey("n", "<leader>ccq", function()
	chat.close()
end, { desc = "CP Close" })
setkey("n", "<leader>ccr", function()
	chat.reset()
end, { desc = "CP Reset" })
setkey("n", "<leader>ccs", function()
	chat.stop()
end, { desc = "CP Stop" })

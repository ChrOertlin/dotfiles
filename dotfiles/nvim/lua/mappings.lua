--- File for assigned mappings
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

--- Tabs
setkey("n", "<leader>to", ":tabnew<CR>", { desc = "Tab open new" })
setkey("n", "<leader>tx", ":tabclose<CR>", { desc = "Tab close current" })
setkey("n", "<leader>tn", ":tabn<CR>", { desc = "Tab go next" })
setkey("n", "<leader>tp", ":tabp<CR>", { desc = "Tab go previous" })
--- Telescope mappings
local telescope_builtin = require("telescope.builtin")
setkey("n", "<leader>ff", telescope_builtin.find_files, { desc = "Telescope find files" })
setkey("n", "<leader>fs", telescope_builtin.live_grep, { desc = "Telescope live grep" })
setkey("n", "<leader>fg", telescope_builtin.git_files, { desc = "Telescope git files" })
setkey("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Telescope git commits" })
setkey("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope git status" })

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
setkey('n', '<leader>sd', '', {
    noremap = true,
    silent = true,
    callback = function()
        toggle_diagnostic_float()
        toggle_border_highlight()
    end
})

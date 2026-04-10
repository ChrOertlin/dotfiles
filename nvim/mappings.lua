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

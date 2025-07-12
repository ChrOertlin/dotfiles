--- nvim options file
local d = vim.diagnostic
local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- options ------------------------------------------
--- Cursor blinking
o.guicursor = "a:blinkwait700-blinkoff400-blinkon240-Cursor/lCursor"

--- Scrolloff
o.scrolloff = 10

o.laststatus = 3
o.showmode = false

o.swapfile = false
o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "both"

-- Indenting
o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4
o.autoindent = true

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.relativenumber = true
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.termguicolors = true
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

d.config({
    underline = false,
    virtual_text = false, -- Turn off inline diagnostics
    float = {
        border = {
            { "╔", "FloatBorder" },
            { "═", "FloatBorder" },
            { "╗", "FloatBorder" },
            { "║", "FloatBorder" },
            { "╝", "FloatBorder" },
            { "═", "FloatBorder" },
            { "╚", "FloatBorder" },
            { "║", "FloatBorder" }
        },
        source = "always",
        update_in_insert = true,
        severity_sort = true,
    },
})

o.updatetime = 250

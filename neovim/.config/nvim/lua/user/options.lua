local options = {
    backup = true,
    clipboard = "unnamedplus",
    completeopt = { "menuone", "noselect" },
    cursorline = true,
    expandtab = true,
    fileencoding = "utf-8",
    ignorecase = true,
    mouse = "a",
    number = true,
    pumheight = 10,
    scrolloff = 8,
    shiftround = true,
    shiftwidth = 4,
    showmode = false,
    sidescrolloff = 8,
    signcolumn = "yes",
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    tabstop = 4,
    termguicolors = true,
    undofile = true,
    wrap = false,
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions=cro]]) -- TODO: This doesn't seem to work

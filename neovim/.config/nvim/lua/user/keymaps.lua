local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Remap space as leader key.
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"

-- Normal --
-- Better window navigation.
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)

-- Dealing with word wrap.
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Navigate buffers.
vim.api.nvim_set_keymap("n", "<Leader>bd", ":bdelete<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>bn", ":bnext<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>bp", ":bprevious<CR>", opts)

-- Save file.
vim.keymap.set("n", "<Leader>fs", ":write<CR>", opts)

-- Insert --
-- Press jk to exit insert mode.
vim.api.nvim_set_keymap("i", "jk", "<Esc>", opts)

-- Visual --
-- Stay in indent mode.
vim.api.nvim_set_keymap("v", "<", "<gv", opts)
vim.api.nvim_set_keymap("v", ">", ">gv", opts)

-- Terminal --
-- Better teminal navigation.
vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

vim.api.nvim_set_keymap(
    "n",
    "<Leader>f",
    "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>",
    opts
)
vim.api.nvim_set_keymap("n", "<C-t>", "<cmd>Telescope live_grep<CR>", opts)

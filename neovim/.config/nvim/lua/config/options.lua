-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
}

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.backup = true
  vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
end

-- disable some extension providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

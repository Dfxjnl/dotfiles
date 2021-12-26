vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {
    'wbthomason/packer.nvim',
    opt = true,
  }
  use 'lewis6991/impatient.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use 'Mofiqul/dracula.nvim'
end)

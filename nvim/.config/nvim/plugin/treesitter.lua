local ts_configs = require 'nvim-treesitter.configs'
ts_configs.setup {
  ensure_intalled = 'maintained',
  highlight = {
    enable = true,
    use_languagetree = true,
  },
}

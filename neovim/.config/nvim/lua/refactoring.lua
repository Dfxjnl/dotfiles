return {
  {
    "ThePrimeagen/refactoring.nvim",
    opts = {},
    config = function(_, opts)
      local refactoring = require("refactoring")

      refactoring.setup(opts)
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}

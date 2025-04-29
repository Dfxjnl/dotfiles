return {
  "folke/snacks.nvim",
  opts = {
    -- show hidden files in snacks.explorer
    picker = {
      sources = {
        explorer = {
          -- show hidden files like .env
          hidden = true,
        },
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
}

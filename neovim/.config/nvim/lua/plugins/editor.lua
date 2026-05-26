return {
  "folke/snacks.nvim",
  opts = {
    -- show hidden files in snacks.explorer
    picker = {
      sources = {
        explorer = {
          hidden = true,
        },
        files = {
          hidden = true,
        },
        grep = {
          hidden = true,
        },
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    config = true,
  },
}

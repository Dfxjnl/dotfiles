return {
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mapping = { "jk" },
      })
    end,
  },
  {
    -- add folding range to capabilities
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
    },
  },
}

return {
  {
    -- auto-resize windows
    "anuvyklack/windows.nvim",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = false },
    },
    keys = { { "<Leader>m", "<cmd>WindowsMaximize<CR>", desc = "Zoom" } },
    config = function()
      vim.o.winwidth = 5
      vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = false, duration = 150 },
      })
    end,
  },
}

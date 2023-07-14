return {
  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<CR>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<Leader>sR",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },
}

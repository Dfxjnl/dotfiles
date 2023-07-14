return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "cmake",
        "cpp",
        "gitignore",
        "json",
        "json5",
        "jsonc",
        "lua",
        "luap",
        "markdown",
        "markdown_inline",
        "yaml",
      },
      matchup = {
        enable = true,
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        line_events = { "BufWrite", "CursorHold" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    opts = { mode = "cursor" },
  },
}

local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = { "c", "cpp", "lua" },
    sync_install = false,
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true },
})

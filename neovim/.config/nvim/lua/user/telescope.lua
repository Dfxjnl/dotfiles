local status_ok, telescope = pcall(require, "telescope")

if not status_ok then
    return
end

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
        },
    },
})

telescope.load_extension("fzf")

vim.keymap.set("n", "<Leader>/", require("telescope.builtin").live_grep, { desc = "[/] Seach by grep" })
vim.keymap.set("n", "<Leader>f", require("telescope.builtin").find_files, { desc = "[F]ind Files" })
vim.keymap.set("n", "<Leader>K", require("telescope.builtin").help_tags, { desc = "[K] Search Help" })
vim.keymap.set("n", "<Leader>x", require("telescope.builtin").diagnostics, { desc = "[x] Search Diagnostics" })

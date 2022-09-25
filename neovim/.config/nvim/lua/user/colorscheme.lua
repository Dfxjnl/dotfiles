local dracula = require("dracula")

dracula.setup({
    show_end_of_buffer = true,
    italic_comment = true,
})

local colorscheme = "dracula"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

vim.api.nvim_set_keymap('n', "<C-a>", "<plug>(dial-increment)", {
  noremap = false,
  silent = true,
})
vim.api.nvim_set_keymap('n', "<C-x>", "<plug>(dial-decrement)", {
  noremap = false,
  silent = true,
})

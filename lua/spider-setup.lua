vim.keymap.set(
  { "n", "o", "x" },
  "<space>w",
  "<cmd>lua require('spider').motion('w')<CR>",
  { desc = "Spider-w" }
)
vim.keymap.set(
  { "n", "o", "x" },
  "<space>e",
  "<cmd>lua require('spider').motion('e')<CR>",
  { desc = "Spider-e" }
)
vim.keymap.set(
  { "n", "o", "x" },
  "<space>b",
  "<cmd>lua require('spider').motion('b')<CR>",
  { desc = "Spider-b" }
)


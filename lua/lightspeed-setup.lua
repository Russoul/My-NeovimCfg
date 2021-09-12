vim.api.nvim_set_keymap('n', '<space><space>l', "<cmd>HopLine<cr>", {})
vim.api.nvim_set_keymap('n', '<space><space>w', "<cmd>HopWord<cr>", {})
vim.api.nvim_set_keymap('n', '<space><space>c1', "<cmd>HopChar1<cr>", {})
vim.api.nvim_set_keymap('n', '<space><space>c2', "<cmd>HopChar2<cr>", {})
vim.api.nvim_set_keymap('n', '<space><space>/', "<cmd>HopPattern<cr>", {})

function repeat_ft(reverse)
  local ls = require'lightspeed'
  ls.ft['instant-repeat?'] = true
  ls.ft:to(reverse, ls.ft['prev-t-like?'])
end

vim.api.nvim_set_keymap('n', ';', '<cmd>lua repeat_ft(false)<cr>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', ';', '<cmd>lua repeat_ft(false)<cr>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', ',', '<cmd>lua repeat_ft(true)<cr>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', ',', '<cmd>lua repeat_ft(true)<cr>',
                        {noremap = true, silent = true})


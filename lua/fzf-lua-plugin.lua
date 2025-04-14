return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({})

    vim.cmd [[nnoremap <silent> <C-x>cc :lua require('fzf-lua.providers.nvim').commands({actions = {enter = require('fzf-lua.actions').ex_run_cr}})<CR>]]
    vim.cmd [[cnoremap <silent> <C-x>cc :lua require('fzf-lua.providers.nvim').commands({actions = {enter = require('fzf-lua.actions').ex_run_cr}})<CR>]]
    vim.cmd [[tnoremap <silent> <C-x>cc :lua require('fzf-lua.providers.nvim').commands({actions = {enter = require('fzf-lua.actions').ex_run_cr}})<CR>]]

    vim.cmd [[nnoremap <silent> <C-x>ll :FzfLua live_grep<CR>]]
    vim.cmd [[cnoremap <silent> <C-x>ll :FzfLua live_grep<CR>]]
    vim.cmd [[tnoremap <silent> <C-x>ll <C-\><C-n>:FzfLua live_grep<CR>]]

    vim.cmd [[noremap <silent> <C-x>b :FzfLua buffers<CR>]]
    vim.cmd [[cnoremap <silent> <C-x>b :FzfLua buffers<CR>]]
    vim.cmd [[tnoremap <silent> <C-x>b <C-\><C-n>:FzfLua buffers<CR>]]

    vim.cmd [[nnoremap <silent> <C-x>ff :FzfLua files<CR>]]
    vim.cmd [[cnoremap <silent> <C-x>ff :FzfLua files<CR>]]
    vim.cmd [[tnoremap <silent> <C-x>ff <C-\><C-n>:FzfLua files<CR>]]
  end
}

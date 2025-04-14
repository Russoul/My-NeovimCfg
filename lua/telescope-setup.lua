local actions = require('telescope.actions')
local actions_layout = require('telescope.actions.layout')

require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ["i"] = actions.move_selection_previous,
        ["k"] = actions.move_selection_next,
        ["x"] = actions.remove_selection,
        ["<C-p>"] = actions_layout.toggle_preview,
        ['<C-d>'] = require('telescope.actions').delete_buffer
      },
      i = {
        ["<C-p>"] = actions_layout.toggle_preview,
        ['<C-d>'] = require('telescope.actions').delete_buffer
      },
    },
  }
}

require("telescope").load_extension("emoji")

-- Live grep the workspace
-- vim.cmd[[nnoremap <silent> <C-x>ll :Telescope live_grep<CR>]]
-- vim.cmd[[cnoremap <silent> <C-x>ll :Telescope live_grep<CR>]]
-- vim.cmd[[tnoremap <silent> <C-x>ll <C-\><C-n>:Telescope live_grep<CR>]]
--
-- List open buffers
-- vim.cmd[[noremap <silent> <C-x>b :lua require("telescope.builtin").buffers({ entry_maker = gen_from_buffer_like_leaderf()})<CR>]]
-- vim.cmd[[cnoremap <silent> <C-x>b :lua require("telescope.builtin").buffers({ entry_maker = gen_from_buffer_like_leaderf()})<CR>]]
-- vim.cmd[[tnoremap <silent> <C-x>b <C-\><C-n>:lua require("telescope.builtin").buffers({ entry_maker = gen_from_buffer_like_leaderf()})<CR>]]
-- List files in the workspace.
-- vim.cmd[[nnoremap <silent> <C-x>ff :Telescope fd<CR>]]
-- vim.cmd[[cnoremap <silent> <C-x>ff :Telescope fd<CR>]]
-- vim.cmd[[tnoremap <silent> <C-x>ff <C-\><C-n>:Telescope fd<CR>]]


-- List files in the folder storing all Idris 2 source files
vim.cmd [[command! FilesIdr :lua require("telescope.builtin").fd({search_dirs={"~/.pack"}})]]
vim.cmd [[nnoremap <silent> <C-x>fi :FilesIdr<CR>]]
vim.cmd [[cnoremap <silent> <C-x>fi :FilesIdr<CR>]]
vim.cmd [[tnoremap <silent> <C-x>fi <C-\><C-n>:FilesIdr<CR>]]

-- Live grep in the folder storing all Idris2 source files
vim.cmd [[nnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.pack"}})<CR>]]
vim.cmd [[cnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.pack"}})<CR>]]
vim.cmd [[tnoremap <silent> <C-x>li <C-\><C-n>:lua require("telescope.builtin").live_grep({search_dirs={"~/.pack"}})<CR>]]


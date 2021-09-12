local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["i"] = actions.move_selection_previous,
        ["k"] = actions.move_selection_next,
        ["x"] = actions.remove_selection,
      },
    },
  }
}

function MyBuffers()
  require('telescope.builtin').buffers({
    show_all_buffers = true,
    attach_mappings = function(prompt_bufnr, map)
      local state = require('telescope.actions.state')
      local actions = require('telescope.actions')
      map("n", 'x', function(a, b, c)
        vim.cmd("bdelete " .. state.get_selected_entry().bufnr)
        actions.close(prompt_bufnr)
        vim.cmd("lua require('telescope.builtin').buffers{show_all_buffers=true}")
      end)
      return true
    end
  })
end


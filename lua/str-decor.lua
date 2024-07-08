local str_decor = {}

str_decor.default_hl_group = "str-decor-hi-group"
str_decor.namespace        = "str-decor-hi-namespace"

function str_decor.hi(hl_group)
  hl_group = hl_group or str_decor.default_hl_group
  local ns = vim.api.nvim_create_namespace(str_decor.namespace)
  local line_start = vim.fn.line(".") - 1
  local col_start_virt = vim.fn.virtcol(".") - 1
  local col_start = vim.fn.byteidx(vim.fn.getline(line_start + 1), col_start_virt)
  local col_end = vim.fn.byteidx(vim.fn.getline(line_start + 1), vim.fn.virtcol("."))
  print(col_start, col_end)
  vim.api.nvim_buf_add_highlight(0, ns, hl_group, line_start, col_start, col_end)
end

function str_decor.hi_sel(hl_group)
  hl_group = hl_group or str_decor.default_hl_group
  local ns = vim.api.nvim_create_namespace(str_decor.namespace)
  local line_start = vim.fn.line("'<") - 1
  local line_end = vim.fn.line("'>") - 1
  local col_start = vim.fn.col("'<") - 1
  for l=line_start, line_end do
    local col_end = vim.fn.byteidx(vim.fn.getline(l + 1), vim.fn.virtcol("'>") + 1) - 1
    vim.api.nvim_buf_add_highlight(0, ns, hl_group, l, col_start, col_end)
  end
end

function str_decor.unhi_sel()
  local ns = vim.api.nvim_create_namespace(str_decor.namespace)
  local lines = vim.fn.getpos("'<")[2]
  local linee = vim.fn.getpos("'>")[2]
  vim.api.nvim_buf_clear_highlight(0, ns, lines - 1, linee)
end

function str_decor.underline_sel()
  local line_start = vim.fn.line("'<") - 1
  local line_end = vim.fn.line("'>") - 1
  local col_start = vim.fn.col("'<")
  local col_end = vim.fn.col("'>")
  for l=line_start, line_end do
    local added = 0
    for c=col_start, col_end do
      vim.api.nvim_buf_set_text(0, l, c + added, l, c + added, {"̲"})
      added = added + 2
    end
  end
end

return str_decor

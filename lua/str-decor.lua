local str_decor            = {}

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
 for l = line_start, line_end do
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

function str_decor.insert_combining(char)
 local line_start = vim.fn.line("'<") - 1
 local line_end = vim.fn.line("'>") - 1
 local col_start = vim.fn.charcol("'<") - 1
 local col_end = vim.fn.charcol("'>") - 1
 for l = line_start, line_end do
  for c = col_start, col_end do
   local line_content = unpack(vim.api.nvim_buf_get_lines(0, l, l + 1, true))
   local column_byte_offset = vim.fn.byteidx(line_content, c + 1)
   vim.api.nvim_buf_set_text(0, l, column_byte_offset, l, column_byte_offset, { char })
  end
 end
 -- Recompute '< and '>
 local line_start_content = unpack(vim.api.nvim_buf_get_lines(0, line_start, line_start + 1, true))
 local column_byte_offset = vim.fn.byteidx(line_start_content, col_start)
 vim.api.nvim_buf_set_mark(0, "<", line_start + 1, column_byte_offset, {})
 local line_end_content = unpack(vim.api.nvim_buf_get_lines(0, line_start, line_start + 1, true))
 local column_byte_offset = vim.fn.byteidx(line_end_content, col_end)
 vim.api.nvim_buf_set_mark(0, ">", line_end + 1, column_byte_offset, {})
end

-- Currently assumes that all combining symbols are 2 bytes wide
function str_decor.remove_combining()
 local line_start = vim.fn.line("'<") - 1
 local line_end = vim.fn.line("'>") - 1
 local col_start = vim.fn.charcol("'<") - 1
 local col_end = vim.fn.charcol("'>") - 1
 for l = line_start, line_end do
  for c = col_start, col_end do
   local line_content = unpack(vim.api.nvim_buf_get_lines(0, l, l + 1, true))
   local column_byte_offset = vim.fn.byteidx(line_content, c)
   local column_byte_offset_next = vim.fn.byteidx(line_content, c + 1)
   vim.api.nvim_buf_set_text(0, l, column_byte_offset_next - 2, l, column_byte_offset_next, {})
  end
 end
 -- Recompute '< and '>
 local line_start_content = unpack(vim.api.nvim_buf_get_lines(0, line_start, line_start + 1, true))
 local column_byte_offset = vim.fn.byteidx(line_start_content, col_start)
 vim.api.nvim_buf_set_mark(0, "<", line_start + 1, column_byte_offset, {})
 local line_end_content = unpack(vim.api.nvim_buf_get_lines(0, line_start, line_start + 1, true))
 local column_byte_offset = vim.fn.byteidx(line_end_content, col_end)
 vim.api.nvim_buf_set_mark(0, ">", line_end + 1, column_byte_offset, {})
end

function str_decor.underline_sel()
  str_decor.insert_combining("̲")
end

function str_decor.overline_sel()
  str_decor.insert_combining("̅")
end

return str_decor

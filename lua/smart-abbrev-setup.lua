require("smart_abbrev_map")

local function esc(x)
   return (x:gsub('%%', '%%%%')
            :gsub('^%^', '%%^')
            :gsub('%$$', '%%$')
            :gsub('%(', '%%(')
            :gsub('%)', '%%)')
            :gsub('%.', '%%.')
            :gsub('%[', '%%[')
            :gsub('%]', '%%]')
            :gsub('%*', '%%*')
            :gsub('%+', '%%+')
            :gsub('%-', '%%-')
            :gsub('%?', '%%?'))
end

-- Small test suite:
-- SubstLongestMatchRightToLeft({{"eta", "η"}, {"Theta", "ϴ"}}, "Greek capital Theta") = "Greek capital ϴ", -3
-- SubstLongestMatchRightToLeft({{"eta", "η"}, {"Theta", "ϴ"}}, "Greek small eta") = "Greek small η", -1
-- SubstLongestMatchRightToLeft({{"eta", "η"}, {"Theta", "ϴ"}}, "Greek small \eta") = "Greek small η", -1
-- SubstLongestMatchRightToLeft({{"eta", "η"}, {"Theta", "ϴ"}}, "Greek small beta") = nil
function SubstLongestMatchRightToLeft(abbrev_list, txt)
  local longestLength = 0
  local toSubst = ""
  for _, abbrev in ipairs(abbrev_list) do
    local key = abbrev[1]
    local subst = abbrev[2]
    local m = txt:match(esc(key) .. '$')
    if m and #m > longestLength then
      longestLength = #m
      toSubst = subst
    end
  end
  if toSubst ~= "" then
    local upToMatch = txt:sub(0, -(longestLength + 1))
    if upToMatch:sub(#upToMatch, #upToMatch) == smart_abbrev_delim then
      upToMatch = upToMatch:sub(0, -2)
    end
    local newLine = upToMatch .. toSubst
    return newLine, #toSubst - longestLength
  else
    return nil
  end
end

-- eta<C-]>   ==> η
-- \eta<C-]>  ==> η
-- Theta<C-]>  ==> ϴ
-- Th\eta<C-]> ==> Thη
function SmartAbbrevExpand()
  local lineTxt = vim.fn.getline('.')
  local buf = vim.fn.getpos('.')[1]
  local line = vim.fn.getpos('.')[2]
  local col = vim.fn.getpos('.')[3]
  local offset = vim.fn.getpos('.')[4]
  if not lineTxt or not col then
    vim.fn.echom("Can't expand: getline | getpos returned nil")
  else
    local upToCursor = lineTxt:sub(0, col)
    local upToCursorExpanded, dif = SubstLongestMatchRightToLeft(smart_abbrev_map, upToCursor)
    if upToCursorExpanded then
      local expandedLine = upToCursorExpanded .. lineTxt:sub(col + 1)
      vim.fn.setline('.', expandedLine)
      vim.fn.setpos('.', {buf, line, col + dif, offset})
    end
  end
end

-- TODO make this work in terminals and popup windows, like one found in telescope
vim.api.nvim_set_keymap('i', '<C-]>', '<Left><C-o>:lua SmartAbbrevExpand()<CR><Right>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', '<C-]>', '<Left><C-o>:lua SmartAbbrevExpand()<CR><Right>',
                        {noremap = true, silent = true})

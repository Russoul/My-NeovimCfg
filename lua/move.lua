local move = {}

--- A function that does nothing
local noop = function() end

--- Creates a function that runs the first function then the second one
--- @param f function
--- @param g function
--- @return function
local function composition(f, g)
  return
      function()
        f()
        g()
      end
end

--- Pad the 0-indeded line at {linenum} in buffer {bufnum} with space on the right
--- until the line has a character at 0-indexed visual character column {atleastcol}.
--- @param bufnum number
--- @param linenum number
--- @param atleastcol number
function move.pad(bufnum, linenum, atleastcol)
  local line = unpack(vim.api.nvim_buf_get_lines(bufnum, linenum, linenum + 1, true))

  local numchars = vim.fn.strchars(line, true)

  if atleastcol - 1 >= numchars then
    vim.api.nvim_buf_set_lines(bufnum, linenum, linenum + 1, true, { line .. " " })
    move.pad(bufnum, linenum, atleastcol)
  end
end

--- Split the line at {linenum} in buffer {bufnum} into 3 subparts by 0-indexed visual character columns {startinc} and {endexc}
--- @param bufnum number
--- @param linenum number
--- @param startinc number
--- @param endexc number
--- @return string, string, string
function move.splitAt(bufnum, linenum, startinc, endexc)
  local line = unpack(vim.api.nvim_buf_get_lines(bufnum, linenum, linenum + 1, true))

  -- 1-indexed
  local startincbyte = 1 + vim.fn.strlen(vim.fn.strcharpart(line, 0, startinc, true))
  -- 1-indexed
  local endexcbyte = 1 + vim.fn.strlen(vim.fn.strcharpart(line, 0, endexc, true))

  local prefix = string.sub(line, 1, startincbyte - 1)
  local infix = string.sub(line, startincbyte, endexcbyte - 1)
  local postfix = string.sub(line, endexcbyte)

  return prefix, infix, postfix
end

--- If possible, exchanges the selection spanned by 0-indexed visual character columns {startinc} and {endexc}
--- at 0-indexed line {linenum} in buffer {bufnum} with the corresponding characters in the previous line in the same buffer.
--- If there aren't enough characters in the previous line, pads that line with space on the right until it has just enough space for a swap.
--- Returns nil if there is nowhere to move the selection. Returns a nullary function that performs the exchange otherwise.
--- @param bufnum number
--- @param linenum number
--- @param startinc number
--- @param endexc number
--- @return nil|function
function move.moveLineSelectionUp(bufnum, linenum, startinc, endexc)
  if linenum - 1 < 0 then
    return nil
  end

  move.pad(bufnum, linenum - 1, endexc)

  local prefix, infix, postfix = move.splitAt(bufnum, linenum, startinc, endexc)

  local prefixprevious, infixprevious, postfixprevious = move.splitAt(bufnum, linenum - 1, startinc,
    endexc)

  local newline = prefix .. infixprevious .. postfix
  local newlineprevious = prefixprevious .. infix .. postfixprevious

  return function()
    vim.api.nvim_buf_set_lines(bufnum, linenum, linenum + 1, true, { newline })
    vim.api.nvim_buf_set_lines(bufnum, linenum - 1, linenum - 1 + 1, true, { newlineprevious })
  end
end

--- Exchanges the selection spanned by 0-indexed visual character columns {startinc} and {endexc}
--- at 0-indexed line {linenum} in buffer {bufnum} with the corresponding characters in the next line in the same buffer.
--- If there aren't enough characters in the next line, pads that line with space on the right until it has just enough space for a swap.
--- If there is no line below, adds an empty one and pads it with space just enough.
--- Returns a nullary function that performs the exchange.
--- @param bufnum number
--- @param linenum number
--- @param startinc number
--- @param endexc number
--- @return function
function move.moveLineSelectionDown(bufnum, linenum, startinc, endexc)
  local numLines = #vim.api.nvim_buf_get_lines(bufnum, 0, -1, true)

  if linenum + 1 >= numLines then
    vim.api.nvim_buf_set_lines(bufnum, linenum + 1, linenum + 1, true, { "" })
    return move.moveLineSelectionDown(bufnum, linenum, startinc, endexc)
  end

  move.pad(bufnum, linenum + 1, endexc)

  local prefix, infix, postfix = move.splitAt(bufnum, linenum, startinc, endexc)

  local prefixnext, infixnext, postfixnext = move.splitAt(bufnum, linenum + 1, startinc, endexc)

  local newline = prefix .. infixnext .. postfix
  local newlinenext = prefixnext .. infix .. postfixnext

  return function()
    vim.api.nvim_buf_set_lines(bufnum, linenum, linenum + 1, true, { newline })
    vim.api.nvim_buf_set_lines(bufnum, linenum + 1, linenum + 1 + 1, true, { newlinenext })
  end
end

--- Exchanges the selection spanned by 0-indexed visual character columns {startinc} and {endexc}
--- at 0-indexed line {linenum} in buffer {bufnum} with the character immediately next to it on the right.
--- If there are no more characters on the right, insert one space.
--- Returns a nullary function that performs the exchange.
--- @param bufnum number
--- @param linenum number
--- @param startinc number
--- @param endexc number
--- @return function
function move.moveLineSelectionRight(bufnum, linenum, startinc, endexc)
  move.pad(bufnum, linenum, endexc + 1)

  local prefix, infix1, _ = move.splitAt(bufnum, linenum, startinc, endexc)

  local _, infix2, postfix = move.splitAt(bufnum, linenum, endexc, endexc + 1)

  return function()
    vim.api.nvim_buf_set_lines(bufnum, linenum, linenum + 1, true,
      { prefix .. infix2 .. infix1 .. postfix })
  end
end

--- If possible, exchanges the selection spanned by 0-indexed visual character columns {startinc} and {endexc}
--- at 0-indexed line {linenum} in buffer {bufnum} with the character immediately next to it on the left.
--- If there is no character preceding the selection, returns nil.
--- Returns a nullary function that performs the exchange otherwise.
--- @param bufnum number
--- @param linenum number
--- @param startinc number
--- @param endexc number
--- @return nil|function
function move.moveLineSelectionLeft(bufnum, linenum, startinc, endexc)
  -- Nowhere to move: there is no space to the left of the selection
  if startinc == 0 then
    return nil
  end

  local _, infix2, postfix = move.splitAt(bufnum, linenum, startinc, endexc)

  local prefix, infix1, _ = move.splitAt(bufnum, linenum, startinc - 1, startinc)

  return function()
    vim.api.nvim_buf_set_lines(bufnum, linenum, linenum + 1, true,
      { prefix .. infix2 .. infix1 .. postfix })
  end
end

function move.moveSelectionDown()
  local bufnr = vim.fn.getpos("'<")[1]
  local lineLeft1 = vim.fn.line("'<")
  local colLeft1 = vim.fn.charcol("'<")
  local colRight1 = vim.fn.charcol("'>")
  local lineRight1 = vim.fn.line("'>")

  local lineStart1 = math.min(lineLeft1, lineRight1)
  local colStart1 = math.min(colLeft1, colRight1)
  local colEnd1 = math.max(colLeft1, colRight1)
  local lineEnd1 = math.max(lineLeft1, lineRight1)

  local toMove = true
  for linei1 = lineEnd1, lineStart1, -1 do
    local linei0 = linei1 - 1
    local act = move.moveLineSelectionDown(bufnr, linei0, colStart1 - 1, colEnd1 - 1 + 1)
    if act then
      act()
    else
      toMove = false
      break
    end
  end

  if toMove then
    vim.fn.setcharpos("'<", { bufnr, lineStart1 + 1, colStart1, 0 })
    vim.fn.setcharpos("'>", { bufnr, lineEnd1 + 1, colEnd1, 0 })
  end

  vim.cmd [[execute "normal! gv"]]
end

function move.moveSelectionUp()
  local bufnr = vim.fn.getpos("'<")[1]
  local lineLeft1 = vim.fn.line("'<")
  local colLeft1 = vim.fn.charcol("'<")
  local colRight1 = vim.fn.charcol("'>")
  local lineRight1 = vim.fn.line("'>")

  local lineStart1 = math.min(lineLeft1, lineRight1)
  local colStart1 = math.min(colLeft1, colRight1)
  local colEnd1 = math.max(colLeft1, colRight1)
  local lineEnd1 = math.max(lineLeft1, lineRight1)

  local toMove = true
  for linei1 = lineStart1, lineEnd1, 1 do
    local linei0 = linei1 - 1
    local act = move.moveLineSelectionUp(bufnr, linei0, colStart1 - 1, colEnd1 - 1 + 1)
    if act then
      act()
    else
      toMove = false
      break
    end
  end

  if toMove then
    vim.fn.setcharpos("'<", { bufnr, lineStart1 - 1, colStart1, 0 })
    vim.fn.setcharpos("'>", { bufnr, lineEnd1 - 1, colEnd1, 0 })
  end

  vim.cmd [[execute "normal! gv"]]
end

function move.moveSelectionRight()
  local bufnr = vim.fn.getpos("'<")[1]

  local lineLeft1 = vim.fn.line("'<")
  local colLeft1 = vim.fn.charcol("'<")
  local colRight1 = vim.fn.charcol("'>")
  local lineRight1 = vim.fn.line("'>")

  local lineStart1 = math.min(lineLeft1, lineRight1)
  local colStart1 = math.min(colLeft1, colRight1)
  local colEnd1 = math.max(colLeft1, colRight1)
  local lineEnd1 = math.max(lineLeft1, lineRight1)

  local toMove = true
  local computation = noop
  for linei1 = lineStart1, lineEnd1 do
    local linei0 = linei1 - 1
    local closure = move.moveLineSelectionRight(bufnr, linei0, colStart1 - 1, colEnd1 - 1 + 1)
    -- All sub-lines must be movable in order for the block move to succeed
    if closure then
      computation = composition(computation, closure)
    else
      toMove = false
      break
    end
  end

  if toMove then
    computation()
    vim.fn.setcharpos("'<", { bufnr, lineStart1, colStart1 + 1, 0 })
    vim.fn.setcharpos("'>", { bufnr, lineEnd1, colEnd1 + 1, 0 })
  end

  vim.cmd [[execute "normal! gv"]]
end

function move.moveSelectionLeft()
  local bufnr = vim.fn.getpos("'<")[1]
  local lineLeft1 = vim.fn.line("'<")
  local colLeft1 = vim.fn.charcol("'<")
  local colRight1 = vim.fn.charcol("'>")
  local lineRight1 = vim.fn.line("'>")

  local lineStart1 = math.min(lineLeft1, lineRight1)
  local colStart1 = math.min(colLeft1, colRight1)
  local colEnd1 = math.max(colLeft1, colRight1)
  local lineEnd1 = math.max(lineLeft1, lineRight1)

  local toMove = true
  local computation = noop
  for linei1 = lineStart1, lineEnd1 do
    local linei0 = linei1 - 1
    local closure = move.moveLineSelectionLeft(bufnr, linei0, colStart1 - 1, colEnd1 - 1 + 1)
    -- All sub-lines must be movable in order for the block move to succeed
    if closure then
      computation = composition(computation, closure)
    else
      toMove = false
      break
    end
  end

  if toMove then
    computation()
    vim.fn.setcharpos("'<", { bufnr, lineStart1, colStart1 - 1, 0 })
    vim.fn.setcharpos("'>", { bufnr, lineEnd1, colEnd1 - 1, 0 })
  end

  vim.cmd [[execute "normal! gv"]]
end

return move

--                        //
--     λy. f y            //
--     λx. f x            //
--        x̄               //
--    ┌───────────┐       //
--    │Hello world│       //
--    └───────────┘       //
--        ȳ               //
--                        //

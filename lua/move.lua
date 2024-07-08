local move = {}

-- handles unicode lines
-- Line number counted from 0
-- Unicode character index counted from 0 (note: this is *not* byte index)
-- bufNum is valid buffer number
-- lineNum is existing line number in that buffer
-- selIndexStartInc is an index into an existing column in that line
-- selIndexEndExc is an index into an existing column in that line
-- selIndexStartInc < selIndexEndExc
-- returns a closure that performs the move if possible
function move.moveLineSelectionUp(bufNum, lineNum, selIndexStartInc, selIndexEndExc)
  local line = unpack(vim.api.nvim_buf_get_lines(bufNum, lineNum, lineNum + 1, true))

  if lineNum - 1 < 0 then
    return nil
  end

  local previousLine = unpack(vim.api.nvim_buf_get_lines(bufNum, lineNum - 1, lineNum - 1 + 1, true))
  local numCharsprevious = vim.fn.strchars(previousLine)

  if selIndexEndExc - 1 >= numCharsprevious then
    vim.api.nvim_buf_set_lines(bufNum, lineNum - 1, lineNum - 1 + 1, true, {previousLine .. " "})
    return (move.moveLineSelectionUp(bufNum, lineNum, selIndexStartInc, selIndexEndExc))
  end

  -- 1-indexed
  local selIndexStartByteInc = 1 + vim.str_byteindex(line, selIndexStartInc)
  -- 1-indexed
  local selIndexEndByteExc = 1 + vim.str_byteindex(line, selIndexEndExc - 1)
                               + vim.fn.strlen(vim.fn.strpart(line, selIndexEndExc - 1, 1, true))

  local prefix = string.sub(line, 1, selIndexStartByteInc - 1)
  local infix = string.sub(line, selIndexStartByteInc, selIndexEndByteExc - 1)
  local postfix = string.sub(line, selIndexEndByteExc, -1)

  -- 1-indexed
  local selIndexStartByteInc = 1 + vim.str_byteindex(previousLine, selIndexStartInc)
  -- 1-indexed
  local selIndexEndByteExc = 1 + vim.str_byteindex(previousLine, selIndexEndExc - 1)
                               + vim.fn.strlen(vim.fn.strpart(previousLine, selIndexEndExc - 1, 1, true))

  local prefixprevious = string.sub(previousLine, 1, selIndexStartByteInc - 1)
  local infixprevious = string.sub(previousLine, selIndexStartByteInc, selIndexEndByteExc - 1)
  local postfixprevious = string.sub(previousLine, selIndexEndByteExc, -1)

  local result = prefix .. infixprevious .. postfix
  local resultprevious = prefixprevious .. infix .. postfixprevious
  return function ()
    vim.api.nvim_buf_set_lines(bufNum, lineNum, lineNum + 1, true, {result})
    vim.api.nvim_buf_set_lines(bufNum, lineNum - 1, lineNum - 1 + 1, true, {resultprevious})
  end

end

-- handles unicode lines
-- Line number counted from 0
-- Unicode character index counted from 0 (note: this is *not* byte index)
-- bufNum is valid buffer number
-- lineNum is existing line number in that buffer
-- selIndexStartInc is an index into an existing column in that line
-- selIndexEndExc is an index into an existing column in that line
-- selIndexStartInc < selIndexEndExc
-- returns a closure that performs the move if possible
function move.moveLineSelectionDown(bufNum, lineNum, selIndexStartInc, selIndexEndExc)
  local line = unpack(vim.api.nvim_buf_get_lines(bufNum, lineNum, lineNum + 1, true))

  local numLines = #vim.api.nvim_buf_get_lines(0, 0, -1, true)

  if lineNum + 1 >= numLines then
    return nil
  end

  local nextLine = unpack(vim.api.nvim_buf_get_lines(bufNum, lineNum + 1, lineNum + 1 + 1, true))
  local numCharsNext = vim.fn.strchars(nextLine)

  if selIndexEndExc - 1 >= numCharsNext then
    vim.api.nvim_buf_set_lines(bufNum, lineNum + 1, lineNum + 1 + 1, true, {nextLine .. " "})
    return (move.moveLineSelectionDown(bufNum, lineNum, selIndexStartInc, selIndexEndExc))
  end

  -- 1-indexed
  local selIndexStartByteInc = 1 + vim.str_byteindex(line, selIndexStartInc)
  -- 1-indexed
  local selIndexEndByteExc = 1 + vim.str_byteindex(line, selIndexEndExc - 1)
                               + vim.fn.strlen(vim.fn.strpart(line, selIndexEndExc - 1, 1, true))


  local prefix = string.sub(line, 1, selIndexStartByteInc - 1)
  local infix = string.sub(line, selIndexStartByteInc, selIndexEndByteExc - 1)
  local postfix = string.sub(line, selIndexEndByteExc, -1)

  -- 1-indexed
  local selIndexStartByteInc = 1 + vim.str_byteindex(nextLine, selIndexStartInc)
  -- 1-indexed
  local selIndexEndByteExc = 1 + vim.str_byteindex(nextLine, selIndexEndExc - 1)
                               + vim.fn.strlen(vim.fn.strpart(nextLine, selIndexEndExc - 1, 1, true))

  local prefixNext = string.sub(nextLine, 1, selIndexStartByteInc - 1)
  local infixNext = string.sub(nextLine, selIndexStartByteInc, selIndexEndByteExc - 1)
  local postfixNext = string.sub(nextLine, selIndexEndByteExc, -1)

  local result = prefix .. infixNext .. postfix
  local resultNext = prefixNext .. infix .. postfixNext
  return function ()
    vim.api.nvim_buf_set_lines(bufNum, lineNum, lineNum + 1, true, {result})
    vim.api.nvim_buf_set_lines(bufNum, lineNum + 1, lineNum + 1 + 1, true, {resultNext})
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
  print(colStart1, colEnd1)

  local toMove = true
  for linei1 = lineEnd1, lineStart1, -1 do
    local linei0 = linei1 - 1
    local act = move.moveLineSelectionDown(bufnr, linei0, colStart1 - 1, colEnd1 - 1 + 1)
    if act then
      act ()
    else
      toMove = false
      break
    end
  end

  if toMove then
    vim.fn.setcharpos("'<", {bufnr, lineStart1 + 1, colStart1, 0})
    vim.fn.setcharpos("'>", {bufnr, lineEnd1 + 1, colEnd1, 0})
  end

  vim.cmd[[execute "normal! gv"]]

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
  print(colStart1, colEnd1)

  local toMove = true
  for linei1 = lineStart1, lineEnd1, 1 do
    local linei0 = linei1 - 1
    local act = move.moveLineSelectionUp(bufnr, linei0, colStart1 - 1, colEnd1 - 1 + 1)
    if act then
      act ()
    else
      toMove = false
      break
    end
  end

  if toMove then
    vim.fn.setcharpos("'<", {bufnr, lineStart1 - 1, colStart1, 0})
    vim.fn.setcharpos("'>", {bufnr, lineEnd1 - 1, colEnd1, 0})
  end

  vim.cmd[[execute "normal! gv"]]

end

-- handles unicode lines
-- Line number counted from 0
-- Unicode character index counted from 0 (note: this is *not* byte index)
-- bufNum is valid buffer number
-- lineNum is existing line number in that buffer
-- selIndexStartInc is an index into an existing column in that line
-- selIndexEndExc is an index into an existing column in that line
-- selIndexStartInc < selIndexEndExc
-- returns a closure that performs the move if possible
function move.moveLineSelectionRight(bufNum, lineNum, selIndexStartInc, selIndexEndExc)
  local line = unpack(vim.api.nvim_buf_get_lines(bufNum, lineNum, lineNum + 1, true))
  local numChars = vim.fn.strchars(line)
  -- print("numChars", numChars)
  -- Nowhere to move: there is no space to the right of the selection
  if selIndexEndExc >= numChars then
    vim.api.nvim_buf_set_lines(bufNum, lineNum, lineNum + 1, true, {line .. " "})
    return (move.moveLineSelectionRight(bufNum, lineNum, selIndexStartInc, selIndexEndExc))
  end
  -- 1-indexed
  local selIndexStartByteInc = 1 + vim.str_byteindex(line, selIndexStartInc)
  -- 1-indexed
  local selIndexEndByteExc = 1 + vim.str_byteindex(line, selIndexEndExc)

  local prefix = string.sub(line, 1, selIndexStartByteInc - 1)

  -- Contains at least one character
  local postfix = string.sub(line, selIndexEndByteExc, -1)
  local firstCharOfPostfix = string.sub(postfix, 1, vim.fn.strlen(vim.fn.strpart(postfix, 0, 1, true)))
  local newPrefix = prefix .. firstCharOfPostfix
  local infix = string.sub(line, selIndexStartByteInc, selIndexEndByteExc - 1)
  local newPostfix = string.sub(postfix, 1 + vim.fn.strlen(firstCharOfPostfix), -1)
  local result = newPrefix .. infix .. newPostfix
  --[[ print("prefix", prefix)
  print("infix", infix)
  print("postfix", postfix) ]]

  return function () vim.api.nvim_buf_set_lines(bufNum, lineNum, lineNum + 1, true, {result}) end
end

-- handles unicode lines
-- Line number counted from 0
-- Unicode character index counted from 0 (note: this is *not* byte index)
-- bufNum is valid buffer number
-- lineNum is existing line number in that buffer
-- selIndexStartInc is an index into an existing column in that line
-- selIndexEndExc is an index into an existing column in that line
-- selIndexStartInc < selIndexEndExc
-- returns a closure that performs the move if possible
function move.moveLineSelectionLeft(bufNum, lineNum, selIndexStartInc, selIndexEndExc)
  local line = unpack(vim.api.nvim_buf_get_lines(bufNum, lineNum, lineNum + 1, true))
  -- Nowhere to move: there is no space to the left of the selection
  if selIndexStartInc == 0 then
    return nil
  end
  -- 1-indexed
  local selIndexStartByteInc = 1 + vim.str_byteindex(line, selIndexStartInc)
  -- 1-indexed
  local selIndexEndByteExc = 1 + vim.str_byteindex(line, selIndexEndExc)

  -- Contains at least one character
  local prefix = string.sub(line, 1, selIndexStartByteInc - 1)
  local prefixLen = vim.fn.strchars(prefix)
  local prefixAllButLastCharByteLen = vim.fn.strlen(vim.fn.strpart(prefix, 0, prefixLen - 1, true))

  local postfix = string.sub(line, selIndexEndByteExc, -1)
  local lastCharOfPrefix = string.sub(prefix, 1 + prefixAllButLastCharByteLen, -1)
  local newPrefix = string.sub(prefix, 1, prefixAllButLastCharByteLen)
  local infix = string.sub(line, selIndexStartByteInc, selIndexEndByteExc - 1)
  local newPostfix = lastCharOfPrefix .. postfix
  local result = newPrefix .. infix .. newPostfix
  --[[ print("prefix", prefix)
  print("infix", infix)
  print("postfix", postfix) ]]

  return function () vim.api.nvim_buf_set_lines(bufNum, lineNum, lineNum + 1, true, {result}) end
end

--                        //
--       λy. f y          //
--       λx. f x          //
--     ┌───────────┐      //
--     │Hello world│      //
--     └───────────┘      //
--                        //
--                        //

local identity = function () end

-- Creates a function that runs the first function then the second one
local function composition (f, g)
  return
    function ()
         f()
         g()
    end

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
  print(colStart1, colEnd1)

  local toMove = true
  local computation = identity
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
    vim.fn.setcharpos("'<", {bufnr, lineStart1, colStart1 + 1, 0})
    vim.fn.setcharpos("'>", {bufnr, lineEnd1, colEnd1 + 1, 0})
  end

  vim.cmd[[execute "normal! gv"]]

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
  print(colStart1, colEnd1)

  local toMove = true
  local computation = identity
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
    vim.fn.setcharpos("'<", {bufnr, lineStart1, colStart1 - 1, 0})
    vim.fn.setcharpos("'>", {bufnr, lineEnd1, colEnd1 - 1, 0})
  end

  vim.cmd[[execute "normal! gv"]]

end

return move


--  ================ LSP config for Idris2 ========================
local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local IdrResponseBufferName = "idris-response"

function IdrInitBuf()
  if vim.fn.bufexists(IdrResponseBufferName) == 1 then
    return vim.fn.bufnr(IdrResponseBufferName)
  end

  -- Create / find the existing
  local bufid = vim.fn.bufadd(IdrResponseBufferName)

  -- Create new window with the buffer
  vim.cmd("sbuffer " .. bufid)

  vim.cmd("setlocal bufhidden=hide")

  -- For syntax highlighting.
  vim.cmd("setlocal filetype=idris2")

  vim.cmd("setlocal buftype=nofile")

  -- Get back to where we were.
  vim.cmd("q")

  return bufid
end

function IdrScrollBuf()
  local bufid = IdrInitBuf()
  local curWinId = vim.fn.win_getid()
  local winid = vim.fn.bufwinid(bufid)
  if winid >= 0 then
    vim.fn.win_gotoid(winid)
    vim.cmd("normal! G")
    vim.fn.win_gotoid(curWinId)
  end
end

-- TODO smoother transition when opening/closing
function IdrOpenBuf()
  local bufid = IdrInitBuf()

  -- Find the first window where that buffer is loaded into.
  local winid = vim.fn.bufwinid(bufid)
  -- If there is one already, we are done.
  if winid >= 0 then
    return false
  end
  local curWinId = vim.fn.win_getid()

  -- Create new window with the buffer
  vim.cmd("sbuffer " .. bufid)

  -- This should find it now.
  local winid = vim.fn.bufwinid(bufid)
  if winid == -1 then
    vim.fn.echom("Weird behaviour when openning 'idris-response'")
    return false
  end

  -- Move to the very right.
  vim.cmd("winc L")
  -- Resize
  vim.cmd("vertical resize 60")
  vim.fn.win_gotoid(curWinId)

  return true

end

function IdrCloseBuf()
  -- Find the first window where that buffer is loaded into.
  local winid = vim.fn.bufwinid(IdrResponseBufferName)
  -- If there is none, we are done
  if winid == -1 then
    return false
  end

  -- close
  vim.cmd(vim.fn.win_id2win(winid) .. "wincmd c")

  return true

end

function IdrToggleBuf()
  local bufid = IdrInitBuf()
  -- Find the first window where that buffer is loaded into.
  local winid = vim.fn.bufwinid(IdrResponseBufferName)
  -- If there is none, open. Otherwise, close.
  if winid == -1 then
    IdrOpenBuf()
  else
    IdrCloseBuf()
  end

end

function IdrPullDiag()
  local diag = vim.lsp.diagnostic.get()
  local buf = IdrInitBuf()
    vim.fn.appendbufline(buf, '$', "")
    vim.fn.appendbufline(buf, '$', "-------------")
    vim.fn.appendbufline(buf, '$', "")
  if #diag > 0 then
    for _, x in pairs(diag) do
      local str = x.message
      for s in str:gmatch("[^\r\n]+") do
        vim.fn.appendbufline(buf, '$', s)
      end
    end
  else
    local t = vim.fn.strftime("%T")
    vim.fn.appendbufline(buf, '$', "")
    vim.fn.appendbufline(buf, '$', "[" .. t .. "]" .. " No errors")
    vim.fn.appendbufline(buf, '$', "")
  end
  IdrScrollBuf()
end

-- Flag to enable semantic highlightning on start, if false you have to issue a first command manually
local autostart_semantic_highlightning = true
lspconfig.idris2_lsp.setup {
  on_new_config = function(new_config, new_root_dir)
    new_config.capabilities['workspace']['semanticTokens'] = {refreshSupport = true}
  end,
  on_attach = function(client)
    if autostart_semantic_highlightning then
      vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
        {textDocument = vim.lsp.util.make_text_document_params()}, nil)
    end
    -- Example of how to request a single kind of code action with a keymap,
    -- refer to the table in the README for the appropriate key for each command.
    -- vim.cmd [[nnoremap <Leader>cs <Cmd>lua vim.lsp.buf.code_action({diagnostics={},only={"refactor.rewrite.CaseSplit"}})<CR>]]
    --custom_attach(client) -- remove this line if you don't have a customized attach function
  end,
  autostart = true,
  handlers = {
    ['workspace/semanticTokens/refresh'] = function(err, method, params, client_id, bufnr, config)
      if autostart_semantic_highlightning then
        vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
          { textDocument = vim.lsp.util.make_text_document_params() }, nil)
      end
      return vim.NIL
    end,
    ['textDocument/semanticTokens/full'] = function(err, method, result, client_id, bufnr, config)
      -- temporary handler until native support lands
      local client = vim.lsp.get_client_by_id(client_id)
      local legend = client.server_capabilities.semanticTokensProvider.legend
      local token_types = legend.tokenTypes
      local data = result.data

      local ns = vim.api.nvim_create_namespace('nvim-lsp-semantic')
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
      local tokens = {}
      local prev_line, prev_start = nil, 0
      for i = 1, #data, 5 do
        local delta_line = data[i]
        prev_line = prev_line and prev_line + delta_line or delta_line
        local delta_start = data[i + 1]
        prev_start = delta_line == 0 and prev_start + delta_start or delta_start
        local token_type = token_types[data[i + 3] + 1]
        local line = vim.api.nvim_buf_get_lines(bufnr, prev_line, prev_line + 1, false)[1]
        if line then
          local byte_start = vim.str_byteindex(line, prev_start)
          local byte_end = vim.str_byteindex(line, prev_start + data[i + 2])
          vim.api.nvim_buf_add_highlight(bufnr, ns, 'LspSemantic_' .. token_type, prev_line, byte_start, byte_end)
        end
      end
    end
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
function(err, method, params, client_id)
  (vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = true,
      signs = true,
      update_in_insert = true
  }))(err, method, params, client_id)
  --IdrPullDiag()
end

-- Set here your preferred colors for semantic values
vim.cmd [[highlight link LspSemantic_type Include]]   -- Type constructors
vim.cmd [[highlight link LspSemantic_function Identifier]] -- Functions names
vim.cmd [[highlight link LspSemantic_enumMember Number]]   -- Data constructors
vim.cmd [[highlight LspSemantic_variable guifg=Gray]] -- Bound variables
vim.cmd [[highlight link LspSemantic_keyword Structure]]  -- Keywords
vim.cmd [[highlight LspSemantic_postulate guifg=Red]]  -- Postulates

-- Those don't seem to do anything
-- vim.cmd [[highlight link LspSemantic_namespace Green]]  -- Namespaces
-- vim.cmd [[highlight link LspSemantic_module Red]]  -- Modules

-- :lua vim.lsp.buf_request(0, 'textDocument/semanticTokens/full', {textDocument = vim.lsp.util.make_text_document_params()}, nil)

function IdrReload()
  vim.lsp.buf.execute_command({command = "reload", arguments = {vim.lsp.util.make_range_params().textDocument.uri}})
end

function IdrRepl(cmd)
  --local table = vim.lsp.util.make_range_params()
  --table.cmd = cmd
  vim.lsp.buf_request(0, "workspace/executeCommand", {command = "repl", arguments = {cmd}}, function(err, method, result, client_id, bufnr, config)
  local buf = IdrInitBuf()
  vim.fn.appendbufline(buf, '$', "")
  vim.fn.appendbufline(buf, '$', "-------------")
  vim.fn.appendbufline(buf, '$', "")
  for s in result:gmatch("[^\r\n]+") do
    vim.fn.appendbufline(buf, '$', s)
  end
  IdrScrollBuf()
  end)
end

function IdrSmartFill(name, sl, sc, el, ec)
  --local table = vim.lsp.util.make_range_params()
  --table.cmd = cmd
  vim.lsp.buf_request(0, "workspace/executeCommand", {command = "smartfill",
    arguments = {name, tostring(sl - 1), tostring(sc - 1), tostring(el - 1), tostring(ec - 1)}}, function(err, method, result, client_id, bufnr, config)
  local buf = IdrInitBuf()
  vim.fn.appendbufline(buf, '$', "")
  vim.fn.appendbufline(buf, '$', "-------------")
  vim.fn.appendbufline(buf, '$', "")
  for s in result:gmatch("[^\r\n]+") do
    vim.fn.appendbufline(buf, '$', s)
  end
  IdrScrollBuf()
  end)
end

vim.api.nvim_set_keymap('n', '<LocalLeader>q', ':lua IdrToggleBuf()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<LocalLeader>p', ':lua IdrPullDiag()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<LocalLeader>r', ':lua IdrReload()<CR>',
                        {noremap = true, silent = false})

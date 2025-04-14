local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
if not configs.hott_lsp then
  configs.hott_lsp = {
    default_config = {
      cmd = {'hott-lsp'}; -- if not available in PATH, provide the absolute path
      filetypes = {'hott'};
      on_new_config = function(new_config, new_root_dir)
        new_config.cmd = {'hott-lsp'}
        new_config.capabilities['workspace']['semanticTokens'] = {refreshSupport = true}
      end;
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname)
      end;
      settings = {};
    };
  }
end
-- Flag to enable semantic highlightning on start, if false you have to issue a first command manually
local autostart_semantic_highlightning = true
lspconfig.hott_lsp.setup {
  on_attach = function(client)
    if autostart_semantic_highlightning then
      vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
        { textDocument = vim.lsp.util.make_text_document_params() }, nil)
    end
  end,
  autostart = true,
  handlers = {
    ['workspace/semanticTokens/refresh'] = function(err, result, ctx, config)
      if autostart_semantic_highlightning then
        vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
          { textDocument = vim.lsp.util.make_text_document_params() }, nil)
      end
      return vim.NIL
    end,
    ['textDocument/semanticTokens/full'] = function(err, result, ctx, config)
      if err ~= nil then
          vim.notify(tostring(err), vim.log.levels.ERROR)
          return
      end
      if not result then return end
      -- temporary handler until native support lands
      local bufnr = ctx.bufnr
      local client = vim.lsp.get_client_by_id(ctx.client_id)
---@diagnostic disable-next-line: need-check-nil
      local legend = client.server_capabilities.semanticTokensProvider.legend
      local token_types = legend.tokenTypes
      local data = result.data

      if #data == 0 then
          return
      end

      local ns = vim.api.nvim_create_namespace('nvim-lsp-semantic-hl')
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

      local prev_line, prev_start = nil, 0
      for i = 1, #data, 5 do
        local delta_line = data[i]
        prev_line = prev_line and prev_line + delta_line or delta_line
        local delta_start = data[i + 1]
        prev_start = delta_line == 0 and prev_start + delta_start or delta_start
        local token_type = token_types[data[i + 3] + 1]

        local line = vim.api.nvim_buf_get_lines(bufnr, prev_line, prev_line + 1, false)[1]
        print("line", line, "column", prev_start)
        if (vim.fn.strchars(line) >= prev_start) then
          local byte_start = vim.str_byteindex(line, prev_start)
          if prev_start + data[i + 2] >= 0 and prev_start + data[i + 2] <= vim.fn.strchars(line) then
            local byte_end = vim.str_byteindex(line, prev_start + data[i + 2])
---@diagnostic disable-next-line: param-type-mismatch
            vim.api.nvim_buf_add_highlight(bufnr, ns, 'HOTTSemantic_' .. token_type, prev_line, byte_start, byte_end)
          else
            print(line, prev_start, data[i], data[i + 1], data[i + 2], data[i + 3])
          end
        end
      end
      vim.notify(vim.fn.expand('%:t') .. ' semantically highlighted', vim.log.levels.INFO)
    end
  },
}

vim.cmd [[highlight link HOTTSemantic_typ Include]]   -- Type constructors
vim.cmd [[highlight link HOTTSemantic_let_var Identifier]] -- Functions names
vim.cmd [[highlight HOTTSemantic_bound_var guifg=gray]] -- Bound variables
vim.cmd [[highlight link HOTTSemantic_keyword Structure]]  -- Keywords
vim.cmd [[highlight HOTTSemantic_comment guifg=#99ccff]]  -- Comments
vim.cmd [[highlight link HOTTSemantic_unsolved_meta Question]]  -- Holes
vim.cmd [[highlight link HOTTSemantic_solved_meta Character]]  -- Holes
vim.cmd [[highlight link HOTTSemantic_elim Identifier]]
vim.cmd [[highlight link HOTTSemantic_elem String]]

function HottInfer(expr)
  vim.lsp.buf_request(0, "workspace/executeCommand", {command = "infer",
    arguments = {expr}}, function(err, result, context, config)
      print(result)
      vim.fn.setreg('x', result)
  end)
end

function HottNormaliseSelection()
  local arg = vim.lsp.util.make_given_range_params()
  local data = {{uri = arg.textDocument.uri, range = arg.range}}
  -- print(vim.inspect(data))
  vim.lsp.buf_request(0, "workspace/executeCommand",
   { command = "normaliseSelection",
     arguments = data}
   , function(err, result, context, config)
       -- print(result)
       vim.lsp.handlers.hover(err, {contents = result, range = arg.range}, context, config)
     end)
end

function HottInferSelection()
  local arg = vim.lsp.util.make_given_range_params()
  local data = {{uri = arg.textDocument.uri, range = arg.range}}
  -- print(vim.inspect(data))
  vim.lsp.buf_request(0, "workspace/executeCommand",
   { command = "inferSelection",
     arguments = data}
   , function(err, result, context, config)
       -- print(result)
       vim.lsp.handlers.hover(err, {contents = result, range = arg.range}, context, config)
       vim.fn.setreg('x', result)
     end)
end

function HottApplySigmaContract()
  local arg = vim.lsp.util.make_given_range_params()
  local data = {{uri = arg.textDocument.uri, range = arg.range}}
  -- print(vim.inspect(data))
  vim.lsp.buf_request(0, "workspace/executeCommand",
   { command = "sigmaContractSelection",
     arguments = data}
   , function(err, result, context, config)
       -- print(result)
       vim.lsp.handlers.hover(err, {contents = result, range = arg.range}, context, config)
     end)
end

function HottApplySigmaExpand()
  local arg = vim.lsp.util.make_given_range_params()
  local data = {{uri = arg.textDocument.uri, range = arg.range}}
  -- print(vim.inspect(data))
  vim.lsp.buf_request(0, "workspace/executeCommand",
   { command = "sigmaExpandSelection",
     arguments = data}
   , function(err, result, context, config)
       -- print(result)
       vim.lsp.handlers.hover(err, {contents = result, range = arg.range}, context, config)
     end)
end

function HottApplyEquiv(ruleName)
  local arg = vim.lsp.util.make_given_range_params()
  local data = {{expression = ruleName, uri = arg.textDocument.uri, range = arg.range}}
  -- print(vim.inspect(data))
  vim.lsp.buf_request(0, "workspace/executeCommand",
   { command = "applyEquivSelection",
     arguments = data}
   , function(err, result, context, config)
       -- print(result)
       vim.lsp.handlers.hover(err, {contents = result, range = arg.range}, context, config)
     end)
end

function HottApplyEqual(ruleName, toFlip)
  local arg = vim.lsp.util.make_given_range_params()
  local data = {{expression = ruleName, bool = toFlip, uri = arg.textDocument.uri, range = arg.range}}
  -- print(vim.inspect(data))
  vim.lsp.buf_request(0, "workspace/executeCommand",
   { command = "applyEqualSelection",
     arguments = data}
   , function(err, result, context, config)
       -- print(result)
       vim.lsp.handlers.hover(err, {contents = result, range = arg.range}, context, config)
     end)
end


function GetVisuallySelectedText()
  local s = vim.api.nvim_buf_get_mark(0, "<")
  local e = vim.api.nvim_buf_get_mark(0, ">")
  local buildup = ""
  if not (s[1] == e[1]) then
    buildup = vim.fn.getline(s[1]):sub(s[2] + 1, -1)
    for line = s[1] + 1, e[1] do
      buildup = buildup .. "\n" .. vim.fn.getline(line)
    end
    buildup = buildup .. "\n" .. vim.fn.getline(e[1] + 1):sub(1, e[2] + 1)
  else
   buildup = vim.fn.getline(s[1]):sub(s[2] + 1, e[2] + 1)
  end
  print(buildup)
  return buildup
end

function HottInferInContext(expr)
  local arg = vim.lsp.util.make_position_params()
  local data = {{expression = expr, uri = arg.textDocument.uri, position = arg.position}}
  -- print(vim.inspect(data))
  vim.lsp.buf_request(0, "workspace/executeCommand",
   { command = "inferInContext",
     arguments = data}
   , function(err, result, context, config)
       print(result)
       vim.fn.setreg('x', result)
     end)
end

function HottContextInfo()
  local arg = vim.lsp.util.make_position_params()
  local data = {{expression = "", uri = arg.textDocument.uri, position = arg.position}}
  -- print(vim.inspect(data))
  vim.lsp.buf_request(0, "workspace/executeCommand",
   { command = "contextInfo",
     arguments = data}
   , function(err, result, context, config)
       print(result)
       vim.fn.setreg('x', result)
     end)
end

function HottFillSelection(expr)
  local arg = vim.lsp.util.make_given_range_params()
  local data = {{expression = expr, uri = arg.textDocument.uri, range = arg.range}}
  -- print(vim.inspect(data))
  vim.lsp.buf_request(0, "workspace/executeCommand",
   { command = "fillSelection",
     arguments = data}
   , function(err, result, context, config)
       print(result)
       vim.fn.setreg('x', result)
     end)
end

-- execute visually selected code block (HOTT)
vim.api.nvim_set_keymap('v', '<C-x><C-e>t', ':lua GetVisuallySelectedText()<CR>',
                        {noremap = true, silent = true})

vim.api.nvim_set_keymap('v', '<C-x><C-e>hi', ':lua HottInfer(GetVisuallySelectedText())<CR>',
                        {noremap = true, silent = true})

vim.api.nvim_set_keymap('v', '<localleader>i', '<esc>:lua HottInferSelection()<CR>',
                        {noremap = true, silent = true})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufEnter" }, {
  pattern = { "*.hott" },
  callback = function(_)
    vim.bo.filetype = "hott"
  end,
  desc = "Assigns a file type to files with .hott extension.",
})

local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
if not configs.massimult_lsp then
  configs.massimult_lsp = {
    default_config = {
      cmd = {'massimult-lsp'}; -- if not available in PATH, provide the absolute path
      filetypes = {'massimult'};
      on_new_config = function(new_config, new_root_dir)
        new_config.cmd = {'/Users/russoul/.local/state/pack/install/0e9b01d0400593fa99b320c56f6e77406a4eb968/massimult-lsp/0bde31fea26593f2ba0577080cb931ac/bin/massimult-lsp'}
        new_config.capabilities['workspace']['semanticTokens'] = {refreshSupport = true}
      end;
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname)
      end;
      settings = {};
    };
  }
end
-- Flag to enable semantic highlightning on start, if false you have to issue the first command manually
local autostart_semantic_highlightning = true
lspconfig.massimult_lsp.setup {
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
    ['textDocument/semanticTokens/full'] = function(err, result, ctx, _)
      if err ~= nil then
          vim.notify(tostring(err), vim.log.levels.ERROR)
          return
      end
      if not result then return end
      -- temporary handler until native support lands
      local bufnr = ctx.bufnr
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if(not client) then print("Massimult LSP: Client not initialised yet") return end
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
        -- print("line", line, "column", prev_start)
        if (vim.fn.strchars(line) >= prev_start) then
          local byte_start = vim.str_byteindex(line, "utf-32", prev_start)
          if prev_start + data[i + 2] >= 0 and prev_start + data[i + 2] <= vim.fn.strchars(line) then
            local byte_end = vim.str_byteindex(line, "utf-32", prev_start + data[i + 2])
            vim.api.nvim_buf_add_highlight(bufnr, ns, 'MassimultSemantic_' .. token_type, prev_line, byte_start, byte_end)
          else
            print(line, prev_start, data[i], data[i + 1], data[i + 2], data[i + 3])
          end
        end
      end
      vim.notify(vim.fn.expand('%:t') .. ' semantically highlighted', vim.log.levels.INFO)
    end
  },
}

vim.cmd [[highlight MassimultSemantic_local guifg=gray]] -- Bound variables
vim.cmd [[highlight link MassimultSemantic_function Identifier]]
vim.cmd [[highlight link MassimultSemantic_namespace Include]]   -- Type constructors
vim.cmd [[highlight link MassimultSemantic_keyword Structure]]  -- Keywords
vim.cmd [[highlight link MassimultSemantic_hole Question]]  -- Holes
vim.cmd [[highlight link MassimultSemantic_constructor String]]
vim.cmd [[highlight link MassimultSemantic_typeconstructor Include]]
vim.cmd [[highlight MassimultSemantic_typevar guifg=skyblue]]
vim.cmd [[highlight MassimultSemantic_comment guifg=#99ccff]]  -- Comments

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufEnter" }, {
  pattern = { "*.lm" },
  callback = function(_)
    vim.bo.filetype = "massimult"
  end,
  desc = "Assigns a file type to files with .lm extension.",
})


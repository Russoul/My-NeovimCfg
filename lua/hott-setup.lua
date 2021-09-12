local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
if not lspconfig.hott_lsp then
  configs.hott_lsp = {
    default_config = {
      cmd = {'hott-lsp'}; -- if not available in PATH, provide the absolute path
      filetypes = {'hott'};
      on_new_config = function(new_config, new_root_dir)
        new_config.cmd = {'hott-lsp'}
        new_config.capabilities['workspace']['semanticTokens'] = {refreshSupport = true}
      end;
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      settings = {};
    };
  }
end
-- Flag to enable semantic highlightning on start, if false you have to issue a first command manually
local autostart_semantic_highlightning = true
lspconfig.hott_lsp.setup {
  on_init = custom_init,
  on_attach = function(client)
    if autostart_semantic_highlightning then
      vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
        { textDocument = vim.lsp.util.make_text_document_params() }, nil)
    end
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

      local ns = vim.api.nvim_create_namespace('nvim-hott-lsp-semantic')
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
        local byte_start = vim.str_byteindex(line, prev_start)
        local byte_end = vim.str_byteindex(line, prev_start + data[i + 2])
        vim.api.nvim_buf_add_highlight(bufnr, ns, 'HOTTSemantic_' .. token_type, prev_line, byte_start, byte_end)
      end
    end
  },
}

vim.cmd [[highlight link HOTTSemantic_universe Include]]   -- Type constructors
vim.cmd [[highlight link HOTTSemantic_ref Identifier]] -- Functions names
vim.cmd [[highlight HOTTSemantic_var guifg=gray]] -- Bound variables
vim.cmd [[highlight link HOTTSemantic_keyword Structure]]  -- Keywords
vim.cmd [[highlight HOTTSemantic_comment guifg=#99ccff]]  -- Comments

vim.lsp.config('hls', {
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  haskell = {
    cabalFormattingProvider = "cabalfmt",
    formattingProvider = "stylish-haskell",
  }
})

require('haskell-tools').project.root_dir = function(_) return vim.fn.getcwd() end
require('haskell-tools.config.internal').hls.default_settings.haskell.formattingProvider = 'stylish-haskell'
require('haskell-tools.config.internal').hls.default_settings.haskell.plugin = {
    semanticTokens = { globalOn = true }
}

local ht = require('haskell-tools')
local opts = { noremap = true, silent = true }
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
-- Evaluate all code snippets
vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>rf', function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)
vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)

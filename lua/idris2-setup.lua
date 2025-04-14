-- Regexp highlighting colours override
vim.cmd [[hi idrisOperators guifg=#FBAB00]]
vim.cmd [[hi link idrisStatement Structure]]
vim.cmd [[hi idrisDocComment guifg=#99ccff]]

-- Semantic highlighting colours override
vim.cmd([[highlight @lsp.type.variable.idris2 guifg=Gray]])
vim.cmd([[highlight link @lsp.type.enumMember.idris2 Number]])
vim.cmd([[highlight link @lsp.type.function.idris2 Identifier]])
vim.cmd([[highlight link @lsp.type.type.idris2 Include]])
vim.cmd([[highlight link @lsp.type.keyword.idris2 Structure]])
vim.cmd([[highlight link @lsp.type.namespace.idris2 Import]])
vim.cmd([[highlight @lsp.type.postulate.idris2 guifg=Red]])
vim.cmd([[highlight link @lsp.type.module.idris2 Import]])

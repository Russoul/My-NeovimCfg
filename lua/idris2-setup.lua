-- Regexp highlighting colours override
vim.cmd [[hi idrisOperators guifg=#FBAB00]]
vim.cmd [[hi link idrisStatement Structure]]
vim.cmd [[hi idrisDocComment guifg=#99ccff]]

-- Semantic highlighting colours override
vim.cmd [[highlight link LspSemantic_type       Include   ]] -- Type constructors
vim.cmd [[highlight link LspSemantic_function   Identifier]] -- Functions names
vim.cmd [[highlight link LspSemantic_enumMember Number    ]] -- Data constructors
vim.cmd [[highlight      LspSemantic_variable   guifg=Gray]] -- Bound variables
vim.cmd [[highlight link LspSemantic_keyword    Structure ]] -- Keywords
vim.cmd [[highlight      LspSemantic_postulate  guifg=Red ]] -- Postulates
vim.cmd [[highlight link LspSemantic_module     Import    ]] -- Not used?

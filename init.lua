----------- NVIM CONFIG (ver 0.10.0) ------------

local g = vim.g
local o = vim.o
local fn = vim.fn

------------- Basic options --------------

-- A keymap for openning the init.lua file from anywhere
vim.cmd [[nnoremap <C-x>cf :e $MYVIMRC<CR>]]

g.mapleader = '|'
g.main_config_file_dir = os.getenv("HOME") .. "/.config/nvim"
g.python3_host_prog = '/usr/bin/python3'
-- disable netrw at the very start of your init.lua
g.loaded_netrwPlugin = 1

-- This setting helps to avoid encoding issues when
-- writing unicode to clipboard (the `+` register)
vim.env.LANG = 'en_US.UTF-8'

o.virtualedit = 'block'
o.shiftwidth = 2
o.tabstop = 2
-- Tabs are not present in source, always expanded to spaces
o.expandtab = true
o.smartcase = true
o.ignorecase = true
o.maxfuncdepth = 10000
-- Tell Vim to wait indefinitely for further input when pressing a prefix key
o.timeout = false
-- Enables mouse in all modes
o.mouse = 'a'
o.wildmenu = true
o.wildmode = 'list'
o.history = 200
o.scrollback = 100000
-- Set path to your preferred shell here
o.shell = '/opt/homebrew/bin/fish'
-- Time period at the end of which the swap file is being writen to disk.
o.updatetime = 100
-- Previews changes done in interactive commands
o.inccommand = 'nosplit'
-- Allow up to 3 signs to be rendered simultaneously
o.signcolumn = 'auto:3'

----------------- Lazy package manager --------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Latex plugin
    { 'lervag/vimtex',                   tag = 'v2.15' },
    -- A theme
    { 'https://github.com/rakr/vim-one', commit = '187f5c85b682c1933f8780d4d419c55d26a82e24' },
    -- Draws a box over the outline of the selection
    { 'jbyuki/venn.nvim',                commit = '71856b548e3206e33bad10acea294ca8b44327ee' },
    -- A git plugin
    { 'tpope/vim-fugitive',              commit = 'f529acef74b4266d94f22414c60b4a8930c1e0f3' },
    -- A UI for git
    require('neogit-plugin'),
    -- Align lines of code in one command with many options of doing it
    { 'godlygeek/tabular',                              commit = '339091ac4dd1f17e225fe7d57b48aff55f99b23a' },
    -- Commenting code
    { 'numToStr/Comment.nvim' },
    -- Surrounding text with delimiters
    { 'https://tpope.io/vim/surround.git',              commit = 'bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea' },
    -- Repeating complex commands; often plugins require
    -- this as a dependency in order for the repeat (.) to work properly
    { 'https://tpope.io/vim/repeat.git',                commit = '24afe922e6a05891756ecf331f39a1f6743d3d5a' },
    -- Nice directory tree view
    { 'kyazdani42/nvim-tree.lua',                       commit = '2086e564c4d23fea714e8a6d63b881e551af2f41' },
    -- The best theme ever (subjectively of course) !
    { 'https://github.com/joshdick/onedark.vim.git',    commit = '7db2ed5b825a311d0f6d12694d4738cf60106dc8' },
    -- Renders a special line at the bottom of each window that reflects user info
    { 'nvim-lualine/lualine.nvim',                      dependencies = { 'nvim-tree/nvim-web-devicons' } },
    -- Nice when you can't keep up with your cursor movements all around the frame
    -- (Dims all windows except the one the cursor is currently in)
    { 'https://github.com/blueyed/vim-diminactive.git', commit = '6f2e14e6ff6a038285937c378ec3685e6ff7ee36' },
    -- LSP configs
    { 'neovim/nvim-lspconfig',                          commit = 'f43135c38a37c588053ad5e209c7460f43f6340c' },
    -- Used by Telescope
    { 'nvim-lua/popup.nvim',                            commit = 'b7404d35d5d3548a82149238289fa71f7f6de4ac' },
    -- Used by many plugins
    { 'nvim-lua/plenary.nvim',                          commit = 'a3e3bc82a3f95c5ed0d7201546d5d2c19b20d683' },
    -- Handles (multiple) choice generically & comes with a few useful finders
    { 'nvim-telescope/telescope.nvim',                  commit = '61a4a615366c470a4e9ca8f8b45718b6b92af73f' },
    -- Icons
    { 'kyazdani42/nvim-web-devicons',                   commit = 'c0cfc1738361b5da1cd0a962dd6f774cc444f856' },
    -- Manage git workflow
    { 'pwntester/octo.nvim',                            commit = '44060b7' },
    -- Successor of Signify for Neovim, Lua
    { 'lewis6991/gitsigns.nvim',                        commit = '0dc886637f9686b7cfd245a4726f93abeab19d4a' },
    -- Stand-in for VimSneak (works differently)
    { 'ggandor/leap.nvim' },
    -- Highlights in colour special symbols like:
    --   * TODO:
    --   * NOTE:
    --   * FIX:
    --   * PERF:
    --   * HACK:
    --   * IDEA:
    --   * REFACTOR:
    --   and additionally marks lines with signs
    { 'folke/todo-comments.nvim',                       commit = '98b1ebf198836bdc226c0562b9f906584e6c400e' },
    -- Idris 2 LSP client
    { 'Russoul/idris2-nvim',                            commit = '313a96bf2d6246cd84cad3eeee36801fda0e9b7b', opts = {} },
    -- UI component library
    { 'MunifTanjim/nui.nvim',                           commit = '322978c734866996274467de084a95e4f9b5e0b1' },
    { 'derekelkins/agda-vim' },
    -- Terminal
    { 'akinsho/toggleterm.nvim',                        commit = '265bbff68fbb8b2a5fb011272ec469850254ec9f' },
    -- Buffers that contain past searches and cmds
    { 'notomo/cmdbuf.nvim',                             commit = 'e6b37e80cab18368d64184557c3a956cafa4ced7' },
    -- Tabs at the top of the screen
    { 'akinsho/bufferline.nvim',                        commit = '81820cac7c85e51e4cf179f8a66d13dbf7b032d9' },
    -- Preview markdown files
    -- {'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'}
    -- Plugin for telescope that allows one to seach for an emoji
    { 'xiyaowong/telescope-emoji.nvim',                 commit = '86248d97be84a1ce83f0541500ef9edc99ea2aa1' },
    -- Plugin configuration end
    { 'simrat39/rust-tools.nvim' },
    -- Metals LSP client for scala lang
    require('metals-plugin'),
    -- Plugin that enables fugitive's GBrowse open links to private repos?
    { 'https://github.com/tpope/vim-rhubarb' },
    -- Plugin that enables fugitive's GBrowse open links to gitlab repos
    {
      'shumphrey/fugitive-gitlab.vim',
      config = function()
        vim.g.fugitive_gitlab_domains = { ["gitlab.onairent.live"] = "https://gitlab.onairent.live" }
      end
    },
    -- A buffer for showing diagnostics, references, telescope results, quickfix and location lists
    require('trouble-plugin'),
    -- Show git blame
    { 'FabijanZulj/blame.nvim',              commit = '3e6b2ef4905982cd7d26eb5b18b0e761138eb5ab' },
    -- Highlight text via Neovims visual highlighting mechanism
    -- The plugin is buggy. Let's keep it here for now, maybe it will be stabilised in the feature
    { 'Pocco81/HighStr.nvim' },
    { "Russoul/abbrev-expand.nvim" },
    -- Helpful for finding out what keys are mapped to interatively
    require('which-key-plugin'),
    -- Typescript LSP
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
    },
    -- Subword textobj and more
    {
      "chrisgrieser/nvim-various-textobjs",
      keys = {},
    },
    -- Motions defined for moving around camel-case words
    { "chrisgrieser/nvim-spider" },
    {
      "yorickpeterse/nvim-window",
      keys = {
        { "<leader>wj", "<cmd>lua require('nvim-window').pick()<cr>", desc = "nvim-window: Jump to window" },
      },
      config = true,
    },
    require('fzf-lua-plugin'),
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/nvim-cmp' }

  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

---------- Persistent undo ----------
if fn.has('persistent_undo') == 1 then
  o.undofile = true
  o.undodir = os.getenv("HOME") .. "/.config/nvim/undo"
end

---------- Enable line numbers for particular file types -------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vim,idris2,python,javascript,lua,c,hott,nova,txt,agda,scala,cpp,h",
  callback = function(_)
    vim.o.number = true
  end,
  desc = "Shows a numeration column on the left edge of the window",
})


---------- Toggle latest search highlight ---------
vim.api.nvim_set_keymap(
  'n',
  '<Leader><Space>',
  '', {
    callback = function() vim.o.hlsearch = not vim.o.hlsearch end,
    noremap = true,
    silent = true
  }
)

----------------- Execute selection ----------------

-- execute visually selected code block (vimL)
vim.api.nvim_set_keymap(
  'v',
  '<C-x><C-e>v',
  '"xy:@x<CR>',
  { noremap = false, silent = true }
)

-- execute visually selected code block (Lua)
vim.api.nvim_set_keymap(
  'v',
  '<C-x><C-e>l',
  '"xy:execute(":lua " . @x)<CR>',
  { noremap = false, silent = true }
)

-------- Highlight on yank (vanity) ----------
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function(_)
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 100, on_visual = true }
  end,
  desc = "Briefly highlights yanked text.",
})

-------- Cursor shape/colour, colour theme, colour palette --------
-- Set theme and cursor shape/color
if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

vim.cmd [[colorscheme onedark]]
o.guicursor = 'n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor'

-- Colour palette setup
vim.cmd [[hi Error ctermfg=204 guifg=#FF0000]]
vim.cmd [[hi Conceal guifg=#FBAB00]]
vim.cmd [[hi todo guifg=#CCCC00]]
vim.cmd [[hi ColorColumn guibg=#303541]]
vim.cmd [[hi Search guifg=black guibg=orange4]]
vim.cmd [[hi @variable ctermfg=59 guifg=#5c6370]]
vim.cmd [[hi Comment ctermfg=59 guifg=#99ccff]]

------------------ Fundamental motions ----------------
--   Main movement remaps
--                 i
--                 ^
--   I use         |
--           j <--- --->  l
--                 |
--   For           v
--    movement     k
--

vim.cmd [[map <S-l> <nop>]]
vim.cmd [[noremap <S-j> ^]]
vim.cmd [[noremap <S-l> g_]]
vim.cmd [[nnoremap k <Down>]]
vim.cmd [[nnoremap j <Left>]]
vim.cmd [[nnoremap i <Up>]]
vim.cmd [[vnoremap k <Down>]]
vim.cmd [[vnoremap j <Left>]]
vim.cmd [[vnoremap i <Up>]]
vim.cmd [[vnoremap I i]]
vim.cmd [[nnoremap h i]]
vim.cmd [[vnoremap h i]]
vim.cmd [[nnoremap H I]]
vim.cmd [[vnoremap H I]]
vim.cmd [[nnoremap <C-P> <C-I>]]
vim.cmd [[nnoremap I <nop>]]

-- Jump to the start/end of a line in insert/cmd modes
vim.cmd [[inoremap <C-j> <C-o>^]]
vim.cmd [[inoremap <C-l> <C-o>$]]
vim.cmd [[cnoremap <C-j> <C-b>]]
vim.cmd [[cnoremap <C-l> <C-e>]]

-- terminal escape sequence
-- I'm ok with <C-v> because I'm on Mac (<D-v> is used for pasting)
vim.api.nvim_set_keymap(
  't',
  '<C-v><Esc>',
  '<C-\\><C-n>',
  { noremap = true, silent = true }
)

-- remap of join
vim.api.nvim_set_keymap(
  'n',
  '<Space>j',
  ':join<CR>',
  { noremap = true, silent = true }
)

-- unmap this built-in command, else it messes up with the commands below
vim.api.nvim_set_keymap(
  '',
  '<C-x>',
  '',
  { noremap = true, silent = true }
)


---------- Trailing whitespace cleanup ------------
function StripTrailingWhitespace()
  local l = fn.line(".")
  local c = fn.col(".")
  vim.cmd [[%s/\s\+$//e]]
  fn.cursor(l, c)
end

-- Creating a custom user command in 0.7
vim.api.nvim_create_user_command("StripTrailingWhitespace", function(_)
  StripTrailingWhitespace()
end, {
  nargs = "?",
  desc = "Strips trailing whitespace.",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(_) StripTrailingWhitespace() end,
  desc = "Strips whitespace on file writes.",
})

------------------ Buffers -------------------

-- Close all buffers except this one (caveat: doesn't keep the cursor position)
vim.cmd [[nnoremap <silent> <C-x>qab :%bd\|e#<CR>]]
vim.cmd [[nnoremap <silent> <C-x>qb :b#<bar>bd#<CR>]]

-- Switch to the alternate buffer
vim.cmd [[nnoremap <C-u> <C-^>]]

------------------ Window manipulation interface (custom plugin) -----------------
vim.cmd [[execute("source " . g:main_config_file_dir . "/config/window_manip.vim")]]

-------------- Jumping inside buffer only (custom plugin) ----------------
vim.cmd [[execute("source " . g:main_config_file_dir . "/config/jumping.vim")]]

-- Those two commands allow one to jump back and forth
-- the jump list but only moving along the lines in the current buffer
vim.cmd [[nnoremap <silent> <Space><C-I> :call JumpNextInBuf()<CR>]]
vim.cmd [[nnoremap <silent> <Space><C-O> :call JumpPrevInBuf()<CR>]]

----------------- Git Signs ----------------
require('gitsigns-setup')

---------- abbrev-expand ----------
-- TODO: make this work in terminals and popup windows, like one found in telescope
require('abbrev-expand').setup(require('abbrev-expand-setup'))

------------------- Octo --------------------
require('octo-setup')

---------------- TODO comments ---------------
require('todo-comments-setup')

------------------ Dev Icons -------------------
require("nvim-web-devicons").setup { default = true }

------------------ Lua Line --------------------
require("lualine-setup")

------------------ Yaml LSP --------------------
require('lspconfig').yamlls.setup {}

------------------- Telescope ------------------
require('telescope-setup')

-------------- Moving selection around (custom plugin) -------------
vim.api.nvim_set_keymap('v', '<C-k>', ":lua require('move').moveSelectionDown()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-i>', ":lua require('move').moveSelectionUp()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-l>', ":lua require('move').moveSelectionRight()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-j>', ":lua require('move').moveSelectionLeft()<CR>", { noremap = true, silent = true })

--------------- CmdBuf ---------------
vim.cmd [[noremap q: <Cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight)<CR>]]
vim.cmd [[cnoremap <C-f> <Cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, {line = vim.fn.getcmdline(), column = vim.fn.getcmdpos()})<CR><C-c>]]

-- open lua command-line window
vim.cmd [[nnoremap ql <Cmd>lua require('cmdbuf').split_open( vim.o.cmdwinheight, {type = "lua/cmd"})<CR>]]

vim.cmd [[nnoremap <C-x>x <Cmd>lua require('cmdbuf').execute()<CR>]]

-- q/, q? alternative
vim.cmd [[nnoremap q/ <Cmd>lua require('cmdbuf').split_open(
  \ vim.o.cmdwinheight,
  \ {type = "vim/search/forward"}
  \ )<CR>]]
vim.cmd [[nnoremap q? <Cmd>lua require('cmdbuf').split_open(
  \ vim.o.cmdwinheight,
  \ {type = "vim/search/backward"}
  \ )<CR>]]

-------------- ToggleTerm -------------
require('toggleterm').setup {
  shade_terminals = false,
  start_in_insert = false,
  auto_scroll = false,
}

vim.cmd [[nnoremap <silent> <C-w>t :ToggleTerm<CR>]]

-- Open an existing terminal instance in the current window.
vim.cmd [[nnoremap <silent> <C-w>t :ToggleTerm<CR>]]

------------  Nvim Tree ---------------
require('nvim-tree-setup')

----------- Comment ------------
require('Comment').setup()

------------ LEAP -------------
require('leap-setup')

--------------- Virtual highlight (high-str) ----------------
require("high-str").setup({
  verbosity = 0,
  saving_path = "/tmp/highstr/",
  highlight_colors = {
    -- color_id = {"bg_hex_code",<"fg_hex_code"/"smart">}
    color_0 = { "#0c0d0e", "smart" }, -- Cosmic charcoal
    color_1 = { "#e5c07b", "smart" }, -- Pastel yellow
    color_2 = { "#7FFFD4", "smart" }, -- Aqua menthe
    color_3 = { "#8A2BE2", "smart" }, -- Proton purple
    color_4 = { "#FF4500", "smart" }, -- Orange red
    color_5 = { "#008000", "smart" }, -- Office green
    color_6 = { "#0000FF", "smart" }, -- Just blue
    color_7 = { "#FFC0CB", "smart" }, -- Blush pink
    color_8 = { "#FFF9E3", "smart" }, -- Cosmic latte
    color_9 = { "#7d5c34", "smart" }, -- Fallow brown
  }
})

------------- Buffer Line -------------
require('bufferline').setup {
  options = { mode = "tabs", numbers = "ordinal" }
}

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
vim.cmd [[nnoremap <silent>]b :BufferLineCycleNext<CR>]]
vim.cmd [[nnoremap <silent>[b :BufferLineCyclePrev<CR>]]

----------------- General LSP mappings ------------------
vim.api.nvim_set_keymap('n', '<LocalLeader>j', ':lua vim.lsp.buf.definition()<CR>',
  { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<LocalLeader>h', ':lua vim.lsp.buf.hover()<CR>',
  { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<LocalLeader>a', ':FzfLua lsp_code_actions<CR>',
  { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<LocalLeader>d', ':lua vim.lsp.buf.signature_help()<CR>',
  { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<LocalLeader>f', ':lua vim.lsp.buf.format()<CR>',
  { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<LocalLeader>i', ':lua vim.lsp.buf.implementation()<CR>',
  { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<LocalLeader>r', ':lua vim.lsp.buf.references()<CR>',
  { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', ']d', ':lua vim.diagnostic.goto_next()<CR>',
  { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>',
  { noremap = true, silent = false })


-------------- Lua LSP ----------------
require('lua-setup')

------------- C/C++ LSP ---------------
require('lspconfig').clangd.setup {}

--------------- Rust --------------
require('rust-setup')

--------------- JSON ----------------
require('lspconfig').jsonls.setup {}

--------------- Idris2 --------------
require('idris2-setup')

----------------- Nova ----------------
require("nova-setup")

----------------- Homotopy Objective Type Theory ----------------
require("hott-setup")

----------------- nvim-various-textojbs ----------------
require('various-textobjs-setup')

---------------- nvim-spider --------------
require('spider-setup')

----------------- nvim-cmp --------------
require('cmp-setup')

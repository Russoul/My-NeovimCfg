-- SUPPORTED NVIM VERSION: 0.9.1


local g = vim.g
local o = vim.o
local api = vim.api
local fn = vim.fn

g.mapleader = '|'
g.main_config_file_dir = "$HOME/.config/nvim"

vim.cmd[[nnoremap <C-x>cf :e $MYVIMRC<CR>]]

-- This setting helps to avoid encoding issues when
-- writing unicode to clipboard (the `+` register)
vim.env.LANG = 'en_US.UTF-8'

api.nvim_set_keymap (
  'n',
  '<C-x>f',
  ':e $MYVIMRC<CR>',
  {noremap = true, silent = true}
)

o.virtualedit = 'block'
o.shiftwidth = 2
o.tabstop = 1
o.smartcase = true
o.ignorecase = true

o.maxfuncdepth = 10000
-- Tabs are not present in source, always expanded to spaces
o.expandtab = true
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

-- Keep undo history after exit
if vim.fn.has('persistent_undo') == 1 then
  vim.o.undofile = true
  vim.o.undodir="/Users/feizerakhmanov/.config/nvim/undo"
end
-- ----------------------------

-- Sidenote:
-- Use neovim-remote !
-- nvr --remote
-- opens a file in the running neovim instance
-- UPDATE: seems like the project has been dead
-- -------------

-- -- TODO: use packer instead
-- Plugin configuration start
vim.cmd[[call plug#begin()]]
-- Latex plugin
vim.cmd[[Plug 'lervag/vimtex', {'commit' : '534fd725f2475a9083b032e402c7e73b8a3fc6bb'}]]
-- Interprets ansi codes in a buffer.
vim.cmd[[Plug 'm00qek/baleia.nvim', { 'tag': 'v1.2.0' }]]
vim.cmd[[Plug 'https://github.com/Shougo/deol.nvim', {'commit' : '51d2367d3373457327e583819c00381387b8c51e'}]]
-- A theme
vim.cmd[[Plug 'https://github.com/rakr/vim-one', {'commit' : '187f5c85b682c1933f8780d4d419c55d26a82e24'}]]
-- Draws a box over the outline of the selection
vim.cmd[[Plug 'jbyuki/venn.nvim', {'commit' : 'c114563960b8fb1197695d42798d1f3e7190b798'}]]
-- Idris 2 integration
-- Edwin's original plugin. Used here for syntax highlighting only
-- Plug 'https://github.com/edwinb/idris2-vim'
-- A git plugin
vim.cmd[[Plug 'tpope/vim-fugitive', {'commit' : '572c8510123cbde02e8a1dafcd376c98e1e13f43'}]]
vim.cmd[[Plug 'shumphrey/fugitive-gitlab.vim']]
-- Align lines of code in one command with many options of doing it
vim.cmd[[Plug 'godlygeek/tabular', {'commit' : '187f5c85b682c1933f8780d4d419c55d26a82e24'}]]
-- Commenting code (Neovim 0.5, Lua)
vim.cmd[[Plug 'b3nj5m1n/kommentary', {'commit' : '187f5c85b682c1933f8780d4d419c55d26a82e24'}]]
-- Surrounding text with delimiters
vim.cmd[[Plug 'https://tpope.io/vim/surround.git', {'commit' : '3d188ed2113431cf8dac77be61b842acb64433d9'}]]
-- Repeating complex commands; often plugins require
-- this as a dependency in order for the repeat (.) to work properly
vim.cmd[[Plug 'https://tpope.io/vim/repeat.git', {'commit' : '24afe922e6a05891756ecf331f39a1f6743d3d5a'}]]
-- Nice directory tree view (Neovim 0.5, Lua)
vim.cmd[[Plug 'kyazdani42/nvim-tree.lua', {'commit' : '00741206c2df9c4b538055def19b99790f0c95c8'}]]
-- The best theme ever (subjectively of course) !
vim.cmd[[Plug 'https://github.com/joshdick/onedark.vim.git', {'commit' : '57b77747694ea5676c3ca0eeaf9567dc499730c0'}]]
-- Renders a special line at the bottom of each window that reflects user info
-- (programmable, Neovim 0.5, Lua)
vim.cmd[[Plug 'nvim-lualine/lualine.nvim', {'commit' : '45e27ca739c7be6c49e5496d14fcf45a303c3a63'}]]
-- Motions defined for moving around camel-case words
vim.cmd[[Plug 'https://github.com/bkad/CamelCaseMotion.git', {'commit' : 'de439d7c06cffd0839a29045a103fe4b44b15cdc'}]]
-- Nice when you can't keep up with your cursor movements all around the frame
-- (Dims all windows except the one the cursor is currently in)
-- TODO: Try getting by without this one?
vim.cmd[[Plug 'https://github.com/blueyed/vim-diminactive.git', {'commit' : '6f2e14e6ff6a038285937c378ec3685e6ff7ee36'}]]
-- Async completion framework
vim.cmd[[Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' , 'commit' : '62dd0192786a4e2429c60b29e16f8390bd65060d'}]]
-- Pretty smart general completion (though not nearly as smart as they claim)
vim.cmd[[Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' , 'commit' : '187f5c85b682c1933f8780d4d419c55d26a82e24'}]]

vim.cmd[[Plug 'sonph/onehalf', {'rtp': 'vim/', 'commit' : '75eb2e97acd74660779fed8380989ee7891eec56'}]]
-- Create and manage terminal instances in Vim
-- TODO: Find a replacement for this one, favourably targeting Neovim 0.5, Lua
-- Plug 'kassio/neoterm'
-- Colourful parentheses
vim.cmd[[Plug 'luochen1990/rainbow', {'commit' : '61f719aebe0dc5c3048330c50db72cfee1afdd34'}]]
-- LSP configs
vim.cmd[[Plug 'neovim/nvim-lspconfig', {'commit' : 'a27356f1ef9c11e1f459cc96a3fcac5c265e72d6'}]]
-- Plug 'gwerbin/nvim-lspconfig', {'branch': 'gwerbin/idris2-lsp'}
-- Used by Telescope
vim.cmd[[Plug 'nvim-lua/popup.nvim', {'commit' : 'b7404d35d5d3548a82149238289fa71f7f6de4ac'}]]
-- Used by many plugins
vim.cmd[[Plug 'nvim-lua/plenary.nvim', {'commit' : '0dbe561ae023f02c2fb772b879e905055b939ce3'}]]
-- Handles (multiple) choice generically & comes with a few useful finders
vim.cmd[[Plug 'nvim-telescope/telescope.nvim', {'commit' : '1dfa66b845673effc8771f9ebe511bb36a09f560'}]]
-- Icons
vim.cmd[[Plug 'kyazdani42/nvim-web-devicons', {'commit' : 'cfc8824cc1db316a276b36517f093baccb8e799a'}]]
-- Manage git workflow
-- Plug 'pwntester/octo.nvim'
-- Successor of Signify for Neovim 0.5, Lua
vim.cmd[[Plug 'lewis6991/gitsigns.nvim', {'commit' : 'd8590288417fef2430f85bc8b312fae8b1cf2c40'}]]
-- In-buffer highlighting of colour codes
-- Plug 'norcalli/nvim-colorizer.lua'
-- Stand-in for EasyMotion based on Neovim 0.5, Lua
vim.cmd[[Plug 'phaazon/hop.nvim', {'commit' : '03f0434869f1f38868618198b5f4f2ab6d39aef2'}]]
-- Stand-in for VimSneak (works differently) targeting Neovim 0.5, Lua
vim.cmd[[Plug 'ggandor/lightspeed.nvim', {'commit' : '299eefa6a9e2d881f1194587c573dad619fdb96f'}]]
--
vim.cmd[[Plug 'folke/todo-comments.nvim', {'commit' : '3094ead8edfa9040de2421deddec55d3762f64d1'}]]
vim.cmd[[Plug 'ShinKage/idris2-nvim', {'branch' : 'main', 'commit' : '8bff02984a33264437e70fd9fff4359679d910da'}]]
vim.cmd[[Plug 'MunifTanjim/nui.nvim', {'commit' : '0f913a3ae1a24c8a4487fbf111b4044cc22b1b0d'}]]
vim.cmd[[Plug 'derekelkins/agda-vim', {'commit' : '4a0f475aaef756702222bdd5b01e25f814f5691f'}]]
vim.cmd[[Plug 'akinsho/toggleterm.nvim', {'commit' : '12cba0a1967b4f3f31903484dec72a6100dcf515'}]]
vim.cmd[[Plug 'notomo/cmdbuf.nvim', {'commit' : 'facbf09bf037ffd5df5293db8e736db569bf4627'}]]
vim.cmd[[Plug 'fedepujol/move.nvim', {'commit' : 'd663b74b4e38f257aae757541c9076b8047844d6'}]]
vim.cmd[[Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }]]
vim.cmd[[Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }]]
-- Plugin for telescope that allows one to seach for an emoji
vim.cmd[[Plug 'xiyaowong/telescope-emoji.nvim', {'commit' : '86248d97be84a1ce83f0541500ef9edc99ea2aa1'}]]
-- Plugin configuration end
vim.cmd[[Plug 'simrat39/rust-tools.nvim', {'commit' : '0cc8adab23117783a0292a0c8a2fbed1005dc645'}]]
vim.cmd[[Plug 'scalameta/nvim-metals', {'commit' : '57cff9a240f3337129188997887d8848fe6022ad'}]]
vim.cmd[[Plug 'folke/trouble.nvim', {'commit' : '3f85d8ed30e97ceeddbbcf80224245d347053711'}]]
vim.cmd[[Plug 'FabijanZulj/blame.nvim', {'commit' : '3e6b2ef4905982cd7d26eb5b18b0e761138eb5ab'}]]
vim.cmd[[call plug#end()]]

-- Highlight on yank (vanity)
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function(args)
        vim.highlight.on_yank {higroup="IncSearch", timeout=100, on_visual=true}
    end,
    desc = "Briefly highlights yanked text.",
})

g.python3_host_prog = '/usr/bin/python3'

g.rainbow_active = false

-- --------------------------------
-- Set theme and cursor shape/color
if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end
vim.cmd[[colorscheme onedark]]
o.guicursor = 'n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor'

-- Colour palette setup
vim.cmd[[hi Error ctermfg=204 guifg=#FF0000]]
vim.cmd[[hi idrisOperators guifg=#FBAB00]]
vim.cmd[[hi idrNiceOperator guifg=#FBAB00]]
vim.cmd[[hi link idrisStatement Structure]]
vim.cmd[[hi Conceal guifg=#FBAB00]]
vim.cmd[[hi todo guifg=#CCCC00]]
vim.cmd[[hi idrisDocComment guifg=#99ccff]]
vim.cmd[[hi link idrisLineComment Comment]]
vim.cmd[[hi link idrisBlockComment Comment]]
vim.cmd[[hi ColorColumn guibg=#303541]]
vim.cmd[[hi Search guifg=black guibg=orange4]]

function StripTrailingWhitespace()
    local l = fn.line(".")
    local c = fn.col(".")
    vim.cmd[[%s/\s\+$//e]]
    fn.cursor(l, c)
end

-- Creating a custom user command in 0.7
api.nvim_create_user_command("StripTrailingWhitespace", function(args)
    StripTrailingWhitespace()
end, {
    nargs = "?",
    desc = "Strips trailing whitespace.",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
      vim.o.shiftwidth = 1
      vim.o.indentkeys = ''
    end,
    desc = "Sets shift width and nullifies indentation keys.",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "vim,idris2,python,javascript,lua,c,hott,nova,txt,agda,scala",
    callback = function(args)
      vim.o.number = true
    end,
    desc = "Shows a numeration column on the left edge of the window",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "idris2",
    callback = function(args)
      vim.o.foldmethod = 'expr'
    end,
    desc = "Assigns a folding method to Idris 2 file type.",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args) StripTrailingWhitespace() end,
    desc = "Strips whitespace on file writes.",
})

vim.api.nvim_create_autocmd({"BufNewFile","BufRead", "BufEnter"}, {
    pattern = {"*.hott"},
    callback = function(args)
      vim.bo.filetype = "hott"
    end,
    desc = "Assigns a file type to files with .hott extension.",
})

vim.api.nvim_create_autocmd({"BufNewFile","BufRead", "BufEnter"}, {
    pattern = {"*.nova"},
    callback = function(args)
      vim.bo.filetype = "nova"
    end,
    desc = "Assigns a file type to files with .nova extension.",
})

vim.api.nvim_create_autocmd("BufNewFile,BufRead", {
    pattern = "*.idr",
    callback = function(args) vim.bo.filetype = "idris2" end,
    desc = "Assigns a file type to files with .idr extension.",
})

api.nvim_set_keymap (
  'n',
  '<C-b>',
  ':NvimTreeToggle<CR>',
  {noremap = true, silent = true}
)

-- terminal escape sequence
-- I'm ok with <C-v> because I'm on Mac (<D-v> is used for pasting)
api.nvim_set_keymap (
  't',
  '<C-v><Esc>',
  '<C-\\><C-n>',
  {noremap = true, silent = true}
)

-- remap of join
api.nvim_set_keymap (
  'n',
  '<Space>j',
  ':join<CR>',
  {noremap = true, silent = true}
)

-- unmap this built-in command, else it messes up with the commands below
api.nvim_set_keymap (
  '',
  '<C-x>',
  '',
  {noremap = true, silent = true}
)

-- execute visually selected code block (vimL)
api.nvim_set_keymap (
  'v',
  '<C-x><C-e>v',
  '"xy:@x<CR>',
  {noremap = false, silent = true}
)

-- execute visually selected code block (Lua)
api.nvim_set_keymap (
  'v',
  '<C-x><C-e>l',
  '"xy:execute(":lua " . @x)<CR>',
  {noremap = false, silent = true}
)

-- Comment out the visually highlighted text.
-- vmap gc <C-]>gc<C-]><Esc><Esc>
api.nvim_set_keymap (
  'v',
  'gc',
  '<C-]>gc<C-]><Esc><Esc>',
  {noremap = false, silent = true}
)

-- Toggles latest search highlight
vim.api.nvim_set_keymap (
  'n',
  '<Leader><Space>',
  '', {
   callback = function () vim.o.hlsearch = not vim.o.hlsearch end,
   noremap = true,
   silent = true
  }
)

-- ============== MOTION ================

--   Main movement remaps
--                 i
--                 ^
--   I use         |
--           j <--- --->  l
--                 |
--   For           v
--    movement     k
--

vim.cmd[[map <S-l> <nop>]]
vim.cmd[[noremap <S-j> ^]]
vim.cmd[[noremap <S-l> g_]]
vim.cmd[[nnoremap k <Down>]]
vim.cmd[[nnoremap j <Left>]]
vim.cmd[[nnoremap i <Up>]]
vim.cmd[[vnoremap k <Down>]]
vim.cmd[[vnoremap j <Left>]]
vim.cmd[[vnoremap i <Up>]]
vim.cmd[[vnoremap I i]]
vim.cmd[[nnoremap h i]]
vim.cmd[[vnoremap h i]]
vim.cmd[[nnoremap H I]]
vim.cmd[[vnoremap H I]]
vim.cmd[[nnoremap <C-P> <C-I>]]
vim.cmd[[nnoremap I <nop>]]

-- Jump to the start/end of a line in insert/cmd modes
vim.cmd[[inoremap <C-j> <C-o>^]]
vim.cmd[[inoremap <C-l> <C-o>$]]
vim.cmd[[cnoremap <C-j> <C-b>]]
vim.cmd[[cnoremap <C-l> <C-e>]]

-- CamelCaseMotion
vim.cmd[[nmap <silent> <Space>w <Plug>CamelCaseMotion_w]]
vim.cmd[[nmap <silent> <Space>b <Plug>CamelCaseMotion_b]]
vim.cmd[[nmap <silent> <Space>e <Plug>CamelCaseMotion_e]]
-- nmap <silent> <Space>ge <Plug>CamelCaseMotion_ge
vim.cmd[[vmap <silent> <Space>w <Plug>CamelCaseMotion_w]]
vim.cmd[[vmap <silent> <Space>b <Plug>CamelCaseMotion_b]]
vim.cmd[[vmap <silent> <Space>e <Plug>CamelCaseMotion_e]]
-- vmap <silent> <Space>ge <Plug>CamelCaseMotion_ge
vim.cmd[[omap <silent> <Space>iw <Plug>CamelCaseMotion_iw]]
vim.cmd[[xmap <silent> <Space>iw <Plug>CamelCaseMotion_iw]]
vim.cmd[[omap <silent> <Space>ib <Plug>CamelCaseMotion_ib]]
vim.cmd[[xmap <silent> <Space>ib <Plug>CamelCaseMotion_ib]]
vim.cmd[[omap <silent> <Space>ie <Plug>CamelCaseMotion_ie]]
vim.cmd[[xmap <silent> <Space>ie <Plug>CamelCaseMotion_ie]]

-- ================ Buffers, Files, Projects ==================
vim.cmd[[noremap <silent> <C-x>b :lua MyBuffers()<CR>]]
vim.cmd[[cnoremap <silent> <C-x>b :lua MyBuffers()<CR>]]
vim.cmd[[tnoremap <silent> <C-x>b <C-\><C-n>:lua MyBuffers()<CR>]]

-- Close all buffers except this one (caveat: doesn't keep the cursor position)
vim.cmd[[nnoremap <silent> <C-x>qab :%bd\|e#<CR>]]
vim.cmd[[nnoremap <silent> <C-x>qb :b#<bar>bd#<CR>]]

-- Search the working directory for files.
vim.cmd[[nnoremap <silent> <C-x>ff :Telescope fd<CR>]]
vim.cmd[[cnoremap <silent> <C-x>ff :Telescope fd<CR>]]
vim.cmd[[tnoremap <silent> <C-x>ff <C-\><C-n>:Telescope fd<CR>]]

-- Find files in the folder storing all Idris 2 source files
vim.cmd[[command! FilesIdr :lua require("telescope.builtin").fd({search_dirs={"~/.idris2/idris2-0.6.0"}})]]
vim.cmd[[nnoremap <silent> <C-x>fi :FilesIdr<CR>]]
vim.cmd[[cnoremap <silent> <C-x>fi :FilesIdr<CR>]]
vim.cmd[[tnoremap <silent> <C-x>fi <C-\><C-n>:FilesIdr<CR>]]

vim.cmd[[nnoremap <silent> <C-s>L :Telescope live_grep<CR>]]
vim.cmd[[cnoremap <silent> <C-s>L :Telescope live_grep<CR>]]
vim.cmd[[tnoremap <silent> <C-s>L <C-\><C-n>:Telescope live_grep<CR>]]

-- A few commands for jumping between buffers
vim.cmd[[noremap <silent> <C-x>" :bprevious<CR>]]
vim.cmd[[nnoremap <silent> <C-x>' :bnext<CR>]]
vim.cmd[[nnoremap <silent> <C-x>1 :bfirst<CR>]]
-- Switch to the alternate buffer
vim.cmd[[nnoremap <C-u> <C-^>]]

-- Source a config file that features a nifty window manipulation interface.
vim.cmd[[execute("source " . g:main_config_file_dir . "/config/window_manip.vim")]]

vim.cmd[[nnoremap <silent> <C-w>t :ToggleTerm<CR>]]

-- Open an existing terminal instance in the current window.
vim.cmd[[nnoremap <silent> <C-w>t :ToggleTerm<CR>]]

vim.cmd[[execute("source " . g:main_config_file_dir . "/config/jumping.vim")]]

-- Those two commands allow one to jump back and forth
-- the jump list but only moving along the lines in the current buffer
vim.cmd[[nnoremap <silent> <Space><C-I> :call JumpNextInBuf()<CR>]]
vim.cmd[[nnoremap <silent> <Space><C-O> :call JumpPrevInBuf()<CR>]]

vim.cmd[[nnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.6.0"}})<CR>]]
vim.cmd[[cnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.6.0"}})<CR>]]
vim.cmd[[tnoremap <silent> <C-x>li <C-\><C-n>:lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.6.0"}})<CR>]]

vim.cmd[[nnoremap <silent> <C-x>ll :lua require("telescope.builtin").live_grep()<CR>]]
vim.cmd[[cnoremap <silent> <C-x>ll :lua require("telescope.builtin").live_grep()<CR>]]
vim.cmd[[tnoremap <silent> <C-x>ll <C-\><C-n>:lua require("telescope.builtin").live_grep()<CR>]]

local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
--[[ lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
} ]]

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<LocalLeader>a", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<LocalLeader>b", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- require'lspconfig'.metals.setup{}

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach({})
  end,
  group = nvim_metals_group,
})
metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"

require('bufferline').setup {
  options = { mode = "tabs", numbers = "ordinal" }
}

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
vim.cmd[[nnoremap <silent>]b :BufferLineCycleNext<CR>]]
vim.cmd[[nnoremap <silent>[b :BufferLineCyclePrev<CR>]]

-- These commands will move the current buffer backwards or forwards in the bufferline
vim.cmd[[nnoremap <silent><mymap> :BufferLineMoveNext<CR>]]
vim.cmd[[nnoremap <silent><mymap> :BufferLineMovePrev<CR>]]

-- These commands will sort buffers by directory, language, or a custom criteria
vim.cmd[[nnoremap <silent><mymap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>]]

require("lightspeed-setup")
require("gitsigns-setup")
-- require("colorizer").setup()
require("hop").setup{create_hl_autocmd = true}
require("nvim-web-devicons").setup{default = true}
require("telescope-setup")
require("telescope").load_extension("emoji")
-- require("idris2-setup")
-- require("idris2-setup-v2")
require("smart-abbrev-setup")
require("hott-setup")
require("nova-setup")
require("lualine-setup")
require("kommentary-setup")
-- require("octo-setup")
require("todo-comments-setup")

-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- require("high-str-setup")
local opts = {
  client = {
    hover = {
      use_split = false, -- Persistent split instead of popups for hover
      with_history = true, -- Show history of hovers instead of only last
    },
  },
  server = {}, -- Options passed to lspconfig idris2 configuration
  hover_split_position = 'right', -- bottom, top, left or right
  autostart_semantic = true, -- Should start and refresh semantic highlight automatically
}
require('idris2').setup(opts)
require('toggleterm').setup{
  shade_terminals = false
}
vim.cmd [[highlight link LspSemantic_type Include]]   -- Type constructors
vim.cmd [[highlight link LspSemantic_function Identifier]] -- Functions names
vim.cmd [[highlight link LspSemantic_enumMember Number]]   -- Data constructors
vim.cmd [[highlight LspSemantic_variable guifg=Gray]] -- Bound variables
vim.cmd [[highlight link LspSemantic_keyword Structure]]  -- Keywords
vim.cmd [[highlight LspSemantic_postulate guifg=Red]]  -- Postulates
vim.cmd [[highlight link LspSemantic_module Import]]

vim.api.nvim_set_keymap('n', '<LocalLeader>j', ':lua vim.lsp.buf.definition()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<LocalLeader>h', ':lua vim.lsp.buf.hover()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<LocalLeader>a', ':lua vim.lsp.buf.code_action()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<LocalLeader>d', ':lua vim.lsp.buf.signature_help()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<LocalLeader>f', ':lua vim.lsp.buf.format()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', ']d', ':lua vim.diagnostic.goto_next()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>',
                        {noremap = true, silent = false})

-- ============== CMDBUF ================

vim.cmd[[noremap q: <Cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight)<CR>]]
vim.cmd[[cnoremap <C-f> <Cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, {line = vim.fn.getcmdline(), column = vim.fn.getcmdpos()})<CR><C-c>]]

-- Custom buffer mappings
--[[ augroup cmdbuf_setting
  autocmd!
  autocmd User CmdbufNew call s:cmdbuf()
augroup END
function! s:cmdbuf() abort
  nnoremap <nowait> <buffer> q <Cmd>quit<CR>
  nnoremap <buffer> dd <Cmd>lua require('cmdbuf').delete()<CR>
endfunction ]]

-- open lua command-line window
vim.cmd[[nnoremap ql <Cmd>lua require('cmdbuf').split_open( vim.o.cmdwinheight, {type = "lua/cmd"})<CR>]]

vim.cmd[[nnoremap <C-x>x <Cmd>lua require('cmdbuf').execute()<CR>]]

-- q/, q? alternative
vim.cmd[[nnoremap q/ <Cmd>lua require('cmdbuf').split_open(
  \ vim.o.cmdwinheight,
  \ {type = "vim/search/forward"}
  \ )<CR>]]
vim.cmd[[nnoremap q? <Cmd>lua require('cmdbuf').split_open(
  \ vim.o.cmdwinheight,
  \ {type = "vim/search/backward"}
  \ )<CR>]]

-- ======================================

-- ;, repeat the last lightspeed motion
vim.g.lightspeed_last_motion = ''

vim.api.nvim_create_autocmd("User", {
    pattern = "LightspeedSxEnter",
    callback = function(args)
      vim.g.lightspeed_last_motion = 'sx'
    end,
    desc = "Lightspeed tricks.",
})

vim.api.nvim_create_autocmd("User", {
    pattern = "LightspeedFtEnter",
    callback = function(args)
      vim.g.lightspeed_last_motion = 'ft'
    end,
    desc = "Lightspeed tricks.",
})

vim.cmd[[map <expr> , g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_;_sx" : "<Plug>Lightspeed_;_ft"]]
vim.cmd[[map <expr> , g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_,_sx" : "<Plug>Lightspeed_,_ft"]]

vim.api.nvim_set_keymap('n', '<C-k>', ":MoveLine(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-i>', ":MoveLine(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-k>', ":lua moveSelectionDown()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-i>', ":lua moveSelectionUp()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-l>', ":lua moveSelectionRight()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-j>', ":lua moveSelectionLeft()<CR>", { noremap = true, silent = true })

require("toggleterm").setup{
  start_in_insert = false,
  auto_scroll = false, -- automatically scroll to the bottom on terminal output
}

vim.cmd[[silent! call repeat#set("<Left><C-o>:lua SmartAbbrevExpand()<CR><Right>", v:count)]]

require'lspconfig'.jsonls.setup{}

--
vim.cmd[[let s:baleia = luaeval("require('baleia').setup { }")
         command! BaleiaColorize call s:baleia.once(bufnr('%'))]]

-- NVim Tree
--
local function nvim_tree_my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  -- BEGIN_DEFAULT_ON_ATTACH
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
  vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
  vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
  vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
  vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
  vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
  vim.keymap.set('n', 'bd',    api.marks.bulk.delete,                 opts('Delete Bookmarked'))
  vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
  vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle Filter: No Buffer'))
  vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
  vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Filter: Git Clean'))
  vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
  vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
  vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
  vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
  vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
  vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
  vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
  vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
  vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
  vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
  vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
  vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Filter: Dotfiles'))
  vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Filter: Git Ignore'))
  vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
  vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
  vim.keymap.set('n', 'm',     api.marks.toggle,                      opts('Toggle Bookmark'))
  vim.keymap.set('n', 'o',     api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
  vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
  vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
  vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
  vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
  vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
  vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
  vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
  vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Filter: Hidden'))
  vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
  vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
  vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
  vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
  vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
end

--
require("nvim-tree").setup{
  on_attach = nvim_tree_my_on_attach,
  diagnostics = {
    enable = true,
  }
}

require("trouble").setup{
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    cycle_results = true, -- cycle item list when reaching beginning or end of list
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "i", -- previous item
        next = "k", -- next item
        help = "?" -- help menu
    },
    multiline = true, -- render multi-line messages
    indent_lines = true, -- add an indent guide below the fold icons
    win_config = { border = "single" }, -- window configuration for floating windows. See |nvim_open_win()|.
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
    include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions"  }, -- for the given modes, include the declaration of the current symbol in the results
    signs = {
      -- icons / text used for a diagnostic
      error = "",
      warning = "",
      hint = "",
      information = "",
      other = "",
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

g.fugitive_gitlab_domains = {'https://gitlab.onairent.live'}

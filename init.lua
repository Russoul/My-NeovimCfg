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

-- A keymap for openning the init.lua file from anywhere
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
  vim.o.undodir="/Users/russoul/.config/nvim/undo"
end
-- ----------------------------

-- TODO: Maybe use packer instead?
-- Plugin configuration start
vim.cmd[[call plug#begin()]]
-- Latex plugin
vim.cmd[[Plug 'lervag/vimtex', { 'tag': 'v2.15' }]]
-- A theme
vim.cmd[[Plug 'https://github.com/rakr/vim-one', {'commit': '187f5c85b682c1933f8780d4d419c55d26a82e24'}]]
-- Draws a box over the outline of the selection
vim.cmd[[Plug 'jbyuki/venn.nvim', {'commit': '71856b548e3206e33bad10acea294ca8b44327ee'}]]
-- A git plugin
vim.cmd[[Plug 'tpope/vim-fugitive', {'commit': 'f529acef74b4266d94f22414c60b4a8930c1e0f3'}]]
-- Align lines of code in one command with many options of doing it
vim.cmd[[Plug 'godlygeek/tabular', {'commit': 'f529acef74b4266d94f22414c60b4a8930c1e0f3'}]]
-- Commenting code
vim.cmd[[Plug 'numToStr/Comment.nvim']]
-- Surrounding text with delimiters
vim.cmd[[Plug 'https://tpope.io/vim/surround.git', {'commit': 'bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea'}]]
-- Repeating complex commands; often plugins require
-- this as a dependency in order for the repeat (.) to work properly
vim.cmd[[Plug 'https://tpope.io/vim/repeat.git', {'commit': '24afe922e6a05891756ecf331f39a1f6743d3d5a'}]]
-- Nice directory tree view
vim.cmd[[Plug 'kyazdani42/nvim-tree.lua', {'commit': '82ec79aac5557c05728d88195fb0d008cacbf565'}]]
-- The best theme ever (subjectively of course) !
vim.cmd[[Plug 'https://github.com/joshdick/onedark.vim.git', {'commit': '7db2ed5b825a311d0f6d12694d4738cf60106dc8'}]]
-- Renders a special line at the bottom of each window that reflects user info
vim.cmd[[Plug 'nvim-lualine/lualine.nvim', {'commit': '619ededcff79e33a7e0ea677881dd07957449f9d'}]]
-- Motions defined for moving around camel-case words
vim.cmd[[Plug 'https://github.com/bkad/CamelCaseMotion.git', {'commit': 'de439d7c06cffd0839a29045a103fe4b44b15cdc'}]]
-- Nice when you can't keep up with your cursor movements all around the frame
-- (Dims all windows except the one the cursor is currently in)
vim.cmd[[Plug 'https://github.com/blueyed/vim-diminactive.git', {'commit': '6f2e14e6ff6a038285937c378ec3685e6ff7ee36'}]]
-- LSP configs
vim.cmd[[Plug 'neovim/nvim-lspconfig', {'commit': '2f37b2ca07a3f89e7994b3b7f54c997e2cb3400a'}]]
-- Used by Telescope
vim.cmd[[Plug 'nvim-lua/popup.nvim', {'commit': 'b7404d35d5d3548a82149238289fa71f7f6de4ac'}]]
-- Used by many plugins
vim.cmd[[Plug 'nvim-lua/plenary.nvim', {'commit': '9069d14a120cadb4f6825f76821533f2babcab92'}]]
-- Handles (multiple) choice generically & comes with a few useful finders
vim.cmd[[Plug 'nvim-telescope/telescope.nvim', {'commit': '795a63ed293ba249a588e9e67aa1f2cec82028e8'}]]
-- Icons
vim.cmd[[Plug 'kyazdani42/nvim-web-devicons', {'commit': 'bdd43421437f2ef037e0dafeaaaa62b31d35ef2f'}]]
-- Manage git workflow
vim.cmd[[Plug 'pwntester/octo.nvim', {'commit': '4de7b07cb0788d69444d8b08d9936a4b3ffced87'}]]
-- Successor of Signify for Neovim 0.5, Lua
vim.cmd[[Plug 'lewis6991/gitsigns.nvim', {'commit': 'aca84fd16ce129965d7c3c69de59f333d9da116c'}]]
-- Stand-in for VimSneak (works differently)
vim.cmd[[Plug 'ggandor/leap.nvim']]
-- Highlights in colour special symbols like:
--   * TODO:
--   * NOTE:
--   * FIX:
--   * PERF:
--   * HACK:
--   * IDEA:
--   * REFACTOR:
--   and additionally marks lines with signs
vim.cmd[[Plug 'folke/todo-comments.nvim']]
vim.cmd[[Plug 'ShinKage/idris2-nvim', {'branch' : 'better-repl'}]]
-- UI component library
vim.cmd[[Plug 'MunifTanjim/nui.nvim', {'commit': 'abdbfab89f307151db83b1a5147cd390ef27ff99'}]]
vim.cmd[[Plug 'derekelkins/agda-vim']]
-- Terminal
vim.cmd[[Plug 'akinsho/toggleterm.nvim', {'commit': '265bbff68fbb8b2a5fb011272ec469850254ec9f'}]]
-- Buffers that contain past searches and cmds
vim.cmd[[Plug 'notomo/cmdbuf.nvim', {'commit': 'e6b37e80cab18368d64184557c3a956cafa4ced7'}]]
-- Tabs at the top of the screen
vim.cmd[[Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }]]
-- Preview markdown files
vim.cmd[[Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }]]
-- Plugin for telescope that allows one to seach for an emoji
vim.cmd[[Plug 'xiyaowong/telescope-emoji.nvim']]
-- Plugin configuration end
vim.cmd[[Plug 'simrat39/rust-tools.nvim']]
-- Metals LSP client for scala lang
vim.cmd[[Plug 'scalameta/nvim-metals']]
-- Plugin that enables fugitive's GBrowse open links to private repos?
vim.cmd[[Plug 'https://github.com/tpope/vim-rhubarb']]
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
    pattern = "vim,idris2,python,javascript,lua,c,hott,nova,txt,agda",
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
vim.cmd[[command! FilesIdr :lua require("telescope.builtin").fd({search_dirs={"~/.idris2/idris2-0.7.0"}})]]
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

vim.cmd[[nnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.7.0"}})<CR>]]
vim.cmd[[cnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.7.0"}})<CR>]]
vim.cmd[[tnoremap <silent> <C-x>li <C-\><C-n>:lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.7.0"}})<CR>]]

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

require'lspconfig'.metals.setup{}
require'lspconfig'.clangd.setup{}

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

require("gitsigns-setup")
-- require("colorizer").setup()
require("nvim-web-devicons").setup{default = true}
require("telescope-setup")
require("telescope").load_extension("emoji")
-- require("idris2-setup")
-- require("idris2-setup-v2")
require("smart-abbrev-setup")
require("hott-setup")
require("nova-setup")
require("lualine-setup")
require("octo-setup")
require("todo-comments-setup")
require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = true,
      list = {
          { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
          { key = {"O"},                          action = "edit_no_picker" },
          { key = {"<2-RightMouse>", "<C-]>"},    action = "cd" },
          { key = "<C-t>",                        action = "tabnew" },
          { key = "<",                            action = "prev_sibling" },
          { key = ">",                            action = "next_sibling" },
          { key = "P",                            action = "parent_node" },
          { key = "<BS>",                         action = "close_node" },
          { key = "<Tab>",                        action = "preview" },
          { key = "K",                            action = "first_sibling" },
          { key = "J",                            action = "last_sibling" },
          { key = "I",                            action = "toggle_git_ignored" },
          { key = "H",                            action = "toggle_dotfiles" },
          { key = "R",                            action = "refresh" },
          { key = "a",                            action = "create" },
          { key = "d",                            action = "remove" },
          { key = "D",                            action = "trash" },
          { key = "r",                            action = "rename" },
          { key = "<C-r>",                        action = "full_rename" },
          { key = "x",                            action = "cut" },
          { key = "c",                            action = "copy" },
          { key = "p",                            action = "paste" },
          { key = "y",                            action = "copy_name" },
          { key = "Y",                            action = "copy_path" },
          { key = "gy",                           action = "copy_absolute_path" },
          { key = "[c",                           action = "prev_git_item" },
          { key = "]c",                           action = "next_git_item" },
          { key = "-",                            action = "dir_up" },
          { key = "s",                            action = "system_open" },
          { key = "q",                            action = "close" },
          { key = "g?",                           action = "toggle_help" },
          { key = "W",                            action = "collapse_all" },
          { key = "S",                            action = "search_node" },
          { key = "<C-k>",                        action = "toggle_file_info" },
          { key = ".",                            action = "run_file_command" }
        -- user mappings go here
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
    }
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
} -- END_DEFAULT_OPTS

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
vim.api.nvim_set_keymap('n', '<LocalLeader>i', ':lua vim.lsp.buf.implementation()<CR>',
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

require("move")
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

require('Comment').setup()

---------- LEAP -------------

require('leap').create_default_mappings()

-- The below settings make Leap's highlighting closer to what you've been
-- used to in Lightspeed.

vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey
vim.api.nvim_set_hl(0, 'LeapMatch', {
  -- For light themes, set to 'black' or similar.
  fg = 'white', bold = true, nocombine = true,
})

-- Lightspeed colors
-- primary labels: bg = "#f02077" (light theme) or "#ff2f87"  (dark theme)
-- secondary labels: bg = "#399d9f" (light theme) or "#99ddff" (dark theme)
-- shortcuts: bg = "#f00077", fg = "white"
-- You might want to use either the primary label or the shortcut colors
-- for Leap primary labels, depending on your taste.
vim.api.nvim_set_hl(0, 'LeapLabelPrimary', {
  fg = 'red', bold = true, nocombine = true,
})
vim.api.nvim_set_hl(0, 'LeapLabelSecondary', {
  fg = 'blue', bold = true, nocombine = true,
})
-- Try it without this setting first, you might find you don't even miss it.
-- require('leap').opts.highlight_unlabeled_phase_one_targets = true

-----------------------------

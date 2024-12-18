----------- NVIM CONFIG (ver 0.10.0) ------------

local g = vim.g
local o = vim.o
local fn = vim.fn

------------- Basic options --------------

-- A keymap for openning the init.lua file from anywhere
vim.cmd[[nnoremap <C-x>cf :e $MYVIMRC<CR>]]

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

----------------- Lazy package manager --------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
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
    {'lervag/vimtex', tag = 'v2.15'},
    -- A theme
    {'https://github.com/rakr/vim-one', commit = '187f5c85b682c1933f8780d4d419c55d26a82e24'},
    -- Draws a box over the outline of the selection
    {'jbyuki/venn.nvim', commit = '71856b548e3206e33bad10acea294ca8b44327ee'},
    -- A git plugin
    {'tpope/vim-fugitive', commit = 'f529acef74b4266d94f22414c60b4a8930c1e0f3'},
    -- Align lines of code in one command with many options of doing it
    {'godlygeek/tabular', commit = '339091ac4dd1f17e225fe7d57b48aff55f99b23a'},
    -- Commenting code
    {'numToStr/Comment.nvim'},
    -- Surrounding text with delimiters
    {'https://tpope.io/vim/surround.git', commit = 'bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea'},
    -- Repeating complex commands; often plugins require
    -- this as a dependency in order for the repeat (.) to work properly
    {'https://tpope.io/vim/repeat.git', commit = '24afe922e6a05891756ecf331f39a1f6743d3d5a'},
    -- Nice directory tree view
    {'kyazdani42/nvim-tree.lua', commit = '2086e564c4d23fea714e8a6d63b881e551af2f41'},
    -- The best theme ever (subjectively of course) !
    {'https://github.com/joshdick/onedark.vim.git', commit = '7db2ed5b825a311d0f6d12694d4738cf60106dc8'},
    -- Renders a special line at the bottom of each window that reflects user info
    {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }},
    -- Nice when you can't keep up with your cursor movements all around the frame
    -- (Dims all windows except the one the cursor is currently in)
    {'https://github.com/blueyed/vim-diminactive.git', commit = '6f2e14e6ff6a038285937c378ec3685e6ff7ee36'},
    -- LSP configs
    {'neovim/nvim-lspconfig', commit = 'f43135c38a37c588053ad5e209c7460f43f6340c'},
    -- Used by Telescope
    {'nvim-lua/popup.nvim', commit = 'b7404d35d5d3548a82149238289fa71f7f6de4ac'},
    -- Used by many plugins
    {'nvim-lua/plenary.nvim', commit = 'a3e3bc82a3f95c5ed0d7201546d5d2c19b20d683'},
    -- Handles (multiple) choice generically & comes with a few useful finders
    {'nvim-telescope/telescope.nvim', commit = '61a4a615366c470a4e9ca8f8b45718b6b92af73f'},
    -- Icons
    {'kyazdani42/nvim-web-devicons', commit = 'c0cfc1738361b5da1cd0a962dd6f774cc444f856'},
    -- Manage git workflow
    {'pwntester/octo.nvim', commit = '44060b7'},
    -- Successor of Signify for Neovim, Lua
    {'lewis6991/gitsigns.nvim', commit = '0dc886637f9686b7cfd245a4726f93abeab19d4a'},
    -- Stand-in for VimSneak (works differently)
    {'ggandor/leap.nvim'},
    -- Highlights in colour special symbols like:
    --   * TODO:
    --   * NOTE:
    --   * FIX:
    --   * PERF:
    --   * HACK:
    --   * IDEA:
    --   * REFACTOR:
    --   and additionally marks lines with signs
    {'folke/todo-comments.nvim', commit = '98b1ebf198836bdc226c0562b9f906584e6c400e'},
    -- Idris 2 LSP client
    {dir = '$HOME/my-stuff/projects/idris2-nvim', opts = {}},
    -- UI component library
    {'MunifTanjim/nui.nvim', commit = '322978c734866996274467de084a95e4f9b5e0b1'},
    {'derekelkins/agda-vim'},
    -- Terminal
    {'akinsho/toggleterm.nvim', commit = '265bbff68fbb8b2a5fb011272ec469850254ec9f'},
    -- Buffers that contain past searches and cmds
    {'notomo/cmdbuf.nvim', commit = 'e6b37e80cab18368d64184557c3a956cafa4ced7'},
    -- Tabs at the top of the screen
    {'akinsho/bufferline.nvim', commit = '81820cac7c85e51e4cf179f8a66d13dbf7b032d9'},
    -- Preview markdown files
    -- {'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'}
    -- Plugin for telescope that allows one to seach for an emoji
    {'xiyaowong/telescope-emoji.nvim', commit = '86248d97be84a1ce83f0541500ef9edc99ea2aa1'},
    -- Plugin configuration end
    {'simrat39/rust-tools.nvim'},
    -- Metals LSP client for scala lang
    {'scalameta/nvim-metals'},
    -- Plugin that enables fugitive's GBrowse open links to private repos?
    {'https://github.com/tpope/vim-rhubarb'},
    -- Plugin that enables fugitive's GBrowse open links to gitlab repos
    {'shumphrey/fugitive-gitlab.vim'},
    -- A buffer for showing diagnostics, references, telescope results, quickfix and location lists
    {
      "folke/trouble.nvim",
      opts = {keys = {i = "prev"}}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle win = { type = split, position = right, size = 60}<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    },
    -- Show git blame
    {'FabijanZulj/blame.nvim', commit = '3e6b2ef4905982cd7d26eb5b18b0e761138eb5ab'},
    -- Highlight text via Neovims visual highlighting mechanism
    -- The plugin is buggy. Let's keep it here for now, maybe it will be stabilised in the feature
    {'Pocco81/HighStr.nvim'},
    -- {"Russoul/abbrev-expand.nvim"}
    {dir = "$HOME/my-stuff/projects/abbrev-expand.nvim"},
    -- Helpful for finding out what keys are mapped to interatively
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {},
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
      enabled = false
    },
    -- TS LSP
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

---------------- Misc ---------------

--TODO: Do we need this?
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(_)
      vim.o.shiftwidth = 1
      vim.o.indentkeys = ''
    end,
    desc = "Sets shift width and nullifies indentation keys.",
})

vim.g.fugitive_gitlab_domains = {["gitlab.onairent.live"]="https://gitlab.onairent.live"}

---------- Enable line numbers for particular file types -------------
vim.api.nvim_create_autocmd("FileType", {
    pattern = "vim,idris2,python,javascript,lua,c,hott,nova,txt,agda,scala,cpp,h",
    callback = function(_)
      vim.o.number = true
    end,
    desc = "Shows a numeration column on the left edge of the window",
})


---------- Toggle latest search highlight ---------
vim.api.nvim_set_keymap (
  'n',
  '<Leader><Space>',
  '', {
   callback = function () vim.o.hlsearch = not vim.o.hlsearch end,
   noremap = true,
   silent = true
  }
)

----------------- Execute selection ----------------

-- execute visually selected code block (vimL)
vim.api.nvim_set_keymap (
  'v',
  '<C-x><C-e>v',
  '"xy:@x<CR>',
  {noremap = false, silent = true}
)

-- execute visually selected code block (Lua)
vim.api.nvim_set_keymap (
  'v',
  '<C-x><C-e>l',
  '"xy:execute(":lua " . @x)<CR>',
  {noremap = false, silent = true}
)

-------- Highlight on yank (vanity) ----------
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function(_)
        vim.highlight.on_yank {higroup="IncSearch", timeout=100, on_visual=true}
    end,
    desc = "Briefly highlights yanked text.",
})

-------- Cursor shape/colour, colour theme, colour palette --------
-- Set theme and cursor shape/color
if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

vim.cmd[[colorscheme onedark]]
o.guicursor = 'n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor'

-- Colour palette setup
vim.cmd[[hi Error ctermfg=204 guifg=#FF0000]]
vim.cmd[[hi Conceal guifg=#FBAB00]]
vim.cmd[[hi todo guifg=#CCCC00]]
vim.cmd[[hi ColorColumn guibg=#303541]]
vim.cmd[[hi Search guifg=black guibg=orange4]]
vim.cmd[[hi @variable ctermfg=59 guifg=#5c6370]]
vim.cmd[[hi Comment ctermfg=59 guifg=#99ccff]]

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

-- terminal escape sequence
-- I'm ok with <C-v> because I'm on Mac (<D-v> is used for pasting)
vim.api.nvim_set_keymap (
  't',
  '<C-v><Esc>',
  '<C-\\><C-n>',
  {noremap = true, silent = true}
)

-- remap of join
vim.api.nvim_set_keymap (
  'n',
  '<Space>j',
  ':join<CR>',
  {noremap = true, silent = true}
)

-- unmap this built-in command, else it messes up with the commands below
vim.api.nvim_set_keymap (
  '',
  '<C-x>',
  '',
  {noremap = true, silent = true}
)


---------------- CamelCaseMotion ----------------
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

---------- Trailing whitespace cleanup ------------
function StripTrailingWhitespace()
    local l = fn.line(".")
    local c = fn.col(".")
    vim.cmd[[%s/\s\+$//e]]
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
vim.cmd[[nnoremap <silent> <C-x>qab :%bd\|e#<CR>]]
vim.cmd[[nnoremap <silent> <C-x>qb :b#<bar>bd#<CR>]]

-- Switch to the alternate buffer
vim.cmd[[nnoremap <C-u> <C-^>]]

------------------ Window manipulation interface (custom plugin) -----------------
vim.cmd[[execute("source " . g:main_config_file_dir . "/config/window_manip.vim")]]

-------------- Jumping inside buffer only (custom plugin) ----------------
vim.cmd[[execute("source " . g:main_config_file_dir . "/config/jumping.vim")]]

-- Those two commands allow one to jump back and forth
-- the jump list but only moving along the lines in the current buffer
vim.cmd[[nnoremap <silent> <Space><C-I> :call JumpNextInBuf()<CR>]]
vim.cmd[[nnoremap <silent> <Space><C-O> :call JumpPrevInBuf()<CR>]]

----------------- Git Signs ----------------
require('gitsigns').setup{
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)
  end
}

---------- abbrev-expand ----------
-- TODO: make this work in terminals and popup windows, like one found in telescope
require('abbrev-expand').setup(require('abbrev-expand-setup'))

vim.api.nvim_set_keymap('i', '<C-]>', '<Left><C-o>:lua require("abbrev-expand").expand(".")<CR><Right>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', '<C-]>', ':lua require("abbrev-expand").expand("\'>")<CR>',
                        {noremap = true, silent = true})

------------------- Octo --------------------
require"octo".setup({
  use_local_fs = false,                    -- use local files on right side of reviews
  enable_builtin = false,                  -- shows a list of builtin actions when no action is provided
  default_remote = {"upstream", "origin"}; -- order to try remotes
  default_merge_method = "commit",         -- default merge method which should be used when calling `Octo pr merge`, could be `commit`, `rebase` or `squash`
  ssh_aliases = {},                        -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
  picker = "telescope",                    -- or "fzf-lua"
  picker_config = {
    use_emojis = false,                    -- only used by "fzf-lua" picker for now
    mappings = {                           -- mappings for the pickers
      open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
      copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
      checkout_pr = { lhs = "<C-o>", desc = "checkout pull request" },
      merge_pr = { lhs = "<C-r>", desc = "merge pull request" },
    },
  },
  comment_icon = "▎",                      -- comment marker
  outdated_icon = "󰅒 ",                    -- outdated indicator
  resolved_icon = " ",                    -- resolved indicator
  reaction_viewer_hint_icon = " ";        -- marker for user reactions
  user_icon = " ";                        -- user icon
  timeline_marker = " ";                  -- timeline marker
  timeline_indent = "2";                   -- timeline indentation
  right_bubble_delimiter = "";            -- bubble delimiter
  left_bubble_delimiter = "";             -- bubble delimiter
  github_hostname = "";                    -- GitHub Enterprise host
  snippet_context_lines = 4;               -- number or lines around commented lines
  gh_cmd = "gh",                           -- Command to use when calling Github CLI
  gh_env = {},                             -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
  timeout = 5000,                          -- timeout for requests between the remote server
  default_to_projects_v2 = false,          -- use projects v2 for the `Octo card ...` command by default. Both legacy and v2 commands are available under `Octo cardlegacy ...` and `Octo cardv2 ...` respectively.
  ui = {
    use_signcolumn = true,                 -- show "modified" marks on the sign column
  },
  issues = {
    order_by = {                           -- criteria to sort results of `Octo issue list`
      field = "CREATED_AT",                -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
      direction = "DESC"                   -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
    }
  },
  pull_requests = {
    order_by = {                           -- criteria to sort the results of `Octo pr list`
      field = "CREATED_AT",                -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
      direction = "DESC"                   -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
    },
    always_select_remote_on_create = false -- always give prompt to select base remote repo when creating PRs
  },
  file_panel = {
    size = 10,                             -- changed files panel rows
    use_icons = true                       -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
  },
  colors = {                               -- used for highlight groups (see Colors section below)
    white = "#ffffff",
    grey = "#2A354C",
    black = "#000000",
    red = "#fdb8c0",
    dark_red = "#da3633",
    green = "#acf2bd",
    dark_green = "#238636",
    yellow = "#d3c846",
    dark_yellow = "#735c0f",
    blue = "#58A6FF",
    dark_blue = "#0366d6",
    purple = "#6f42c1",
  },
  mappings_disable_default = false,        -- disable default mappings if true, but will still adapt user mappings
  mappings = {
    issue = {
      close_issue = { lhs = "<space>ic", desc = "close issue" },
      reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
      list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
      reload = { lhs = "<C-r>", desc = "reload issue" },
      open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
      copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
      add_assignee = { lhs = "<space>aa", desc = "add assignee" },
      remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
      create_label = { lhs = "<space>lc", desc = "create label" },
      add_label = { lhs = "<space>la", desc = "add label" },
      remove_label = { lhs = "<space>ld", desc = "remove label" },
      goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
      add_comment = { lhs = "<space>ca", desc = "add comment" },
      delete_comment = { lhs = "<space>cd", desc = "delete comment" },
      next_comment = { lhs = "]c", desc = "go to next comment" },
      prev_comment = { lhs = "[c", desc = "go to previous comment" },
      react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
      react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
      react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
      react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
      react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
      react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
      react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
      react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    },
    pull_request = {
      checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
      merge_pr = { lhs = "<space>pm", desc = "merge commit PR" },
      squash_and_merge_pr = { lhs = "<space>psm", desc = "squash and merge PR" },
      rebase_and_merge_pr = { lhs = "<space>prm", desc = "rebase and merge PR" },
      list_commits = { lhs = "<space>pc", desc = "list PR commits" },
      list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
      show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
      add_reviewer = { lhs = "<space>va", desc = "add reviewer" },
      remove_reviewer = { lhs = "<space>vd", desc = "remove reviewer request" },
      close_issue = { lhs = "<space>ic", desc = "close PR" },
      reopen_issue = { lhs = "<space>io", desc = "reopen PR" },
      list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
      reload = { lhs = "<C-r>", desc = "reload PR" },
      open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
      copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
      goto_file = { lhs = "gf", desc = "go to file" },
      add_assignee = { lhs = "<space>aa", desc = "add assignee" },
      remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
      create_label = { lhs = "<space>lc", desc = "create label" },
      add_label = { lhs = "<space>la", desc = "add label" },
      remove_label = { lhs = "<space>ld", desc = "remove label" },
      goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
      add_comment = { lhs = "<space>ca", desc = "add comment" },
      delete_comment = { lhs = "<space>cd", desc = "delete comment" },
      next_comment = { lhs = "]c", desc = "go to next comment" },
      prev_comment = { lhs = "[c", desc = "go to previous comment" },
      react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
      react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
      react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
      react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
      react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
      react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
      react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
      react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
      review_start = { lhs = "<space>vs", desc = "start a review for the current PR" },
      review_resume = { lhs = "<space>vr", desc = "resume a pending review for the current PR" },
    },
    review_thread = {
      goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
      add_comment = { lhs = "<space>ca", desc = "add comment" },
      add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
      delete_comment = { lhs = "<space>cd", desc = "delete comment" },
      next_comment = { lhs = "]c", desc = "go to next comment" },
      prev_comment = { lhs = "[c", desc = "go to previous comment" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
      select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
      react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
      react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
      react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
      react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
      react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
      react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
      react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    },
    submit_win = {
      approve_review = { lhs = "<C-a>", desc = "approve review" },
      comment_review = { lhs = "<C-m>", desc = "comment review" },
      request_changes = { lhs = "<C-r>", desc = "request changes review" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
    },
    review_diff = {
      submit_review = { lhs = "<leader>vs", desc = "submit review" },
      discard_review = { lhs = "<leader>vd", desc = "discard review" },
      add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
      add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
      focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
      toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
      next_thread = { lhs = "]t", desc = "move to next thread" },
      prev_thread = { lhs = "[t", desc = "move to previous thread" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
      select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
      goto_file = { lhs = "gf", desc = "go to file" },
    },
    file_panel = {
      submit_review = { lhs = "<leader>vs", desc = "submit review" },
      discard_review = { lhs = "<leader>vd", desc = "discard review" },
      next_entry = { lhs = "k", desc = "move to next changed file" },
      prev_entry = { lhs = "i", desc = "move to previous changed file" },
      select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
      refresh_files = { lhs = "R", desc = "refresh changed files panel" },
      focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
      toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
      select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
    },
  },
})

---------------- TODO comments ---------------
require("todo-comments").setup
{
  signs = true, -- show icons in the signs column
  sign_priority = 8, -- sign priority
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "warning" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    REFACTOR = { icon = "", color = "warning", alt = { "REFACTOR" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO", "COMMENT" } },
    IDEA = { icon = "", color = "#10A010", alt = { "THOUGHT" } },
  },
  merge_keywords = true, -- when true, custom keywords will be merged with the defaults
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    before = "", -- "fg" or "bg" or empty
    keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    after = "fg", -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
  },
  -- list of named colors where we try to extract the guifg from the
  -- list of hilight groups or use the hex color if hl not found as a fallback
  colors = {
    error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
    warning = { "#FBBF24" },
    info = { "#2563EB" },
    hint = { "LspDiagnosticsDefaultHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
}

------------------ Dev Icons -------------------
require("nvim-web-devicons").setup{default = true}

------------------ Lua Line --------------------
require("lualine-setup")

------------------ Yaml LSP --------------------

require('lspconfig').yamlls.setup {}

------------------- Telescope ------------------
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["i"] = actions.move_selection_previous,
        ["k"] = actions.move_selection_next,
        ["x"] = actions.remove_selection,
      },
    },
  }
}

require("telescope").load_extension("emoji")

-- Live grep the workspace
vim.cmd[[nnoremap <silent> <C-x>ll :Telescope live_grep<CR>]]
vim.cmd[[cnoremap <silent> <C-x>ll :Telescope live_grep<CR>]]
vim.cmd[[tnoremap <silent> <C-x>ll <C-\><C-n>:Telescope live_grep<CR>]]

-- List open buffers
vim.cmd[[noremap <silent> <C-x>b :Telescope buffers<CR>]]
vim.cmd[[cnoremap <silent> <C-x>b :Telescope buffers<CR>]]
vim.cmd[[tnoremap <silent> <C-x>b <C-\><C-n>:Telescope buffers<CR>]]

-- List files in the workspace.
vim.cmd[[nnoremap <silent> <C-x>ff :Telescope fd<CR>]]
vim.cmd[[cnoremap <silent> <C-x>ff :Telescope fd<CR>]]
vim.cmd[[tnoremap <silent> <C-x>ff <C-\><C-n>:Telescope fd<CR>]]

-- List files in the folder storing all Idris 2 source files
vim.cmd[[command! FilesIdr :lua require("telescope.builtin").fd({search_dirs={"~/.pack"}})]]
vim.cmd[[nnoremap <silent> <C-x>fi :FilesIdr<CR>]]
vim.cmd[[cnoremap <silent> <C-x>fi :FilesIdr<CR>]]
vim.cmd[[tnoremap <silent> <C-x>fi <C-\><C-n>:FilesIdr<CR>]]

-- Live grep in the folder storing all Idris2 source files
vim.cmd[[nnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.pack"}})<CR>]]
vim.cmd[[cnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.pack"}})<CR>]]
vim.cmd[[tnoremap <silent> <C-x>li <C-\><C-n>:lua require("telescope.builtin").live_grep({search_dirs={"~/.pack"}})<CR>]]

-------------- Moving selection around (custom plugin) -------------
vim.api.nvim_set_keymap('v', '<C-k>', ":lua require('move').moveSelectionDown()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-i>', ":lua require('move').moveSelectionUp()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-l>', ":lua require('move').moveSelectionRight()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-j>', ":lua require('move').moveSelectionLeft()<CR>", { noremap = true, silent = true })

--------------- CmdBuf ---------------
vim.cmd[[noremap q: <Cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight)<CR>]]
vim.cmd[[cnoremap <C-f> <Cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, {line = vim.fn.getcmdline(), column = vim.fn.getcmdpos()})<CR><C-c>]]

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

-------------- ToggleTerm -------------
require('toggleterm').setup{
  shade_terminals = false,
  start_in_insert = false,
  auto_scroll = false,
}

vim.cmd[[nnoremap <silent> <C-w>t :ToggleTerm<CR>]]

-- Open an existing terminal instance in the current window.
vim.cmd[[nnoremap <silent> <C-w>t :ToggleTerm<CR>]]

------------  Nvim Tree ---------------

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

require("nvim-tree").setup{
  on_attach = nvim_tree_my_on_attach,
  diagnostics = {
    enable = true,
  }
}

vim.api.nvim_set_keymap (
  'n',
  '<C-b>',
  ':NvimTreeToggle<CR>',
  {noremap = true, silent = true}
)

----------- Comment ------------
require('Comment').setup()

------------ LEAP -------------
---
vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
vim.keymap.set({'n'}, 'S',  '<Plug>(leap-backward)')
vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')

require('leap').opts.safe_labels = {}
-------------- Trouble --------------

--------------- Virtual highlight (high-str) ----------------
require("high-str").setup({
	verbosity = 0,
	saving_path = "/tmp/highstr/",
	highlight_colors = {
		-- color_id = {"bg_hex_code",<"fg_hex_code"/"smart">}
		color_0 = {"#0c0d0e", "smart"},	-- Cosmic charcoal
		color_1 = {"#e5c07b", "smart"},	-- Pastel yellow
		color_2 = {"#7FFFD4", "smart"},	-- Aqua menthe
		color_3 = {"#8A2BE2", "smart"},	-- Proton purple
		color_4 = {"#FF4500", "smart"},	-- Orange red
		color_5 = {"#008000", "smart"},	-- Office green
		color_6 = {"#0000FF", "smart"},	-- Just blue
		color_7 = {"#FFC0CB", "smart"},	-- Blush pink
		color_8 = {"#FFF9E3", "smart"},	-- Cosmic latte
		color_9 = {"#7d5c34", "smart"},	-- Fallow brown
	}
})

------------- Buffer Line -------------
require('bufferline').setup {
  options = { mode = "tabs", numbers = "ordinal" }
}

----------------- General LSP mappings ------------------
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
vim.api.nvim_set_keymap('n', '<LocalLeader>r', ':lua vim.lsp.buf.references()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', ']d', ':lua vim.diagnostic.goto_next()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>',
                        {noremap = true, silent = false})


-------------- Lua LSP ----------------
require('lspconfig').lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

------------- Metals LSP --------------
local metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach({})
  end,
  group = nvim_metals_group,
})


------------- C/C++ LSP ---------------
require('lspconfig').clangd.setup{}

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
vim.cmd[[nnoremap <silent>]b :BufferLineCycleNext<CR>]]
vim.cmd[[nnoremap <silent>[b :BufferLineCyclePrev<CR>]]

--------------- Rust LSP --------------
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

--------------- JSON LSP ----------------
require('lspconfig').jsonls.setup{}

-- Regexp highlighting colours override
vim.cmd[[hi idrisOperators guifg=#FBAB00]]
vim.cmd[[hi link idrisStatement Structure]]
vim.cmd[[hi idrisDocComment guifg=#99ccff]]

-- Semantic highlighting colours override
vim.cmd [[highlight link LspSemantic_type       Include   ]] -- Type constructors
vim.cmd [[highlight link LspSemantic_function   Identifier]] -- Functions names
vim.cmd [[highlight link LspSemantic_enumMember Number    ]] -- Data constructors
vim.cmd [[highlight      LspSemantic_variable   guifg=Gray]] -- Bound variables
vim.cmd [[highlight link LspSemantic_keyword    Structure ]] -- Keywords
vim.cmd [[highlight      LspSemantic_postulate  guifg=Red ]] -- Postulates
vim.cmd [[highlight link LspSemantic_module     Import    ]] -- Not used?

----------------- Nova LSP ----------------
require("nova-setup")

vim.api.nvim_create_autocmd({"BufNewFile","BufRead", "BufEnter"}, {
    pattern = {"*.nova"},
    callback = function(_)
      vim.bo.filetype = "nova"
    end,
    desc = "Assigns a file type to files with .nova extension.",
})


----------------- Homotopy Objective Type Theory LSP ----------------
require("hott-setup")

vim.api.nvim_create_autocmd({"BufNewFile","BufRead", "BufEnter"}, {
    pattern = {"*.hott"},
    callback = function(_)
      vim.bo.filetype = "hott"
    end,
    desc = "Assigns a file type to files with .hott extension.",
})

----------------- nvim-various-textojbs ----------------

vim.keymap.set({ "o", "x" }, "as", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
vim.keymap.set({ "o", "x" }, "<space>is", '<cmd>lua require("various-textobjs").subword("inner")<CR>')

---------------- nvim-spider --------------
vim.keymap.set(
	{ "n", "o", "x" },
	"<space>w",
	"<cmd>lua require('spider').motion('w')<CR>",
	{ desc = "Spider-w" }
)
vim.keymap.set(
	{ "n", "o", "x" },
	"<space>e",
	"<cmd>lua require('spider').motion('e')<CR>",
	{ desc = "Spider-e" }
)
vim.keymap.set(
	{ "n", "o", "x" },
	"<space>b",
	"<cmd>lua require('spider').motion('b')<CR>",
	{ desc = "Spider-b" }
)

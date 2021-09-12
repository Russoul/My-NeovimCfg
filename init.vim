" The Leader key
let g:mapleader='|'
let maplocalleader = "\\"
" This setting helps to avoid encoding issues when
" writing unicode to clipboard (the `+` register)
let $LANG='en_US.UTF-8'
" Opens up the main config file of the Vim distribution
" This config file is tightly bound to Neovim features.
"c for config, f for file
nnoremap <C-x>cf :e $MYVIMRC<CR>
let g:main_config_file_dir = "$HOME/.config/nvim"
set virtualedit=block
set shiftwidth=2
set tabstop=1
set smartcase
set ignorecase
"Technical, used to avoid stack-overflows due to deep recursion.
"Not sure this is needed any longer.
set maxfuncdepth=10000
set expandtab "Tabs are not present in source, always expanded to spaces
set notimeout "Tell Vim to wait indefinitely for further input when pressing a prefix key
set mouse=a "enables mouse in all modes
set wildmenu
set wildmode=list
set history=200
" Set path to your preferred shell here
set shell=/Users/russoul/.nix-profile/bin/fish
set updatetime=100 "Time period at the end of which the swap file is being writen to disk.
set inccommand=nosplit " Previews changes done in interactive commands
" Allow up to 3 signs to be rendered simultaneously
set signcolumn=auto:3
" Highlight on yank (vanity)
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=100, on_visual=true}

" Keep undo history after exit
if has('persistent_undo')
set undofile
set undodir=$HOME/.config/nvim/undo
endif
" ----------------------------


" Sidenote:
" Use neovim-remote !
" nvr --remote
" opens a file in the running neovim instance
" UPDATE: seems like the project has been dead
" -------------

"Plugin configuration start
call plug#begin()
" Idris 2 integration
" Edwin's original plugin. Used here for syntax highlighting only
Plug 'https://github.com/edwinb/idris2-vim'
" A git plugin
Plug 'tpope/vim-fugitive'
" Align lines of code in one command with many options of doing it
Plug 'godlygeek/tabular'
" Commenting code (Neovim 0.5, Lua)
Plug 'b3nj5m1n/kommentary'
" Surrounding text with delimiters
Plug 'https://tpope.io/vim/surround.git'
" Repeating complex commands; often plugins require
" this as a dependency in order for the repeat (.) to work properly
Plug 'https://tpope.io/vim/repeat.git'
" Nice directory tree view (Neovim 0.5, Lua)
Plug 'kyazdani42/nvim-tree.lua'
" The best theme ever (subjectively of course) !
Plug 'https://github.com/joshdick/onedark.vim.git'
" Renders a special line at the bottom of each window that reflects user info
" (programmable, Neovim 0.5, Lua)
Plug 'https://github.com/shadmansaleh/lualine.nvim.git'
" Motions defined for moving around camel-case words
Plug 'https://github.com/bkad/CamelCaseMotion.git'
" Nice when you can't keep up with your cursor movements all around the frame
" (Dims all windows except the one the cursor is currently in)
Plug 'https://github.com/blueyed/vim-diminactive.git'
" Self-explanatory
Plug 'https://github.com/JamshedVesuna/vim-markdown-preview.git'
" Async completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Pretty smart general completion (though not nearly as smart as they claim)
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
" Create and manage terminal instances in Vim
" TODO: Find a replacement for this one, favourably targeting Neovim 0.5, Lua
Plug 'kassio/neoterm'
" Colourful parentheses
Plug 'luochen1990/rainbow'
" LSP configs
Plug 'neovim/nvim-lspconfig'
" Used by Telescope
Plug 'nvim-lua/popup.nvim'
" Used by many plugins
Plug 'nvim-lua/plenary.nvim'
" Handles (multiple) choice generically & comes with a few useful finders
Plug 'nvim-telescope/telescope.nvim'
" Icons
Plug 'kyazdani42/nvim-web-devicons'
" Manage git workflow
Plug 'pwntester/octo.nvim'
" Successor of Signify for Neovim 0.5, Lua
Plug 'lewis6991/gitsigns.nvim'
" In-buffer highlighting of colour codes
Plug 'norcalli/nvim-colorizer.lua'
" Stand-in for EasyMotion based on Neovim 0.5, Lua
Plug 'phaazon/hop.nvim'
" Stand-in for VimSneak (works differently) targeting Neovim 0.5, Lua
Plug 'ggandor/lightspeed.nvim'

" Plugin configuration end
call plug#end()

 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = v:false

" Enable deoplete at startup
" Not always want that as it depletes a battery real fast
let g:deoplete#enable_at_startup = v:false

" Also later pick a keybinding for switching between manual and auto modes
" call deoplete#custom#option('auto_complete', 'manual') " manual/auto

" Render markdown using pandoc.
let vim_markdown_preview_pandoc=1
let vim_markdown_preview_toggle=0
let vim_markdown_preview_hotkey='<C-x>ma'

" --------------------------------
" Set theme and cursor shape/color
if (has("termguicolors"))
   set termguicolors
endif
syntax enable
colorscheme onedark
set guicursor=n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor

" Colour palette setup
function! s:setColours()
   hi Error ctermfg=204 guifg=#FF0000
   hi idrisOperators guifg=#FBAB00
   hi idrNiceOperator guifg=#FBAB00
   hi link idrisStatement Structure
   hi Conceal guifg=#FBAB00
   hi todo guifg=#CCCC00
   hi idrisDocComment guifg=#99ccff
   hi link idrisLineComment Comment
   hi link idrisBlockComment Comment
   hi ColorColumn guibg=#303541
   hi Search guifg=black guibg=orange4
endfunction
call s:setColours()
" --------------------------------

" ====================== RANDOM THINGS =======================
function! ShowTrailingSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function! <SID>StripTrailingSpaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Highlights trailing whitespace
command! -bar -nargs=? ShowTrailingSpaces call ShowTrailingSpaces(<args>)
" Removes trailing whitespace across current buffer
command! -bar -nargs=? StripTrailingSpaces call <SID>StripTrailingSpaces()

" number, scroll, shiftwidth, indentkeys setup for .idr, .py, .vim buffers
" Also strips trailing spaces on write
augroup setupProperties
   autocmd!
   autocmd FileType * set shiftwidth=1 | set indentkeys=
   autocmd FileType vim,idris2,python,javascript,lua,c,hott set number
   autocmd FileType idris2 set foldmethod=expr | call s:setColours()
   autocmd BufWritePre * :call <SID>StripTrailingSpaces()
   autocmd FileType agda set number
   " Filetype for .hott
   autocmd BufNewFile,BufRead *.hott set filetype=hott
augroup END

" Shortcut that toggles NVimTree on the left of the screen
nnoremap <silent> <C-b> :NvimTreeToggle<CR>

" Terminal escape sequence
" I'm ok with <C-v> because I'm on Mac (<D-v> is used for pasting)
tnoremap <C-v><Esc> <C-\><C-n>

" remap of Join
nnoremap <silent> <Space>j :join<CR>

" Unmap this built-in command, else it messes up with the commands below
vnoremap <C-x> <Nop>
unmap <c-x>

"execute visually selected code block (vimL)
vmap <silent> <C-x><C-e>v "xy:@x<CR>

"execute visually selected code block (Lua)
vmap <silent> <C-x><C-e>l "xy:execute(":lua " . @x)<CR>

"execute visually selected code block (terminal)
vnoremap <silent> <C-x><C-e>t :TREPLSendSelection<CR>

"execute visually selected code block (Idris)
vmap <silent> <C-x><C-e>i "xy:lua IdrRepl("<C-r>x")<CR>
"execute visually selected code block (Idris) and erase it
"afterwards
vmap <silent> <C-x><C-e>I "xy:lua IdrRepl("<C-r>x")<CR>gvx

" Comment out the visually highlighted text.
vmap gc <C-]>gc<C-]><Esc><Esc>

" ======================   Finding things   ==========================
func!SearchSelection(cmdname, str)
   if a:str ==# ''
      echo "abort"
      return
   endif
   let dirs = join(readfile(expand("~/dirs.txt")), ' ')
   echom dirs
   let cmd = a:cmdname . " " . "'" . trim(a:str) . "'" . ' ' . dirs
   echom cmd
   exe cmd
endfunction
" TODO reimplement in Telescope.
" nmap <Leader>sfs :call SearchSelection("AckFile!", @")<CR>
" nmap <Leader>sfw :call SearchSelection("AckFile!", "<cword>")<CR>
" nmap <Leader>sfW :call SearchSelection("AckFile!", "<cWORD>")<CR>
" nmap <Leader>sfl :call SearchSelection("AckFile!", getline('.'))<CR>
" nmap <Leader>sfp :call SearchSelection("AckFile!", input("pattern: "))<CR>
" nmap <Leader>scs :call SearchSelection("Ack!", @")<CR>
" nmap <Leader>scw :call SearchSelection("Ack!", "<cword>")<CR>
" nmap <Leader>scW :call SearchSelection("Ack!", "<cWORD>")<CR>
" nmap <Leader>scl :call SearchSelection("Ack!", getline('.'))<CR>
" nmap <Leader>scp :call SearchSelection("Ack!", input("pattern: "))<CR>
" ====================================================================

command! OpenIndentToCursorCol call append('.', repeat(' ', getcurpos()[2] -1)) | exe "normal k" | startinsert!
"^^ starts new line with indent of the current cursor position
func! Get_right_buffers() abort
    let right_edge = win_screenpos(0)[1] + winwidth(0)
    return filter(map(filter(getwininfo(),
        \ {i,v -> v.tabnr == tabpagenr()}),
        \ {i,v -> v.wincol == right_edge + 1 ? getwininfo()[i].bufnr : -1}),
        \ {i,v -> v != -1})
endfunc

function! NewLineAndBack()
   let pos = getcurpos()
   :execute "normal h\<CR>\<Esc>"
   :call setpos(".", pos)
endfunction

function! NewLineBegAndBack()
   let pos = getcurpos()
   :execute "normal o\<Esc>"
   :call setpos(".", [pos[0], pos[1], pos[2], pos[3], pos[4]])
endfunction

function! NewLineBegAboveAndBack()
   let pos = getcurpos()
   :execute "normal O\<Esc>"
   :call setpos(".", [pos[0], pos[1] + 1, pos[2], pos[3], pos[4]])
endfunction

" A few commands that push a newline to the next/previous line
nmap <Leader>o :call NewLineAndBack()<CR>
nmap <Leader>n :call NewLineBegAndBack()<CR>
nmap <Leader>N :call NewLineBegAboveAndBack()<CR>

" Put the cursor on the next line at the same column it currently is
nnoremap <Leader>K :OpenIndentToCursorCol<CR>

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" Toggles latest search highlight
nnoremap <leader><space> :set hlsearch!<CR>

" ============== MOTION ================

" Main movement remaps
"               i
"               ^
" I use         |
"         j <--- --->  l
"               |
" For           v
"  movement     k
"
map <S-l> <nop>
noremap <S-j> ^
noremap <S-l> g_
nnoremap k <Down>
nnoremap j <Left>
nnoremap i <Up>
vnoremap k <Down>
vnoremap j <Left>
vnoremap i <Up>
vnoremap I i
nnoremap h i
vnoremap h i
nnoremap H I
vnoremap H I
nnoremap <C-P> <C-I>
nnoremap I <nop>

" Jump to the start/end of a line in insert/cmd modes
inoremap <C-j> <C-o>^
inoremap <C-l> <C-o>$
cnoremap <C-j> <C-b>
cnoremap <C-l> <C-e>

" Double movements
nmap <silent> <Up> ii
nmap <silent> <Down> kk
nmap <silent> <Left> jj
nmap <silent> <Right> ll

vmap <silent> <Up> ii
vmap <silent> <Down> kk
vmap <silent> <Left> jj
vmap <silent> <Right> ll

" CamelCaseMotion
nmap <silent> <Space>w <Plug>CamelCaseMotion_w
nmap <silent> <Space>b <Plug>CamelCaseMotion_b
nmap <silent> <Space>e <Plug>CamelCaseMotion_e
" nmap <silent> <Space>ge <Plug>CamelCaseMotion_ge
vmap <silent> <Space>w <Plug>CamelCaseMotion_w
vmap <silent> <Space>b <Plug>CamelCaseMotion_b
vmap <silent> <Space>e <Plug>CamelCaseMotion_e
" vmap <silent> <Space>ge <Plug>CamelCaseMotion_ge
omap <silent> <Space>iw <Plug>CamelCaseMotion_iw
xmap <silent> <Space>iw <Plug>CamelCaseMotion_iw
omap <silent> <Space>ib <Plug>CamelCaseMotion_ib
xmap <silent> <Space>ib <Plug>CamelCaseMotion_ib
omap <silent> <Space>ie <Plug>CamelCaseMotion_ie
xmap <silent> <Space>ie <Plug>CamelCaseMotion_ie

" ================ Buffers, Files, Projects ==================
nnoremap <silent> <C-x>b :lua MyBuffers()<CR>
cnoremap <silent> <C-x>b :lua MyBuffers()<CR>
tnoremap <silent> <C-x>b <C-\><C-n>:lua MyBuffers()<CR>

" Close all buffers except this one (caveat: doesn't keep the cursor position)
nnoremap <silent> <C-x>qab :%bd\|e#<CR>
nnoremap <silent> <C-x>qb :b#<bar>bd#<CR>

"Search the working directory for files.
nnoremap <silent> <C-x>ff :Telescope fd<CR>
cnoremap <silent> <C-x>ff :Telescope fd<CR>
tnoremap <silent> <C-x>ff <C-\><C-n>:Telescope fd<CR>

" Find files in the folder storing all Idris 2 source files
" It is planned to change this folder soon.
command! FilesIdr :lua require("telescope.builtin").fd({search_dirs={"~/.idris2/idris2-0.4.0"}})
nnoremap <silent> <C-x>fi :FilesIdr<CR>
cnoremap <silent> <C-x>fi :FilesIdr<CR>
tnoremap <silent> <C-x>fi <C-\><C-n>:FilesIdr<CR>

" TODO If I ever need it, implement via Telescope.
" nnoremap <silent> <C-x>w :Windows<CR>
" cnoremap <silent> <C-x>w :Windows<CR>
" tnoremap <silent> <C-x>w <C-\><C-n>:Windows<CR>

" TODO If I ever need it, implement via Telescope.
" Modified tracked files
" nnoremap <silent> <C-g>s :GFiles?<CR>
" cnoremap <silent> <C-g>s :GFiles?<CR>
" tnoremap <silent> <C-g>s <C-\><C-n>:GFiles?<CR>

" TODO If I ever need it, implement via Telescope.
" nnoremap <silent> <C-s>l :Lines<CR>
" cnoremap <silent> <C-s>l :Lines<CR>
" tnoremap <silent> <C-s>l <C-\><C-n>:Lines<CR>

nnoremap <silent> <C-s>L :Telescope live_grep<CR>
cnoremap <silent> <C-s>L :Telescope live_grep<CR>
tnoremap <silent> <C-s>L <C-\><C-n>:Telescope live_grep<CR>

" A few commands for jumping between buffers
nnoremap <silent> <C-x>" :bprevious<CR>
nnoremap <silent> <C-x>' :bnext<CR>
nnoremap <silent> <C-x>1 :bfirst<CR>
" Switch to the alternate buffer
nnoremap <C-u> <C-^>

" Source a config file that features a nifty window manipulation interface.
execute("source " . g:main_config_file_dir . "/config/window_manip.vim")

" Open an existing terminal instance in the current window.
nnoremap <silent> <C-w>t :Topen<CR>

function! s:jumpInBufH(prev, jumpId, thisBuf, jumps, count)
  if a:jumpId <= 0 || a:jumpId >= len(a:jumps)
    return
  elseif a:jumps[a:jumpId]['bufnr'] == a:thisBuf
    if a:prev
      execute "normal! " . a:count . "\<C-o>"
    else
      execute "normal! " . a:count . "\<C-i>"
    endif
  else
    let newJumpId = 0
    if a:prev
      let newJumpId = a:jumpId - 1
    else
      let newJumpId = a:jumpId + 1
    end
    call s:jumpInBufH(a:prev, newJumpId, a:thisBuf, a:jumps, a:count + 1)
  endif
endfunction

function! JumpPrevInBuf()
  let [jumps, lastJump] = getjumplist()
  let thisBuf = bufnr('%')
  call s:jumpInBufH(v:true, lastJump - 1, thisBuf, jumps, 1)
endfunction

function! JumpNextInBuf()
  let [jumps, lastJump] = getjumplist()
  let thisBuf = bufnr('%')
  call s:jumpInBufH(v:false, lastJump + 1, thisBuf, jumps, 1)
endfunction

" Those two commands allow one to jump back and forth
" the jump list but only moving along the lines in the current buffer
nnoremap <silent> <Space><C-I> :call JumpNextInBuf()<CR>
nnoremap <silent> <Space><C-O> :call JumpPrevInBuf()<CR>

" Simple word completion from dictionary.
" TODO Reimplement in Telescope.
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})

nnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.4.0"}})<CR>
cnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.4.0"}})<CR>
tnoremap <silent> <C-x>li <C-\><C-n>:lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.4.0"}})<CR>

nnoremap <silent> <C-x>ll :lua require("telescope.builtin").live_grep()<CR>
cnoremap <silent> <C-x>ll :lua require("telescope.builtin").live_grep()<CR>
tnoremap <silent> <C-x>ll <C-\><C-n>:lua require("telescope.builtin").live_grep()<CR>
" ===============================================================

lua << EOF
local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local IdrResponseBufferName = "idris-response"

require("lightspeed-setup")
require("gitsigns-setup")
require("colorizer").setup()
require("hop").setup{create_hl_autocmd = true}
require("nvim-web-devicons").setup{default = true}
require("telescope-setup")
require("idris2-setup")
require("smart-abbrev-setup")
require("hott-setup")
require("lualine-setup")
require("kommentary-setup")
require("octo-setup")

vim.api.nvim_set_keymap('n', '<LocalLeader>j', ':lua vim.lsp.buf.definition()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<LocalLeader>h', ':lua vim.lsp.buf.hover()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<LocalLeader>a', ':Telescope lsp_code_actions<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<LocalLeader>d', ':lua vim.lsp.buf.signature_help()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', ']d', ':lua vim.lsp.diagnostic.goto_next()<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '[d', ':lua vim.lsp.diagnostic.goto_prev()<CR>',
                        {noremap = true, silent = false})

EOF

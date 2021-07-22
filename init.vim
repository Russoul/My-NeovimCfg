" The Leader key
let g:mapleader='|'
let maplocalleader = "\\"
" This setting helps to avoid encoding issues when
" writing unicode to clipboard (the `+` register)
let $LANG='en_US.UTF-8'
" Opens up the main config file of your Vim distribution
"c for config, f for file
nnoremap <C-x>cf :e $MYVIMRC<CR>
let g:main_config_file_dir = "$HOME/.config/nvim"
" Or set to block
set virtualedit=block
set shiftwidth=2
set tabstop=1
set smartcase
set ignorecase
set maxfuncdepth=10000
set expandtab "Tabs are not present in source, always expanded to spaces
set notimeout "Tell Vim to wait indefinitely for further input when pressing a prefix key
set mouse=a "enables mouse in all modes
set wildmenu
set wildmode=list
set history=200
" Set path to your preferred shell here
set shell=/Users/russoul/.nix-profile/bin/fish
set updatetime=100 "Used in VimGutter
set inccommand=nosplit " Previews changes done in interactive commands
" Allow up to 3 signs to be rendered simultaneously
set signcolumn=auto:3
" Highlight on yank
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

" Keep undo history after exit
if has('persistent_undo')
set undofile
set undodir=$HOME/.config/nvim/undo
endif
" ----------------------------


" Sidenote:
"Use neovim-remote !
" nvr --remote
" opens a file in the running neovim instance
" -------------

"Plugin configuration start
call plug#begin()
" Idris 2 integration
" Edwin's original plugin. Used for syntax highlighting only.
Plug 'https://github.com/edwinb/idris2-vim'
" A git plugin
Plug 'tpope/vim-fugitive'
" Align lines of code in one command with many options of doing it.
Plug 'godlygeek/tabular'
" Commenting code
Plug 'https://github.com/tpope/vim-commentary.git'
" Surrounding text with delimiters
Plug 'https://tpope.io/vim/surround.git'
" Repeating complex commands; often plugins require
" this as a dependency in order for the repeat (.) to work properly
Plug 'https://tpope.io/vim/repeat.git'
" Nice directory tree view
Plug 'https://github.com/preservim/nerdtree.git'
" The best theme ever (subjectively of course) !
Plug 'https://github.com/joshdick/onedark.vim.git'
" Renders a special line at the bottom of each window that reflects user info
" (programmable)
Plug 'itchyny/lightline.vim'
" Motions defined for moving around camel-case words
Plug 'https://github.com/bkad/CamelCaseMotion.git'
" Nice when you can't keep up with your cursor movements all around the frame
Plug 'https://github.com/blueyed/vim-diminactive.git'
" Self-explanatory
Plug 'https://github.com/JamshedVesuna/vim-markdown-preview.git'
" Async completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Pretty smart general completion (though not nearly as smart as they claim)
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
" Create and manage terminal instances in Vim
Plug 'kassio/neoterm'
" Colourful parentheses
Plug 'luochen1990/rainbow'
" LSP configs
Plug 'neovim/nvim-lspconfig'
" Used by Telescope
Plug 'nvim-lua/popup.nvim'
" Used by many plugins
Plug 'nvim-lua/plenary.nvim'
" Handles (multiple) choice generically & comes with a few useful finders.
Plug 'nvim-telescope/telescope.nvim'
" Icons
Plug 'kyazdani42/nvim-web-devicons'
" Manage git workflow
Plug 'pwntester/octo.nvim'
" Successor of Signify for Neovim 0.5
Plug 'lewis6991/gitsigns.nvim'
" In-buffer highlighting of colour codes
Plug 'norcalli/nvim-colorizer.lua'
" Stand-in for EasyMotion based on Neovim 0.5
Plug 'phaazon/hop.nvim'
" Stand-in for VimSneak (works differently)
Plug 'ggandor/lightspeed.nvim'

" Plugin configuration end
call plug#end()

 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = v:false

" Enable deoplete at startup
" Not always want that as it depletes a battery real fast
let g:deoplete#enable_at_startup = v:false

" Also later pick a keybind for switching between manual and auto modes
" call deoplete#custom#option('auto_complete', 'manual') " manual/auto

" Render .md like github does, using grip.
"let vim_markdown_preview_github=1
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

" Color palette setup
function! s:setColors()
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
call s:setColors()
" --------------------------------

" ================  Configure Lightline ===========================
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help'&& &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction


function! s:lightlineUpdate()
  call lightline#update()
endfunction

augroup AutoLightline
  autocmd!
  autocmd CursorHold * call s:lightlineUpdate()
augroup END
" ===============================================================

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
   autocmd FileType vim,idris2,python,javascript,lua,c set number
   autocmd FileType idris2 set foldmethod=expr | call s:setColors()
   autocmd BufWritePre * :call <SID>StripTrailingSpaces()
   autocmd FileType agda set number
augroup END

" Specify how to comment idris code
autocmd FileType idris2 setlocal commentstring=--\ %s

" Not sure what those do ...
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" Some NerdTree options I never set myself
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeMapOpenSplit='h'
let g:NERDTreeMapPreviewSplit='gh'

" Shortcut that toggles NerdTree on the left of the screen
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" Terminal escape sequence
" I'm ok with <C-v> because I'm on Mac (<D-v> is used for pasting)
tnoremap <C-v><Esc> <C-\><C-n>

" remap of Join
nnoremap <silent> <Space>j :join<CR>

" Unmap this built-in command, else it messes up with the commands below
vnoremap <C-x> <Nop>

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
" Actually uses Ag internally !
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

lua << EOF
vim.api.nvim_set_keymap('n', '<space><space>l', "<cmd>HopLine<cr>", {})
vim.api.nvim_set_keymap('n', '<space><space>w', "<cmd>HopWord<cr>", {})
vim.api.nvim_set_keymap('n', '<space><space>c1', "<cmd>HopChar1<cr>", {})
vim.api.nvim_set_keymap('n', '<space><space>c2', "<cmd>HopChar2<cr>", {})
vim.api.nvim_set_keymap('n', '<space><space>/', "<cmd>HopPattern<cr>", {})

function repeat_ft(reverse)
  local ls = require'lightspeed'
  ls.ft['instant-repeat?'] = true
  ls.ft:to(reverse, ls.ft['prev-t-like?'])
end
vim.api.nvim_set_keymap('n', ';', '<cmd>lua repeat_ft(false)<cr>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', ';', '<cmd>lua repeat_ft(false)<cr>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', ',', '<cmd>lua repeat_ft(true)<cr>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', ',', '<cmd>lua repeat_ft(true)<cr>',
                        {noremap = true, silent = true})

EOF

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
command! FilesIdr :lua require("telescope.builtin").fd({search_dirs={"~/.idris2/idris2-0.3.0"}})
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

function! ShowInPreview(name, fileType, lines)
    let l:command = "silent! pedit! +setlocal\\ " .
                  \ "buftype=nofile\\ nobuflisted\\ " .
                  \ "noswapfile\\ nonumber\\ " .
                  \ "filetype=" . a:fileType . " " . a:name

    exe l:command

    if has('nvim')
        let l:bufNr = bufnr(a:name)
        call nvim_buf_set_lines(l:bufNr, 0, -1, 0, a:lines)
    else
        call setbufline(a:name, 1, a:lines)
    endif
endfunction

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

nnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.3.0"}})<CR>
cnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.3.0"}})<CR>
tnoremap <silent> <C-x>li <C-\><C-n>:lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.3.0"}})<CR>

nnoremap <silent> <C-x>ll :lua require("telescope.builtin").live_grep()<CR>
cnoremap <silent> <C-x>ll :lua require("telescope.builtin").live_grep()<CR>
tnoremap <silent> <C-x>ll <C-\><C-n>:lua require("telescope.builtin").live_grep()<CR>
" ===============================================================

" ================= Other plugin setup ==========================
lua << EOF
require('gitsigns').setup()
require('colorizer').setup()
require('hop').setup {
  create_hl_autocmd = true
}
EOF
" ===============================================================

" ================ LSP config for Idris2 ========================
lua << EOF
local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local IdrResponseBufferName = "idris-response"

function IdrInitBuf()
  if vim.fn.bufexists(IdrResponseBufferName) == 1 then
    return vim.fn.bufnr(IdrResponseBufferName)
  end

  -- Create / find the existing
  local bufid = vim.fn.bufadd(IdrResponseBufferName)

  -- Create new window with the buffer
  vim.cmd("sbuffer " .. bufid)

  vim.cmd("setlocal bufhidden=hide")

  -- For syntax highlighting.
  vim.cmd("setlocal filetype=idris2")

  vim.cmd("setlocal buftype=nofile")

  -- Get back to where we were.
  vim.cmd("q")

  return bufid
end

function IdrScrollBuf()
  local bufid = IdrInitBuf()
  local curWinId = vim.fn.win_getid()
  local winid = vim.fn.bufwinid(bufid)
  if winid >= 0 then
    vim.fn.win_gotoid(winid)
    vim.cmd("normal! G")
    vim.fn.win_gotoid(curWinId)
  end
end

-- TODO smoother transition when opening/closing
function IdrOpenBuf()
  local bufid = IdrInitBuf()

  -- Find the first window where that buffer is loaded into.
  local winid = vim.fn.bufwinid(bufid)
  -- If there is one already, we are done.
  if winid >= 0 then
    return false
  end
  local curWinId = vim.fn.win_getid()

  -- Create new window with the buffer
  vim.cmd("sbuffer " .. bufid)

  -- This should find it now.
  local winid = vim.fn.bufwinid(bufid)
  if winid == -1 then
    vim.fn.echom("Weird behaviour when openning 'idris-response'")
    return false
  end

  -- Move to the very right.
  vim.cmd("winc L")
  -- Resize
  vim.cmd("vertical resize 60")
  vim.fn.win_gotoid(curWinId)

  return true

end

function IdrCloseBuf()
  -- Find the first window where that buffer is loaded into.
  local winid = vim.fn.bufwinid(IdrResponseBufferName)
  -- If there is none, we are done
  if winid == -1 then
    return false
  end

  -- close
  vim.cmd(vim.fn.win_id2win(winid) .. "wincmd c")

  return true

end

function IdrToggleBuf()
  local bufid = IdrInitBuf()
  -- Find the first window where that buffer is loaded into.
  local winid = vim.fn.bufwinid(IdrResponseBufferName)
  -- If there is none, open. Otherwise, close.
  if winid == -1 then
    IdrOpenBuf()
  else
    IdrCloseBuf()
  end

end

function IdrPullDiag()
  local diag = vim.lsp.diagnostic.get()
  local buf = IdrInitBuf()
    vim.fn.appendbufline(buf, '$', "")
    vim.fn.appendbufline(buf, '$', "-------------")
    vim.fn.appendbufline(buf, '$', "")
  if #diag > 0 then
    for _, x in pairs(diag) do
      local str = x.message
      for s in str:gmatch("[^\r\n]+") do
        vim.fn.appendbufline(buf, '$', s)
      end
    end
  else
    local t = vim.fn.strftime("%T")
    vim.fn.appendbufline(buf, '$', "")
    vim.fn.appendbufline(buf, '$', "[" .. t .. "]" .. " No errors")
    vim.fn.appendbufline(buf, '$', "")
  end
  IdrScrollBuf()
end

if not lspconfig.idris2_lsp then
  configs.idris2_lsp = {
    default_config = {
      cmd = {'idris2-lsp'}; -- if not available in PATH, provide the absolute path
      filetypes = {'idris2'};
      on_new_config = function(new_config, new_root_dir)
        new_config.cmd = {'idris2-lsp'}
        new_config.capabilities['workspace']['semanticTokens'] = {refreshSupport = true}
      end;
      root_dir = function(fname)
        local scandir = require('plenary.scandir')
        local find_ipkg_ancestor = function(fname)
          return lspconfig.util.search_ancestors(fname, function(path)
            local res = scandir.scan_dir(path, {depth=1; search_pattern='.+%.ipkg'})
            if not vim.tbl_isempty(res) then
              return path
            end
          end)
        end
        return find_ipkg_ancestor(fname) or lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      settings = {};
    };
  }
end

local autostart_semantic_highlightning = true
lspconfig.idris2_lsp.setup {
  on_init = custom_init,
  on_attach = function(client)
    if autostart_semantic_highlightning then
      vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
        { textDocument = vim.lsp.util.make_text_document_params() }, nil)
    end
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

      local ns = vim.api.nvim_create_namespace('nvim-lsp-semantic')
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
      local tokens = {}
      local prev_line, prev_start = nil, 0
      for i = 1, #data, 5 do
        local delta_line = data[i]
        prev_line = prev_line and prev_line + delta_line or delta_line
        local delta_start = data[i + 1]
        prev_start = delta_line == 0 and prev_start + delta_start or delta_start
        local token_type = token_types[data[i + 3] + 1]
        vim.api.nvim_buf_add_highlight(bufnr, ns, 'LspSemantic_' .. token_type, prev_line, prev_start, prev_start + data[i + 2])
      end
    end
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
function(err, method, params, client_id)
  (vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      -- Disable underline, it's very annoying when it covers up whole lines of code
      underline = true,
      -- So is virtual text, that is almost always obscured by the vertical line border.
      virtual_text = true,
      -- Render that `E` thingy over the left border.
      signs = true,
      update_in_insert = true
  }))(err, method, params, client_id)
  IdrPullDiag()
end

-- Set here your preferred colors for semantic values
vim.cmd [[highlight link LspSemantic_type Include]]   -- Type constructors
vim.cmd [[highlight link LspSemantic_function Identifier]] -- Functions names
vim.cmd [[highlight link LspSemantic_struct Number]]   -- Data constructors
vim.cmd [[highlight LspSemantic_variable guifg=gray]] -- Bound variables
vim.cmd [[highlight link LspSemantic_keyword Structure]]  -- Keywords

-- :lua vim.lsp.buf_request(0, 'textDocument/semanticTokens/full', {textDocument = vim.lsp.util.make_text_document_params()}, nil)

--vim.cmd [[highlight LspSemantic_type guifg=#ff9d5c]]     -- Type constructors
--vim.cmd [[highlight link LspSemantic_function Identifier]] -- Functions names
--vim.cmd [[highlight link LspSemantic_struct Number]]   -- Data constructors
--vim.cmd [[highlight LspSemantic_variable guifg=gray]] -- Bound variables
--vim.cmd [[highlight link LspSemantic_keyword Structure]]  -- Keywords

function IdrReload()
  vim.lsp.buf.execute_command({command = "reload", arguments = {vim.lsp.util.make_range_params().textDocument.uri}})
end

function IdrRepl(cmd)
  --local table = vim.lsp.util.make_range_params()
  --table.cmd = cmd
  vim.lsp.buf_request(0, "workspace/executeCommand", {command = "repl", arguments = {cmd}}, function(err, method, result, client_id, bufnr, config)
  local buf = IdrInitBuf()
  vim.fn.appendbufline(buf, '$', "")
  vim.fn.appendbufline(buf, '$', "-------------")
  vim.fn.appendbufline(buf, '$', "")
  for s in result:gmatch("[^\r\n]+") do
    vim.fn.appendbufline(buf, '$', s)
  end
  IdrScrollBuf()
  end)
end

function IdrSmartFill(name, sl, sc, el, ec)
  --local table = vim.lsp.util.make_range_params()
  --table.cmd = cmd
  vim.lsp.buf_request(0, "workspace/executeCommand", {command = "smartfill",
    arguments = {name, tostring(sl - 1), tostring(sc - 1), tostring(el - 1), tostring(ec - 1)}}, function(err, method, result, client_id, bufnr, config)
  local buf = IdrInitBuf()
  vim.fn.appendbufline(buf, '$', "")
  vim.fn.appendbufline(buf, '$', "-------------")
  vim.fn.appendbufline(buf, '$', "")
  for s in result:gmatch("[^\r\n]+") do
    vim.fn.appendbufline(buf, '$', s)
  end
  IdrScrollBuf()
  end)
end

EOF

nnoremap <LocalLeader>q :lua IdrToggleBuf()<CR>
nnoremap <LocalLeader>j :lua vim.lsp.buf.definition()<CR>
nnoremap <LocalLeader>h :lua vim.lsp.buf.hover()<CR>
nnoremap <LocalLeader>a :Telescope lsp_code_actions<CR>
nnoremap <LocalLeader>d :lua vim.lsp.buf.signature_help()<CR>
nnoremap <LocalLeader>p :lua IdrPullDiag()<CR>
nnoremap ]d :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap [d :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <LocalLeader>r :lua IdrReload()<CR>

" ======================== TELESCOPE ============================
lua << EOF
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

function MyBuffers()
  require('telescope.builtin').buffers({
    show_all_buffers = true,
    attach_mappings = function(prompt_bufnr, map)
      local state = require('telescope.actions.state')
      local actions = require('telescope.actions')
      map("n", 'x', function(a, b, c)
        vim.cmd("bdelete " .. state.get_selected_entry().bufnr)
        actions.close(prompt_bufnr)
        vim.cmd("lua require('telescope.builtin').buffers{show_all_buffers=true}")
      end)
      return true
    end
  })
end

require'nvim-web-devicons'.setup {
 default = true;
}

EOF

" ======================== Octo ============================
lua << EOF

require"octo".setup({
default_remote = {"upstream", "origin"}; -- order to try remotes
reaction_viewer_hint_icon = "💬";          -- marker for user reactions
user_icon = "👤";                         -- user icon
timeline_marker = "🕑";                   -- timeline marker
timeline_indent = "2";                   -- timeline indentation
right_bubble_delimiter = ">>";            -- Bubble delimiter
left_bubble_delimiter = "<<";             -- Bubble delimiter
github_hostname = "";                    -- GitHub Enterprise host
snippet_context_lines = 4;               -- number or lines around commented lines
file_panel = {
  size = 10,                             -- changed files panel rows
  use_icons = true                       -- use web-devicons in file panel
},
mappings = {
  issue = {
    close_issue = "<space>ic",           -- close issue
    reopen_issue = "<space>io",          -- reopen issue
    list_issues = "<space>il",           -- list open issues on same repo
    reload = "<C-r>",                    -- reload issue
    open_in_browser = "<C-o>",           -- open issue in browser
    add_assignee = "<space>aa",          -- add assignee
    remove_assignee = "<space>ad",       -- remove assignee
    add_label = "<space>la",             -- add label
    remove_label = "<space>ld",          -- remove label
    goto_issue = "<space>gi",            -- navigate to a local repo issue
    add_comment = "<space>ca",           -- add comment
    delete_comment = "<space>cd",        -- delete comment
    next_comment = "]c",                 -- go to next comment
    prev_comment = "[c",                 -- go to previous comment
    react_hooray = "<space>rp",          -- add/remove 🎉 reaction
    react_heart = "<space>rh",           -- add/remove ❤️ reaction
    react_eyes = "<space>re",            -- add/remove 👀 reaction
    react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
    react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
    react_rocket = "<space>rr",          -- add/remove 🚀 reaction
    react_laugh = "<space>rl",           -- add/remove 😄 reaction
    react_confused = "<space>rc",        -- add/remove 😕 reaction
  },
  pull_request = {
    checkout_pr = "<space>po",           -- checkout PR
    merge_pr = "<space>pm",              -- merge PR
    list_commits = "<space>pc",          -- list PR commits
    list_changed_files = "<space>pf",    -- list PR changed files
    show_pr_diff = "<space>pd",          -- show PR diff
    add_reviewer = "<space>va",          -- add reviewer
    remove_reviewer = "<space>vd",       -- remove reviewer request
    close_issue = "<space>ic",           -- close PR
    reopen_issue = "<space>io",          -- reopen PR
    list_issues = "<space>il",           -- list open issues on same repo
    reload = "<C-r>",                    -- reload PR
    open_in_browser = "<C-o>",           -- open PR in browser
    add_assignee = "<space>aa",          -- add assignee
    remove_assignee = "<space>ad",       -- remove assignee
    add_label = "<space>la",             -- add label
    remove_label = "<space>ld",          -- remove label
    goto_issue = "<space>gi",            -- navigate to a local repo issue
    add_comment = "<space>ca",           -- add comment
    delete_comment = "<space>cd",        -- delete comment
    next_comment = "]c",                 -- go to next comment
    prev_comment = "[c",                 -- go to previous comment
    react_hooray = "<space>rp",          -- add/remove 🎉 reaction
    react_heart = "<space>rh",           -- add/remove ❤️ reaction
    react_eyes = "<space>re",            -- add/remove 👀 reaction
    react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
    react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
    react_rocket = "<space>rr",          -- add/remove 🚀 reaction
    react_laugh = "<space>rl",           -- add/remove 😄 reaction
    react_confused = "<space>rc",        -- add/remove 😕 reaction
  },
  review_thread = {
    goto_issue = "<space>gi",            -- navigate to a local repo issue
    add_comment = "<space>ca",           -- add comment
    add_suggestion = "<space>sa",        -- add suggestion
    delete_comment = "<space>cd",        -- delete comment
    next_comment = "]c",                 -- go to next comment
    prev_comment = "[c",                 -- go to previous comment
    select_next_entry = "]q",            -- move to previous changed file
    select_prev_entry = "[q",            -- move to next changed file
    close_review_tab = "<C-c>",          -- close review tab
    react_hooray = "<space>rp",          -- add/remove 🎉 reaction
    react_heart = "<space>rh",           -- add/remove ❤️ reaction
    react_eyes = "<space>re",            -- add/remove 👀 reaction
    react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
    react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
    react_rocket = "<space>rr",          -- add/remove 🚀 reaction
    react_laugh = "<space>rl",           -- add/remove 😄 reaction
    react_confused = "<space>rc",        -- add/remove 😕 reaction
  },
  submit_win = {
    approve_review = "<C-a>",            -- approve review
    comment_review = "<C-m>",            -- comment review
    request_changes = "<C-r>",           -- request changes review
    close_review_tab = "<C-c>",          -- close review tab
  },
  review_diff = {
    add_review_comment = "<space>ca",    -- add a new review comment
    add_review_suggestion = "<space>sa", -- add a new review suggestion
    focus_files = "<leader>e",           -- move focus to changed file panel
    toggle_files = "<leader>b",          -- hide/show changed files panel
    next_thread = "]t",                  -- move to next thread
    prev_thread = "[t",                  -- move to previous thread
    select_next_entry = "]q",            -- move to previous changed file
    select_prev_entry = "[q",            -- move to next changed file
    close_review_tab = "<C-c>",          -- close review tab
    toggle_viewed = "<leader><space>",   -- toggle viewer viewed state
  },
  file_panel = {
    next_entry = "j",                    -- move to next changed file
    prev_entry = "k",                    -- move to previous changed file
    select_entry = "<cr>",               -- show selected changed file diffs
    refresh_files = "R",                 -- refresh changed files panel
    focus_files = "<leader>e",           -- move focus to changed file panel
    toggle_files = "<leader>b",          -- hide/show changed files panel
    select_next_entry = "]q",            -- move to previous changed file
    select_prev_entry = "[q",            -- move to next changed file
    close_review_tab = "<C-c>",          -- close review tab
    toggle_viewed = "<leader><space>",   -- toggle viewer viewed state
  }
}
})

EOF

" ============== Mini plugin for 'smart' abbreviations ==============

execute("luafile " . g:main_config_file_dir . "/config/smart_abbrev_map.lua")
lua << EOF

-- Small test suite:
-- SubstLongestMatchRightToLeft({{"eta", "η"}, {"Theta", "ϴ"}}, "Greek capital Theta") = "Greek capital ϴ", -3
-- SubstLongestMatchRightToLeft({{"eta", "η"}, {"Theta", "ϴ"}}, "Greek small eta") = "Greek small η", -1
-- SubstLongestMatchRightToLeft({{"eta", "η"}, {"Theta", "ϴ"}}, "Greek small \eta") = "Greek small η", -1
-- SubstLongestMatchRightToLeft({{"eta", "η"}, {"Theta", "ϴ"}}, "Greek small beta") = nil
function SubstLongestMatchRightToLeft(abbrev_list, txt)
  local longestLength = 0
  local toSubst = ""
  for _, abbrev in ipairs(abbrev_list) do
    local key = abbrev[1]
    local subst = abbrev[2]
    local m = txt:match(key .. '$')
    if m and #m > longestLength then
      longestLength = #m
      toSubst = subst
    end
  end
  if toSubst ~= "" then
    local upToMatch = txt:sub(0, -(longestLength + 1))
    if upToMatch:sub(#upToMatch, #upToMatch) == smart_abbrev_delim then
      upToMatch = upToMatch:sub(0, -2)
    end
    local newLine = upToMatch .. toSubst
    return newLine, #toSubst - longestLength
  else
    return nil
  end
end

-- eta<C-]>   ==> η
-- \eta<C-]>  ==> η
-- Theta<C-]>  ==> ϴ
-- Th\eta<C-]> ==> Thη
function SmartAbbrevExpand()
  local lineTxt = vim.fn.getline('.')
  local buf = vim.fn.getpos('.')[1]
  local line = vim.fn.getpos('.')[2]
  local col = vim.fn.getpos('.')[3]
  local offset = vim.fn.getpos('.')[4]
  if not lineTxt or not col then
    vim.fn.echom("Can't expand: getline | getpos returned nil")
  else
    local upToCursor = lineTxt:sub(0, col)
    local upToCursorExpanded, dif = SubstLongestMatchRightToLeft(smart_abbrev_map, upToCursor)
    if upToCursorExpanded then
      local expandedLine = upToCursorExpanded .. lineTxt:sub(col + 1)
      vim.fn.setline('.', expandedLine)
      vim.fn.setpos('.', {buf, line, col + dif, offset})
    end
  end
end

EOF
inoremap <silent> <C-]> <Left><C-o>:lua SmartAbbrevExpand()<CR><Right>
" FIXME doesn't work
tnoremap <silent> <C-]> <Left><C-\><C-n>:lua SmartAbbrevExpand()<CR><Right>
unmap <c-x>


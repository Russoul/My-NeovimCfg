" The Leader key
let g:mapleader='|'
let maplocalleader = "\\"
let g:agdavim_enable_goto_definition = 0
" Opens up the main config file of your Vim distribution
"c for config, f for file
nnoremap <C-x>cf :e $MYVIMRC<CR>
let g:main_config_file_dir = "/Users/russoul/.config/nvim"

" Or set to block
set virtualedit=all
set shiftwidth=2
set tabstop=2
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

" expand UltiSnips abbreviations via this shortcut:
let g:UltiSnipsExpandTrigger = "<C-]>"
let g:sneak#label = 0

" TODO Is it used or not? -- I have no idea
let g:idris2_load_on_start = v:false

let g:signify_priority = 2

" Sidenote:
"Use neovim-remote !
" nvr --remote
" opens a file in the running neovim instance
" -------------

"Plugin configuration start
call plug#begin()
" Idris 2 integration
" Edwin's original plugin. Not used.
Plug 'https://github.com/edwinb/idris2-vim'
" This is used by me currently.
" Hope to switch to Idris2-LSP soonish
" Plug 'ShinKage/nvim-idris2', {'do': 'make build'}
" A git plugin
Plug 'tpope/vim-fugitive'
" Align lines of code in one command with many options of doing it.
Plug 'godlygeek/tabular'
" Agda plugin
" Plug 'https://github.com/derekelkins/agda-vim'
Plug 'https://github.com/GustavoMF31/agda-vim'
" A plugin for moving around
Plug 'easymotion/vim-easymotion'
" Another plugin for moving around. (More lightweight)
Plug 'justinmk/vim-sneak'
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
" Not sure what that does anymore ...
Plug 'https://github.com/dag/vim-fish.git'
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
" Plugin for doing your VC tasks in Vim
Plug 'mhinz/vim-signify'
" Create and manage terminal instances in Vim
" Has problems with the fish terminals though
Plug 'kassio/neoterm'
" Colorful parentheses
Plug 'luochen1990/rainbow'
" Code snippets (and in particular - abbreviations)
Plug 'sirver/ultisnips'
" LSP configs
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Handles (multiple) choice generically & comes with a few useful finders.
Plug 'nvim-telescope/telescope.nvim'

" Plugin configuration end
call plug#end()

let g:rainbow_active = v:false "set to 0 if you want to enable it later via :RainbowToggle

" Enable deoplete at startup
" Not always want that as it depletes a battery real fast
let g:deoplete#enable_at_startup = v:false

" Also later pick a keybind for switching between manual and auto modes
" call deoplete#custom#option('auto_complete', 'manual') " manual/auto

" Render .md like github does, using grip.
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=2
let vim_markdown_preview_hotkey='<C-x>ma'

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
endfunction
call s:setColors()


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

"execute visually selected code block (vimL)
vmap <C-x><C-e>v "xy:@x<CR>

"execute visually selected code block (Lua)
vmap <C-x><C-e>l "xy:execute(":lua " . @x)<CR>

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

" Keep undo history after exit
if has('persistent_undo')
set undofile
set undodir=$HOME/.config/nvim/undo
endif

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

" Space is the main prefix key for motion commands
map <Space><Space> <Plug>(easymotion-prefix)

" Move over any open windows
nmap <Space>g <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" Move line up
map <Space><space>i <Plug>(easymotion-k)
" Move line down
map <Space><space>k <Plug>(easymotion-j)
" Move on current line forward
map <Space><space>l <Plug>(easymotion-lineforward)
" Move on current line backward
map <Space><space>j <Plug>(easymotion-linebackward)

" Gif config
map  <Space>/ <Plug>(easymotion-sn)
omap <Space>/ <Plug>(easymotion-tn)

" Vim sneak.
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

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

nnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.3.0-src"}})<CR>
cnoremap <silent> <C-x>li :lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.3.0-src"}})<CR>
tnoremap <silent> <C-x>li <C-\><C-n>:lua require("telescope.builtin").live_grep({search_dirs={"~/.idris2/idris2-0.3.0-src"}})<CR>

nnoremap <silent> <C-x>ll :lua require("telescope.builtin").live_grep()<CR>
cnoremap <silent> <C-x>ll :lua require("telescope.builtin").live_grep()<CR>
tnoremap <silent> <C-x>ll <C-\><C-n>:lua require("telescope.builtin").live_grep()<CR>
" ===============================================================

" ================ LSP config for Idris2 ========================
lua << EOF
local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local IdrResponseBufferName = "idris-response"

function IdrInitBuf()
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

------------------------ TELESCOPE ----------------------------
local actions = require('telescope.actions')
-- Global remapping
------------------------------
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
function IdrReload()
  vim.lsp.buf.execute_command({command = "reload", arguments = {vim.lsp.util.make_range_params().textDocument.uri}})
end
EOF

nnoremap <LocalLeader>q :lua IdrToggleBuf()<CR>
" nunmap <LocalLeader>gn
nnoremap <LocalLeader>j :lua vim.lsp.buf.definition()<CR>
nnoremap <LocalLeader>h :lua vim.lsp.buf.hover()<CR>
nnoremap <LocalLeader>p :lua IdrPullDiag()<CR>
nnoremap ]d :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap [d :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <LocalLeader>r :lua IdrReload()<CR>

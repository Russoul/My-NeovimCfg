" The Leader key
" TODO Try out: https://github.com/nvim-telescope/telescope.nvim
" as a replacement for FZF
let g:mapleader='|'
let maplocalleader = "\\"
let g:agdavim_enable_goto_definition = 0
" Opens up the main config file of your Vim distribution
"c for config, f for file
nnoremap <C-x>cf :e $MYVIMRC<CR>

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

" expand UltiSnips abbreviations via this shortcut:
let g:UltiSnipsExpandTrigger = "<C-]>"
let g:sneak#label = 0


" TODO Is it used or not? -- I have no idea
let g:idris2_load_on_start = v:false
" TODO Not used?
let g:idrisIdeDisableDefaultMaps = v:false

" Sidenote:
"Use neovim-remote !
" nvr --remote
" opens a file in the running neovim instance
" -------------

"Plugin configuration start
call plug#begin()
" Idris 2 integration
" Edwin's original plugin. Not used.
" Plug 'https://github.com/edwinb/idris2-vim'
" This is used by me currently.
" Hope to switch to Idris2-LSP soonish
Plug 'ShinKage/nvim-idris2', {'do': 'make build'}
" A git plugin
Plug 'tpope/vim-fugitive'
" Align lines of code in one command with many options of doing it.
Plug 'godlygeek/tabular'
" Agda plugin
" Plug 'https://github.com/derekelkins/agda-vim'
Plug 'https://github.com/GustavoMF31/agda-vim'
" FZF integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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
" Though named 'Ack', plugin supports the usage of 'Ag' instead
Plug 'https://github.com/mileszs/ack.vim.git'
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
Plug 'nvim-lua/plenary.nvim'

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

" Tell Ack plugin to actually use Ag, because it's faster
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

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

" tnoremap <C-w><Esc> <Esc>

" Plugin for deleting buffers
" Probably should find a better one, like Emacs has (using Ivy)
nnoremap <silent> <Leader>q :Bdelete menu<CR>

" remap of Join
nnoremap <silent> <Space>j :join<CR>

"execute visually selected code block (vimL)
vmap <C-x><C-e> "xy:@x<CR>

" function! s:doNTimesNormal(i, cmd)
"    if a:i > 0
"        call execute ("normal! " . a:cmd)
"       call s:doNTimesNormal(a:i - 1, a:cmd)
"    endif
" endfunction

" function!ShiftUp()
"    normal! "zykv
"    let l = len(@z)
"    call s:doNTimesNormal(l, "l")
"    normal! "wyR\<C-r>z\<Esc>j
"    call s:doNTimesNormal(l, "h")
"    normal! "R\<C-r>w\<Esc>gv\<Esc>
" endfunction

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
nmap <Leader>sfs :call SearchSelection("AckFile!", @")<CR>
nmap <Leader>sfw :call SearchSelection("AckFile!", "<cword>")<CR>
nmap <Leader>sfW :call SearchSelection("AckFile!", "<cWORD>")<CR>
nmap <Leader>sfl :call SearchSelection("AckFile!", getline('.'))<CR>
nmap <Leader>sfp :call SearchSelection("AckFile!", input("pattern: "))<CR>
nmap <Leader>scs :call SearchSelection("Ack!", @")<CR>
nmap <Leader>scw :call SearchSelection("Ack!", "<cword>")<CR>
nmap <Leader>scW :call SearchSelection("Ack!", "<cWORD>")<CR>
nmap <Leader>scl :call SearchSelection("Ack!", getline('.'))<CR>
nmap <Leader>scp :call SearchSelection("Ack!", input("pattern: "))<CR>
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
"nnoremap <Leader>K :OpenIndentToCursorCol<CR>

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


" ================ Buffers, Files, Projects ==================
nnoremap <silent> <C-x>b :Buffers<CR>
cnoremap <silent> <C-x>b :Buffers<CR>
tnoremap <silent> <C-x>b <C-\><C-n>:Buffers<CR>

" Close all buffers except this one (caveat: doesn't keep the cursor position)
nnoremap <silent> <C-x>qab :%bd\|e#<CR>
nnoremap <silent> <C-x>qb :b#<bar>bd#<CR>

"Search the working directory for files.
nnoremap <silent> <C-x>ff :Files<CR>
cnoremap <silent> <C-x>ff :Files<CR>
tnoremap <silent> <C-x>ff <C-\><C-n>:Files<CR>

" Find files in the folder storing all Idris 2 source files
" It is planned to change this folder soon.
command! FilesIdr :FZF ~/.idris2/idris2-0.3.0-src
nnoremap <silent> <C-x>fi :FilesIdr<CR>
cnoremap <silent> <C-x>fi :FilesIdr<CR>
tnoremap <silent> <C-x>fi <C-\><C-n>:FilesIdr<CR>

nnoremap <silent> <C-x>w :Windows<CR>
cnoremap <silent> <C-x>w :Windows<CR>
tnoremap <silent> <C-x>w <C-\><C-n>:Windows<CR>

" Modified tracked files
nnoremap <silent> <C-g>s :GFiles?<CR>
cnoremap <silent> <C-g>s :GFiles?<CR>
tnoremap <silent> <C-g>s <C-\><C-n>:GFiles?<CR>

" Search
nnoremap <silent> <C-s>l :Lines<CR>
cnoremap <silent> <C-s>l :Lines<CR>
tnoremap <silent> <C-s>l <C-\><C-n>:Lines<CR>

nnoremap <silent> <C-s>L :BLines<CR>
cnoremap <silent> <C-s>L :BLines<CR>
tnoremap <silent> <C-s>L <C-\><C-n>:BLines<CR>

" A few commands for jumping between buffers
nnoremap <silent> <C-x>" :bprevious<CR>
nnoremap <silent> <C-x>' :bnext<CR>
nnoremap <silent> <C-x>1 :bfirst<CR>
" Switch to the alternate buffer
nnoremap <C-u> <C-^>

" Looks like one of the installed plugins remaps those keys ??
" nnoremap q: q:
" nnoremap q/ q/
" nnoremap q? q?

" =================   Window manipulation ====================
" The code below is pretty bad, copied from somewhere.
" And it really should go into its own file, but let's just leave that for later.
" At least it has been ironed out.
function! s:start(mode, oneTime)

  let win_mode = a:mode

  while 1

    echo s:keysMsg(win_mode)

    let c = getchar()

    if c == char2nr("s")
      let win_mode = "swap"
    elseif c == char2nr("m")
      let win_mode = "move"
    elseif c == char2nr("r")
      let win_mode = "resize"
    elseif c == char2nr("f")
      let win_mode = "focus"
    elseif c == char2nr("\<Esc>")
      break
    else
      if win_mode == "focus"
        call s:focusKeys(c)
      elseif win_mode == "swap"
        call s:swapKeys(c)
      elseif win_mode == "resize"
        call s:resizeKeys(c)
      elseif win_mode == "move"
        call s:moveKeys(c)
      endif
    endif
    if a:oneTime == 1
       break
    endif
    redraw

  endwhile

  redraw
  echo ""
endfunction

function! s:step()
  return get(g:, 'win_mode_resize_step', '5')
endfunction

function! s:verticalStep()
  return get(g:, 'win_mode_vertical_resize_step', s:step())
endfunction

function! s:horizontalStep()
  return get(g:, 'win_mode_horizontal_resize_step', s:step())
endfunction

function! s:resizeIncHeight()
  silent! exe s:resizeCommand(s:verticalStep(), '+')
endfunction

function! s:resizeDecHeight()
  silent! exe s:resizeCommand(s:verticalStep(), '-')
endfunction

function! s:resizeDecWidth()
  silent! exe s:resizeCommand(s:horizontalStep(), '<')
endfunction

function! s:resizeIncWidth()
  silent! exe s:resizeCommand(s:horizontalStep(), '>')
endfunction

fun! s:resizeCommand(step, dir)
  return "normal! \<c-w>" . a:step . a:dir
endfun

" Swap buffer in current window to the direct window. The direct argument can
" be one of h, j, k, l
fun! s:swapTo(direct)
  let from = winnr()
  exe "wincmd " . a:direct
  let to = winnr()
  exe from . "wincmd w"

  if to != from
    call s:swapWindow(to)
  endif

endfun

" Values of the argument
"   1 : Top
"   2 : Right
"   3 : Bottom
"   4 : Left
function! HasNeighbour(direction)
    " Position of the current window
    let currentPosition = win_screenpos(winnr())

    if a:direction == 1
        " if we are looking for a top neigbour simply test if we are on the first line
        return currentPosition[0] != 1
    elseif a:direction == 4
        " if we are looking for a left neigbour simply test if we are on the first column
        return currentPosition[1] != 1
    endif

    " Number of windows on the screen
    let winNr = winnr('$')

    while winNr > 0
        " Get the position of each window
        let position = win_screenpos(winNr)
        let winNr = winNr - 1

        " Test for window on the right
        if ( a:direction == 2 && ( currentPosition[1] + winwidth(0) ) < position[1] )
            return 1
        " Test for windo on the bottom
        elseif ( a:direction == 3 && ( currentPosition[0] + winheight(0) ) < position[0] )
            return 1
        endif
    endwhile
endfunction

fun! s:swapWindow(to)
  let curNum = winnr()
  let curBuf = bufnr( "%" )
  exe a:to . "wincmd w"
  let toBuf  = bufnr( "%" )
  exe 'hide buf' curBuf
  exe curNum . "wincmd w"
  exe 'hide buf' toBuf
  exe a:to ."wincmd w"
endfun


function! s:keysMsg(mode)
  return s:commonMsg(a:mode) . s:modeMsg(a:mode)
endfunction

function! s:commonMsg(mode)
  return '[win ' . a:mode . ' mode]'
endfunction

function! s:modeMsg(mode)
  if a:mode == 'focus'
    return s:focusMsg()
  elseif a:mode == 'swap'
    return s:swapMsg()
  elseif a:mode == 'move'
    return s:moveMsg()
  elseif a:mode == 'resize'
    return s:resizeMsg()
  endif
endfunction

function! s:focusMsg()
  return '(s:swap,m:move,r:resize,h:split,v:vsplit,(x,q):close)'
endfunction

function! s:moveMsg()
  return '(s:swap,f:focus,r:resize,h:split,v:vsplit,(x,q):close)'
endfunction

function! s:resizeMsg()
  return '(s:swap,f:focus,m:move,=:equal)'
endfunction

function! s:swapMsg()
  return '(f:focus,m:move,r:resize)'
endfunction

function! s:focusKeys(key)
  let c = a:key
  if c == char2nr("j")
    exe "normal! \<c-w>h"
  elseif c == char2nr("i")
    exe "normal! \<c-w>k"
  elseif c == char2nr("k")
    exe "normal! \<c-w>j"
  elseif c == char2nr("l")
    exe "normal! \<c-w>l"
  elseif c == char2nr("x") || c == char2nr("q")
    exe ":close"
  elseif c == char2nr("v")
    exe ":vsplit"
  elseif c == char2nr("h")
    exe ":split"
  endif
endfunction

function! s:swapKeys(key)
  let c = a:key
  if c == char2nr("j")
    exe ":call s:swapTo('h')"
  elseif c == char2nr("i")
    exe ":call s:swapTo('k')"
  elseif c == char2nr("k")
    exe ":call s:swapTo('j')"
  elseif c == char2nr("l")
    exe ":call s:swapTo('l')"
  endif
endfunction

function! s:resizeKeys(key)
  let c = a:key
  if c == char2nr("j")
    if HasNeighbour(2)
       call s:resizeDecWidth()
    else
       exec "normal! \<C-w>h"
       call s:resizeDecWidth()
       exec "normal! \<C-w>l"
    endif
  elseif c == char2nr("i")
    if HasNeighbour(3)
       call s:resizeDecHeight()
    else
       exec "normal! \<C-w>k"
       call s:resizeDecHeight()
       exec "normal! \<C-w>j"
    endif
  elseif c == char2nr("k")
    if HasNeighbour(3)
       call s:resizeIncHeight()
    else
       exec "normal! \<C-w>k"
       call s:resizeIncHeight()
       exec "normal! \<C-w>j"
    endif
  elseif c == char2nr("l")
    if HasNeighbour(2)
       call s:resizeIncWidth()
    else
       exec "normal! \<C-w>h"
       call s:resizeIncWidth()
       exec "normal! \<C-w>l"
    endif
  elseif c == char2nr("=")
    exe "normal! \<c-w>="
  elseif c == char2nr("_")
    exe "normal! \<c-w>_"
  endif
endfunction

function! s:moveKeys(key)
  let c = a:key
  let oldeoa = &equalalways
  set noequalalways
  if c == char2nr("j")
    exe "normal! \<c-w>H"
  elseif c == char2nr("i")
    exe "normal! \<c-w>K"
  elseif c == char2nr("k")
    exe "normal! \<c-w>J"
  elseif c == char2nr("l")
    exe "normal! \<c-w>L"
  elseif c == char2nr("x") || c == char2nr("q")
    exe ":close"
  elseif c == char2nr("vsplit")
    exe ":vsplit"
  elseif c == char2nr("h")
    exe ":split"
  endif
  let &equalalways = oldeoa
endfunction

command! WinModeFocusStart call s:start("focus", 0)
command! WinModeFocus call s:start("focus", 1)
command! WinModeResize call s:start("resize", 1)
command! WinModeSwap call s:start("swap", 1)
command! WinModeMove call s:start("move", 1)

noremap <Plug>WinModeStart :call s:start(g:win_mode_default, 0)<CR>
noremap <Plug>WinModeFocus :call s:start("focus", 1)<CR>
noremap <Plug>WinModeResize :call s:start("resize", 1)<CR>
noremap <Plug>WinModeSwap :call s:start("swap", 1)<CR>
noremap <Plug>WinModeMove :call s:start("move", 1)<CR>

" Start window manipulation session
nnoremap <C-w>w :WinModeFocusStart<CR>

" Switching between windows
nnoremap <C-w>i <C-w>k
nnoremap <C-w>k <C-w>j
nnoremap <C-w>j <C-w>h
nnoremap <C-w>l <C-w>l

" Switching between windows when in terminal
tmap <silent> <C-w>i <C-v><Esc>:execute('winc k')<cr>
tmap <silent> <C-w>j <C-v><Esc>:execute('winc h')<cr>
tmap <silent> <C-w>k <C-v><Esc>:execute('winc j')<cr>
tmap <silent> <C-w>l <C-v><Esc>:execute('winc l')<cr>

" Push current window towards given direction beyond all windows
nnoremap <C-w>I <C-w>K
nnoremap <C-w>K <C-w>J
nnoremap <C-w>J <C-w>H
nnoremap <C-w>L <C-w>L
tmap <C-w>I <C-v><Esc><C-w>I
tmap <C-w>K <C-v><Esc><C-w>K
tmap <C-w>J <C-v><Esc><C-w>J
tmap <C-w>L <C-v><Esc><C-w>L

" Mnemonic for 'fullscreen': resize current window to maximal width
nnoremap <C-w>f :vertical resize<CR>

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
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})

function! s:openFileAtPos(filename, line, col)
   silent write
   execute "edit " . a:filename
   call setpos('.', [0, a:line, a:col, 0])
   normal! zz
endfunction

function! s:openRgFile(str)
   let [_, f, line, col; rest] = matchlist(a:str, '\v([^:]+):([^:]+):([^:]+):.*')
   call s:openFileAtPos(f, line, col)
endfunction

function! RgDir(dir, str)
  call fzf#run(fzf#wrap({'source' : 'rg -i --no-heading --column '. a:str . ' ' . a:dir,
                      \  'sink'   : {file -> s:openRgFile(file)},
                      \  'options' : '-d : --nth 4 --color=dark -1'}))
endfunction

command! -bang -nargs=* RgIdr call RgDir('~/.idris2/idris2-0.3.0-src', <q-args>)

nnoremap <silent> <C-x>li :call RgDir('~/.idris2/idris2-0.3.0-src', '"' . input('> ') . '"')<CR>
cnoremap <silent> <C-x>li :call RgDir('~/.idris2/idris2-0.3.0-src', '"' . input('> ') . '"')<CR>
tnoremap <silent> <C-x>li <C-\><C-n>:call RgDir('~/.idris2/idris2-0.3.0-src', '"' . input('> ') . '"')<CR>

nnoremap <silent> <C-x>ll :call RgDir('.', '"' . input('> ') . '"')<CR>
cnoremap <silent> <C-x>ll :call RgDir('.', '"' . input('> ') . '"')<CR>
tnoremap <silent> <C-x>ll <C-\><C-n>:call RgDir('.', '"' . input('> ') . '"')<CR>

vmap gc <C-]>gc<C-]><Esc><Esc>

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" LSP config for Idris2
" lua << EOF
" local lspconfig = require('lspconfig')
" local configs = require('lspconfig/configs')
" if not lspconfig.idris2_lsp then
"   configs.idris2_lsp = {
"     default_config = {
"       cmd = {'idris2-lsp'}; -- if not available in PATH, provide the absolute path
"       filetypes = {'idris2'};
"       on_new_config = function(new_config, new_root_dir)
"         new_config.cmd = {'idris2-lsp'}
"         new_config.capabilities['workspace']['semanticTokens'] = {refreshSupport = true}
"       end;
"       root_dir = function(fname)
"         local scandir = require('plenary.scandir')
"         local find_ipkg_ancestor = function(fname)
"           return lspconfig.util.search_ancestors(fname, function(path)
"             local res = scandir.scan_dir(path, {depth=1; search_pattern='.+%.ipkg'})
"             if not vim.tbl_isempty(res) then
"               return path
"             end
"           end)
"         end
"         return find_ipkg_ancestor(fname) or lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
"       end;
"       settings = {};
"     };
"   }
" end
" -- Semantic highlightning support is not yet on the main branch, PR#39 is needed
" -- if you are on the main branch, remove the if in on_attach, the handlers and the highlight commands.
" -- Flag to enable semantic highlightning on start, if false you have to issue a first command manually
" local autostart_semantic_highlightning = true
" lspconfig.idris2_lsp.setup {
"   on_init = custom_init,
"   on_attach = function(client)
"     if autostart_semantic_highlightning then
"       vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
"         { textDocument = vim.lsp.util.make_text_document_params() }, nil)
"     end
"     --custom_attach(client) -- remove this line if you don't have a customized attach function
"   end,
"   autostart = true,
"   handlers = {
"     ['workspace/semanticTokens/refresh'] = function(err, method, params, client_id, bufnr, config)
"       if autostart_semantic_highlightning then
"         vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
"           { textDocument = vim.lsp.util.make_text_document_params() }, nil)
"       end
"       return vim.NIL
"     end,
"     ['textDocument/semanticTokens/full'] = function(err, method, result, client_id, bufnr, config)
"       -- temporary handler until native support lands
"       local client = vim.lsp.get_client_by_id(client_id)
"       local legend = client.server_capabilities.semanticTokensProvider.legend
"       local token_types = legend.tokenTypes
"       local data = result.data
"
"       local ns = vim.api.nvim_create_namespace('nvim-lsp-semantic')
"       vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
"       local tokens = {}
"       local prev_line, prev_start = nil, 0
"       for i = 1, #data, 5 do
"         local delta_line = data[i]
"         prev_line = prev_line and prev_line + delta_line or delta_line
"         local delta_start = data[i + 1]
"         prev_start = delta_line == 0 and prev_start + delta_start or delta_start
"         local token_type = token_types[data[i + 3] + 1]
"         vim.api.nvim_buf_add_highlight(bufnr, ns, 'LspSemantic_' .. token_type, prev_line, prev_start, prev_start + data[i + 2])
"       end
"     end
"   },
" }
"
" -- Set here your preferred colors for semantic values
" --vim.cmd [[highlight link LspSemantic_type Include]]   -- Type constructors
" --vim.cmd [[highlight link LspSemantic_function Identifier]] -- Functions names
" --vim.cmd [[highlight link LspSemantic_struct Number]]   -- Data constructors
" --vim.cmd [[highlight LspSemantic_variable guifg=gray]] -- Bound variables
" --vim.cmd [[highlight link LspSemantic_keyword Structure]]  -- Keywords
"
" -- Add the following command to a mapping if you want to send a manual request for semantic highlight
" -- :lua vim.lsp.buf_request(0, 'textDocument/semanticTokens/full', {textDocument = vim.lsp.util.make_text_document_params()}, nil)
"
" vim.cmd [[highlight LspSemantic_type guifg=#ff9d5c]]     -- Type constructors
" vim.cmd [[highlight link LspSemantic_function Identifier]] -- Functions names
" vim.cmd [[highlight link LspSemantic_struct Number]]   -- Data constructors
" vim.cmd [[highlight LspSemantic_variable guifg=gray]] -- Bound variables
" vim.cmd [[highlight link LspSemantic_keyword Structure]]  -- Keywords
" EOF


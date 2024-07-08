" =================   Window manipulation ====================
" The code below is pretty bad but it works
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

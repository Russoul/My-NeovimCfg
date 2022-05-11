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


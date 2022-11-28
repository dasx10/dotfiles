function! ToUpRecursive()
  if (line('.') == 1)
    :move $<cr>
  else
    :move -2<cr>
  endif
endfunction

function! ToDownRecursive()
  if (line('.') == line('$'))
    :move 0<cr>
  else
    :move +1<cr>
  endif
endfunction

function! ToSide()
  if (col('.') == (col('$') - 1))
    :normal ^
  else
    :normal $
  endif
endfunction

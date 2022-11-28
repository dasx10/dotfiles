function! CheckboxSpaceHighlight()
  if (&list == 1)
    set list!
  else
    set list listchars  =tab:→\ ,eol:↲,nbsp:␣,trail:·,space:·,extends:⟩,precedes:⟨
  endif
endfunction

function! CheckboxRelative()
  if (&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

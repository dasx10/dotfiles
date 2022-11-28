function! Tail(index, string)
  return a:string[a:index:len(a:string)]
endfunction

function! Head(index, string)
  return a:string[0:a:index - 1]
endfunction

function! First(string)
  return a:string[0]
endfunction

function! Last(string)
  return a:string[len(a:string) - 1]
endfunction

function! LastIndex(string)
  return len(a:string) - 1
endfunction

function! IndexOf(char, string)
  let index = 0
  for stringChar in a:string
    if a:char == stringChar
      return index
    endif
    let index += 1
  endfor
endfunction

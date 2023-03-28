function ToUpRecursive()
  if vim.fn.line('.') == 1 then
    vim.cmd('move $')
  else
    vim.cmd('move -2')
  end
end

function ToDownRecursive()
  if vim.fn.line('.') == vim.fn.line('$') then
    vim.cmd('move 0')
  else
    vim.cmd('move +1')
  end
end

function CheckboxSpaceHighlight()
  if vim.bo.list == 1 then
    vim.opt.list = false
  else
    vim.opt.list = true
    vim.opt.listchars:append({tab = '→\\ ', eol = '↲', nbsp = '␣', trail = '·', space = '·', extends = '⟩', precedes = '⟨'})
  end
end

function CheckboxRelative()
  if vim.wo.relativenumber == true then
    vim.wo.relativenumber = false
  else
    vim.wo.relativenumber = true
  end
end

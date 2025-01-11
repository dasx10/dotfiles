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
    vim.cmd('move +=1')
  end
end
function CheckboxRelative()
  vim.wo.relativenumber = vim.wo.relativenumber == false
end

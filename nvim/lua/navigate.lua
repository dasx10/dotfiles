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

function EchoSelectedText()
  -- Отримати тип виділення та початковий та кінцевий рядки виділення
  local pos1 = vim.fn.getpos("'<")
  local lnum1, col1 = pos1[2], pos1[3]
  local pos2 = vim.fn.getpos("'>")
  local lnum2, col2 = pos2[2], pos2[3]
  local regtype = vim.fn.visualmode()

  -- Отримати виділений текст
  local text = vim.fn.getline(lnum1, lnum2)
  text = string.gsub(text, '\n', '\\n')

  -- Вивести текст у командному режимі за допомогою команди echo
  vim.cmd('echo "' .. text .. '"')
end

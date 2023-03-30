function CheckBackspace()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.')[col - 1]:match('%s') ~= nil
end

function HasGit()
  local branch = vim.fn['fugitive#statusline']()
  return #branch > 1
end

function CurrentGitBranch()
  if HasGit() then
    local branch = vim.fn.split(vim.fn['fugitive#statusline'](), '[()]')
    return vim.fn.remove(branch, 1)
  end
  return ''
end

function GitStatus()
  if HasGit() then
    local summary = vim.fn.GitGutterGetHunkSummary()
    local a, m, r = summary[1], summary[2], summary[3]
    if a == 0 and m == 0 and r == 0 then
      return ''
    end
    return string.format('   +:%d ~:%d -:%d', a, m, r)
  end
  return ''
end

function ShowDocumentation()
  if vim.bo.filetype == 'vim' then
    vim.cmd('h ' .. vim.fn.expand('<cword>'))
  elseif vim.g.coc_rpc_initialized == 1 then
    vim.fn.CocActionAsync('doHover')
  else
    vim.fn.execute('!' .. vim.bo.keywordprg .. ' ' .. vim.fn.expand('<cword>'))
  end
end

function LinterStatus()
  local counts = vim.fn['ale#statusline#Count'](vim.fn.bufnr(''))
  if counts.total == 0 then
    return ''
  end
  local all_errors = counts.error + counts.style_error
  local all_non_errors = counts.total - all_errors
  return string.format('[?:%d !:%d]', all_non_errors, all_errors)
end

function DiagnosticStatus()
  local info = vim.b.coc_diagnostic_info
  if vim.fn.empty(info) == 1 then
    return ''
  end
  local error = info['error']
  local warning = info['warning']
  local information = info['information']
  local hint = info['hint']
  if error == 0 and warning == 0 and information == 0 and hint == 0 then
    return ''
  end
  return string.format('w:%d e:%d h:%d i:%d', warning, error, hint, information)
end


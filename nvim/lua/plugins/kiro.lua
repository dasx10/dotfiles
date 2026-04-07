local kiro_buf = nil
local kiro_win = nil

local function get_context(selection)
  local file = vim.fn.expand("%:p")
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line, col = cursor[1], cursor[2] + 1
  local ctx = string.format("File: %s\nCursor: line %d, col %d", file, line, col)
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    local name = vim.api.nvim_buf_get_name(buf)
    if name == file then
      ctx = ctx .. "\nBuffer: " .. name
      break
    end
  end

  if selection then
    ctx = ctx .. "\nSelected text:\n" .. selection
  end

  return ctx
end

local function ensure_win()
  if kiro_win and vim.api.nvim_win_is_valid(kiro_win) then
    vim.api.nvim_set_current_win(kiro_win)
    return
  end
  local width = math.floor(vim.o.columns * 0.45)
  local height = math.floor(vim.o.lines * 0.85)
  kiro_win = vim.api.nvim_open_win(kiro_buf, true, {
    relative = "editor", width = width, height = height,
    col = vim.o.columns - width - 2, row = math.floor((vim.o.lines - height) / 2),
    style = "minimal", border = "rounded", title = " Kiro ", title_pos = "center",
  })
end

local function open_kiro(input)
  if kiro_buf and vim.api.nvim_buf_is_valid(kiro_buf) then
    if input then
      vim.fn.setreg("+", input)
      vim.notify("Context copied — paste with <C-S-v>", vim.log.levels.INFO)
    end
    ensure_win()
    vim.cmd("startinsert")
    return
  end

  kiro_buf = vim.api.nvim_create_buf(false, true)
  ensure_win()

  local cmd = input and string.format('kiro-cli chat "%s"', input:gsub('"', '\\"')) or "kiro-cli chat"
  vim.fn.termopen(cmd, {
    on_exit = function()
      kiro_buf = nil
      kiro_win = nil
    end,
  })

  vim.cmd("startinsert")
end

local function close_kiro()
  if kiro_win and vim.api.nvim_win_is_valid(kiro_win) then
    vim.api.nvim_win_close(kiro_win, false)
    kiro_win = nil
  end
end

-- kiro
vim.keymap.set("n", "<leader>ak", function()
  if kiro_win and vim.api.nvim_win_is_valid(kiro_win) then
    close_kiro()
  else
    open_kiro(get_context())
  end
end, { desc = "Toggle Kiro Chat" })

-- kiro with selection
vim.keymap.set("v", "<leader>ak", function()
  local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
  open_kiro(get_context(table.concat(lines, "\n")))
end, { desc = "Kiro Chat with selection" })

vim.keymap.set("t", "ZQ", close_kiro, { desc = "Hide Kiro float" })

-- kiro git
vim.keymap.set("n", "ag", function()
  -- Базові дані (завжди компактні)
  local branch = vim.trim(vim.fn.system("git branch --show-current"))
  local status = vim.trim(vim.fn.system("git status --short"))
  local log = vim.trim(vim.fn.system("git log -n 5 --oneline"))

  if status == "" then
    vim.notify("No changes to commit", vim.log.levels.INFO)
    return
  end

  -- Отримуємо повний diff
  local diff = vim.fn.system("git diff --staged") .. vim.fn.system("git diff")
  
  -- Рахуємо кількість рядків у diff
  local _, line_count = diff:gsub("\n", "\n")
  
  local final_prompt = ""
  local limit = 100 -- Максимальна кількість рядків, які ми готові передати одразу

  if line_count > limit then
    -- Якщо diff завеликий, передаємо лише статус та пропозицію
    final_prompt = string.format(
      "I have a lot of changes (%d lines). Here is my git status:\n%s\n\n" ..
      "Current branch: %s\n" ..
      "Recent log:\n%s\n\n" ..
      "The diff is too large to show at once. Please tell me which files or parts you want to see, or give instructions based on the file list.",
      line_count, status, branch, log
    )
    vim.notify("Diff is too large (" .. line_count .. " lines). Sending summary.", vim.log.levels.WARN)
  else
    -- Якщо diff в межах норми, передаємо все як раніше
    final_prompt = string.format(
      "Check my changes:\n\nBranch: %s\n\nHistory:\n%s\n\nStatus:\n%s\n\nFull Diff:\n%s\n\n" ..
      "Instructions: suggest commits, amend or rebase if needed.",
      branch, log, status, diff
    )
  end

  -- Виклик Kiro
  if type(open_kiro) == "function" then
    open_kiro(final_prompt)
  else
    vim.notify("open_kiro function not found", vim.log.levels.ERROR)
  end
end, { desc = "Kiro git smart check" })

-- kiro fix with selection
vim.keymap.set("v", "af", function()
  local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
  open_kiro("fix: " .. table.concat(lines, "\n"))
end, { desc = "Kiro fix with selection" })



return {}

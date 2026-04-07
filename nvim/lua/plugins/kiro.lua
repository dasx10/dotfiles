local kiro_buf = nil
local kiro_win = nil

local function get_context(selection)
  local file = vim.fn.expand("%:p")
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line, col = cursor[1], cursor[2] + 1
  local ctx = string.format("File: %s\nCursor: line %d, col %d", file, line, col)
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

vim.keymap.set("n", "<leader>ak", function()
  if kiro_win and vim.api.nvim_win_is_valid(kiro_win) then
    close_kiro()
  else
    open_kiro(get_context())
  end
end, { desc = "Toggle Kiro Chat" })

vim.keymap.set("v", "<leader>ak", function()
  local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
  open_kiro(get_context(table.concat(lines, "\n")))
end, { desc = "Kiro Chat with selection" })

vim.keymap.set("t", "ZQ", close_kiro, { desc = "Hide Kiro float" })

vim.keymap.set("n", "ag", function()
  local status = vim.fn.system("git status")
  local diff = vim.fn.system("git diff --staged")
  local branch = vim.fn.system("git branch --show-current")

  if status == "" and diff == "" then
    vim.notify("No changes to commit", vim.log.levels.INFO)
    return
  end

  open_kiro("please check before push and next git add and commit and push changes" .. "\nstatus: \n" .. status .. "\ndiff: \n" .. diff .. "\nbranch: \n" .. branch)

end, { desc = "Kiro git check commit and push" })

return {}

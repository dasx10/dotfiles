local claude_buf = nil
local claude_win = nil
local claude_job = nil

local function hide_claude()
  if claude_win and vim.api.nvim_win_is_valid(claude_win) then
    vim.api.nvim_win_close(claude_win, false)
    claude_win = nil
  end
end

local function kill_claude()
  hide_claude()
  if claude_job then
    vim.fn.jobstop(claude_job)
  end
  if claude_buf and vim.api.nvim_buf_is_valid(claude_buf) then
    vim.api.nvim_buf_delete(claude_buf, { force = true })
  end
  claude_buf = nil
  claude_job = nil
end

local function open_split()
  local width = math.floor(vim.o.columns * 0.45)
  vim.cmd("botright vsplit")
  claude_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_width(claude_win, width)
end

local function send_to_claude(text)
  if claude_job then
    vim.fn.chansend(claude_job, text)
  end
end

local function open_claude(initial_file)
  if claude_buf and vim.api.nvim_buf_is_valid(claude_buf) then
    if claude_win and vim.api.nvim_win_is_valid(claude_win) then
      vim.api.nvim_set_current_win(claude_win)
    else
      open_split()
      vim.api.nvim_win_set_buf(claude_win, claude_buf)
    end
    if initial_file then
      vim.cmd("startinsert")
      vim.defer_fn(function() send_to_claude("@" .. initial_file .. " ") end, 50)
    else
      vim.cmd("startinsert")
    end
    return
  end

  claude_buf = vim.api.nvim_create_buf(false, false)
  open_split()
  vim.api.nvim_win_set_buf(claude_win, claude_buf)

  claude_job = vim.fn.termopen("claude", {
    on_exit = function()
      claude_buf = nil
      claude_win = nil
      claude_job = nil
    end,
  })

  if initial_file then
    local this_job = claude_job
    vim.defer_fn(function()
      if claude_job == this_job then
        send_to_claude("@" .. initial_file .. " ")
      end
    end, 1500)
  end

  vim.cmd("startinsert")
end

-- toggle: закрити якщо видно, або вбити стару сесію і відкрити нову
vim.keymap.set("n", "<leader>ac", function()
  local file = vim.fn.expand("%:p")
  if claude_win and vim.api.nvim_win_is_valid(claude_win) then
    kill_claude()
  else
    kill_claude()  -- вбити будь-яку приховану сесію перед відкриттям
    open_claude(file ~= "" and file or nil)
  end
end, { desc = "Toggle Claude split" })

-- надіслати поточний файл як @mention у відкриту сесію
vim.keymap.set("n", "<leader>af", function()
  local file = vim.fn.expand("%:p")
  if file == "" then return end
  if not (claude_win and vim.api.nvim_win_is_valid(claude_win)) then
    open_claude(file)
  else
    vim.api.nvim_set_current_win(claude_win)
    vim.cmd("startinsert")
    vim.defer_fn(function() send_to_claude("@" .. file .. " ") end, 50)
  end
end, { desc = "Send current file to Claude" })

-- visual: передати файл + діапазон + виділений текст
vim.keymap.set("v", "<leader>ac", function()
  local file = vim.fn.expand("%:p")
  if file == "" then return end

  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local selected = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
  local text = table.concat(selected, "\n")

  local msg = string.format("@%s lines %d-%d\nSelected:\n%s\n", file, start_line, end_line, text)

  vim.cmd("normal! \027")
  if not (claude_win and vim.api.nvim_win_is_valid(claude_win)) then
    open_claude()
    local this_job = claude_job
    vim.defer_fn(function()
      if claude_job == this_job then send_to_claude(msg) end
    end, 1500)
  else
    vim.api.nvim_set_current_win(claude_win)
    vim.cmd("startinsert")
    local this_job = claude_job
    vim.defer_fn(function()
      if claude_job ~= this_job then return end
      send_to_claude("\x15")
      vim.defer_fn(function()
        if claude_job == this_job then send_to_claude(msg) end
      end, 30)
    end, 50)
  end
end, { desc = "Claude with selection" })

-- ZC / Esc з терміналу — тільки ховає вікно, сесія продовжується
vim.keymap.set("t", "ZC", hide_claude, { desc = "Hide Claude split (keep session)" })

vim.keymap.set("t", "<Esc>", function()
  if claude_win and vim.api.nvim_win_is_valid(claude_win)
    and vim.api.nvim_get_current_win() == claude_win then
    hide_claude()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  end
end, { desc = "Hide Claude or pass Esc to terminal" })

return {}

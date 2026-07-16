local group = vim.api.nvim_create_augroup("NvapiSelection", { clear = true })
local timer = nil

local function get_visual_text()
  local mode = vim.api.nvim_get_mode().mode
  if not mode:match("[vV\22]") then
    return nil
  end

  local _, sl, sc = unpack(vim.fn.getpos("v"))
  local _, el, ec = unpack(vim.fn.getpos("."))

  if sl > el or (sl == el and sc > ec) then
    sl, el = el, sl
    sc, ec = ec, sc
  end

  local lines = vim.api.nvim_buf_get_lines(0, sl - 1, el, false)
  if mode == "V" then
    return table.concat(lines, "\n")
  end

  if #lines == 1 then
    lines[1] = string.sub(lines[1], sc, ec)
  else
    lines[1] = string.sub(lines[1], sc, -1)
    lines[#lines] = string.sub(lines[#lines], 1, ec)
  end
  return table.concat(lines, "\n")
end

local function write_selection()
  local text = get_visual_text()
  if text == nil then
    return
  end

  local f = io.open("/tmp/nvim.seleted", "w")
  if f then
    f:write(text)
    f:close()
  end
end

local function debounced_flush()
  if timer then
    timer:stop()
  end
  timer = vim.uv.new_timer()
  timer:start(50, 0, function()
    vim.schedule(write_selection)
  end)
end

vim.api.nvim_create_autocmd("ModeChanged", {
  group = group,
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    if mode:match("[vV\22]") then
      write_selection()
    end
  end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  group = group,
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    if mode:match("[vV\22]") then
      debounced_flush()
    end
  end,
})

local context_file = "/tmp/nvim_context.json"

local function write_context()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(bufnr)

  if file == "" or vim.bo[bufnr].buftype ~= "" then return end

  local cursor = vim.api.nvim_win_get_cursor(0)
  local lnum = cursor[1]
  local col = cursor[2]
  local total = vim.api.nvim_buf_line_count(bufnr)
  local start_line = math.max(0, lnum - 11)
  local end_line = math.min(total, lnum + 10)
  local lines_around = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)

  local open_buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" then
        table.insert(open_buffers, name)
      end
    end
  end

  local context = {
    file = file,
    filetype = vim.bo[bufnr].filetype,
    cursor_line = lnum,
    cursor_col = col,
    lines_around_cursor = lines_around,
    unsaved_changes = vim.bo[bufnr].modified,
    open_buffers = open_buffers,
  }

  local f = io.open(context_file, "w")
  if f then
    f:write(vim.fn.json_encode(context))
    f:close()
  end
end

local group = vim.api.nvim_create_augroup("NvimContext", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI", "CursorHold" }, {
  group = group,
  callback = write_context,
})

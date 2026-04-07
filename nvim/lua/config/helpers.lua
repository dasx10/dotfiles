local absolute_to_relative = function()
  local from_file = vim.api.nvim_buf_get_name(0)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  local line = vim.api.nvim_get_current_line()
  if not line or line == "" then return end

  for s, e in line:gmatch('()"src/[^"]+"()') do
    if col >= s - 1 and col <= e - 2 then
      local match = line:sub(s, e - 1)
      local path = match:match([["(src/.-)"]])
      if not path then return end

      local cwd = vim.fn.getcwd()
      local from_dir = vim.fn.fnamemodify(from_file, ":h")
      local abs_target = cwd .. "/" .. path

      local function split_path(p)
        local t = {}
        for part in string.gmatch(p, "[^/]+") do
          table.insert(t, part)
        end
        return t
      end

      local function relative_path(from, to)
        local from_parts = split_path(from)
        local to_parts = split_path(to)

        -- find common prefix
        local i = 1
        while i <= #from_parts and i <= #to_parts and from_parts[i] == to_parts[i] do
          i = i + 1
        end

        local rel_parts = {}
        for _ = i, #from_parts do
          table.insert(rel_parts, "..")
        end
        for j = i, #to_parts do
          table.insert(rel_parts, to_parts[j])
        end

        return table.concat(rel_parts, "/")
      end

      local rel = relative_path(from_dir, abs_target)
      if not rel:match("^%.") then rel = "./" .. rel end

      local replaced = line:sub(1, s - 1) .. '"' .. rel .. '"' .. line:sub(e)
      vim.api.nvim_set_current_line(replaced)
      vim.notify("✅ Replaced: " .. rel)
      return
    end
  end

  vim.notify("No path under cursor", vim.log.levels.WARN)
end

vim.keymap.set("n", "<leader>atr", absolute_to_relative, { desc = "Convert absolute import under cursor to relative" })

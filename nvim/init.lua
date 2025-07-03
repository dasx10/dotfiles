vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"
require("config.alt")
require("config.macros")
require("config.options")
require("config.lazy")
require("config.keymaps")
vim.cmd("colorscheme tender")

vim.api.nvim_create_user_command("SpellCheck", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(bufnr)
  local namespace = vim.api.nvim_create_namespace("codespell")
  vim.diagnostic.reset(namespace, bufnr)

  vim.fn.jobstart({ "codespell", "--quiet-level=3", file }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then return end

      local diagnostics = {}
      for _, line in ipairs(data) do
        local path, lnum, msg = string.match(line, "^(.-):(%d+):%s(.+)$")
        if path and lnum and msg then
          table.insert(diagnostics, {
            lnum = tonumber(lnum) - 1,
            col = 0,
            end_col = 80,
            severity = vim.diagnostic.severity.WARN,
            source = "codespell",
            message = msg,
          })
        end
      end

      vim.diagnostic.set(namespace, bufnr, diagnostics)
    end,
  })
end, {})
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function(args)
    vim.cmd("SpellCheck")
  end,
})


vim.filetype.add({
  extension = {
    hbs = 'html',
  },
})

vim.api.nvim_create_user_command("BlinkDocumentation", function()
  local function try_doc()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then return false end
  
    local client = clients[1] -- беремо перший активний LSP
    local params = vim.lsp.util.make_position_params(0, client.offset_encoding or "utf-16")
  
    local result = vim.lsp.buf_request_sync(0, "textDocument/hover", params, 300)
    if not result or vim.tbl_isempty(result) then return false end
  
    for _, res in pairs(result) do
      local contents = res.result and res.result.contents
      if contents and not vim.tbl_isempty(vim.lsp.util.convert_input_to_markdown_lines(contents)) then
        vim.lsp.buf.hover()
        return true
      end
    end
  
    return false
  end

  if try_doc() then return end

  local max_lines = vim.fn.line("$")
  while true do
    local prev = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! w")
    local after = vim.api.nvim_win_get_cursor(0)

    if prev[1] == after[1] and prev[2] == after[2] then
      vim.notify("No documentation found (stuck)")
      break
    end

    if after[1] > max_lines then
      vim.notify("No documentation found (EOF)")
      break
    end

    if try_doc() then break end
  end
end, {})

-- vim.api.nvim_set_keymap("n", "<C-space>", ":BlinkDocumentation<CR>", { noremap = true, silent = true })


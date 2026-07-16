vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"
require("config.alt")
require("config.gemini")
require("config.nvim_context")
require("config.macros")
require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.helpers")
require("config.visual")
vim.cmd("colorscheme tender")

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


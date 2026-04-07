return {
  'christoomey/vim-tmux-navigator',
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    local nav = {
      h = "TmuxNavigateLeft",
      j = "TmuxNavigateDown",
      k = "TmuxNavigateUp",
    }
    for key, cmd in pairs(nav) do
      vim.keymap.set("n", "<C-" .. key .. ">", "<cmd>" .. cmd .. "<cr>", { silent = true })
      vim.keymap.set("t", "<C-" .. key .. ">", "<C-\\><C-n><cmd>" .. cmd .. "<cr>", { silent = true })
    end

    -- <C-l>: focus float to the right if exists, else tmux navigate
    local function go_right()
      local cur_win = vim.api.nvim_get_current_win()
      local cur_col = vim.api.nvim_win_get_position(cur_win)[2]
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local cfg = vim.api.nvim_win_get_config(win)
        if cfg.relative ~= "" and vim.api.nvim_win_get_position(win)[2] > cur_col then
          vim.api.nvim_set_current_win(win)
          vim.cmd("startinsert")
          return
        end
      end
      vim.cmd("TmuxNavigateRight")
    end

    vim.keymap.set("n", "<C-l>", go_right, { silent = true })
    vim.keymap.set("t", "<C-l>", "<C-\\><C-n><cmd>TmuxNavigateRight<cr>", { silent = true })
  end,
}

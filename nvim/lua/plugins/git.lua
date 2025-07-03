nvim_set_keymap = vim.api.nvim_set_keymap
local s = { silent = true }
local sn = { silent = true, noremap = true }
local snx = { silent = true, noremap = true, expr = true }
local n = { noremap = true }
local e = {}
local x = { expr = true }
local L = function(length)
  return string.rep("<left>", length)
end

nvim_set_keymap("n", "<leader>g", ":Git<space>", e)
nvim_set_keymap("n", "<leader>g<space>", ":Git blame<cr>", e)
nvim_set_keymap("n", "<leader>gA", ":!git add -A<CR>", s)
nvim_set_keymap("n", "<leader>ga", ":Git add<space>", s)
nvim_set_keymap(
  "n",
  "<leader>gmm",
  ":!(git fecth && git pull origin $(git branch --show-current) && git merge origin $(git branch --show-current)) & <cr>",
  e
)
nvim_set_keymap("n", "<leader>gP", ":Git push<space>", e)
nvim_set_keymap("n", "<leader>gPo", ":Git push origin<space>", e)
nvim_set_keymap("n", "<leader>gPP", ":!git push origin $(git branch --show-current) &<cr>", e)
nvim_set_keymap("n", "<leader>gp", ":Git pull<space>", e)
nvim_set_keymap("n", "<leader>gpo", ":Git pull origin<space>", e)
nvim_set_keymap("n", "<leader>gpp", ":!git pull origin $(git branch --show-current)<cr>", e)
nvim_set_keymap("n", "<leader>gC", ':!git commit -am "" && git push origin $(git branch --show-current)' .. L(49), e)
nvim_set_keymap("n", "<leader>ghp", "<Plug>(GitGutterPreviewHun)", e)
nvim_set_keymap("n", "<leader>ghs", "<Plug>(GitGutterStageHun)", e)
nvim_set_keymap("n", "<leader>ghu", "<Plug>(GitGutterUndoHun)", e)
nvim_set_keymap("n", "<leader>ga%", ":Git add %<CR>", e)
nvim_set_keymap("n", "<leader>ga", ":Git add<space>", e)
nvim_set_keymap("n", "<leader>gb", ":Git branch<space>", e)
nvim_set_keymap("n", "<leader>g?", ":Git blame<space>", e)
nvim_set_keymap("n", "<leader>gc", ":Git commit<space>", e)
nvim_set_keymap("n", "<leader>gam", ':Git commit -am<space>""<left>', e)
nvim_set_keymap("n", "<leader>gcm", ':Git commit -m ""<left>', e)
nvim_set_keymap("n", "<leader>gcM", ':Git commit --amend -m ""' .. L(1), e)
nvim_set_keymap("n", "<leader>gdf", ":Git diff<CR>", s)
nvim_set_keymap("n", "<leader>gdh", ":Gdiffsplit<CR>", s)
nvim_set_keymap("n", "<leader>gdv", ":Gvdiffsplit<CR>", s)
nvim_set_keymap("n", "<leader>gf", ":!git fetch &<CR>", e)
nvim_set_keymap("n", "<leader>gg", ":Git<CR>", s)
nvim_set_keymap("n", "<leader>gl", ":Git log<CR>", s)
nvim_set_keymap("n", "<leader>gm", ":Git merge<space>", e)
nvim_set_keymap("n", "<leader>gmo", ":Git merge origin<space>", e)
-- nvim_set_keymap("n", "<leader>gw", ":Git switch<space>", e)
nvim_set_keymap("n", "<leader>gn", ":Git switch -c<space>", e)
nvim_set_keymap("n", "<leader>go", ":Git checkout<space>", e)
nvim_set_keymap("n", "<leader>go%", ":Git checkout %<CR>", e)
nvim_set_keymap("n", "<leader>gr", ":Git rebase<space>", e)
nvim_set_keymap("n", "<leader>gro", ":Git rebase origin<space>", e)
nvim_set_keymap("n", "<leader>gri", ":Git rebase -i<space>", e)
nvim_set_keymap("n", "<leader>grh", ":Git rebase -i HEAD~", e)
nvim_set_keymap("n", "<leader>gs", ":!git status<CR>", e)

return {
  {
    "f-person/git-blame.nvim",
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gz", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "tpope/vim-fugitive",
  },
}

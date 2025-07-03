nvim_set_keymap = vim.api.nvim_set_keymap
local sn = { silent = true, noremap = true }
local n = { noremap = true }

nvim_set_keymap("v", "=e", "==:EasyAlign<cr><right>", sn)
nvim_set_keymap("v", "=<right>", "=gv:EasyAlign<cr><right>", sn)
nvim_set_keymap("v", "= ", "=gv:EasyAlign<cr>* ", sn)
nvim_set_keymap("v", "=:", "=gv:EasyAlign<cr><right>:", sn)
nvim_set_keymap("v", "=+", "=gv:EasyAlign<cr><right>=", sn)
nvim_set_keymap("v", "=,", "=gv:EasyAlign<cr><right>,", sn)
nvim_set_keymap("v", "=. ", "=gv:EasyAlign<cr><right>.", sn)

nvim_set_keymap("n", "=:", "vi{=vi{:EasyAlign<cr><right>:", n)
nvim_set_keymap("n", "=+", "vip=vip:EasyAlign<cr><right>=", n)
nvim_set_keymap("n", "= ", "vip=vip:EasyAlign<cr>*<space>", n)

return {
  "junegunn/vim-easy-align",
}

local x = { expr = true }
vim.keymap.set("i", "<a-i>", function()
  return vim.fn["codeium#Accept"]()
end, x)
vim.keymap.set("i", "<a-,>", function()
  return vim.fn["codeium#CycleCompletions"](1)
end, x)
vim.keymap.set("i", "<a-.>", function()
  return vim.fn["codeium#CycleCompletions"](-1)
end, x)
vim.keymap.set("i", "<a-x>", function()
  return vim.fn["codeium#Clear"]()
end, x)

return {
  {
    "Exafunction/codeium.vim",
    branch = "main",
  },
}

